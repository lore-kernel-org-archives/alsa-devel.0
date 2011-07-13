From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Thu, 14 Jul 2011 08:58:47 +0900
Message-ID: <20110713235845.GF9770@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78ECC103941
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jul 2011 09:06:00 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.se>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit e320bc42be746b8f006d163b6e340e5fb79ce7b2:

  Merge branch 'for-3.1' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into topic/asoc (2011-07-09 11:43:04 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.1

Giridhar Maruthy (1):
      ASoC: SAMSUNG: 24-bit audio playback on Exynos4210

Jarkko Nikula (2):
      ASoC: tlv320aic3x: Don't sync first two registers from register cache
      ASoC: tlv320aic3x: Do soft reset to codec when going to bias off state

Johannes Stezenbach (2):
      ASoC: STA32x: Add mixer controls for biquad coefficients
      ASoC: STA32x: Preserve reserved register bits

Kuninori Morimoto (3):
      ASoC: sh: fsi-ak4642: fixup snd_soc_card name
      ASoC: sh: fsi-da7210: fixup snd_soc_card name
      ASoC: sh: fsi-hdmi: fixup snd_soc_card name

Mark Brown (9):
      Merge branch 'for-3.0' into for-3.1
      Merge branch 'for-3.0' into for-3.1
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-3.1
      ASoC: Conditionalize the enable of WM8994 ADC TDM mode
      ASoC: Use late enable handling for direct voice, speaker and headphone
      ASoC: Implement DC servo completion IRQ handling for wm_hubs devices
      ASoC: Hook up DC servo completion IRQ for WM8994 and WM8958
      ASoC: Use WM8994 FLL lock interrupt
      ASoC: Don't warn on low WM8994/58 AIFnCLKs

Michael Williamson (1):
      audio: tlv320aic26: fix PLL register configuration

Takashi Iwai (4):
      Merge branch 'for-3.0' of git://git.kernel.org/.../lrg/asoc-2.6 into fix/asoc
      Merge branch 'for-3.0' of git://git.kernel.org/.../broonie/sound-2.6 into fix/asoc
      ASoC: Don't set invalid name string to snd_card->driver field
      Merge branch 'for-3.0' of git://git.kernel.org/.../broonie/sound-2.6 into fix/asoc

 sound/soc/codecs/sta32x.c       |  140 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic26.c  |   14 +++-
 sound/soc/codecs/tlv320aic3x.c  |    9 ++-
 sound/soc/codecs/wm8993.c       |    2 +-
 sound/soc/codecs/wm8994.c       |  101 +++++++++++++++++++++++-----
 sound/soc/codecs/wm8994.h       |    3 +
 sound/soc/codecs/wm_hubs.c      |   37 ++++++++--
 sound/soc/codecs/wm_hubs.h      |    8 ++
 sound/soc/samsung/smdk_wm8994.c |    5 +-
 sound/soc/sh/fsi-ak4642.c       |   16 ++--
 sound/soc/sh/fsi-da7210.c       |    2 +-
 sound/soc/sh/fsi-hdmi.c         |    4 +-
 sound/soc/soc-core.c            |    5 +-
 13 files changed, 301 insertions(+), 45 deletions(-)
