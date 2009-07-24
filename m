From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Fri, 24 Jul 2009 15:33:41 +0100
Message-ID: <20090724143341.GA2691@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E547624600
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 16:33:42 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 416c8fe3cdcd2d46a6ca12d8ec6143c62d8569d9:
  Takashi Iwai (1):
        ASoC: Kill direct accesses to driver_data

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Candelaria Villareal, Jorge (1):
      ASoC: SDP3430: Add support for EXTMUTE using TWL GPIO6

Chaithrika U S (1):
      ASoC: tlv320aic3x: Enable PLL when not bypassed

Janusz Krzysztofik (2):
      ASoC: Add support for Conexant CX20442-11 voice modem codec
      ASoC: Jack handling enhancements as suggested by subsystem maintainer

John Bonesio (1):
      ASoC: MPC5200: Increase the delay time between resets

Joonyoung Shim (2):
      ASoC: MAX9877: separate callback functions
      ASoC: MAX9877: fix write operation for register

Lopez Cruz, Misael (1):
      ASoC: OMAP: Staticise pcm creation function of omap-pcm

Marek Vasut (2):
      ALSA: Allow passing platform_data to devices attached to AC97 bus
      ASoC: Switch palm27x-asoc to jack detection api

Mark Brown (4):
      ASoC: Bodge around GCC 4.4.0 flow analysis bug in GCC 4.4.0
      ASoC: Fix FLL reference clock division setup in WM8993
      ASoC: Fix checkpatch issues in AD1938
      Merge branch 'for-2.6.31' into for-2.6.32

 include/sound/ac97_codec.h       |    6 +
 include/sound/soc-dai.h          |    1 +
 sound/soc/codecs/Kconfig         |    3 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/ad1938.c        |  156 ++++++++--------
 sound/soc/codecs/cx20442.c       |  395 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cx20442.h       |   19 ++
 sound/soc/codecs/max9877.c       |  110 +++++++----
 sound/soc/codecs/tlv320aic3x.c   |   11 +-
 sound/soc/codecs/wm8400.c        |    9 +-
 sound/soc/codecs/wm8993.c        |    2 +
 sound/soc/fsl/mpc5200_psc_ac97.c |    3 +-
 sound/soc/omap/omap-pcm.c        |    2 +-
 sound/soc/omap/sdp3430.c         |    9 +
 sound/soc/pxa/palm27x.c          |  204 +++++++-------------
 sound/soc/soc-core.c             |    6 +-
 sound/soc/soc-jack.c             |   20 ++-
 17 files changed, 703 insertions(+), 255 deletions(-)
 create mode 100644 sound/soc/codecs/cx20442.c
 create mode 100644 sound/soc/codecs/cx20442.h
