From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 0/4] ASoC DSP topology
Date: Wed, 22 Apr 2015 09:40:20 +0530
Message-ID: <20150422041020.GG2738@intel.com>
References: <1429217285.7100.18.camel@loki> <5535F513.8030902@ti.com>
 <20150421092812.GA22845@sirena.org.uk> <553642EC.8010400@ti.com>
 <1429629831.2797.9.camel@loki>
 <20150421163942.GM22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0107569141491794550=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 180002604AE
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 06:12:58 +0200 (CEST)
In-Reply-To: <20150421163942.GM22845@sirena.org.uk>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============0107569141491794550==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2015 at 05:39:42PM +0100, Mark Brown wrote:
> On Tue, Apr 21, 2015 at 04:23:51PM +0100, Liam Girdwood wrote:
> > On Tue, 2015-04-21 at 15:30 +0300, Peter Ujfalusi wrote:
>=20
> > > We have discussed this with Liam in the past: in my view the DSP topo=
logy (or
> > > Dynamic FW) should be represented in the machine level and it would b=
e the
> > > best if the same image could carry card level widgets routes and link=
s. If you
> > > have big enough change in the FW and it's provided widgets/PCMs you w=
ould need
> > > separate machine driver or at least a way to have different set of ma=
chine
> > > level routes, widgets, links, etc for different DSP topology file.
>=20
> > The component level allows us to target the physical component devices
> > that may have runtime definable topologies. This would include codecs
> > too, since some vendors are making codecs with built in FW (maybe TI
> > too ?). The machine level more represents the board HW topology and this
> > should be derived from ACPI or DT.
>=20
> I tend to agree.  We should let each vendor provide their own topology
> information - if they need to do something with this (which does seem
> unlikely) system integrators should be on an equal footing with silicon
> vendors here, and we shouldn't be encouraging systems where we need
> per-board firmware definitions for the silicon components just because
> the board has differences.
One case which comes to my mind worth discussing here is PCMs.

We are trying to move FE dialink PCMs to toplogy as that is SW defined and
IMO not linked to HW.
So machine driver will not have dailinks to register at probe so we can't g=
et
sound card created (other info like widgets map can get get registered after
probe though)

I was thinking that in core, a component should register with a toplogy bin
as well. Core can load (or with a callback) the toplogy binary and then par=
se it for
PCMs register them, and create sound card...

thoughts...

--=20
~Vinod

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVNx8sAAoJEHwUBw8lI4NH9X8P/3sgWJiI3N7YbTVeS6/fjL5f
IC2W6o1HUm40veboRNGcrLMRDV9pyfBLvcwJBHDiO+DAribsyP5w6ava0cSfHUCU
cjTzqw0P10hAiAtl0PdDgJZjwt7wOAk/x/e3pIpBfArIHMjO+yMinO9u4PxE8PPq
rdTcB1W20Tw5T3NpdXbpfoZHu7uzadnzKq8KES+WwmQVdb2VDbkshBg9V65//nmV
tWNelgeojrVcZC6q+AFN9CCLrwbsdev3FEVUc5tfX2OQPGJNjIIBtxM6jH0Krkm1
rvtuj4A99OOVMrdjR747wBDfaWl2Sq4RaO2cDDcB1KICiN7BJMzRMoHzK32NdMSc
YrK56YvDhR8rMaqs0S1Pi1X7TOyisvZSWTFHzhJAJY162FKt+zqapkZjPWZRWJw3
ZF4Eqbrv3pJyXxiz3pnvL5SJce44HZW9Xy4kuBTYHCxIsHXq7XhIC/X3XPMzCmCt
YRiOO0Exxl5jxQ7hx1FeNewyPZ1QGUhFpzCerde7h3H/xqiRVuSaJm2fWc4dnjnv
Ia0cLtt0wk61QjtCGhQyKIAhLfWAQMng34hrw68fZYsCr4h6DZ+1QqCSBqWgvjEH
bXg9243V9izegXpMH+dzzrhVdrpLo4wboEpLz4o3xQ/324HQfUR4XsmjcdKQmx5X
/o586O1oJ9AcnhpnbO9z
=Tl1x
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--

--===============0107569141491794550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0107569141491794550==--
