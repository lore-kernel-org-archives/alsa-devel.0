From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6 v4] Add ASoC support for AMD Stoney APUs
Date: Thu, 14 Sep 2017 10:42:28 -0700
Message-ID: <20170914174228.esh6lvih3yjs46ur@sirena.org.uk>
References: <1505325475-22602-1-git-send-email-alexander.deucher@amd.com>
 <20170913181218.bb2br4zehzjoatyq@sirena.org.uk>
 <CADnq5_PdpjS448n6u6tPBqgKfEw278BENMTjVPiEQ4zQx313AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1192938193=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_PdpjS448n6u6tPBqgKfEw278BENMTjVPiEQ4zQx313AA@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1192938193==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uhety2vnu65tf6iv"
Content-Disposition: inline


--uhety2vnu65tf6iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 13, 2017 at 02:49:08PM -0400, Alex Deucher wrote:
> On Wed, Sep 13, 2017 at 2:12 PM, Mark Brown <broonie@kernel.org> wrote:

> > No, send me a pull request for the dependencies so we can do a cross
> > merge.  I want to make sure that when this gets reviewed it actually
> > gets merged.

> I'm not quite sure what you mean by the cross merge.  There are no
> dependencies outside this patch set.  The only patches that touch drm
> are patches 1 and 2.  Patch 1 touches both audio and drm, patch 2 just
> touches drm.  Do you want me to send you a pull request for patches 1

I can't see any reason for patch 1 to be a single patch, just have a DRM
patch that adds the property and then a separate audio patch that uses
it.  Send me a pull request for that and patch 2 then I can handle the
audio stuff.

> and 2 and then would you'd send Dave a pull request for the audio side
> (patches 3-6)?

I guess, but I thought you were a maintainer for this stuff and could
merge things yourself?

--uhety2vnu65tf6iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlm6v4QACgkQJNaLcl1U
h9C12gf+K4piz3HzkL8bfoL0aOpEufeZ2lzdAB0iozeO3lUgNvVcOhs5Eaybgz1l
rVRSMf7NSh9m/v+Qf/sUcZsLLyQQ22UCGrexVVnry0x5bsHFddomeThny4ETptmy
kzmtvt/GONq6yrsAxzaZOEU1I21is0Oxs+C10F/+byHh/FIholeyOm7fucNORzHf
AeF2utnKuJ/MhlcEfVpDcykV67NtVDxjmFrHBqIYVksUy3YCic4Yza6yQp9vnlDZ
eCJkJChLC/VL4MG4wdinuptDLAomRldNR+hprFqmXzl6UNffIfglBuhZ4XWPS2BQ
0Uwvn/QQVfqbrRUu5ZUkVoB6iG71sw==
=3+6X
-----END PGP SIGNATURE-----

--uhety2vnu65tf6iv--

--===============1192938193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1192938193==--
