From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: aic31xx_set_jack() can be static" to the asoc tree
Date: Wed,  3 Apr 2019 05:41:33 +0100 (BST)
Message-ID: <20190403044133.5EF89440083@finisterre.ee.mobilebroadband>
References: <20190402114618.GA8728@lkp-wsm-ep1>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402114618.GA8728@lkp-wsm-ep1>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Colin Ian King <colin.king@canonical.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: aic31xx_set_jack() can be static

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

>From 7742a5b418c91b1f27a08ebf90cb662cf4c06604 Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Tue, 2 Apr 2019 19:46:18 +0800
Subject: [PATCH] ASoC: tlv320aic31xx: aic31xx_set_jack() can be static

Fixes: ebf3326cd969 ("ASoC: tlv320aic31xx: Add headphone/headset detection")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index fa47bfcb93e9..9b37e98da0db 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1264,8 +1264,8 @@ static int aic31xx_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
-int aic31xx_set_jack(struct snd_soc_component *component,
-		     struct snd_soc_jack *jack, void *data)
+static int aic31xx_set_jack(struct snd_soc_component *component,
+			    struct snd_soc_jack *jack, void *data)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
 
-- 
2.20.1
