From: Imre Deak <imre.deak@intel.com>
Subject: Re: [RFC] set up an sync channel between audio and
 display driver (i.e. ALSA and DRM)
Date: Wed, 21 May 2014 20:07:35 +0300
Message-ID: <1400692055.26136.69.camel@intelbox>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
 <1400596147.32158.36.camel@intelbox> <20140520143555.GD21128@intel.com>
 <32F4D3A311A1404B92CF923AFF38C3C522292976@BGSMSX104.gar.corp.intel.com>
 <CAKMK7uFd8eLO2JnF-duOD3TDNUAjayr70N+A3vJ=T9_cHVSgkg@mail.gmail.com>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0165927636=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAKMK7uFd8eLO2JnF-duOD3TDNUAjayr70N+A3vJ=T9_cHVSgkg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikkanen,
 Kimmo" <kimmo.nikkanen@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Babu,
 Ramesh" <ramesh.babu@intel.com>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Vetter,
 Daniel" <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0165927636==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-3/W97ICS/uscZTgnsLbD"


--=-3/W97ICS/uscZTgnsLbD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2014-05-21 at 18:05 +0200, Daniel Vetter wrote:
> On Wed, May 21, 2014 at 5:56 PM, Babu, Ramesh <ramesh.babu@intel.com> wro=
te:
> >> On Tue, May 20, 2014 at 05:29:07PM +0300, Imre Deak wrote:
> >> > On Tue, 2014-05-20 at 05:52 +0300, Lin, Mengdong wrote:
> >> > > This RFC is based on previous discussion to set up a generic
> >> > > communication channel between display and audio driver and an
> >> > > internal design of Intel MCG/VPG HDMI audio driver. It's still an
> >> > > initial draft and your advice would be appreciated to improve the
> >> > > design.
> >> > >
> >> > > The basic idea is to create a new avsink module and let both drm a=
nd
> >> > > alsa depend on it.
> >> > > This new module provides a framework and APIs for synchronization
> >> > > between the display and audio driver.
> >> > >
> >> > > 1. Display/Audio Client
> >> > >
> >> > > The avsink core provides APIs to create, register and lookup a
> >> > > display/audio client.
> >> > > A specific display driver (eg. i915) or audio driver (eg. HD-Audio
> >> > > driver) can create a client, add some resources objects (shared
> >> > > power wells, display outputs, and audio inputs, register ops) to t=
he
> >> > > client, and then register this client to avisink core. The peer
> >> > > driver can look up a registered client by a name or type, or both.
> >> > > If a client gives a valid peer client name on registration, avsink
> >> > > core will bind the two clients as peer for each other. And we expe=
ct
> >> > > a display client and an audio client to be peers for each other in=
 a
> >> > > system.
> >> >
> >> > One problem we have at the moment is the order of calling the system
> >> > suspend/resume handlers of the display driver wrt. that of the audio
> >> > driver. Since the power well control is part of the display HW block=
,
> >> > we need to run the display driver's resume handler first, initialize
> >> > the HW, and only then let the audio driver's resume handler run. For
> >> > similar reasons we have to call the audio suspend handler first and
> >> > only then the display driver resume handler. Currently we solve this
> >> > using the display driver's late/early suspend/resume hooks, but we'd
> >> > need a more robust solution.
> >> >
> >> > This seems to be a similar issue to the load time ordering problem
> >> > that you describe later. Having a real device for avsync that would =
be
> >> > a child of the display device would solve the ordering issue in both
> >> > cases. I admit I haven't looked into it if this is feasible, but I
> >> > would like to see some solution to this as part of the plan.
> >>
> >> If we are able create and mandate that HDMI display controller is pare=
nt and
> >> audio is child device, then this wouldn't be an issue and PM frameowrk=
 will
> >> ensure parent is suspended last.
> >>
> > If there is a scenario where HDMI audio has to active but display has
> > to go to low power, then > parent-child device is not optimal. There
> > needs to be a mechanism to turn on/off individual hw blocks within
> > the controller.
>
> Our gfx runtime pm code is a _lot_ better than that. We track each
> power domain individually and enable/disable them only when need.
> armsoc drivers could do the same or make sure that the avsink device
> is a child of the right block. Of course if your driver only has
> binary runtime pm and fires up everything then we have a problem. But
> imo that's a problem with that driver, not with making avsink real
> devices as children of something.

I would also add that at least in case of Haswell, there is really a
hard dependency between the display device and the HDMI audio
functionality: The power well required by HDMI is controlled via the
PWR_WELL_CTL2 register which is in turn part of the display power
domain. This domain is turned off when the display device is in D3
state, so to turn on audio we really have to first put the display
device into D0 state. Since the PM framework doesn't provide any way to
reorder the initialization of devices, we can only depend on the device
parent -> child relationship to achieve the above correct init order.

--Imre


--=-3/W97ICS/uscZTgnsLbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAABAgAGBQJTfN1XAAoJEORIIAnNuWDFgEwIAM+RVczHNNi3HYWLErWart/z
FUPr2sFrW6WudNw7raKPRJXgdhtpVVa7Rffb6u5OOHpIb/ZVkXrCEFQHWNtfdjsy
A58sSzQEesdd9Mw7Rlov0DvJq8GvKNHnHDN/ebngtGeIYiQHxeaP03PX9onZyzs3
kzoYHhaffI2BI652cs7KxuWTtmPLiu8GbHKkm9vFNYDy0JkpW6kiyj3FKfKxECpq
pKsUddY3VI2GQy5ymNCGDGZv6JqTywMfKcpV6tepyzPFMC8hAV8IIJqS5gq2fMn0
xjblqiFaRuqB/Ncy9wmAlFjQcLwwNJJFklQ46doBc2oy2RBniZRM7sR9ATrtjIc=
=okaO
-----END PGP SIGNATURE-----

--=-3/W97ICS/uscZTgnsLbD--


--===============0165927636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0165927636==--
