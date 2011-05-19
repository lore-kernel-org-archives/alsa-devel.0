From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.40
Date: Thu, 19 May 2011 14:24:22 -0700
Message-ID: <20110519212422.GH18849@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42F25103A6E
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 23:24:20 +0200 (CEST)
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
To: Takashi Iwai <tiawi@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 0f3c6af92100193cf9a86bdd0ee35e6da3e0c56e:

  Merge branch 'for-2.6.39' into for-2.6.40 (2011-05-10 15:58:17 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.40

Ben Gardiner (1):
      ASoC: davinci-mcasp: enable ping-pong SRAM buffers

Dmitry Artamonow (2):
      ASoC: Asahi Kasei AK4641 codec driver
      ASoC: add iPAQ hx4700 machine driver

Jarkko Nikula (1):
      ASoC: Fix wrong data type access in a few codec drivers

Jin Park (3):
      ASoC: codecs: max98088: Fixed invalid register definitions in mixer controls
      ASoC: codecs: max98088: Moved the EX Limiter Mode from dapm widget to control
      ASoC: codecs: max98088: Added digital mute function in DAI1 and DAI2

Liam Girdwood (1):
      ASoC: core - allow ASoC more flexible machine name

Mark Brown (10):
      ASoC: Fix NULL vs. 0 warning in SSM2602
      ASoC: Don't squash 16x8 registers down to 8 bits
      ASoC: Remove byte swap in 4x12 SPI write
      ASoC: Use spi_write() for SPI writes
      ASoC: Disable WM8994/58 microphone detection over suspend
      ASoC: Reintroduce do_spi_write()
      ASoC: Ensure output PGA is enabled for line outputs in wm_hubs
      ASoC: Add some missing volume update bit sets for wm_hubs devices
      ASoC: Skip noop reconfiguration of WM8958 DSP2 algorithms
      ASoC: Don't restart an already running WM8958 DSP2

Misael Lopez Cruz (1):
      ASoC: DMIC codec - Add input widget

Randy Dunlap (1):
      ASoC: fix wm8958-dsp2 printk format warnings

Stephen Boyd (1):
      ASoC: Silence DEBUG_STRICT_USER_COPY_CHECKS=y warning

Taylor Hutt (1):
      ASoC: Max98095: Move existing NULL check before pointer dereference.

 include/sound/ak4641.h            |   26 ++
 include/sound/soc.h               |    2 +
 sound/soc/codecs/Kconfig          |    4 +
 sound/soc/codecs/Makefile         |    2 +
 sound/soc/codecs/ak4641.c         |  664 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak4641.h         |   47 +++
 sound/soc/codecs/dmic.c           |   26 ++-
 sound/soc/codecs/max98088.c       |   62 +++-
 sound/soc/codecs/max98088.h       |   13 +
 sound/soc/codecs/max98095.c       |   16 +-
 sound/soc/codecs/ssm2602.c        |    2 +-
 sound/soc/codecs/tlv320aic3x.c    |    3 +-
 sound/soc/codecs/wm8903.c         |    3 +-
 sound/soc/codecs/wm8958-dsp2.c    |   29 ++-
 sound/soc/codecs/wm8993.c         |    3 +-
 sound/soc/codecs/wm8994.c         |   31 ++-
 sound/soc/codecs/wm8995.c         |    4 +-
 sound/soc/codecs/wm_hubs.c        |   24 +-
 sound/soc/davinci/davinci-mcasp.c |    2 +
 sound/soc/pxa/Kconfig             |    9 +
 sound/soc/pxa/Makefile            |    2 +
 sound/soc/pxa/hx4700.c            |  255 ++++++++++++++
 sound/soc/soc-cache.c             |  140 +-------
 sound/soc/soc-core.c              |    8 +-
 24 files changed, 1199 insertions(+), 178 deletions(-)
 create mode 100644 include/sound/ak4641.h
 create mode 100644 sound/soc/codecs/ak4641.c
 create mode 100644 sound/soc/codecs/ak4641.h
 create mode 100644 sound/soc/pxa/hx4700.c
