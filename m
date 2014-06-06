From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm5102: Add controls to allow
	shaping of ultrasonic response
Date: Fri,  6 Jun 2014 13:33:20 +0100
Message-ID: <1402058000-5357-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1402058000-5357-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 057E7265232
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 14:40:52 +0200 (CEST)
In-Reply-To: <1402058000-5357-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: lee.jones@linaro.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.org, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add controls to allow custom shaping of the ultrasonic response. This
custom shaping can be turned on/off at runtime, although, it should be
noted that settings will not affect a currently open audio stream,
they will be applied when the next audio stream is started.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/linux/mfd/arizona/core.h |    3 ++
 sound/soc/codecs/arizona.c       |   34 +++++++++++++++++++++
 sound/soc/codecs/wm5102.c        |   62 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/arizona/core.h b/include/linux/mfd/arizona/core.h
index 11783b5..5592651 100644
--- a/include/linux/mfd/arizona/core.h
+++ b/include/linux/mfd/arizona/core.h
@@ -113,6 +113,9 @@ struct arizona {
 
 	int tdm_width[ARIZONA_MAX_AIF];
 	int tdm_slots[ARIZONA_MAX_AIF];
+
+	uint16_t dac_comp_coeff;
+	uint8_t dac_comp_enabled;
 };
 
 int arizona_clk32k_enable(struct arizona *arizona);
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e77f61c..41b56ee 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1127,6 +1127,31 @@ static int arizona_startup(struct snd_pcm_substream *substream,
 					  constraint);
 }
 
+static void arizona_wm5102_set_dac_comp(struct snd_soc_codec *codec,
+					unsigned int rate)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	struct reg_default dac_comp[] = {
+		{ 0x80, 0x3 },
+		{ ARIZONA_DAC_COMP_1, 0 },
+		{ ARIZONA_DAC_COMP_2, 0 },
+		{ 0x80, 0x0 },
+	};
+
+	mutex_lock(&codec->mutex);
+
+	dac_comp[1].def = arizona->dac_comp_coeff;
+	if (rate >= 176400)
+		dac_comp[2].def = arizona->dac_comp_enabled;
+
+	mutex_unlock(&codec->mutex);
+
+	regmap_multi_reg_write(arizona->regmap,
+			       dac_comp,
+			       ARRAY_SIZE(dac_comp));
+}
+
 static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
@@ -1153,6 +1178,15 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 
 	switch (dai_priv->clk) {
 	case ARIZONA_CLK_SYSCLK:
+		switch (priv->arizona->type) {
+		case WM5102:
+			arizona_wm5102_set_dac_comp(codec,
+						    params_rate(params));
+			break;
+		default:
+			break;
+		}
+
 		snd_soc_update_bits(codec, ARIZONA_SAMPLE_RATE_1,
 				    ARIZONA_SAMPLE_RATE_1_MASK, sr_val);
 		if (base)
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 289b64d..a40ea4d 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -612,6 +612,62 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	uint16_t data;
+
+	mutex_lock(&codec->mutex);
+	data = cpu_to_be16(arizona->dac_comp_coeff);
+	memcpy(ucontrol->value.bytes.data, &data, sizeof(data));
+	mutex_unlock(&codec->mutex);
+
+	return 0;
+}
+
+static int wm5102_out_comp_coeff_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+
+	mutex_lock(&codec->mutex);
+	memcpy(&arizona->dac_comp_coeff, ucontrol->value.bytes.data,
+	       sizeof(arizona->dac_comp_coeff));
+	arizona->dac_comp_coeff = be16_to_cpu(arizona->dac_comp_coeff);
+	mutex_unlock(&codec->mutex);
+
+	return 0;
+}
+
+static int wm5102_out_comp_switch_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+
+	mutex_lock(&codec->mutex);
+	ucontrol->value.integer.value[0] = arizona->dac_comp_enabled;
+	mutex_unlock(&codec->mutex);
+
+	return 0;
+}
+
+static int wm5102_out_comp_switch_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+
+	mutex_lock(&codec->mutex);
+	arizona->dac_comp_enabled = ucontrol->value.integer.value[0];
+	mutex_unlock(&codec->mutex);
+
+	return 0;
+}
+
 static const char *wm5102_osr_text[] = {
 	"Low power", "Normal", "High performance",
 };
@@ -843,6 +899,12 @@ SOC_SINGLE_TLV("Noise Gate Threshold Volume", ARIZONA_NOISE_GATE_CONTROL,
 	       ARIZONA_NGATE_THR_SHIFT, 7, 1, ng_tlv),
 SOC_ENUM("Noise Gate Hold", arizona_ng_hold),
 
+SND_SOC_BYTES_EXT("Output Compensation Coefficient", 0, 1,
+		  wm5102_out_comp_coeff_get, wm5102_out_comp_coeff_put),
+
+SOC_SINGLE_EXT("Output Compensation Switch", 0, 0, 1, 0,
+	       wm5102_out_comp_switch_get, wm5102_out_comp_switch_put),
+
 WM5102_NG_SRC("HPOUT1L", ARIZONA_NOISE_GATE_SELECT_1L),
 WM5102_NG_SRC("HPOUT1R", ARIZONA_NOISE_GATE_SELECT_1R),
 WM5102_NG_SRC("HPOUT2L", ARIZONA_NOISE_GATE_SELECT_2L),
-- 
1.7.2.5
