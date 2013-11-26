From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: atmel: sam9x5_wm8731: fix oops when unload
 module
Date: Tue, 26 Nov 2013 13:22:44 +0000
Message-ID: <20131126132244.GP14725@sirena.org.uk>
References: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NsYpzUZ4z5mp8BBz"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, richard.genoud@gmail.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--NsYpzUZ4z5mp8BBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 12:17:51PM +0800, Bo Shen wrote:

> +	card->drvdata = priv;

You should use snd_soc_card_set_drvdata() for this.

--NsYpzUZ4z5mp8BBz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlKChAAoJELSic+t+oim9Td4P/0j9JI9GEx4dHiwErfQXWYjQ
DSPIPWF01OT4JEBHHQ4BFVxEmlu7tPpwGjRS3pRGllQnbMMy4SeMRqq//QIkJQ0U
870Hck6vhtYcuG51tuuYExUfoBWwMF5wKU9bU+ToRZSHtNhZTZL9vzCePAsbWlX/
+BFeRHm/zyZnTglxxi0a2Gxy2aT3QXtKlSlUlSiaq1UFt/zFao7bREv+vbjC/H7R
1LKXdcXF/ZLNkmZYmzUopZ5Bvg9I8a+6hZdP2XJVmdsU0SfG9PlIIQNJ8pCiVIhC
0Ha98cfZR8nWCSaJKxbUF3aVKNpM72hAmVclM6KemupUC+OdMPPaPWaiGDe3ltdD
gXZzgx3uv6vfZmOfIYq9GHqcZQtYB46aqzcOl7DaqYP1mZgBCmJuE4iLrHybkO2U
7E88MgqeDg3Pk6FsSOaRIbsyV6LCsH2yPNPxl3OUoLqBhmZB1jByeF1qVFGP3bbV
KuU2ioI7dgWBTF3MTp4m/IC/2xAE4W5RoO4uvd9/tnF6s9IBiWfZsX5kc5DJK1Xy
mxnavw0QeUxVVesPBLy9ZLTSJ8MW7tJxKldvmP6QfYN9LekdTwdzMk8usPYJZOTj
HIoK7/22Z3pTtZehmpGkFn10LFwrxOrnoT4K5MZqYXNPLeptXH6fsz2zf+FEWLz8
81BwxmUBPMr5ilq4YLBr
=LeXy
-----END PGP SIGNATURE-----

--NsYpzUZ4z5mp8BBz--
