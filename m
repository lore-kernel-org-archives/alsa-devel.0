From: Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH v2] ASoC: rt5514: expose Hotword Model control
Date: Sat, 26 Aug 2017 01:09:47 +0800
Message-ID: <20170825170947.32241-1-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f42.google.com (mail-pg0-f42.google.com [74.125.83.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 302082673F1
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 19:09:55 +0200 (CEST)
Received: by mail-pg0-f42.google.com with SMTP id 63so2092070pgc.2
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 10:09:55 -0700 (PDT)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Hsin-Yu Chao <hychao@chromium.org>
List-Id: alsa-devel@alsa-project.org

This change exposes mixer control 'Hotword Model' for switching
hotword model in runtime. This new function requires updated
firmware to load hotword model at address 0x4ff80000.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
---
 sound/soc/codecs/rt5514.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5514.h |  3 +++
 2 files changed, 66 insertions(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index a2722177470e..250581082e9d 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -335,6 +335,39 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 				fw = NULL;
 			}
 
+			if (rt5514->model_buf && rt5514->model_len) {
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
+				int ret;
+
+				ret = rt5514_spi_burst_write(0x4ff80000,
+					rt5514->model_buf,
+					((rt5514->model_len / 8) + 1) * 8);
+				if (ret) {
+					dev_err(codec->dev,
+						"Model load failed %d\n", ret);
+					return ret;
+				}
+#else
+				dev_err(codec->dev,
+					"No SPI driver for loading firmware\n");
+#endif
+			} else {
+				request_firmware(&fw, RT5514_FIRMWARE3,
+						 codec->dev);
+				if (fw) {
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
+					rt5514_spi_burst_write(0x4ff80000,
+						fw->data,
+						((fw->size/8)+1)*8);
+#else
+					dev_err(codec->dev,
+						"No SPI driver to load fw\n");
+#endif
+					release_firmware(fw);
+					fw = NULL;
+				}
+			}
+
 			/* DSP run */
 			regmap_write(rt5514->i2c_regmap, 0x18002f00,
 				0x00055148);
@@ -349,6 +382,34 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int rt5514_hotword_model_put(struct snd_kcontrol *kcontrol,
+		const unsigned int __user *bytes, unsigned int size)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt5514_priv *rt5514 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_codec *codec = rt5514->codec;
+	int ret = 0;
+
+	if (rt5514->model_buf || rt5514->model_len < size) {
+		if (rt5514->model_buf)
+			devm_kfree(codec->dev, rt5514->model_buf);
+		rt5514->model_buf = devm_kmalloc(codec->dev, size, GFP_KERNEL);
+		if (!rt5514->model_buf) {
+			ret = -ENOMEM;
+			goto done;
+		}
+	}
+
+	/* Skips the TLV header. */
+	bytes += 2;
+
+	if (copy_from_user(rt5514->model_buf, bytes, size))
+		ret = -EFAULT;
+done:
+	rt5514->model_len = (ret ? 0 : size);
+	return ret;
+}
+
 static const struct snd_kcontrol_new rt5514_snd_controls[] = {
 	SOC_DOUBLE_TLV("MIC Boost Volume", RT5514_ANA_CTRL_MICBST,
 		RT5514_SEL_BSTL_SFT, RT5514_SEL_BSTR_SFT, 8, 0, bst_tlv),
@@ -360,6 +421,8 @@ static const struct snd_kcontrol_new rt5514_snd_controls[] = {
 		adc_vol_tlv),
 	SOC_SINGLE_EXT("DSP Voice Wake Up", SND_SOC_NOPM, 0, 1, 0,
 		rt5514_dsp_voice_wake_up_get, rt5514_dsp_voice_wake_up_put),
+	SND_SOC_BYTES_TLV("Hotword Model", 0x8504,
+		NULL, rt5514_hotword_model_put),
 };
 
 /* ADC Mixer*/
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 02bc212a86d9..07475a9918d2 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -236,6 +236,7 @@
 
 #define RT5514_FIRMWARE1	"rt5514_dsp_fw1.bin"
 #define RT5514_FIRMWARE2	"rt5514_dsp_fw2.bin"
+#define RT5514_FIRMWARE3	"rt5514_dsp_fw3.bin"
 
 /* System Clock Source */
 enum {
@@ -262,6 +263,8 @@ struct rt5514_priv {
 	int pll_in;
 	int pll_out;
 	int dsp_enabled;
+	u8 *model_buf;
+	unsigned int model_len;
 };
 
 #endif /* __RT5514_H__ */
-- 
2.12.2
