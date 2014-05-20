From: Imre Deak <imre.deak@intel.com>
Subject: Re: [RFC] set up an sync channel between audio and
 display driver (i.e. ALSA and DRM)
Date: Tue, 20 May 2014 17:29:07 +0300
Message-ID: <1400596147.32158.36.camel@intelbox>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1086556421=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikkanen,
 Kimmo" <kimmo.nikkanen@intel.com>, "Takashi Iwai
 (tiwai@suse.de)" <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Babu,
 Ramesh" <ramesh.babu@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Vetter,
 Daniel" <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1086556421==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-BkqHYh06xeTDv+mICcUr"


--=-BkqHYh06xeTDv+mICcUr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2014-05-20 at 05:52 +0300, Lin, Mengdong wrote:
> This RFC is based on previous discussion to set up a generic
> communication channel between display and audio driver and
> an internal design of Intel MCG/VPG HDMI audio driver. It's still an
> initial draft and your advice would be appreciated
> to improve the design.
> =20
> The basic idea is to create a new avsink module and let both drm and
> alsa depend on it.
> This new module provides a framework and APIs for synchronization
> between the display and audio driver.=20
> =20
> 1. Display/Audio Client
> =20
> The avsink core provides APIs to create, register and lookup a
> display/audio client.
> A specific display driver (eg. i915) or audio driver (eg. HD-Audio
> driver) can create a client, add some resources=20
> objects (shared power wells, display outputs, and audio inputs,
> register ops) to the client, and then register this=20
> client to avisink core. The peer driver can look up a registered
> client by a name or type, or both. If a client gives
> a valid peer client name on registration, avsink core will bind the
> two clients as peer for each other. And we=20
> expect a display client and an audio client to be peers for each other
> in a system.

One problem we have at the moment is the order of calling the system
suspend/resume handlers of the display driver wrt. that of the audio
driver. Since the power well control is part of the display HW block, we
need to run the display driver's resume handler first, initialize the
HW, and only then let the audio driver's resume handler run. For similar
reasons we have to call the audio suspend handler first and only then
the display driver resume handler. Currently we solve this using the
display driver's late/early suspend/resume hooks, but we'd need a more
robust solution.

This seems to be a similar issue to the load time ordering problem that
you describe later. Having a real device for avsync that would be a
child of the display device would solve the ordering issue in both
cases. I admit I haven't looked into it if this is feasible, but I would
like to see some solution to this as part of the plan.

--Imre


--=-BkqHYh06xeTDv+mICcUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAABAgAGBQJTe2azAAoJEORIIAnNuWDFuFEH/17mTH/oNUSTLdSqJBVanwII
8QlWOH1mZKEbBx/GhN4rS5dQ16ftAiy+9BPsGFv3mQyeAwED1/nmq1PnavBRcyNZ
/PFWxNPSelMaPt+XYoehtLzqfmG685lDqY7P5uwg5HkWI52xTITIiVVuPofFubFD
ry2dTYrAWv8xACrGGiCuqjjxYu5HQH0W5p0abP+b2keWZJ8qG0rotpTJSFBErjME
XXRa0ZjvbEUYo3vCyViSlPb/SpRr+bFAvhCMWAE96J4xiXRuUJpOvAGOqY1PAX/c
DERJna3NDnSb0zbfGXzO3AVIvaZ6IZiE0aM3Fg/5Txb9w7RcbU9qHTQI0oC1qW4=
=ojIa
-----END PGP SIGNATURE-----

--=-BkqHYh06xeTDv+mICcUr--


--===============1086556421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1086556421==--
