From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: AMD: add AMD ASoC ACP-I2S driver
	[v4]
Date: Thu, 20 Aug 2015 17:10:39 -0700
Message-ID: <20150821001039.GC12027@sirena.org.uk>
References: <1440101361-9912-1-git-send-email-alexander.deucher@amd.com>
 <1440101361-9912-3-git-send-email-alexander.deucher@amd.com>
 <20150820211305.GU12027@sirena.org.uk>
 <CADnq5_NOd_JLafdvbCs3oVGhDPZC+dD1xD_hL1R8+qaMgr2i3w@mail.gmail.com>
 <20150820223113.GW12027@sirena.org.uk>
 <CADnq5_OGvvbq7=mc5JtcdA2zouUvk1VhV5pHg-Rbp2szQhA2KA@mail.gmail.com>
 <20150820234537.GA12027@sirena.org.uk>
 <CADnq5_MvWi9w4QgmenGDyotdmwSxC+WAdpJUbF+pi5RV_ZmBAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2878749176428448096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B50732654E0
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 02:10:50 +0200 (CEST)
In-Reply-To: <CADnq5_MvWi9w4QgmenGDyotdmwSxC+WAdpJUbF+pi5RV_ZmBAA@mail.gmail.com>
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


--===============2878749176428448096==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xOS8do0ZRfB5pORP"
Content-Disposition: inline


--xOS8do0ZRfB5pORP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2015 at 07:50:34PM -0400, Alex Deucher wrote:
> On Thu, Aug 20, 2015 at 7:45 PM, Mark Brown <broonie@kernel.org> wrote:

> > This is not a DRM driver, it is an ASoC driver, and like I say DRM is a
> > bit special.  I do note that AMD has contributed at least its CCP and
> > cpufreq drivers (indeed all their non-DRM code I could find with
> > explicit license statements) under a normal kernel license.  As far as I
> > can tell this licensing is entirely confined to the DRM drivers.

> > I am not readily able to convince myself that this is compatible with
> > the intent of exporting the ASoC APIs _GPL(), this looks like it can be
> > used as the basis for a shim layer for non-GPL code (the licensing
> > strategy seems very similar).  I'd need to think through this carefully.

> If you have strong concerns, I can double check with our lawyers and
> see about changing it, I'm just not sure how long that will take :(

I at the very least need to think about this, it's really important to
me that we don't want to see proprietary drivers.

> The licensing tends to vary based on the teams involved.  The ACP
> audio and i2s was developed by the GPU teams and we've mostly worked
> on drm and Xorg stuff until now.

For reference the GPL code in the kernel includes at least:

  drivers/crypto/ccp/ccp-crypto-*.c
  drivers/cpufreq/powernow-k8.c
  drivers/pinctrl/pinctrl-amd.c

and there's direct contributions from AMD there AFAICT, not just outside
developers contributing support for AMD chips.

--xOS8do0ZRfB5pORP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1mx6AAoJECTWi3JdVIfQv0AH/iV+MPytyTVfr9rcY6nazT/o
5u19vwRWdHLQr5KUdbr/2jwGlx87OtcISq4y9IbF+VF2vzW7yzRpKtiNlDPFNyCl
do5G4S9gMt7T0rOjx3ICzepP5Fyq77rSOgbeiQlAKBBnZ1svdj/T8EgKPACgsYic
qv01zZ/g6QnbYXkqjQg2VUdD/otcEEflOKQ6JnFU+SqnEy4a86vraXE+vY+3RUWw
Y2epqqEsHK9+OoHhfy7GYZ8NpMsJ9Gc73RMNy/wBkD0IQkM//cpBYYKs4N4a8ZsH
fScbto24dmOPbZ7trL2BFwumOFl8BQkJonabSZ4e4hAa7dyeCEMxlyS/2U4k6KI=
=edQs
-----END PGP SIGNATURE-----

--xOS8do0ZRfB5pORP--

--===============2878749176428448096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2878749176428448096==--
