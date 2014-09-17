From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Wed, 17 Sep 2014 11:30:43 -0700
Message-ID: <20140917183043.GR7960@sirena.org.uk>
References: <5dc0f13cdb62904ae0f104f9112faec672adea6f.1410833402.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SorlIzCW0DSU55cr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5dc0f13cdb62904ae0f104f9112faec672adea6f.1410833402.git.shengjiu.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: timur@tabi.org, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, mpa@pengutronix.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--SorlIzCW0DSU55cr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2014 at 10:13:16AM +0800, Shengjiu Wang wrote:
> Check if ipg clock is in clock-names property, then we can move the
> ipg clock enable and disable operation to startup and shutdown, that
> is only enable ipg clock when ssi is working and keep clock is disabled
> when ssi is in idle.
> But when the checking is failed, remain the clock control as before.

Applied, thanks.

--SorlIzCW0DSU55cr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGdNOAAoJECTWi3JdVIfQMDYH/RwLDNitdtxPsO8VST2UHb0E
IGx1uWvA+yJTVbJguO5NPuUWasSEgAzjBWPOxhsNNPOeKVut+LM1G633uZmLGlI+
nqSwjIYmrH1SWBy9Inw0sfJMgcvbZ1i2jfTHb8Fpkc3GgKQb95Hy6nTz+2PqxINu
x2hrVCpsf/1IjHcE56G47bLpXEHuyfqwRN1XxCbmX4Y8U+avQ/PPUVwW0f14s/Zm
VMvTZveqoLGg9V53TaCGXv/7JF9StICmZG3rEzmhIG7SXyOfUPwSYNvqaUY03g8L
Lr/dtHZ419yjLHXJICj4NbV+823G3f4iAPpZYk7+NWGEO/TZV70FzgBb3ziXi3Y=
=G/8g
-----END PGP SIGNATURE-----

--SorlIzCW0DSU55cr--
