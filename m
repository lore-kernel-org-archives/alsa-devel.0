From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: Makefile - fix the top-level
 kernel module names (add snd- prefix)
Date: Thu, 25 Jul 2019 14:19:08 +0100
Message-ID: <20190725131908.GE4213@sirena.org.uk>
References: <20190725110808.19938-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6600274628597735340=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32BCBF800F5
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 15:19:10 +0200 (CEST)
In-Reply-To: <20190725110808.19938-1-perex@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ALSA development <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6600274628597735340==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2019 at 01:08:08PM +0200, Jaroslav Kysela wrote:
> Use the proper module name. The objs assignments are already there.

This breaks the build for me:

  DESCEND  objtool
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
make[3]: *** No rule to make target 'sound/soc/sof/snd-sof-acpi-dev.o', needed by 'sound/soc/sof/built-in.a'.  Stop.

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl05rEsACgkQJNaLcl1U
h9Cv5Af/a6c3U+b7B7Csg6lYLOWLFRNOtiIXN1tZ8FUCEkndMwNLTpabr6s1ClwP
qwcWhoev2hGl2aZCDN7gjcX63iyoZ09Xb5kqkdJ06aMXllDzEoC+d/GDnRwGq3qS
9NfI6vd5WcqjOnsNxN2SjykvXSYbWJW6zjqX7unhuSyIoxJ8uQQr6zIZj5ZV5zaZ
+QcVxOCVAGfIxwjxe5KIktRScjDNOY29HNK+FtJDqW/t3nQt1xvq2tSDAcIDlQ1X
nQ4q2tNVU2bJEUyFc8EEjBWV/bvTSCUkJEVJH1dV7Rt2FY1NQRwogc7kBQtetE/y
jBu6HWl6EhfdpFtFY3BPBkq78GXFag==
=mEDf
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--

--===============6600274628597735340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6600274628597735340==--
