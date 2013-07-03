From: Mark Brown <broonie@kernel.org>
Subject: Re: [v2 0/5] ASoC: atmel-pcm: align with generic dmaengine framwork
Date: Wed, 3 Jul 2013 10:52:57 +0100
Message-ID: <20130703095257.GF27646@sirena.org.uk>
References: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sF4+LqaTi7T9hg64"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, lars@metafoo.de, richard.genoud@gmail.com, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--sF4+LqaTi7T9hg64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2013 at 04:37:55PM +0800, Bo Shen wrote:
> This patch set is based on linux next-20130701
>=20
> mainly implement
>   - move set dma data from hw_params to startup callback to avoid memory =
leak
>   - align atmel pcm with generic dmaenigne framwork

Applied all, thanks.

--sF4+LqaTi7T9hg64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0/R2AAoJELSic+t+oim9s5oP/RNy3R5MZ/1cc+iptc3jhnFu
/tAX0H3Lb7VBXItxNTnCfmlaDlmUL38M6+3RdTucleSOfy74EHNfjZdk6J4glQD5
yPOACt+/3NwomuGKKm58QChyvEgJSdMORtTFQ4715xnBgCo3uV8Ez7rYFNZfIcR9
xCyaOcgZziND6T2BZgOi4W5/6ufXPJvecYL0L89dyUZE38WlmGwvNN46lH64JlLo
r4Z3HsJYylgBuiWB9ZSGhqqzhSeCa6x8Didg0vEEVCvGoigEKnONwgNO5a6NBvsY
bStwmpiNHRDfFFC+0XeKoHquZyUp0obg1GrtgggZTUy4ncwpgXjZ1pbijyeRHloz
pEv6/jWdB5tM1pTx7O+N+zW8DoyhJ6UZ0Fs429Ns63/+wjKxAtpoOoWpca3xKyg6
EHHZt1wcapC20QHCpuN0xPvc6fPCOevIbkdBzB5hMdCacJE5nevWbpgOGriGIMyS
tTztOGHIwH7cPWy5mypQoGP1BlGSH+RiuUNJxszjulGfHihBl3XvVhYjCiKFxRNf
lyHjYvIhx+mc+b1kIHBR21QegvmRbtuCuCn4RwLqDKfCs6gEHmBlcWBN8+5Vtvxp
MhXIphoQxa4TpXLsp+i6JqwluR4sr2QPXqmk92nBWn5Ms54W09HBwNMM84bQRJiF
abzRmcOcfhmoZE573d1e
=I097
-----END PGP SIGNATURE-----

--sF4+LqaTi7T9hg64--
