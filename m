From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Wed, 13 Oct 2010 18:53:21 +0100
Message-ID: <20101013175320.GA5781@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A34524458
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 19:53:25 +0200 (CEST)
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

The following changes since commit fe3e2e7ff2da41bd7a985c4c206e05a95ebe7a6b:

  ASoC: checking kzalloc() for IS_ERR() instead of NULL (2010-10-11 12:38:21 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Kuninori Morimoto (6):
      ASoC: ak4642: simultaneous playback/recorde support
      ASoC: fsi: Add fsi_get_frame_width function
      ASoC: fsi: remove un-necessary variable from fsi_dai_startup
      ASoC: fsi: avoid un-necessary status read
      ASoC: fsi: Add new macro and shift for PortA/B In/Out
      ASoC: Add fsi_is_play function

Mark Brown (5):
      ASoC: Add WM8962 microphone bias control
      ASoC: Restore DAI ID specification for WM8994
      ASoC: Move soc-core module init next to functon definition
      ASoC: Check list debugfs files for PAGE_SIZE overflow
      ASoC: Pay attention to driver supplied DAI IDs

Mika Westerberg (3):
      ASoC: ac97: don't call snd_soc_new_ac97_codec at probe
      ASoC: don't register AC97 devices twice
      ASoC: ac97: add MODULE_ALIAS for the platform driver

 include/sound/soc.h       |    1 +
 sound/soc/codecs/ac97.c   |    7 +---
 sound/soc/codecs/ak4642.c |    8 ++--
 sound/soc/codecs/wm8962.c |    2 +
 sound/soc/codecs/wm8994.c |    3 ++
 sound/soc/sh/fsi.c        |   74 +++++++++++++++++++++++++-------------------
 sound/soc/soc-core.c      |   75 ++++++++++++++++++++++++++++++++++-----------
 7 files changed, 110 insertions(+), 60 deletions(-)
