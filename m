From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: AMD: add AMD ASoC ACP-I2S driver
	[v4]
Date: Thu, 20 Aug 2015 16:45:37 -0700
Message-ID: <20150820234537.GA12027@sirena.org.uk>
References: <1440101361-9912-1-git-send-email-alexander.deucher@amd.com>
 <1440101361-9912-3-git-send-email-alexander.deucher@amd.com>
 <20150820211305.GU12027@sirena.org.uk>
 <CADnq5_NOd_JLafdvbCs3oVGhDPZC+dD1xD_hL1R8+qaMgr2i3w@mail.gmail.com>
 <20150820223113.GW12027@sirena.org.uk>
 <CADnq5_OGvvbq7=mc5JtcdA2zouUvk1VhV5pHg-Rbp2szQhA2KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9153786551301114887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC45A265467
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 01:45:51 +0200 (CEST)
In-Reply-To: <CADnq5_OGvvbq7=mc5JtcdA2zouUvk1VhV5pHg-Rbp2szQhA2KA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9153786551301114887==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gz4FNQG/2iJjJcgR"
Content-Disposition: inline


--gz4FNQG/2iJjJcgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2015 at 07:11:22PM -0400, Alex Deucher wrote:
> On Thu, Aug 20, 2015 at 6:31 PM, Mark Brown <broonie@kernel.org> wrote:

> > DRM is a special case here since there has always been work to share
> > bits of the code with other operating systems, the licensing for DRM is
> > very unusual within the kernel.  A quick sampling of drivers suggests
> > that this license is not universally used there either.

> > There is also the issue I raised with the fact that your non-GPL license
> > statement does not appear to correspond to the MODULE_LICENSE() that
> > you've included which claims the code is GPLed.

> Once again this is exactly what the other drm drivers and support
> modules do.  AMD generally prefers to contribute code licensed under
> an MIT/X11 style licence which is why we've done this.  IANAL, but I
> think that is compatible with "GPL and additional rights".

This is not a DRM driver, it is an ASoC driver, and like I say DRM is a
bit special.  I do note that AMD has contributed at least its CCP and
cpufreq drivers (indeed all their non-DRM code I could find with
explicit license statements) under a normal kernel license.  As far as I
can tell this licensing is entirely confined to the DRM drivers.

I am not readily able to convince myself that this is compatible with
the intent of exporting the ASoC APIs _GPL(), this looks like it can be
used as the basis for a shim layer for non-GPL code (the licensing
strategy seems very similar).  I'd need to think through this carefully.

--gz4FNQG/2iJjJcgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1madAAoJECTWi3JdVIfQYjgH/14nPcvRkWkz4JyWg7gtn/4D
PsxeJzBkmkSyIcOtGB/DkqG6ioUgKcMF7LPgazl7hKy5mniPWJUgwpVgu3Q63RFF
sb9DSUbdjGLHFz0kzzUjKTiI0nVPec7PV297pNuffxfGbsO8TdA9svigweR2frXK
14+saUdN5NRT5r76DduomEe8ZyE2Xe3n/ndupZ/lu4Oybp5XtF8BeCp74dIZrLor
JhQ/1oB40tnPH587XfI5RdIA/233DBP47QSx0isPmfeWOJuYmjFadTBvc5wXmfDh
ylfEmB1T1qVLvItohJeTJWbVOe8iZCRvL6ZfO9Dc3EAtfrKigsNE3Hyub02IsRc=
=kmhm
-----END PGP SIGNATURE-----

--gz4FNQG/2iJjJcgR--

--===============9153786551301114887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9153786551301114887==--
