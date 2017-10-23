From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/14] regmap: Add SoundWire bus support
Date: Mon, 23 Oct 2017 15:16:39 +0200
Message-ID: <20171023131639.x4cfpmylurp6eim6@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-8-git-send-email-vinod.koul@intel.com>
 <20171021093426.vzhv3ponaxhi4yw3@sirena.org.uk>
 <1508759787.29460.6.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6jsga5bvvfo3qmia"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508759787.29460.6.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--6jsga5bvvfo3qmia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 23, 2017 at 12:56:27PM +0100, Alan Cox wrote:
> On Sat, 2017-10-21 at 10:34 +0100, Mark Brown wrote:
> > On Thu, Oct 19, 2017 at 08:33:23AM +0530, Vinod Koul wrote:

> > > +EXPORT_SYMBOL(__regmap_init_sdw);

> > ...this is just an obvious attempt to allow non-GPL code to directly
> > use
> > GPL code.

> There's nothing in the GPL about EXPORT_SYMBOL. If its built GPL
> dependent then it depends upon GPL code so is GPL.

My point is that in the context of this very thin wrapper around an API
that's entirely EXPORT_SYMBOL_GPL() dropping the _GPL() from the export
looks like it's going to enable questionable usage, probably in this
case it's just an oversight caused by all the other non-GPL exports in
the Slimbus code rather than something that's intentional.  This seems
particularly important here in something that's for drivers rather than
the subsystem itself since people might make assumptions (justified or
not) based on the EXPORT_SYMBOL() exports.

--6jsga5bvvfo3qmia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnt67MACgkQJNaLcl1U
h9CG8wf9FR6WLo4awBCzva+TmwQa5NvYRFmTEuwwbJM3eWU3KiTfXuo3p7zMRPyR
OIbbVDZHM9azrOjmFV//+nNl50WqY4SUNm5z7xjAWHFinQDDTm92u5x5oqVr6+Sl
MDkY+ZuRX89mX2H0c0DXZ9Tl3f2LiSZJRhg0ILkO29L4dhG79Rhc8BKIkTMjwE2M
cwyPy5caNpAK4NMbZyg3aXE4PdrGQ00r9OsOVsBhdmYNtQCOst5Tl8mb67ajZphx
VnHPosZbB3BEMRjkTD/IZarab71uafph9n3A5ZdBH2GbwFp0ADmkQ+xS86So2kvP
McBCKYf5axUqS2P4ljp6iqX5a/E+pA==
=U22W
-----END PGP SIGNATURE-----

--6jsga5bvvfo3qmia--
