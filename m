From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5640: add headset detection function
Date: Tue, 23 Jul 2013 14:54:29 +0800
Message-ID: <1374562469-5190-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A638261AAF
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 08:55:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Add headset detection function to rt5640 codec driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5640.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5640.h |  3 +++
 2 files changed, 64 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index ce585e3..dc0d063 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1911,6 +1911,67 @@ static int rt5640_resume(struct snd_soc_codec *codec)
 #define rt5640_resume NULL
 #endif
 
+/**
+ * rt5640_headset_detect - Detect headset.
+ * @codec: SoC audio codec device.
+ * @jack_insert: Jack insert or not.
+ *
+ * Detect whether is headset or not when jack inserted.
+ *
+ * Returns detect status.
+ */
+int rt5640_headset_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack, int jack_insert)
+{
+	int jack_type = 0;
+	int sclk_src = 0;
+	int reg63, reg64;
+
+	if (jack_insert) {
+		reg63 = snd_soc_read(codec, RT5640_PWR_ANLG1);
+		reg64 = snd_soc_read(codec, RT5640_PWR_ANLG2);
+		if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
+			snd_soc_write(codec, RT5640_PWR_ANLG1, 0xa814);
+			sclk_src = snd_soc_read(codec, RT5640_GLB_CLK) &
+				RT5640_SCLK_SRC_MASK;
+			snd_soc_update_bits(codec, RT5640_GLB_CLK,
+				RT5640_SCLK_SRC_MASK,
+				0x2 << RT5640_SCLK_SRC_SFT);
+		}
+		snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
+			RT5640_PWR_LDO2, RT5640_PWR_LDO2);
+		snd_soc_update_bits(codec, RT5640_PWR_ANLG2,
+			RT5640_PWR_MB1, RT5640_PWR_MB1);
+		snd_soc_update_bits(codec, RT5640_MICBIAS,
+			RT5640_MIC1_OVCD_MASK | RT5640_MIC1_OVTH_MASK |
+			RT5640_PWR_CLK25M_MASK | RT5640_PWR_MB_MASK,
+			RT5640_MIC1_OVCD_EN | RT5640_MIC1_OVTH_600UA |
+			RT5640_PWR_MB_PU | RT5640_PWR_CLK25M_PU);
+		snd_soc_update_bits(codec, RT5640_DUMMY1, 0x1, 0x1);
+		msleep(100);
+		if (snd_soc_read(codec, RT5640_IRQ_CTRL2) & 0x8)
+			jack_type = SND_JACK_HEADPHONE;
+		else
+			jack_type = SND_JACK_HEADSET;
+		snd_soc_update_bits(codec, RT5640_IRQ_CTRL2,
+			RT5640_MB1_OC_CLR, 0);
+		if (SND_SOC_BIAS_OFF == codec->dapm.bias_level)
+			snd_soc_update_bits(codec, RT5640_GLB_CLK,
+				RT5640_SCLK_SRC_MASK, sclk_src);
+		snd_soc_write(codec, RT5640_PWR_ANLG1, reg63);
+		snd_soc_write(codec, RT5640_PWR_ANLG2, reg64);
+		snd_soc_jack_report(jack, jack_type, SND_JACK_HEADSET);
+	} else {
+		snd_soc_update_bits(codec, RT5640_MICBIAS,
+			RT5640_MIC1_OVCD_MASK,
+			RT5640_MIC1_OVCD_DIS);
+		snd_soc_jack_report(jack, 0, jack->jack->type);
+	}
+
+	return jack_type;
+}
+EXPORT_SYMBOL_GPL(rt5640_headset_detect);
+
 #define RT5640_STEREO_RATES SNDRV_PCM_RATE_8000_96000
 #define RT5640_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index c48286d..263615b 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -2089,4 +2089,7 @@ struct rt5640_priv {
 	int dmic_en;
 };
 
+int rt5640_headset_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack, int jack_insert);
+
 #endif
-- 
1.8.1.1.439.g50a6b54
