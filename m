From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: add avc enable control
Date: Tue, 30 May 2017 12:33:47 +0100
Message-ID: <20170530113347.xtb3u4dpt6rnu6tl@sirena.org.uk>
References: <1496142019-13533-1-git-send-email-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iqtfpyiy5zu7dpmd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496142019-13533-1-git-send-email-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <richard.leitner@skidata.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dev@g0hl1n.net
List-Id: alsa-devel@alsa-project.org


--iqtfpyiy5zu7dpmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2017 at 01:00:19PM +0200, Richard Leitner wrote:

> +
> +	SOC_SINGLE("AVC Enable", SGTL5000_DAP_AVC_CTRL, 0, 1, 0),

All on/off switches should end in Switch as covered in ControlNames.txt.

--iqtfpyiy5zu7dpmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlktWJsACgkQJNaLcl1U
h9D3aAf/UbRXvcMuv2YdnEKQT8G/gAhPSDWjtkaSPWu7g89vSKabeDGc84GDCoyr
bCF6mlCv2/5GNLjHLNDofHb0y4W17eyeD22SLoyRgMSI0KzaIk8Bpg4UQWugfp3D
zYp5F1XvJtSUlUN34o5gyV01HSCWF3jYYtNutXJDznRw1M8baCvZlBFCo92NqKyy
p93A1uU0QMSyLuTB0sRkaQsTcAh1Ow8LV2bX9Cx9KySYelJoVmOzdI9mvMSqrByX
XQ3queqC1yVJ/wXWerinnh4gYft6ajCouUh5cI5hGP9MB9bQRAWrHLpWAV2jqz9T
ssARyk3ctrpcIOIIf9I0CH5SfXApMQ==
=5CHt
-----END PGP SIGNATURE-----

--iqtfpyiy5zu7dpmd--
