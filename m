From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Move codec sysclk config to
	codec_init function" to the asoc tree
Date: Fri, 01 Jun 2018 12:05:51 +0100
Message-ID: <E1fOhsV-0000Sd-BQ@debutante>
References: <1527234447-1384-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C4BE42676E7
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 13:05:57 +0200 (CEST)
In-Reply-To: <1527234447-1384-1-git-send-email-mac.chiang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mac Chiang <mac.chiang@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl: Move codec sysclk config to codec_init function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 56c3a95385df558a471f7fcedba73c9ed836a906 Mon Sep 17 00:00:00 2001
From: Mac Chiang <mac.chiang@intel.com>
Date: Fri, 1 Jun 2018 01:18:32 +0800
Subject: [PATCH] ASoC: Intel: kbl: Move codec sysclk config to codec_init
 function

On APL, commit fd0f237572ad
("ASoC: Intel: bxt: Move codec sysclk config to codec_init function")
fixed an issue related to jack detection.

The MCLK for DA7219 does not change in this platform, but is
currently being configured everytime as part of the platform_clock
event handler for DAPM. The upshot of this is that we have
unnecessary calls to this function, and it also means that if
a stream hasn't yet been started, DA7219 driver does not have the
correct MCLK rates programmed and so the HP detection feature does
not operate as expected.

The same fix is needed on KBL.

This patch rectifies this issue by moving the sysclk call to
codec_init function so it's only called once at initialisation.

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 60e739f3d6f3..94294c27d1db 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -65,14 +65,6 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		return -EIO;
 	}
 
-	/* Configure sysclk for codec */
-	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, 24576000,
-				     SND_SOC_CLOCK_IN);
-	if (ret) {
-		dev_err(card->dev, "can't set codec sysclk configuration\n");
-		return ret;
-	}
-
 	if (SND_SOC_DAPM_EVENT_OFF(event)) {
 		ret = snd_soc_dai_set_pll(codec_dai, 0,
 				     DA7219_SYSCLK_MCLK, 0, 0);
@@ -169,9 +161,18 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_component *component = rtd->codec_dai->component;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_jack *jack;
 	int ret;
 
+	/* Configure sysclk for codec */
+	ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK, 24576000,
+						SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
+		return ret;
+	}
+
 	/*
 	 * Headset buttons map to the google Reference headset.
 	 * These can be configured by userspace.
-- 
2.17.0
