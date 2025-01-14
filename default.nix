{ pkgs ? import <nixpkgs> {} }:
pkgs.buildGoModule {
  pname = "ssh-to-age";
  version = "1.0.1";

  src = ./.;

  vendorSha256 = "sha256-1iDFM6KNsvvwOTg05TAJZvHVTv+Gc0nG0STzNdk0NB4=";

  # golangci-lint is marked as broken on macOS
  nativeBuildInputs = pkgs.lib.optional (!pkgs.stdenv.isDarwin) [ pkgs.golangci-lint ];

  checkPhase = ''
    runHook preCheck
    go test ./...
    runHook postCheck
  '';

  shellHook = ''
    unset GOFLAGS
  '';

  doCheck = true;

  meta = with pkgs.lib; {
    description = "Convert ssh private keys in ed25519 format to age keys";
    homepage = "https://github.com/Mic92/ssh-to-age";
    license = licenses.mit;
    maintainers = with maintainers; [ mic92 ];
    platforms = platforms.unix;
  };
}
