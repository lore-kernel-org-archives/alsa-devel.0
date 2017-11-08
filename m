From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 18:47:52 +0000
Message-ID: <20171108184752.wff6qn6ssguaegkq@sirena.co.uk>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
 <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
 <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1686710305=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============1686710305==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tchbshitoukioalf"
Content-Disposition: inline


--tchbshitoukioalf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2017 at 01:40:32PM -0500, Alex Deucher wrote:
> On Wed, Nov 8, 2017 at 1:22 PM, Mark Brown <broonie@kernel.org> wrote:

> > Like I said in reply to your other mail please don't resubmit already
> > applied patches.  The current tip of my topic/amd branch appears to be
> > this very patch, if there's anything needs changing please send an
> > incremental patch.

> I'm not seeing this one in your tree either.  This is just a resend of
> Guenter's patch from an hour ago with the chromium stuff removed.
> Maybe you already applied it in the interim?

Is this different to "ASoC: amd: Report accurate hw_ptr during dma"
which was applied at 16:07?

--tchbshitoukioalf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDUVcACgkQJNaLcl1U
h9BaZAf/UTmxu1gtoSTQO/qyKknMrBWrk8Nptt8T1asLw8tXXL323OQcMNBiTe5f
jvDoV1elTFwPIIaMmhWCEwI0UKoOd/Y1ecGrnpMpWz0VjChxKJgxF2NTnZ/fu4ff
AZCnSMmLjJI/+tEclFigEWU4fz/qBkBLE3DI5ocAD2i5onX5s5LTfiM39HSLH1Za
2UDEiUxMurl2N2mbGJdYzzsQkpOsPgfAussOuVtvQdyIagmKU6iDRkzE+xyobE2c
/tC4RAa+AVXeFXYsF4TIwF5YG/XliVhGQiPxxzHZsP00V3jbWuqMKGvrG2K5GIgv
iiQxcWp6RbAwqwCQ/Wf0KXZAv6LMkg==
=r2Hz
-----END PGP SIGNATURE-----

--tchbshitoukioalf--

--===============1686710305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1686710305==--
