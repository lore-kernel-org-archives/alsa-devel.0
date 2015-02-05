From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: fix sst firmware path
Date: Thu, 5 Feb 2015 19:17:12 +0000
Message-ID: <20150205191712.GK21293@sirena.org.uk>
References: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
 <20150205181458.GG21293@sirena.org.uk>
 <20150205184822.GE13647@H87M>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2nY0HneG+H+bGpQT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150205184822.GE13647@H87M>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Strasser <kevin.strasser@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Yang Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org


--2nY0HneG+H+bGpQT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 10:48:22AM -0800, Kevin Strasser wrote:
> On Thu, Feb 05, 2015 at 06:14:58PM +0000, Mark Brown wrote:

> > Applied, thanks.  It doesn't apply as a fix but that seems to be OK as the
> > only request_firmware() I spotted there appears to use intel/ prefixed
> > directories already.

> I'm a little confused. Do you want me to submit a version that can be applied as
> a fix? It seems to me that we want this patch in 3.19.

Yes, if you want this in v3.19 you need to send me something that can be
applied to the v3.19 code.

--2nY0HneG+H+bGpQT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU08G3AAoJECTWi3JdVIfQkJAH/1GK6SPKlVZbvp+1mgq7psiC
f9fcgACIS+RHEG1jD3geA8EykQP6Nh6aPT97ANT0EkfC0xjKjpURftB9stYkkwFD
LGjerFDVMSNnLRkPRm6gdTzXEHJYL30pZAm8DwmzO+PfTfNQPPRCjxWHtp+80snC
/MlpkE+ZqAROVpKfvumKgAJvFwca1RND6d2tCQ87MF3NcF+wQvrKVO2q5BZL5Imx
Z8h3rYyBKmDnLXMHRDZamQMZtIqCHjspL6lmCg/yIxW8Nl/S7rAgQNog6P1ZMeu0
hPXee2bq/KhpomWyxTZaHJA8F6CDSlj6nwjJ3HDWl2h5oFXGv3JPt11p7chEOB4=
=bdTM
-----END PGP SIGNATURE-----

--2nY0HneG+H+bGpQT--
