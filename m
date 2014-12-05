From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH v3] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Fri, 5 Dec 2014 17:39:32 +0000
Message-ID: <20141205173932.GN11764@sirena.org.uk>
References: <1417696879-15402-1-git-send-email-b50113@freescale.com>
 <20141205170156.GB14516@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v541l457l4DThMFo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141205170156.GB14516@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Zidan Wang <b50113@freescale.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--v541l457l4DThMFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 05, 2014 at 05:01:56PM +0000, Charles Keepax wrote:
> On Thu, Dec 04, 2014 at 08:41:19PM +0800, Zidan Wang wrote:

> >  struct wm8960_data {
> > +	struct clk *mclk;

> Is this really pdata? Would the pdata entry to locate the clock
> not be a string holding the clock name that you call clk_get on,
> rather than a clk pointer itself? Probably this should go in
> wm8960_priv instead.

There should be no platform data of any kind for the clock, the name
should be fixed and defined in terms of the name of the clock on the
device requesting it.  The code is actually doing the right thing here,
it's just that it's put the variable into the platform data because
currently the driver just uses the platform data as the driver data.

--v541l457l4DThMFo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUge3TAAoJECTWi3JdVIfQOCwIAIMa/jqp6hOr38kRpbWnkrzm
o0PJZFVQDEhVAy/+lJfnM31NWjw0tmvCzShOk9YEoYBOnGTiUYEnPtTN4b4HWoXC
Am+FmsmEuTKpx9yEgerMGGn0XcgnRLl2RSgqD4FzaAKeUk2BgpJRmInHtjkAmZz7
xtouUumkV1IdqsRP5u11I8WMNfQqZ05+3dHuU5IyGpYcA6PXlkj/kXdUZl3+drl6
a107f3I5l/7AzuySQwcjX3E3MVc5ECN1t9tNGaH0mDTI/EujsspZZkpfmKrxA/tT
tHDpCoHom6ZSTuYZSRoRd7NcHjrIS3h505/MgkjEsKWe+2vRl+UwH7E5e+NxhyY=
=sBfT
-----END PGP SIGNATURE-----

--v541l457l4DThMFo--
