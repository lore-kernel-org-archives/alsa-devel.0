From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 1/2] ASoC: cs42l52: Make MICA/B mixer dependent
	on mic config
Date: Thu, 14 Nov 2013 11:46:11 -0600
Message-ID: <1384451172-1532-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 4015C2651F3
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 18:43:23 +0100 (CET)
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgridwood@gmail.com
List-Id: alsa-devel@alsa-project.org

MICA/B Single-Ended input selection depends on mica/b config so lets
make the mixer controls for them only show for selected mic's

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 include/sound/cs42l52.h    |  8 ++++----
 sound/soc/codecs/cs42l52.c | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/include/sound/cs42l52.h b/include/sound/cs42l52.h
index daa91f3..bbabf84 100644
--- a/include/sound/cs42l52.h
+++ b/include/sound/cs42l52.h
@@ -16,11 +16,11 @@ struct cs42l52_platform_data {
 	/* MICBIAS Level. Check datasheet Pg48 */
 	unsigned int micbias_lvl;
 
-	/* MICA mode selection 0=Single 1=Differential */
-	unsigned int mica_cfg;
+	/* MICA mode selection Differential or Single-ended */
+	bool mica_diff_cfg;
 
-	/* MICB mode selection 0=Single 1=Differential */
-	unsigned int micb_cfg;
+	/* MICB mode selection Differential or Single-ended */
+	bool micb_diff_cfg;
 
 	/* Charge Pump Freq. Check datasheet Pg73 */
 	unsigned int chgfreq;
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 46c8af5..e68450e 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -419,9 +419,6 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 
 	SOC_DOUBLE("Bypass Mute", CS42L52_MISC_CTL, 4, 5, 1, 0),
 
-	SOC_ENUM("MICA Select", mica_enum),
-	SOC_ENUM("MICB Select", micb_enum),
-
 	SOC_DOUBLE_R_TLV("MIC Gain Volume", CS42L52_MICA_CTL,
 			      CS42L52_MICB_CTL, 0, 0x10, 0, mic_tlv),
 
@@ -528,6 +525,30 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 
 };
 
+static const struct snd_kcontrol_new cs42l52_mica_controls[] = {
+	SOC_ENUM("MICA Select", mica_enum),
+};
+
+static const struct snd_kcontrol_new cs42l52_micb_controls[] = {
+	SOC_ENUM("MICB Select", micb_enum),
+};
+
+static int cs42l52_add_mic_controls(struct snd_soc_codec *codec)
+{
+	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l52_platform_data *pdata = &cs42l52->pdata;
+
+	if (!pdata->mica_diff_cfg)
+		snd_soc_add_codec_controls(codec, cs42l52_mica_controls,
+				     ARRAY_SIZE(cs42l52_mica_controls));
+
+	if (!pdata->micb_diff_cfg)
+		snd_soc_add_codec_controls(codec, cs42l52_micb_controls,
+				     ARRAY_SIZE(cs42l52_micb_controls));
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget cs42l52_dapm_widgets[] = {
 
 	SND_SOC_DAPM_INPUT("AIN1L"),
@@ -1104,6 +1125,8 @@ static int cs42l52_probe(struct snd_soc_codec *codec)
 	}
 	regcache_cache_only(cs42l52->regmap, true);
 
+	cs42l52_add_mic_controls(codec);
+
 	cs42l52_init_beep(codec);
 
 	cs42l52_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -1221,16 +1244,16 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 			reg & 0xFF);
 
 	/* Set Platform Data */
-	if (cs42l52->pdata.mica_cfg)
+	if (cs42l52->pdata.mica_diff_cfg)
 		regmap_update_bits(cs42l52->regmap, CS42L52_MICA_CTL,
 				   CS42L52_MIC_CTL_TYPE_MASK,
-				cs42l52->pdata.mica_cfg <<
+				cs42l52->pdata.mica_diff_cfg <<
 				CS42L52_MIC_CTL_TYPE_SHIFT);
 
-	if (cs42l52->pdata.micb_cfg)
+	if (cs42l52->pdata.micb_diff_cfg)
 		regmap_update_bits(cs42l52->regmap, CS42L52_MICB_CTL,
 				   CS42L52_MIC_CTL_TYPE_MASK,
-				cs42l52->pdata.micb_cfg <<
+				cs42l52->pdata.micb_diff_cfg <<
 				CS42L52_MIC_CTL_TYPE_SHIFT);
 
 	if (cs42l52->pdata.chgfreq)
-- 
1.8.4.3
