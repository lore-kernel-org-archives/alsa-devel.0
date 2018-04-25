From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.17
Date: Wed, 25 Apr 2018 11:20:51 +0100
Message-ID: <20180425102051.GA24769@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3591791264785306435=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8965726773E
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 12:21:12 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3591791264785306435==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 445bb423f6a3c50788529a33b82e45148001e855:

  Merge remote-tracking branch 'asoc/topic/zx_aud96p22' into asoc-next (2018-03-28 10:32:03 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-4.17-rc2

for you to fetch changes up to a8419a0cd98ddf628a9e38a92110af7cc650dde7:

  ASoC: msm8916-wcd-analog: use threaded context for mbhc events (2018-04-19 12:30:42 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.17

A small batch of fixes collected since the merge window, none of which
are particularly large or remarkable.  They've all been cooking in -next
for a while.

----------------------------------------------------------------
Arnd Bergmann (1):
      ASoC: rsnd: mark PM functions __maybe_unused

Dan Carpenter (1):
      ASoC: topology: fix some tiny memory leaks

Danny Smith (1):
      ASoC: adau17x1: Handling of DSP_RUN register during fw setup

Liam Girdwood (1):
      ASoC: topology: Check widget kcontrols before deref

Nicolin Chen (2):
      ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
      ASoC: fsl_ssi: Fix mode setting when changing channel number

Pierre-Louis Bossart (1):
      ASoC: Intel: atom: fix ACPI/PCI Kconfig

Srinivas Kandagatla (1):
      ASoC: msm8916-wcd-analog: use threaded context for mbhc events

Tero Kristo (1):
      ASoC: dmic: Fix clock parenting

Wei Yongjun (1):
      ASoC: amd: acp-da7219-max98357: Make symbol da7219_dai_clk static

Yan Wang (1):
      ASoC: topology: Fix bugs of freeing soc topology

oder_chiou@realtek.com (1):
      ASoC: rt5514: Add the missing register in the readable table

 sound/soc/amd/acp-da7219-max98357a.c  |  2 +-
 sound/soc/codecs/adau17x1.c           | 26 ++++++++++++++++++++------
 sound/soc/codecs/adau17x1.h           |  3 ++-
 sound/soc/codecs/msm8916-wcd-analog.c |  9 ++++++---
 sound/soc/codecs/rt5514.c             |  3 +++
 sound/soc/fsl/fsl_esai.c              |  7 +++++++
 sound/soc/fsl/fsl_ssi.c               | 14 +++++++++++---
 sound/soc/intel/Kconfig               | 22 +++++++++++++---------
 sound/soc/omap/omap-dmic.c            | 14 +++++++++++---
 sound/soc/sh/rcar/core.c              |  4 ++--
 sound/soc/soc-topology.c              | 14 +++++++++-----
 11 files changed, 85 insertions(+), 33 deletions(-)

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgVoIACgkQJNaLcl1U
h9B5bgf6ApgYztYdgZVRPXINa9US1TL8okEqLw9HM1ruUaA/xPJ1w9Vy4bJ6KWF/
Bj1pzYc0m4aZwo/5x7BL+r5fDHpSphxXApnQMXYJSkYUkZp6nF5UZvyDAHIvT4x7
ha8f7eUjMv8pLYPEN6sfEHAY8oKVVaAw2+yUXtY+qtnw0h+QQkAQs9zDGSzm5525
HExoV0MX+YDXBpQFEjblQ6WDuJfhPpQhgBsTsBka3pxVwUpD35nz+F26Eyyqve/p
J1EwA9UVonr3IH4xONqvrDOBGKEKOjXQHEMzHzt/qJfHE46r+ORFgstIN5VpkF6Q
98ZboId4yQUN+L8UDeDmb8aJ3z9baA==
=BIcr
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

--===============3591791264785306435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3591791264785306435==--
