From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v4.4
Date: Fri, 25 Sep 2015 09:33:11 -0700
Message-ID: <20150925163311.GH30445@sirena.org.uk>
References: <20150924203908.GF30445@sirena.org.uk>
 <s5h4mijq9xj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1100456701666748469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2635C26064C
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2015 18:33:52 +0200 (CEST)
In-Reply-To: <s5h4mijq9xj.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1100456701666748469==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IfZ7xA51UQS4uQU3"
Content-Disposition: inline


--IfZ7xA51UQS4uQU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2015 at 08:39:52AM +0200, Takashi Iwai wrote:

> I got the following warning at build test:

> WARNING: sound/soc/codecs/snd-soc-rt5645.o(.text+0x21d5): Section
> mismatch in reference from the function rt5645_i2c_probe() to the variable .init.data:dmi_platform_intel_broadwell
> The function rt5645_i2c_probe() references the variable __initdata dmi_platform_intel_broadwell.
> This is often because rt5645_i2c_probe lacks a __initdata annotation or the annotation of dmi_platform_intel_broadwell is wrong.

> I pulled now, in anyway, since this is no serious issue.
> In case where the bug is still not fixed, added John and Bard to Cc.

Yes, 0day already reported it.  :/

--IfZ7xA51UQS4uQU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWBXdBAAoJECTWi3JdVIfQiWgH/3w2h6GcQOELR0XSbD1EM3zD
kBg+v43uecfKiIvgbRAmXlydVjs+AwROZ9CHbmaXdlEzKZIiD4Zf/K4YD2YJUxCf
IbPZhgMQ3wyHL1RIgi+/7cZJ4wcSEfwA1GL4eI8CYIwdg4wcR5pLmElAMbMpPSvM
meMO99tUXvOI5WSwEn1Is7Da2EFigQygkVZb7ZCQKU0IhhBM1wrxrZEWiMSTw6Y2
uaERASj7jG+sRD3quztZBvWc/xNCcY0f3Cn9ZSK6DRBO9vUXx+GrjPqcbxzQ4uAQ
uRq4uyAEtsP/d061112N0h6A21SAvnOYQbCsH58OmmQ9JdTjLgDy639jRB9Q9Qw=
=F7WN
-----END PGP SIGNATURE-----

--IfZ7xA51UQS4uQU3--

--===============1100456701666748469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1100456701666748469==--
