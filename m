From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: fix typo in sizeof
Date: Fri, 30 Oct 2015 17:06:54 +0530
Message-ID: <20151030113654.GB21326@localhost>
References: <1446156281-31024-1-git-send-email-vincent.stehle@laposte.net>
 <20151030030255.GW28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151030030255.GW28319@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>, trivial@kernel.org
List-Id: alsa-devel@alsa-project.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2015 at 12:02:58PM +0900, Mark Brown wrote:
> On Thu, Oct 29, 2015 at 11:04:41PM +0100, Vincent Stehl=E9 wrote:
> > The size of the pointer to a data structure to send is erroneously
> > passed to sst_ipc_tx_message_wait() as its tx_bytes argument. It should
> > be given the size of the pointed skl_ipc_dxstate_info structure instead.
>=20
> This was reported by 0 day, please don't ignore reports from 0 day.

I usually do keep track of any issues reported by 0day, must have missed
this one then. Will check if any other issue was reported..

I know one issue at least for which we have a patch, will send that out as
well

--=20
~Vinod

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWM1ZWAAoJEHwUBw8lI4NH5/8P/36QkBiLbgdX6h5NDyBslxfs
nErbpuJc19yDY1dVdkDtg+mKXVfzh174w1UKVUTd29KFTKwAsXWimld81YqwUQjw
6XVRHAEaN83RgF1l3KUQb+rmc0xMlm0GpmuG/OW+rRQPk8lipGy0VWYIDMwhf0YZ
TM1F1a7vwc91N04u1xOEPEtBgjKzGWVfHbEZS00EmHodEs17250QroNtyN+LQTYd
tuXBJozHNWXhgk1VwcQcoLM9jEz879F3Woo1UuTmSAWgvHajNY3M7hHcQo6u+S+R
WetGU1riG3vvDEHGo6HLqC/iU+aXATE+YH4h2nt2bNFhMhuve64Eu90HIW04gOGJ
lZ0d8z9qe6BcIs6s197YVq8x3VAvWhhuDu8no8mNMLSyQdke1pElvUzTAfdFlB0S
2+lkVPjp4ePyUrbuI4BQLRVMev5qUy7HdU3bsbdUfWshkcmeDnJlTUOsnSQsrQ+c
Nt0aSWBLKUGw3bCdqo0v/DxVTX1B3RWKF3gqzYkqXY4GhU3j+PXTWuzOHCibfCCG
XxuZ2QgEn7kM6nnKNFSy+LTdsncQUsWruoa0/awsCSCb++QgMpjMDZd0JVmLI2Th
BcdigWHTj5WxMzIsPrc4lPhuLp8NS0iw4JmUuExL10SNTpmNW8Lk+L8Cxl/Sberc
BSCy5sW41lXvjZE/99B6
=ijKM
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
