From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: wm8962: Let CODEC driver enable and disable its
 own MCLK
Date: Thu, 31 Jul 2014 20:53:23 +0100
Message-ID: <20140731195323.GU17528@sirena.org.uk>
References: <1406630319-5302-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PrI1xm21m7BS25/2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406630319-5302-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, b42378@freescale.com, b02247@freescale.com, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org


--PrI1xm21m7BS25/2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2014 at 06:38:39PM +0800, Nicolin Chen wrote:
> snd_soc_open() will trigger pm_runtime resume() which will then enable
> the regulator and initialization. So we should make sure the MCLK is
> enabled before this resume().

Applied, thanks.  However the clock should really be being enabled in
the probe() as well so that runtime PM can then disable it - the current
probe() gets this wrong for the regulators though so this is fine for
now.

--PrI1xm21m7BS25/2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2p6wAAoJELSic+t+oim9vUwP/1Xkqvm5jyNp/6cs/V2qsyVI
ZV0oZqZUphGb8hf3e56eKJJdFEImrKMleY2Uqr/c71OpXrFXqcMpVZ5hNabt0EfE
WUY9PSnfAMWA9UGGdlY/ZWmBkfHaJplKDebyM327mFQ1eykp0emqG7tkBByzbqfg
iO96j5cs1k2b0ugS7tBErDZ1SwL5USbCy9SWmisIWdgdjjJH3c/vhKSDnHM+g3kw
At/KpDq4zRVTgAx/ZqwBmgbJNEmylu/FZGZ/5GbfNPqdMFwYmeJbz/GTRM8sKJF1
b1DDOREVjomQQ0G5vDMXIVhD4+JllW9r8ODV3YPSSYupM50F78XE6OHqr3oyo8WC
fWykn/jS0wGUaX+jXWMywgoBtvh1B7xGqNxraJmTji4scxmtkkbxEfM4ZANwLdD0
WTQ7IOx6aro0e6Tty+dZnZ00xss1qtbWZ5m4hotGW0bPBzoKm3NFkRDnjX/eJdNh
TmWiRzfU+nqGKfQy2a7WpvJypmxphFmQvJ7mXkE5Ls3IR0HU2fPewIqtU6Mj5yMa
i+8hpWJXSDIDpdQ1n2Rge/QydoeZSvtGlLwrWyZ+geAllLG3K96Rhk9K1d/LFxFt
qbTQUB2/ymbeVlViIwSaovf3D4It5WgVqIlLVS33avhSoHAZfiaO0ZAVDQisaE1A
T/TAcv455MyW+qUrRXhM
=Powt
-----END PGP SIGNATURE-----

--PrI1xm21m7BS25/2--
