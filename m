From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: AMD: add AMD ASoC ACP-I2S driver
	[v4]
Date: Thu, 20 Aug 2015 15:31:13 -0700
Message-ID: <20150820223113.GW12027@sirena.org.uk>
References: <1440101361-9912-1-git-send-email-alexander.deucher@amd.com>
 <1440101361-9912-3-git-send-email-alexander.deucher@amd.com>
 <20150820211305.GU12027@sirena.org.uk>
 <CADnq5_NOd_JLafdvbCs3oVGhDPZC+dD1xD_hL1R8+qaMgr2i3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3037942308394400113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 88920265388
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 00:31:26 +0200 (CEST)
In-Reply-To: <CADnq5_NOd_JLafdvbCs3oVGhDPZC+dD1xD_hL1R8+qaMgr2i3w@mail.gmail.com>
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


--===============3037942308394400113==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tpZe61tYkA9f+p/0"
Content-Disposition: inline


--tpZe61tYkA9f+p/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2015 at 05:30:27PM -0400, Alex Deucher wrote:
> On Thu, Aug 20, 2015 at 5:13 PM, Mark Brown <broonie@kernel.org> wrote:

> >> v4: squash in naming fixes

> > To repeat what I said last time:

> > | Please follow the patch submission process in SubmittingPatches: put any
> > | versioning in the subject line inside the [] and put noise like inter
> > | version changelogs after the ---.

> I addressed this in my coverletter.  Some subsystems prefer to retain
> that information.  If you'd prefer to not have them in the audio patch
> I will remove them.

When I said to follow the standard process here that's what I meant,
yes.  It's basically just the graphics subsystem that does something
different here, and note that if you are going to include a changelog
(either in the normal place or the DRM place) it really ought to
actually describe the changes that have been made - the above doesn't
reflect the changes that were made at all.

> > I also remain very concerned about this non-GPL license you are using.
> > Please do not ignore review comments like this :(

> I mentioned this in the cover letter as well.  Most if not all of the
> drm drivers are licensed the same way.  IANAL, but I am not aware of
> any concerns about them.

DRM is a special case here since there has always been work to share
bits of the code with other operating systems, the licensing for DRM is
very unusual within the kernel.  A quick sampling of drivers suggests
that this license is not universally used there either.

There is also the issue I raised with the fact that your non-GPL license
statement does not appear to correspond to the MODULE_LICENSE() that
you've included which claims the code is GPLed.

--tpZe61tYkA9f+p/0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1lUtAAoJECTWi3JdVIfQkucH+wUsO+7PiGKyA99h656opIxb
yPA7dVef507n3I0SuqHsCMgXqG3thbi5igPOI6/kzQCXq701x5FJ4iQzh/0VuI8P
Tq4WBXtLNnRcc8R4Rzi2t7E3abb71BgKv2LZ2KLJjmP6XOtbcTruYd20PMaFHsUv
+wGLgzcH5AGS88CsbJRY8o6bR8lZNV2myPcqfLvZ/K7eGa1UUk16UEXzXL5cqXMn
XcuINxXd6AxRIyTOTI1xLuf56RI1iJLQ7rV6WXZ3VZYPjSXUsTCVuNm0mL/tW4II
pxixU8MxrZmZ6MydF1FQ+sNB7TZ3Q0pauVA6/1ADdnJ3GF7SIsLCV35MfjGgktU=
=0sjp
-----END PGP SIGNATURE-----

--tpZe61tYkA9f+p/0--

--===============3037942308394400113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3037942308394400113==--
