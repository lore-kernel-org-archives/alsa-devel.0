From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: cs35l35: Correct handling of PDN_DONE with external boost" to the asoc tree
Date: Thu, 06 Apr 2017 19:55:14 +0100
Message-ID: <E1cwCYs-0001j0-Ig@debutante>
References: <1491483134-28079-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491483134-28079-2-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgbrian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Correct handling of PDN_DONE with external boost

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

>From 77b329d1943d38a5acdbaf9d57754975bce701d4 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Date: Thu, 6 Apr 2017 13:52:13 +0100
Subject: [PATCH] ASoC: cs35l35: Correct handling of PDN_DONE with external
 boost

When using an external boost supply the PDN_DONE bit is not set, update
the handling in this case to use to use an appropriate fixed delay.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Acked-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/sound/cs35l35.h    |  2 ++
 sound/soc/codecs/cs35l35.c | 32 ++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/sound/cs35l35.h b/include/sound/cs35l35.h
index 983c610eba2e..88744bbd6728 100644
--- a/include/sound/cs35l35.h
+++ b/include/sound/cs35l35.h
@@ -96,6 +96,8 @@ struct cs35l35_platform_data {
 	int adv_channel;
 	/* Shared Boost for stereo */
 	bool shared_bst;
+	/* Specifies this amp is using an external boost supply */
+	bool ext_bst;
 	/* ClassH Algorithm */
 	struct classh_cfg classh_algo;
 	/* Monitor Config */
diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 1db07a6296a4..6ecb7ddae9cf 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -162,6 +162,27 @@ static bool cs35l35_precious_register(struct device *dev, unsigned int reg)
 	}
 }
 
+static int cs35l35_wait_for_pdn(struct cs35l35_private *cs35l35)
+{
+	int ret;
+
+	if (cs35l35->pdata.ext_bst) {
+		usleep_range(5000, 5500);
+		return 0;
+	}
+
+	reinit_completion(&cs35l35->pdn_done);
+
+	ret = wait_for_completion_timeout(&cs35l35->pdn_done,
+					  msecs_to_jiffies(100));
+	if (ret == 0) {
+		dev_err(cs35l35->dev, "PDN_DONE did not complete\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int cs35l35_sdin_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
@@ -191,14 +212,7 @@ static int cs35l35_sdin_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_DIG_VOL_CTL,
 				   CS35L35_AMP_DIGSFT_MASK, 0);
 
-		reinit_completion(&cs35l35->pdn_done);
-
-		ret = wait_for_completion_timeout(&cs35l35->pdn_done,
-							msecs_to_jiffies(100));
-		if (ret == 0) {
-			dev_err(codec->dev, "TIMEOUT PDN_DONE did not complete in 100ms\n");
-			ret = -ETIMEDOUT;
-		}
+		ret = cs35l35_wait_for_pdn(cs35l35);
 
 		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
 					CS35L35_MCLK_DIS_MASK,
@@ -1198,6 +1212,8 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 						"cirrus,shared-boost");
 	}
 
+	pdata->ext_bst = of_property_read_bool(np, "cirrus,external-boost");
+
 	pdata->gain_zc = of_property_read_bool(np, "cirrus,amp-gain-zc");
 
 	classh = of_get_child_by_name(np, "cirrus,classh-internal-algo");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
