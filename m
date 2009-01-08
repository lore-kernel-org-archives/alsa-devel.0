From: Mark Brown <broonie@sirena.org.uk>
Subject: [PATCH 0/7] ASoc updates for -next
Date: Thu, 8 Jan 2009 19:37:20 +0000
Message-ID: <20090108193718.GA29183@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A6FDA24366
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 20:37:24 +0100 (CET)
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

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-tiwai

Ian Molton (1):
      ASoC: dapm: Allow explictly named mixer controls

Mark Brown (4):
      Merge branch 'asoc' of git://git.mnementh.co.uk/linux-2.6-im into for-tiwai
      ASoC: Constify pin names for DAPM pin status APIs
      ASoC: Add jack reporting interface
      ASoC: Implement WM8350 headphone jack detection

Peter Ujfalusi (3):
      ASoC: Merge the soc_value_enum to soc_enum struct
      ASoC: TWL4030: Change the soc_value_enum back to soc_enum
      ASoC: TWL4030: Module unloading fix

 Documentation/sound/alsa/soc/dapm.txt |    3 +
 include/linux/mfd/wm8350/audio.h      |    1 +
 include/sound/soc-dapm.h              |   21 ++++-
 include/sound/soc.h                   |   47 ++++++++----
 sound/soc/Kconfig                     |    1 +
 sound/soc/Makefile                    |    2 +-
 sound/soc/codecs/twl4030.c            |   12 ++-
 sound/soc/codecs/wm8350.c             |  116 +++++++++++++++++++++++++++
 sound/soc/codecs/wm8350.h             |    8 ++
 sound/soc/soc-core.c                  |   37 +--------
 sound/soc/soc-dapm.c                  |  137 +++++++++++----------------------
 sound/soc/soc-jack.c                  |  138 +++++++++++++++++++++++++++++++++
 12 files changed, 372 insertions(+), 151 deletions(-)
 create mode 100644 sound/soc/soc-jack.c
