From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 2/3] ASoC: cs35l35: Correct handling of PDN_DONE with external boost
Date: Thu, 6 Apr 2017 13:52:13 +0100
Message-ID: <1491483134-28079-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1491483134-28079-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491483134-28079-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

When using an external boost supply the PDN_DONE bit is not set, update
the handling in this case to use to use an appropriate fixed delay.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 include/sound/cs35l35.h    |  2 ++
 sound/soc/codecs/cs35l35.c | 32 ++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/sound/cs35l35.h b/include/sound/cs35l35.h
index 983c610..88744bb 100644
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
index 1db07a6..6ecb7dd 100644
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
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
