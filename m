From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH RESEND 2/2] ASoC: cs42l52: convert platform
	data config to regmap_update_bits
Date: Thu, 24 Oct 2013 09:29:07 -0500
Message-ID: <1382624947-10678-2-git-send-email-brian.austin@cirrus.com>
References: <1382624947-10678-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id DBD972610A4
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 16:26:56 +0200 (CEST)
In-Reply-To: <1382624947-10678-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Moving Platform Data config to bus probe and convert to
regmap_update_bits. This will work nicer when converted to device tree
instead of having it split into multiple probes

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l52.c | 69 +++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 6782d4875..5bee30b 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1117,40 +1117,6 @@ static int cs42l52_probe(struct snd_soc_codec *codec)
 	cs42l52->sysclk = CS42L52_DEFAULT_CLK;
 	cs42l52->config.format = CS42L52_DEFAULT_FORMAT;
 
-	/* Set Platform MICx CFG */
-	snd_soc_update_bits(codec, CS42L52_MICA_CTL,
-			    CS42L52_MIC_CTL_TYPE_MASK,
-				cs42l52->pdata.mica_cfg <<
-				CS42L52_MIC_CTL_TYPE_SHIFT);
-
-	snd_soc_update_bits(codec, CS42L52_MICB_CTL,
-			    CS42L52_MIC_CTL_TYPE_MASK,
-				cs42l52->pdata.micb_cfg <<
-				CS42L52_MIC_CTL_TYPE_SHIFT);
-
-	/* if Single Ended, Get Mic_Select */
-	if (cs42l52->pdata.mica_cfg)
-		snd_soc_update_bits(codec, CS42L52_MICA_CTL,
-				    CS42L52_MIC_CTL_MIC_SEL_MASK,
-				cs42l52->pdata.mica_sel <<
-				CS42L52_MIC_CTL_MIC_SEL_SHIFT);
-	if (cs42l52->pdata.micb_cfg)
-		snd_soc_update_bits(codec, CS42L52_MICB_CTL,
-				    CS42L52_MIC_CTL_MIC_SEL_MASK,
-				cs42l52->pdata.micb_sel <<
-				CS42L52_MIC_CTL_MIC_SEL_SHIFT);
-
-	/* Set Platform Charge Pump Freq */
-	snd_soc_update_bits(codec, CS42L52_CHARGE_PUMP,
-			    CS42L52_CHARGE_PUMP_MASK,
-				cs42l52->pdata.chgfreq <<
-				CS42L52_CHARGE_PUMP_SHIFT);
-
-	/* Set Platform Bias Level */
-	snd_soc_update_bits(codec, CS42L52_IFACE_CTL2,
-			    CS42L52_IFACE_CTL2_BIAS_LVL,
-				cs42l52->pdata.micbias_lvl);
-
 	return ret;
 }
 
@@ -1259,8 +1225,41 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 	dev_info(&i2c_client->dev,
 		 "Cirrus Logic CS42L52, Revision: %02X\n", reg & 0xFF);
 
-	regcache_cache_only(cs42l52->regmap, true);
+	/* Set Platform Data */
+	if (cs42l52->pdata.mica_cfg)
+		regmap_update_bits(cs42l52->regmap, CS42L52_MICA_CTL,
+				   CS42L52_MIC_CTL_TYPE_MASK,
+				cs42l52->pdata.mica_cfg <<
+				CS42L52_MIC_CTL_TYPE_SHIFT);
+
+	if (cs42l52->pdata.micb_cfg)
+		regmap_update_bits(cs42l52->regmap, CS42L52_MICB_CTL,
+				   CS42L52_MIC_CTL_TYPE_MASK,
+				cs42l52->pdata.micb_cfg <<
+				CS42L52_MIC_CTL_TYPE_SHIFT);
 
+	if (cs42l52->pdata.mica_sel)
+		regmap_update_bits(cs42l52->regmap, CS42L52_MICA_CTL,
+				   CS42L52_MIC_CTL_MIC_SEL_MASK,
+				cs42l52->pdata.mica_sel <<
+				CS42L52_MIC_CTL_MIC_SEL_SHIFT);
+	if (cs42l52->pdata.micb_sel)
+		regmap_update_bits(cs42l52->regmap, CS42L52_MICB_CTL,
+				    CS42L52_MIC_CTL_MIC_SEL_MASK,
+				cs42l52->pdata.micb_sel <<
+				CS42L52_MIC_CTL_MIC_SEL_SHIFT);
+
+	if (cs42l52->pdata.chgfreq)
+		regmap_update_bits(cs42l52->regmap, CS42L52_CHARGE_PUMP,
+				   CS42L52_CHARGE_PUMP_MASK,
+				cs42l52->pdata.chgfreq <<
+				CS42L52_CHARGE_PUMP_SHIFT);
+
+	if (cs42l52->pdata.micbias_lvl)
+		regmap_update_bits(cs42l52->regmap, CS42L52_IFACE_CTL2,
+				   CS42L52_IFACE_CTL2_BIAS_LVL,
+				cs42l52->pdata.micbias_lvl);
+
 	ret =  snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_dev_cs42l52, &cs42l52_dai, 1);
 	if (ret < 0)
-- 
1.8.4.rc3
