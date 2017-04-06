From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: cs35l35: Improve power down time" to the asoc tree
Date: Thu, 06 Apr 2017 19:55:17 +0100
Message-ID: <E1cwCYv-0001k5-Hq@debutante>
References: <1491483134-28079-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491483134-28079-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgbrian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Improve power down time

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2c84afb52ebea59e9862fcb8234126b7ae1d1960 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Date: Thu, 6 Apr 2017 13:52:12 +0100
Subject: [PATCH] ASoC: cs35l35: Improve power down time

Shorten the time it takes to power down the amp by disabling the volume
ramp whilst doing the final shutdown. The driver has already muted the
amplifier at this stage so doing the volume ramp serves no purpose.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Acked-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/codecs/cs35l35.c | 8 ++++++++
 sound/soc/codecs/cs35l35.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 9688274f7c90..1db07a6296a4 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -187,6 +187,10 @@ static int cs35l35_sdin_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
 					  CS35L35_PDN_ALL_MASK, 1);
 
+		/* Already muted, so disable volume ramp for faster shutdown */
+		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_DIG_VOL_CTL,
+				   CS35L35_AMP_DIGSFT_MASK, 0);
+
 		reinit_completion(&cs35l35->pdn_done);
 
 		ret = wait_for_completion_timeout(&cs35l35->pdn_done,
@@ -199,6 +203,10 @@ static int cs35l35_sdin_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
 					CS35L35_MCLK_DIS_MASK,
 					1 << CS35L35_MCLK_DIS_SHIFT);
+
+		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_DIG_VOL_CTL,
+				   CS35L35_AMP_DIGSFT_MASK,
+				   1 << CS35L35_AMP_DIGSFT_SHIFT);
 		break;
 	default:
 		dev_err(codec->dev, "Invalid event = 0x%x\n", event);
diff --git a/sound/soc/codecs/cs35l35.h b/sound/soc/codecs/cs35l35.h
index 156d2f0e6fd8..54e9ac536b20 100644
--- a/sound/soc/codecs/cs35l35.h
+++ b/sound/soc/codecs/cs35l35.h
@@ -190,6 +190,9 @@
 #define CS35L35_AMP_GAIN_ZC_MASK	0x10
 #define CS35L35_AMP_GAIN_ZC_SHIFT	4
 
+#define CS35L35_AMP_DIGSFT_MASK		0x02
+#define CS35L35_AMP_DIGSFT_SHIFT	1
+
 /* CS35L35_SP_FMT_CTL3 */
 #define CS35L35_SP_I2S_DRV_MASK		0x03
 #define CS35L35_SP_I2S_DRV_SHIFT	0
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
