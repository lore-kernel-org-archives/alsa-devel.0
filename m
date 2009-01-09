From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Fri, 9 Jan 2009 11:44:07 +0000
Message-ID: <20090109114407.GB5170@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5A8E9103855
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 12:44:08 +0100 (CET)
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

The following changes since commit 227b4dc6432d271eecd0ff0aefe6f0897ec47397:
  Mark Brown (1):
        ASoC: Fix SND_SOC_ALL_CODECS handling of dual SPI and I2C control buses

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Ian Molton (2):
      ASoC: dapm: Allow explictly named mixer controls
      ASoC: cleanup duplicated code.

Mark Brown (4):
      ASoC: Constify pin names for DAPM pin status APIs
      ASoC: Add jack reporting interface
      ASoC: Implement WM8350 headphone jack detection
      Merge branch 'for-2.6.29' into for-2.6.30

Peter Ujfalusi (3):
      ASoC: Merge the soc_value_enum to soc_enum struct
      ASoC: TWL4030: Change the soc_value_enum back to soc_enum
      ASoC: TWL4030: Module unloading fix

 Documentation/sound/alsa/soc/dapm.txt |    3 +
 include/linux/mfd/wm8350/audio.h      |    1 +
 include/sound/soc-dapm.h              |   21 ++++-
 include/sound/soc.h                   |   49 ++++++++----
 sound/soc/Kconfig                     |    1 +
 sound/soc/Makefile                    |    2 +-
 sound/soc/codecs/ad1980.c             |   17 +----
 sound/soc/codecs/ak4535.c             |   18 +----
 sound/soc/codecs/ssm2602.c            |   18 +----
 sound/soc/codecs/tlv320aic23.c        |   21 +-----
 sound/soc/codecs/tlv320aic3x.c        |   19 +----
 sound/soc/codecs/twl4030.c            |   31 ++-----
 sound/soc/codecs/uda134x.c            |   50 ++++--------
 sound/soc/codecs/uda1380.c            |   18 +----
 sound/soc/codecs/wm8350.c             |  134 ++++++++++++++++++++++++++++----
 sound/soc/codecs/wm8350.h             |    8 ++
 sound/soc/codecs/wm8510.c             |   19 +----
 sound/soc/codecs/wm8580.c             |   17 +----
 sound/soc/codecs/wm8728.c             |   18 +----
 sound/soc/codecs/wm8731.c             |   19 +----
 sound/soc/codecs/wm8750.c             |   18 +----
 sound/soc/codecs/wm8753.c             |   18 +----
 sound/soc/codecs/wm8900.c             |   19 +----
 sound/soc/codecs/wm8903.c             |   18 +----
 sound/soc/codecs/wm8971.c             |   18 +----
 sound/soc/codecs/wm8990.c             |   18 +----
 sound/soc/codecs/wm9712.c             |   18 +----
 sound/soc/codecs/wm9713.c             |   18 +----
 sound/soc/soc-core.c                  |   68 ++++++++--------
 sound/soc/soc-dapm.c                  |  137 +++++++++++----------------------
 sound/soc/soc-jack.c                  |  138 +++++++++++++++++++++++++++++++++
 31 files changed, 461 insertions(+), 511 deletions(-)
 create mode 100644 sound/soc/soc-jack.c
