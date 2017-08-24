From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: expose Hotword Model control"
	to the asoc tree
Date: Thu, 24 Aug 2017 11:49:56 +0100
Message-ID: <E1dkpi0-0000rj-Vu@debutante>
References: <20170823102931.184967-1-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A2472669F3
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 12:50:01 +0200 (CEST)
In-Reply-To: <20170823102931.184967-1-hychao@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: oder_chiou@realtek.com, dgreid@chromium.org, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: expose Hotword Model control

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

>From d18420b0a0b8f8f51f55fc654b2e0eb86d8b41d7 Mon Sep 17 00:00:00 2001
From: Hsin-Yu Chao <hychao@chromium.org>
Date: Wed, 23 Aug 2017 18:29:31 +0800
Subject: [PATCH] ASoC: rt5514: expose Hotword Model control

This change exposes mixer control 'Hotword Model' for switching
hotword model in runtime. This new function requires updated
firmware to load hotword model at address 0x4ff80000.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5514.h |  3 +++
 2 files changed, 55 insertions(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index a694ce9fed86..0e239e8c7bf8 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -302,6 +302,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 	struct rt5514_priv *rt5514 = snd_soc_component_get_drvdata(component);
 	struct snd_soc_codec *codec = rt5514->codec;
 	const struct firmware *fw = NULL;
+	int ret = 0;
 
 	if (ucontrol->value.integer.value[0] == rt5514->dsp_enabled)
 		return 0;
@@ -338,6 +339,27 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 				fw = NULL;
 			}
 
+			if (rt5514->model_buf && rt5514->model_len) {
+				ret = rt5514_spi_burst_write(0x4ff80000,
+					rt5514->model_buf,
+					((rt5514->model_len / 8) + 1) * 8);
+				if (ret) {
+					dev_err(codec->dev,
+						"Model load failed %d\n", ret);
+					return ret;
+				}
+			} else {
+				request_firmware(&fw, RT5514_FIRMWARE3,
+						 codec->dev);
+				if (fw) {
+					rt5514_spi_burst_write(0x4ff80000,
+						fw->data,
+						((fw->size/8)+1)*8);
+					release_firmware(fw);
+					fw = NULL;
+				}
+			}
+
 			/* DSP run */
 			regmap_write(rt5514->i2c_regmap, 0x18002f00,
 				0x00055148);
@@ -352,6 +374,34 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
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
@@ -363,6 +413,8 @@ static const struct snd_kcontrol_new rt5514_snd_controls[] = {
 		adc_vol_tlv),
 	SOC_SINGLE_EXT("DSP Voice Wake Up", SND_SOC_NOPM, 0, 1, 0,
 		rt5514_dsp_voice_wake_up_get, rt5514_dsp_voice_wake_up_put),
+	SND_SOC_BYTES_TLV("Hotword Model", 0x8504,
+		NULL, rt5514_hotword_model_put),
 };
 
 /* ADC Mixer*/
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 2dc40e6d8b3f..803311cb7e2a 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -255,6 +255,7 @@
 
 #define RT5514_FIRMWARE1	"rt5514_dsp_fw1.bin"
 #define RT5514_FIRMWARE2	"rt5514_dsp_fw2.bin"
+#define RT5514_FIRMWARE3	"rt5514_dsp_fw3.bin"
 
 /* System Clock Source */
 enum {
@@ -281,6 +282,8 @@ struct rt5514_priv {
 	int pll_in;
 	int pll_out;
 	int dsp_enabled;
+	u8 *model_buf;
+	unsigned int model_len;
 };
 
 #endif /* __RT5514_H__ */
-- 
2.14.1
