From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 05/10] ASoC: Intel: mrfld: add DSP core
	controls
Date: Tue, 23 Sep 2014 09:22:24 +0530
Message-ID: <20140923035224.GE24663@intel.com>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140916193053.GD7960@sirena.org.uk>
 <20140917105552.GA13006@vinod.koul@linux.intel.com>
 <20140917193706.GU7960@sirena.org.uk>
 <20140918061237.GA24663@intel.com>
 <20140918172852.GY7960@sirena.org.uk>
 <20140919081047.GB24663@intel.com>
 <20140919082152.GC24663@intel.com>
 <20140923015730.GG27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4733153163527433427=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EAE2261AA5
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 06:20:09 +0200 (CEST)
In-Reply-To: <20140923015730.GG27755@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4733153163527433427==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2014 at 06:57:30PM -0700, Mark Brown wrote:
> On Fri, Sep 19, 2014 at 01:51:53PM +0530, Vinod Koul wrote:
>=20
> >         if (e->w && e->w->power)
> >                 ret =3D sst_send_slot_map(drv);
> > 		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> > Here is the widget is powered up then we send the updated slot map to D=
SP.
>=20
> > So it will be updated real time now :)
>=20
> So in what situation might there not be a widget there?
This function is _put handler for the interleaver widget. This is linked to
the dapm BE pipeline.

So the situation where there might not be a widget is remote.

Btw Shubransu has sent out the updated series with you feedback and style
issues fixed.

Thanks
--=20
~Vinod

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUIO54AAoJEHwUBw8lI4NHsXMP/iMI+gR2mkRDUviihJLdFwdG
u5X/ESXffrwpmynIE0i5ynJmTuyOq3pqN+odk5aVfR/CaKFPTB7MLQQe1z79Pv2/
YG2qtksiiQKlk0Z/oBlt7RuVex05AJoZd2VFfOsx+rSLwmCovDx6Vv+NOLE41dxT
LvehpR9MpDwkF2p3m5c8dm9VxQAZhvoOOeuSOfA8pqbzeeYJ7zXjmq6RKmUG69yT
vMsoLUYh/G3tcqbAIhfP2S4Ezky2ZFpZnN48r57hi/QIXfYHoyHRPgjqMITkls8D
dUou3vWQKPISj8wIGS2BrvpHTdZqRMw/6fuvN4YGSnXcBlbur7F1T8JYg+N1fJKT
D7wxDOQdPSrGTYlneCVypwMdaevE4+UL4KuvyfqhoiRR05vRgyG/NSBNcWEdulD8
0Vynol0Yjj38nadaeMMBygHJQnQLzSHYYSbgO4xS/L4XJfEFEfY9QYwTEsX3VH+3
huriPyEwU18U4l2qVoiYa+n1g4lPAzvh0+vBSiSO+SlIXKaVi83nZ/+nZx3Aop0f
sCZuzdt7bSM4u3XIb0NyxD0FgdeeXWzyyhz1zxDTjGDlEPAUmiV13GIUEx3b/e+h
aI7meVMGrzOQK8x00BGUtQ/0RUCC8LBmNRsmACq0TMEpNGVyMzTNVxgsr+nNiNLs
lMVGDuX2xH4B8Hfm2H+m
=zzOl
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--

--===============4733153163527433427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4733153163527433427==--
