From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Fri, 7 Aug 2009 12:08:16 +0100
Message-ID: <20090807110816.GA9068@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1C621038EB
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 13:08:17 +0200 (CEST)
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

The following changes since commit 6d7f68a1eab3d5b3c0a6a5cf9434c77cd3a8c6ac:
  Janusz Krzysztofik (1):
        ASoC: add support for Amstrad E3 (Delta) machine

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

There's a merge up of a for-2.6.31 change in here which I've not pushed
yet since the change is relatively invasive for so late in the release
cycle (the OMAP simultaneous audio change).  I didn't redo the branch
in case it does get pushed; worst case it's just an extra merge commit
which isn't the end of the world.

Daniel Mack (1):
      ALSA: ASoC: cs4270: move power management hooks to snd_soc_codec_device

Janusz Krzysztofik (3):
      ASoC: CX20442: add some debugging
      ASoC: CX20442: simplify codec controller usage
      TTY/ASoC: Rename N_AMSDELTA line discipline to N_V253

Jarkko Nikula (1):
      ARM: OMAP: McBSP: Fix ASoC on OMAP1510 by fixing API of omap_mcbsp_start/stop

John Bonesio (1):
      ASoC: MPC5200: Support for buffer wrap around

Mark Brown (12):
      ASoC: Begin to factor out register cache I/O functions
      ASoC: Remove use of hw_read from TLV320AIC3x driver
      ASoC: Factor out WM8580 register cache code
      Merge branch 'tlv320aic3x' into reg-cache
      ASoC: Add I/O control bus information to factored out cache setup
      ASoC: Factor out I2C 8 bit address 16 bit data I/O
      ASoC: Factor out I/O for Wolfson 8 bit data 16 bit register CODECs
      ASoC: Factor out 7 bit register 9 bit data SPI write
      ASoC: Existing S3C24xx AC97 drivers should depend on S3C24xx
      ASoC: Add WM8776 CODEC driver
      Merge branch 'for-2.6.31' into for-2.6.32
      Merge branch 'reg-cache' into for-2.6.32

Troy Kisky (2):
      ASoC: DaVinci: i2s: don't bounce through rtd to get dai
      ASoC: DaVinci: pcm, constrain buffer size to multiple of period

 arch/arm/plat-omap/include/mach/mcbsp.h |    4 +-
 arch/arm/plat-omap/mcbsp.c              |   50 ++-
 include/linux/tty.h                     |    2 +-
 include/sound/soc.h                     |   11 +-
 sound/soc/Makefile                      |    2 +-
 sound/soc/codecs/Kconfig                |    4 +
 sound/soc/codecs/Makefile               |    2 +
 sound/soc/codecs/cs4270.c               |   27 +-
 sound/soc/codecs/cx20442.c              |    3 +-
 sound/soc/codecs/tlv320aic3x.c          |   11 +-
 sound/soc/codecs/wm8510.c               |  174 +++-----
 sound/soc/codecs/wm8523.c               |   98 +---
 sound/soc/codecs/wm8580.c               |  154 ++-----
 sound/soc/codecs/wm8728.c               |  111 +----
 sound/soc/codecs/wm8731.c               |  141 ++-----
 sound/soc/codecs/wm8750.c               |  154 ++-----
 sound/soc/codecs/wm8776.c               |  781 +++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8776.h               |   51 ++
 sound/soc/codecs/wm8900.c               |  319 +++++--------
 sound/soc/codecs/wm8903.c               |  244 ++++-------
 sound/soc/codecs/wm8940.c               |  143 ++----
 sound/soc/codecs/wm8960.c               |  200 +++-----
 sound/soc/codecs/wm8961.c               |  231 ++++------
 sound/soc/codecs/wm8971.c               |  127 ++----
 sound/soc/codecs/wm8988.c               |  138 ++----
 sound/soc/codecs/wm8990.c               |  194 +++-----
 sound/soc/codecs/wm9081.c               |  229 ++++------
 sound/soc/davinci/davinci-i2s.c         |   14 +-
 sound/soc/davinci/davinci-pcm.c         |    5 +
 sound/soc/fsl/mpc5200_dma.c             |   17 +
 sound/soc/omap/ams-delta.c              |    6 +-
 sound/soc/omap/omap-mcbsp.c             |   10 +-
 sound/soc/s3c24xx/Kconfig               |    4 +-
 sound/soc/soc-cache.c                   |  218 +++++++++
 34 files changed, 2048 insertions(+), 1831 deletions(-)
 create mode 100644 sound/soc/codecs/wm8776.c
 create mode 100644 sound/soc/codecs/wm8776.h
 create mode 100644 sound/soc/soc-cache.c
