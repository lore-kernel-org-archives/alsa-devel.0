From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2][RESEND] ASoC: generic-dmaengine-pcm:
 Use SNDRV_DMA_TYPE_DEV_IRAM as default
Date: Thu, 7 Nov 2013 11:32:18 +0000
Message-ID: <20131107113218.GU2493@sirena.org.uk>
References: <1383806716-23469-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4927511833118961278=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 661DB26555C
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 12:32:23 +0100 (CET)
In-Reply-To: <1383806716-23469-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4927511833118961278==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PUHnpEUN0SLOjcm5"
Content-Disposition: inline


--PUHnpEUN0SLOjcm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2013 at 02:45:16PM +0800, Nicolin Chen wrote:
> When allocating memory space for DMA buffer, use on-chip internal SRAM
> as default choice to save power. Since the core would allocate memory
> from traditional external memory if iram allocation failed, we don't
> need to worry about any side effect.

Acked-by: Mark Brown <broonie@linaro.org>

--PUHnpEUN0SLOjcm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe3o+AAoJELSic+t+oim92SkP/jchxybowLaTkuG0W+r6rZjk
tlpDNNThL88qGA6C1fdDbYUKAl+IR3Lysn5Zc9TUuElWs9MPeC/PkA5gdQTFeFoq
WDXVtmYTKImvdTyhkXLcptHFXMxzo/9DPKr62DQQalAxafHMXMngy8hmGoTHEIAh
Wh+UITeENuDGC2KqorFtOSNFdbHAhBd265fX7MV9wgbQ/k1rHsjp4o+sgaBzxUHC
PKe09s2PdErUplHXxGtLrD078ZORL8tcYPJ7D4USV/IiW03WdD/0CAJxu1+Wa7zt
RIPdw7fAF7q3lk4s0B8zaIz2EE++r2x+1o29h4In3c0se9jHtK0jar9Td5cJ99sr
XU6drnYdnkPCKSBiw6GUx5kdZwBtY14xx3z2t5xdGOeQpiFjoKsEFVYuQruzPJw5
0bkiLsEhGqg6q5clKjntEl47PpTX2AEZT1c3bEZVctugLQXqDvfg5mGxIvdSUSuW
9B4jAHMhtsTq/xPrpsKBijWBtpAMFTZlcu+sDReb8pSlSrMtt2aGa1noxvwEnWTN
AoIZ39PMwlk2xK1UDeaw5frXYQ83rTWUfBYG8PfQV0ns7H8pMeYcI8MFX+B/K7Pm
QZRMKkKhwDiAwfP0rxKJLwnt8NLLF61PgxbovDdyAn6n76ZzDZsOPA2/8zqkGo5j
ZeC3KQUHxG5k7Bchmwc6
=Nl8y
-----END PGP SIGNATURE-----

--PUHnpEUN0SLOjcm5--

--===============4927511833118961278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4927511833118961278==--
