From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Fri, 31 Jul 2009 22:58:47 +0100
Message-ID: <20090731215847.GD6335@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ED5724715
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 23:58:54 +0200 (CEST)
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

The following changes since commit c8489c3ed319677f23e5387fec09c844365566e8:
  Barry Song (1):
        ASoC: board driver to connect bf5xx with ad1938

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Barry Song (1):
      ASoC: Fix checkpatch issues and typos of ad1938 codec and bf5xx-tdm dai

Janusz Krzysztofik (3):
      TTY: Add definition of a new line discipline required by Amstrad E3 (Delta) ASoC driver
      ASoC: CX20442: push down machine independent line discipline bits
      ASoC: add support for Amstrad E3 (Delta) machine

Lars-Peter Clausen (3):
      ASoC: neo1973_gta02_wm8753: Replace snd_soc_cnew with snd_soc_add_controls.
      ASoC: neo1973_gta02_wm8753: Replace deprecated s3c_gpio calls with gpiolib
      ASoC: jack: Fix race in snd_soc_jack_add_gpios

Mark Brown (3):
      ASoC: Add Openmoko Neo FreeRunner (GTA02) audio driver
      Merge branch 'gta02-audio' into for-2.6.32
      ASoC: Allow CODECs to flag invalid registers

 include/linux/tty.h                      |    4 +-
 include/sound/soc.h                      |    1 +
 sound/soc/blackfin/bf5xx-tdm-pcm.c       |    4 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.h       |    2 +-
 sound/soc/blackfin/bf5xx-tdm.h           |    2 +-
 sound/soc/codecs/ad1938.c                |   50 ++-
 sound/soc/codecs/cx20442.c               |  116 +++++-
 sound/soc/codecs/cx20442.h               |    1 +
 sound/soc/omap/Kconfig                   |    8 +
 sound/soc/omap/Makefile                  |    2 +
 sound/soc/omap/ams-delta.c               |  646 ++++++++++++++++++++++++++++++
 sound/soc/s3c24xx/Kconfig                |    9 +
 sound/soc/s3c24xx/Makefile               |    2 +
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c |  498 +++++++++++++++++++++++
 sound/soc/soc-core.c                     |    3 +
 sound/soc/soc-jack.c                     |    6 +-
 16 files changed, 1323 insertions(+), 31 deletions(-)
 create mode 100644 sound/soc/omap/ams-delta.c
 create mode 100644 sound/soc/s3c24xx/neo1973_gta02_wm8753.c
