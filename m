From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [GIT PULL] ASoC updates for v3.8
Date: Thu, 10 Jan 2013 12:49:10 +0000
Message-ID: <20130110124910.GP20956@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1811903989921032683=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 92D0A2615FA
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 13:57:51 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1811903989921032683==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftQmbtOmUf2cr8rB"
Content-Disposition: inline


--ftQmbtOmUf2cr8rB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-3.8-rc2

for you to fetch changes up to 49a170bcf28af5ef372cdbed7750ba8d4162bb0e:

  Merge remote-tracking branch 'asoc/fix/wm5100' into tmp (2013-01-10 12:22:30 +0000)

----------------------------------------------------------------

ASoC: Fixes for v3.8

Nothing terribly exciting here except for the DOUBLE_RANGE fix which
just hadn't worked before, nobody noticed due to lack of use.

----------------------------------------------------------------
Axel Lin (5):
      ASoC: sta529: Fix update register bits in sta529_set_dai_fmt
      ASoC: wm2200: Fix setting dai format in wm2200_set_fmt
      ASoC: lm49453: Fix mask for setting mode bit in lm49453_set_dai_fmt()
      ASoC: arizona: Do proper shift for setting AIF rate
      ASoC: cs42l52: Catch no-match case in cs42l52_get_clk

Chuansheng Liu (2):
      ASoC: core: fix the memory leak in case of device_add() failure
      ASoC: core: fix the memory leak in case of remove_aux_dev()

Daniel Mack (2):
      ASoC: cs4271: fix sparse warning
      ASoC: cs4271: fix property check

Fabio Estevam (2):
      ASoC: soc-core: Remove unused 'ret' variable
      ASoC: sgtl5000: Fix maximum value for microphone gain

MR.Swami.Reddy@ti.com (2):
      ASoC: lm49453: Fix adc, mic and sidetone volume ranges
      ASoC: lm49453: Update lm49453_reg_defs values as per LM49453 HW revision-B

Mark Brown (20):
      ASoC: core: Fix SOC_DOUBLE_RANGE() macros
      ASoC: arizona: Correct FLL source definitions
      ASoC: wm5102: Improve speaker enable performance
      ASoC: wm2200: Remove DSP B and left justified AIF modes
      ASoC: arizona: Remove DSP B and left justified AIF modes
      ASoC: wm5100: Remove DSP B and left justified formats
      ASoC: wm2000: Fix sense of speech clarity enable
      ASoC: wm_adsp: Ensure that block writes are from DMA aligned addresses
      Merge remote-tracking branch 'asoc/fix/arizona' into tmp
      Merge remote-tracking branch 'asoc/fix/core' into tmp
      Merge remote-tracking branch 'asoc/fix/cs4271' into tmp
      Merge remote-tracking branch 'asoc/fix/cs42l52' into tmp
      Merge remote-tracking branch 'asoc/fix/lm49453' into tmp
      Merge remote-tracking branch 'asoc/fix/pxa' into tmp
      Merge remote-tracking branch 'asoc/fix/sgtl5000' into tmp
      Merge remote-tracking branch 'asoc/fix/sta529' into tmp
      Merge remote-tracking branch 'asoc/fix/wm-adsp' into tmp
      Merge remote-tracking branch 'asoc/fix/wm2000' into tmp
      Merge remote-tracking branch 'asoc/fix/wm2200' into tmp
      Merge remote-tracking branch 'asoc/fix/wm5100' into tmp

Mike Dunn (2):
      ALSA: pxa27x: fix ac97 cold reset
      ALSA: pxa27x: fix ac97 warm reset

Patrick Lai (1):
      ASoC: pcm: allow backend hardware to be freed in pause state

 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    3 +
 arch/arm/mach-pxa/pxa27x.c                  |    4 +-
 include/sound/cs4271.h                      |    2 +-
 include/sound/soc.h                         |   10 ++-
 sound/arm/pxa2xx-ac97-lib.c                 |   26 ++++++-
 sound/soc/codecs/arizona.c                  |    9 +--
 sound/soc/codecs/arizona.h                  |   18 ++---
 sound/soc/codecs/cs4271.c                   |    6 +-
 sound/soc/codecs/cs42l52.c                  |    4 +-
 sound/soc/codecs/lm49453.c                  |  106 ++++++++++-----------------
 sound/soc/codecs/sgtl5000.c                 |    4 +-
 sound/soc/codecs/sta529.c                   |    9 ++-
 sound/soc/codecs/wm2000.c                   |    4 +-
 sound/soc/codecs/wm2200.c                   |    8 +-
 sound/soc/codecs/wm5100.c                   |    6 --
 sound/soc/codecs/wm5102.c                   |   48 +++++++++++-
 sound/soc/codecs/wm_adsp.c                  |   23 +++++-
 sound/soc/soc-core.c                        |   35 ++++++++-
 sound/soc/soc-pcm.c                         |    1 +
 19 files changed, 201 insertions(+), 125 deletions(-)

--ftQmbtOmUf2cr8rB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJQ7ri9AAoJELSic+t+oim9IrQP+OfskS6pI83xUVsqDjD91fUe
gPVsDmKJYA6tzSDJZ2pnymJwvMOJTWnlzUg2jEO79SaNsgXgv2Ll97Kn33lc8Etg
d4EXZyXdh/IE5gRs7RMroEpNIS65w44SY/FscEKzagK2ub7eKP4x7DiI6fQglISP
rFO4ys9JJirLv5UmKi4gJgqcH0iQqC7GmoqxLTiZz19MGsB1VGubDschmcdt9M3Y
TnQZu8I1zqB2W+e6wyqYpxKiH/JKsr44shg/btUKJNF0ZYeJH8kWkQV0zX2P9/+0
h8Nu0sOCT2K0yRSk37coNj7fRD9J/5QcpUjlxQUOU0RHx5xUZ4ga6nD5R3Imtfhj
BRg6le1ff1e0WLfqdW5ifUN02I+Pd40MHN6jgZTAFW0sQb7iIQAUNFio6+6Y4UtB
BYRtXr1kdaN6sWmGknLOw/NPFZTq00saJNzZiIYhKB6kV0TbDff/HIiuU8kaQw3h
vqISdQFPgStC7aG+1dgdqsu2R6rD98dBRgGxD6zdIV+A86V5byItfGUGCRi+ZSYM
S5uvZQt7tterJOQNw9Cy+y2VRZP0NiYoEG3oVcaJi7NWQKAKsMoz3wuzdjZrsfZV
3vOOWjPzs++DhsjIz4L/J9ivqAepIBZoNZVr68NkZ2kI/3DC1rfEYz+P2FIVaBOt
5cSjepvTXAejag26XM0=
=vQtU
-----END PGP SIGNATURE-----

--ftQmbtOmUf2cr8rB--

--===============1811903989921032683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1811903989921032683==--
