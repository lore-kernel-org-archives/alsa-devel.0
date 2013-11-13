From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dmaengine: Add support for BCM2835.
Date: Wed, 13 Nov 2013 14:54:41 +0000
Message-ID: <20131113145441.GQ878@sirena.org.uk>
References: <527D1DDA.2040004@koalo.de>
 <20131108181743.GR2493@sirena.org.uk>
 <20131113050017.GO8834@intel.com>
 <20131113125111.GE878@sirena.org.uk>
 <20131113133536.GZ8834@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i13qRg9tmWEwo36p"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131113133536.GZ8834@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Florian Meier <florian.meier@koalo.de>, Stephen Warren <swarren@wwwdotorg.org>, Dan Williams <dan.j.williams@intel.com>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Martin Sperl <martin@sperl.org>
List-Id: alsa-devel@alsa-project.org


--i13qRg9tmWEwo36p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2013 at 07:05:36PM +0530, Vinod Koul wrote:
> On Wed, Nov 13, 2013 at 12:51:11PM +0000, Mark Brown wrote:

> > I'm probably going to be looking at that at some point, though perhaps
> > Martin will get to it since he seems to be looking at this.

> Okay sounds good. This will also help in streamline the implementations..

Yes, though I think some of the stuff Martin was talking about will need
changes to the dmaengine APIs.  He was wanting to reuse DMA lists which
currently dmaengine needs to have built up each time.

--i13qRg9tmWEwo36p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg5KtAAoJELSic+t+oim9qqIP/iOXfikITADNLFePu4CDZIMB
csTTt9lhu0Q59fH03aXc2F5JdiUzuVohkH7jK8tFXuxDZ0rCqdm6Zh0FwxL/peIm
B7fKc6/qRvq3d2gaRBEcRB/aCO9GG8WoKFKdgqWlIl5yEIVmgPPyrePayXXBgf4A
RA+BiIbC5XrWzIrCWgPqkg8izNZbWvOAF7/THvp7vDleyHeFMWSCn53kczUKye8a
XVa4Nc4NV4sUWWDfy/5i5w3JcQDEa3KHR10MlRcucNWLqtc+qHY7RQ8k2azerL13
5IH69j39vNqlD8jfvmJE19nIc8fuSzGBvBX095GkAAEs/oaJoLojTB9aWjvrjeVj
2KnXOXHdq0Nhu5o8ho0IARU0/IbzEKqUhQ197H0iGB32+UQ1egyAmZQC3yzjzSJF
Yg5Namq9Wzkv7ZiQsHSmPLWZ7/DV031Es6RmE/x+eMjf07dMn6V8HUn4OnKRisDn
8nVWz9+Gph14lRHcK3CY+QFby6OpyTkSsjtoBvQWUqYSZu1JoYafCaZxGZRdyrbS
AluMKSjvFsuFEA02Yl0A7zaoXs1ApHSORpW7UQCrKATI70GXYoetAsv601D7/AFl
zvb7Zs+jCNDmuou9l49SinH/RX5j6FYP9JXOG/IPqJiO03UFrw35/IDJVQ5pMoHw
qRWrm8zlEree18mu6K1r
=gLfd
-----END PGP SIGNATURE-----

--i13qRg9tmWEwo36p--
