From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 0/6 v4] Add ASoC support for AMD Stoney APUs
Date: Thu, 28 Sep 2017 11:59:36 -0700
Message-ID: <20170928185936.zajc466sp6ttuh7v@sirena.org.uk>
References: <1505325475-22602-1-git-send-email-alexander.deucher@amd.com>
 <20170913181218.bb2br4zehzjoatyq@sirena.org.uk>
 <CADnq5_PdpjS448n6u6tPBqgKfEw278BENMTjVPiEQ4zQx313AA@mail.gmail.com>
 <20170914174228.esh6lvih3yjs46ur@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1217676945=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170914174228.esh6lvih3yjs46ur@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============1217676945==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rl3hrlvw3hlgygif"
Content-Disposition: inline


--rl3hrlvw3hlgygif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 14, 2017 at 10:42:28AM -0700, Mark Brown wrote:
> On Wed, Sep 13, 2017 at 02:49:08PM -0400, Alex Deucher wrote:

> > I'm not quite sure what you mean by the cross merge.  There are no
> > dependencies outside this patch set.  The only patches that touch drm
> > are patches 1 and 2.  Patch 1 touches both audio and drm, patch 2 just
> > touches drm.  Do you want me to send you a pull request for patches 1

> I can't see any reason for patch 1 to be a single patch, just have a DRM
> patch that adds the property and then a separate audio patch that uses
> it.  Send me a pull request for that and patch 2 then I can handle the
> audio stuff.

Any updates with the pull requests?

--rl3hrlvw3hlgygif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnNRpcACgkQJNaLcl1U
h9D1TAf9EGk3yxKTSQwT+eFkJgsN1dFMLXqwytoA2TaKjU2/l4UcX4YJ8rhNujpQ
jAi1LUp+Rq0S8XY7c7DrRW2jz2wq/dlT/bob3KikfgoAfNBi7zZSjGDoV86omGA1
zRIwuwuT+y7Vt8504esS8MaCr8aS0GqexMNVhWxFZqP9KuAgkGdEca0kQVXsONSB
0RnCFcy8LPxo0sdez+pwJnl0bBCM/1iV52IHsYWuCnxeLB7lknUKbM1mRR3ThqXp
elRZ6+E7XpJTgNHFMwZHdZBDIscewTbHxx6zDeQAlgSMzJeBZZtPnbggAt5dvDt8
HNdqRdu5u3R7NIqfZQ3lFVb1bsfZwA==
=fOcK
-----END PGP SIGNATURE-----

--rl3hrlvw3hlgygif--

--===============1217676945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1217676945==--
