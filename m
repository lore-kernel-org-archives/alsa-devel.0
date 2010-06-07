From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.36
Date: Mon, 7 Jun 2010 14:41:58 +0100
Message-ID: <20100607134158.GG13287@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CCAE0245AA
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 15:41:59 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 1fab79b8a1bf0d46a7c7e6a1c06dbed1803f403c:

  Merge branch 'for-2.6.36' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/broonie/sound-2.6 into topic/asoc (2010-05-31 18:13:20 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.36

Eric B=E9nard (2):
      ASoC: imx-ssi.c: add new choices to platform configuration
      ASoC: imx: add eukrea-tlv320

Mark Brown (1):
      Merge branch 'for-2.6.35' into for-2.6.36

Ryan Mallon (1):
      ASoC: ep93xx i2s audio driver

Sascha Hauer (2):
      ASoC: Add missing Kconfig entry for Phytec boards
      ASoC: MX31ads sound support should depend on MACH_MX31ADS_WM1133_EV1

Wan ZongShun (10):
      ASoC: nuc900: patch for SUBSTREAM_TYPE', 'PCM_TX' and 'PCM_RX' removal
      ASoC: nuc900: fix a wait loop bug
      ASoC: nuc900: fix a typo and rename the header file
      ASoC: nuc900: patch for modifing the ac97 delays to minimum
      ASoC: s6000: use resource_size for {request/release}_mem_region and i=
oremap
      ASoC: use resource_size for au1x
      ASoC: atmel: patch for the unnecessary variable removal
      ASoC: s3c: patch for the unnecessary variable 'state' removal
      ASoC: atmel: trivial code cleanup
      ASoC: patch for the useless 'break' removal in kirkwood

 arch/arm/plat-mxc/include/mach/ssi.h               |    3 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/atmel/atmel-pcm.c                        |    1 -
 sound/soc/atmel/atmel_ssc_dai.c                    |    1 -
 sound/soc/au1x/psc-ac97.c                          |   13 +-
 sound/soc/au1x/psc-i2s.c                           |   13 +-
 sound/soc/au1x/psc.h                               |    1 -
 sound/soc/ep93xx/Kconfig                           |    9 +
 sound/soc/ep93xx/Makefile                          |    8 +
 sound/soc/ep93xx/ep93xx-i2s.c                      |  487 ++++++++++++++++=
++++
 sound/soc/ep93xx/ep93xx-i2s.h                      |   18 +
 sound/soc/ep93xx/ep93xx-pcm.c                      |  319 +++++++++++++
 sound/soc/ep93xx/ep93xx-pcm.h                      |   22 +
 sound/soc/imx/Kconfig                              |   20 +-
 sound/soc/imx/Makefile                             |    2 +
 sound/soc/imx/eukrea-tlv320.c                      |  135 ++++++
 sound/soc/imx/imx-ssi.c                            |   11 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |    1 -
 sound/soc/nuc900/nuc900-ac97.c                     |   32 +-
 .../soc/nuc900/{nuc900-auido.h =3D> nuc900-audio.h}  |    4 -
 sound/soc/nuc900/nuc900-pcm.c                      |   18 +-
 sound/soc/s3c24xx/s3c-ac97.c                       |    1 -
 sound/soc/s6000/s6000-i2s.c                        |   38 +-
 24 files changed, 1080 insertions(+), 79 deletions(-)
 create mode 100644 sound/soc/ep93xx/Kconfig
 create mode 100644 sound/soc/ep93xx/Makefile
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.c
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.h
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.c
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.h
 create mode 100644 sound/soc/imx/eukrea-tlv320.c
 rename sound/soc/nuc900/{nuc900-auido.h =3D> nuc900-audio.h} (95%)
