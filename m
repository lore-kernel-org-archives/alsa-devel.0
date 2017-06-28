From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] drm/amd/amdgpu: Added asic_type as ACP DMA driver
 platform data
Date: Wed, 28 Jun 2017 18:54:06 +0100
Message-ID: <20170628175406.5yykiv33xdcs6qnr@sirena.org.uk>
References: <1498235706-31111-1-git-send-email-alexander.deucher@amd.com>
 <1498235706-31111-2-git-send-email-alexander.deucher@amd.com>
 <fb879fdd-b241-7368-9c33-7a78dafa491d@vodafone.de>
 <CADnq5_MT+h6nOmXfVi42tH9G917wTRguBdMC02zmgRuH2dD-iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1643700902=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_MT+h6nOmXfVi42tH9G917wTRguBdMC02zmgRuH2dD-iA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1643700902==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zff5mzs6yn4po6bh"
Content-Disposition: inline


--zff5mzs6yn4po6bh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 01:05:37PM -0400, Alex Deucher wrote:
> On Fri, Jun 23, 2017 at 12:43 PM, Christian K=F6nig

> > Have the painkillers jellyfied my brain or are you setting a pointer in=
 the
> > amdgpu device structure to some variable on the stack?

> > If it's just for initialization then that's probably ok, but I would re=
set
> > the pointer at the end of the function.

> > Otherwise somebody might have the idea to dereference it later on and t=
hat
> > can only lead to trouble.

> I think it's ok because the hotplug of the audio device is triggered
> from this function, so the audio device should be probed by the time
> this variable goes out of scope.  That said, it would probably be

No, that's in no way safe.  There is no guarantee that probe is going to
happen on any particular schedule, if the other driver isn't registered
yet it'll need to wait for that to happen for example.  You will often
get away with it but that's at best going to be vulnerable to framework
changes (what if someone decides to kick off the probe on a separate
CPU in an effort to reduce boot time?).

> better to use the asic_type from the GPU driver instance directly
> rather than a stack variable.

Yes.

--zff5mzs6yn4po6bh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT7T4ACgkQJNaLcl1U
h9DPwwf9G1d2YqqtHdw2rJzhykueSICxMvBp7uqWIQTJFoGNJSGbSpvY80f4Xs0i
ErPapLUi8lXBLuA/AYkU76ODEBRubMqG1+MZz+KgtVzmvBX4OfP6fNcR+I8DWV/3
EY5M22kwDie9fkG5vsK6XnsI5dM+uuGuIWH4OQoS/1SdIz26m+Y06I2XLA5633Tr
2LY6Th+9bkMiR6yBP+WuNk6GiG8/raR5HROU4VG9rCInNNazyWiyEeGTNhGnZ+T8
VddiDxq0rfVuUDdrS4KuY30co3/Erf+WzpTcVk6L1OuOlg85ZqrTYRdOUYsJmV5v
Rmlum1D1z0Jy98/Q3zjuIX3LMGEs+g==
=63op
-----END PGP SIGNATURE-----

--zff5mzs6yn4po6bh--

--===============1643700902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1643700902==--
