From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel-pcm-dma: won't check direction when
 configure dma
Date: Mon, 2 Feb 2015 12:19:28 +0000
Message-ID: <20150202121928.GR21293@sirena.org.uk>
References: <1422859486-11051-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jcUJ+eOYMBLzsnct"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422859486-11051-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, Ludovic.Desroches@atmel.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--jcUJ+eOYMBLzsnct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 02:44:46PM +0800, Bo Shen wrote:
> As DMA framework request DMA using direction only in prep_slave
> function, (The At91 xdma driver has adapted to this request).
> So won't check direction when do DMA configuration.

Applied, thanks.

--jcUJ+eOYMBLzsnct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz2tPAAoJECTWi3JdVIfQulkH/2pFw8PdKwAyUIDYnaNDJUjH
k5L5lKLEttPv3r0FYougRzaAdx+G4FhqM0AYUURT5JJUUtqVzzbZlK+kUMCziSgh
Q69BnLmMWYyltQioZI1AnKlaqKhxNnzxyDcIiEImcr4kxLOkq/XfhW+ez6dDBb/G
ieMlDD6VW/DubfpzKoe/PC0z+78b2rHB843Qd9az2nMGFHLFeuxZXB9m4eNfIPkT
KDTjtsPoYlK1e/qCv2fl9J7HFUJdXEj/a9QkI8ccAsfV+uf13tgMMiO4AaArwkhZ
GlBrf5qnCnbU1RKGhV6e/o8Yu/L3HVJ4Bqx1q8L20j6LnIeLR3JRAafBkM39e1I=
=Zx3b
-----END PGP SIGNATURE-----

--jcUJ+eOYMBLzsnct--
