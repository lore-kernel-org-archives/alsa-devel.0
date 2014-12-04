From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_ssi: fix error path in probe
Date: Thu, 4 Dec 2014 22:48:10 +0000
Message-ID: <20141204224810.GI11764@sirena.org.uk>
References: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
 <1417499707-3125-2-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417499707-3125-2-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: timur@tabi.org, festevam@gmail.com, lars@metafoo.de, arnd@arndb.de, mpa@pengutronix.de, alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, tiwai@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 02, 2014 at 02:55:06PM +0900, Jiada Wang wrote:
> SSI component isn't unregistered if fsl_ssi_debugfs_create() fails
> in probe phase.

applied, thanks.

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgOSqAAoJECTWi3JdVIfQmD0H/2cab5BQ49PiKU7DBqR4h0b/
3ieozrSYda0JOR2zNNCKB2LSzHI2heenBcd7cvCCM8rMIhHAsaGdBx/Df/CGMmmF
BQLuEzpzpbMVXrBO4fhdT6gJhZ80/eBwmCIVQQwvN+6mbr8yNm6nW/9j3wZaxDiX
iJSKtcqwjMXxTtBvZWKAFNXIPoIOu3loJpXkKyaz09eGm4tunpwzLzUysAZWViLE
0Uel8ypnGkGrvk54k2csKDrOOrEpveWDtmP+vEX9KOQ+8zgRb5rBJWXC+UTSDrUD
LMQ/RmMrfCl3Epzuor14zl1uf2iMlxmP0TmhsNW8v+crzkTOioa20NKELmrqZjs=
=iPDz
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
