From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [alsa-devel] [RFC] set up an sync channel between
 audio and display driver (i.e. ALSA and DRM)
Date: Tue, 20 May 2014 16:57:32 +0200
Message-ID: <20140520145729.GB23140@ulmo>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
 <1400596147.32158.36.camel@intelbox>
 <CAKMK7uFdPiBoTO-oKCF-t3JbHVwB9F_wFTNnUwgH5JL2fpSH7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0254542554=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAKMK7uFdPiBoTO-oKCF-t3JbHVwB9F_wFTNnUwgH5JL2fpSH7Q@mail.gmail.com>
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
 Kimmo" <kimmo.nikkanen@intel.com>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "Babu,
 Ramesh" <ramesh.babu@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Vetter,
 Daniel" <daniel.vetter@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org


--===============0254542554==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2014 at 04:45:56PM +0200, Daniel Vetter wrote:
> On Tue, May 20, 2014 at 4:29 PM, Imre Deak <imre.deak@intel.com> wrote:
> > On Tue, 2014-05-20 at 05:52 +0300, Lin, Mengdong wrote:
> >> This RFC is based on previous discussion to set up a generic
> >> communication channel between display and audio driver and
> >> an internal design of Intel MCG/VPG HDMI audio driver. It's still an
> >> initial draft and your advice would be appreciated
> >> to improve the design.
> >>
> >> The basic idea is to create a new avsink module and let both drm and
> >> alsa depend on it.
> >> This new module provides a framework and APIs for synchronization
> >> between the display and audio driver.
> >>
> >> 1. Display/Audio Client
> >>
> >> The avsink core provides APIs to create, register and lookup a
> >> display/audio client.
> >> A specific display driver (eg. i915) or audio driver (eg. HD-Audio
> >> driver) can create a client, add some resources
> >> objects (shared power wells, display outputs, and audio inputs,
> >> register ops) to the client, and then register this
> >> client to avisink core. The peer driver can look up a registered
> >> client by a name or type, or both. If a client gives
> >> a valid peer client name on registration, avsink core will bind the
> >> two clients as peer for each other. And we
> >> expect a display client and an audio client to be peers for each other
> >> in a system.
> >
> > One problem we have at the moment is the order of calling the system
> > suspend/resume handlers of the display driver wrt. that of the audio
> > driver. Since the power well control is part of the display HW block, we
> > need to run the display driver's resume handler first, initialize the
> > HW, and only then let the audio driver's resume handler run. For similar
> > reasons we have to call the audio suspend handler first and only then
> > the display driver resume handler. Currently we solve this using the
> > display driver's late/early suspend/resume hooks, but we'd need a more
> > robust solution.
> >
> > This seems to be a similar issue to the load time ordering problem that
> > you describe later. Having a real device for avsync that would be a
> > child of the display device would solve the ordering issue in both
> > cases. I admit I haven't looked into it if this is feasible, but I would
> > like to see some solution to this as part of the plan.
>=20
> Yeah, this is a big reason why I want real devices - we have piles of
> infrastructure to solve these ordering issues as soon as there's a
> struct device around. If we don't use that, we need to reinvent all
> those wheels ourselves.

To make the driver core's magic work I think you'd need to find a way to
reparent the audio device under the display device. Presumably they come
=66rom two different parts of the device tree (two different PCI devices I
would guess for Intel, two different platform devices on SoCs). Changing
the parent after a device has been registered doesn't work as far as I
know. But even assuming that would work, I have trouble imagining what
the implications would be on the rest of the driver model.

I faced similar problems with the Tegra DRM driver, and the only way I
can see to make this kind of interaction between devices work is by
tacking on an extra layer outside the core driver model.

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe21ZAAoJEN0jrNd/PrOhW+IP/jUVgR4yNp6XTwXToZ1CqDfn
6DlGAovVMIZAHdJe5Xp7qD8pbvMSNYETW2V1+G1eE8O2aM+rIgL7DzmSXGf9OT73
Q1Cyor2UtsovPwKddUhhf2ad11wb4L+H+xpEWNVviHvX9oqQw8y0JLPt59T4bOBW
5x2SgMBbyE09eej42pJ4+9D3SaOrr2a5MIM70iSMO/iUPI6MYzyn8aaKKRfOjtLz
Nkqq9HdSawje8XRIh+VuPFgTiWoS0F5V7XcF21PGVN/JHRNUUaX9Vl1hDsD7rPQX
d1StX1EUxxHTuNOKJSx0bvZu1RRJAh9KCT4Vr1FMd9gDQ3KjZNmKeI8x/4GWzq18
Y4SX0ZZ39mjk78aaAJ70814ieXDM/QC6iwraLvGS8jU8V5CpWlXhfOQlUhpZaFCy
0SNAptWoh1zLOD76T1WLab9kt4xwwASEvuxdhtrYoeG3ugFFGGVxF0xm9EAPj2BZ
OeNWolCh8YLXClZlwkbeNhe4ankD2PQv52SHvfloghFDA/PHTjFJoGJ22y9IlgBL
rj8blYyoUzAawVniwakbQzqmr6YpD4BEmCl7BeQ271n64JTetcLitTwFSo6nfcFO
YfbKQ/SpN+RT9nu2SsD0KsbQQ36qliM71K9c7pmaweIit4hAZ0Tyz/y1Bv3iF+BL
3n1qErApRh+bR3ov9m/Q
=I04c
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

--===============0254542554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0254542554==--
