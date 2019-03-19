From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH 10/13] ASoC: tlv320aic32x4: Remove sysclk
	references
Date: Mon, 18 Mar 2019 20:37:53 -0700
Message-ID: <20190319033756.20616-11-nh6z@nh6z.net>
References: <20190319033756.20616-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp89.iad3a.emailsrvr.com (smtp89.iad3a.emailsrvr.com
 [173.203.187.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB642F89717
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 04:38:21 +0100 (CET)
In-Reply-To: <20190319033756.20616-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

Sysclk is not used by anything anymore.  Remove support for it.
All that information now comes from the clock tree.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 10f0e07889b7..27babe48d5bc 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -49,7 +49,6 @@
 
 struct aic32x4_priv {
 	struct regmap *regmap;
-	u32 sysclk;
 	u32 power_cfg;
 	u32 micpga_routing;
 	bool swapdacs;
@@ -563,23 +562,6 @@ const struct regmap_config aic32x4_regmap_config = {
 };
 EXPORT_SYMBOL(aic32x4_regmap_config);
 
-static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-				  int clk_id, unsigned int freq, int dir)
-{
-	struct snd_soc_component *component = codec_dai->component;
-	struct aic32x4_priv *aic32x4 = snd_soc_component_get_drvdata(component);
-
-	switch (freq) {
-	case 12000000:
-	case 24000000:
-	case 25000000:
-		aic32x4->sysclk = freq;
-		return 0;
-	}
-	printk(KERN_ERR "aic32x4: invalid frequency to set DAI system clock\n");
-	return -EINVAL;
-}
-
 static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = codec_dai->component;
@@ -855,7 +837,6 @@ static const struct snd_soc_dai_ops aic32x4_ops = {
 	.hw_params = aic32x4_hw_params,
 	.digital_mute = aic32x4_mute,
 	.set_fmt = aic32x4_set_dai_fmt,
-	.set_sysclk = aic32x4_set_dai_sysclk,
 };
 
 static struct snd_soc_dai_driver aic32x4_dai = {
-- 
2.19.1
