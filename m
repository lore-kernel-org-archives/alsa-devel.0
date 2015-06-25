From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: arizona: Implement stability check
	for LHPF coefficients
Date: Thu, 25 Jun 2015 09:35:12 +0100
Message-ID: <1435221312-22977-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1435221312-22977-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 113DD26047E
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 10:49:45 +0200 (CEST)
In-Reply-To: <1435221312-22977-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Specifying unstable coefficients for the low/high pass filters can have
a severe impact on the audio. This patchs adds a stability check on the
coefficients written to the low/high pass filter block to prevent this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   17 +++++++++++++++++
 sound/soc/codecs/arizona.h |    9 +++++++++
 sound/soc/codecs/wm5102.c  |    8 ++++----
 sound/soc/codecs/wm5110.c  |    8 ++++----
 sound/soc/codecs/wm8997.c  |    8 ++++----
 5 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 3996786..a88202d 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2372,6 +2372,23 @@ out:
 }
 EXPORT_SYMBOL_GPL(arizona_eq_coeff_put);
 
+int arizona_lhpf_coeff_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	__be16 *data = (__be16 *)ucontrol->value.bytes.data;
+	s16 val = be16_to_cpu(*data);
+
+	if (abs(val) >= 4096) {
+		dev_err(arizona->dev, "Rejecting unstable LHPF coefficients\n");
+		return -EINVAL;
+	}
+
+	return snd_soc_bytes_put(kcontrol, ucontrol);
+}
+EXPORT_SYMBOL_GPL(arizona_lhpf_coeff_put);
+
 MODULE_DESCRIPTION("ASoC Wolfson Arizona class device support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index ebe50cf..13598b0 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -201,6 +201,13 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	((unsigned long)&(struct soc_bytes) { .base = xbase,  \
 	 .num_regs = 20, .mask = ~ARIZONA_EQ1_B1_MODE }) }
 
+#define ARIZONA_LHPF_CONTROL(xname, xbase)                    \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
+	.info = snd_soc_bytes_info, .get = snd_soc_bytes_get, \
+	.put = arizona_lhpf_coeff_put, .private_value =       \
+	((unsigned long)&(struct soc_bytes) { .base = xbase,  \
+	 .num_regs = 1 }) }
+
 #define ARIZONA_RATE_ENUM_SIZE 4
 extern const char *arizona_rate_text[ARIZONA_RATE_ENUM_SIZE];
 extern const int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE];
@@ -238,6 +245,8 @@ extern int arizona_hp_ev(struct snd_soc_dapm_widget *w,
 
 extern int arizona_eq_coeff_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol);
+extern int arizona_lhpf_coeff_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol);
 
 extern int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 			      int source, unsigned int freq, int dir);
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 556bd98..6ddee99 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -847,10 +847,10 @@ ARIZONA_MIXER_CONTROLS("LHPF2", ARIZONA_HPLP2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("LHPF3", ARIZONA_HPLP3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("LHPF4", ARIZONA_HPLP4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES("LHPF1 Coefficients", ARIZONA_HPLPF1_2, 1),
-SND_SOC_BYTES("LHPF2 Coefficients", ARIZONA_HPLPF2_2, 1),
-SND_SOC_BYTES("LHPF3 Coefficients", ARIZONA_HPLPF3_2, 1),
-SND_SOC_BYTES("LHPF4 Coefficients", ARIZONA_HPLPF4_2, 1),
+ARIZONA_LHPF_CONTROL("LHPF1 Coefficients", ARIZONA_HPLPF1_2),
+ARIZONA_LHPF_CONTROL("LHPF2 Coefficients", ARIZONA_HPLPF2_2),
+ARIZONA_LHPF_CONTROL("LHPF3 Coefficients", ARIZONA_HPLPF3_2),
+ARIZONA_LHPF_CONTROL("LHPF4 Coefficients", ARIZONA_HPLPF4_2),
 
 ARIZONA_MIXER_CONTROLS("DSP1L", ARIZONA_DSP1LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP1R", ARIZONA_DSP1RMIX_INPUT_1_SOURCE),
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index dfa4d4b..05aa5bc 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -310,10 +310,10 @@ ARIZONA_MIXER_CONTROLS("LHPF2", ARIZONA_HPLP2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("LHPF3", ARIZONA_HPLP3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("LHPF4", ARIZONA_HPLP4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES("LHPF1 Coefficients", ARIZONA_HPLPF1_2, 1),
-SND_SOC_BYTES("LHPF2 Coefficients", ARIZONA_HPLPF2_2, 1),
-SND_SOC_BYTES("LHPF3 Coefficients", ARIZONA_HPLPF3_2, 1),
-SND_SOC_BYTES("LHPF4 Coefficients", ARIZONA_HPLPF4_2, 1),
+ARIZONA_LHPF_CONTROL("LHPF1 Coefficients", ARIZONA_HPLPF1_2),
+ARIZONA_LHPF_CONTROL("LHPF2 Coefficients", ARIZONA_HPLPF2_2),
+ARIZONA_LHPF_CONTROL("LHPF3 Coefficients", ARIZONA_HPLPF3_2),
+ARIZONA_LHPF_CONTROL("LHPF4 Coefficients", ARIZONA_HPLPF4_2),
 
 SOC_ENUM("LHPF1 Mode", arizona_lhpf1_mode),
 SOC_ENUM("LHPF2 Mode", arizona_lhpf2_mode),
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 53e0a46..b4dba3a 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -238,10 +238,10 @@ SOC_ENUM("LHPF2 Mode", arizona_lhpf2_mode),
 SOC_ENUM("LHPF3 Mode", arizona_lhpf3_mode),
 SOC_ENUM("LHPF4 Mode", arizona_lhpf4_mode),
 
-SND_SOC_BYTES("LHPF1 Coefficients", ARIZONA_HPLPF1_2, 1),
-SND_SOC_BYTES("LHPF2 Coefficients", ARIZONA_HPLPF2_2, 1),
-SND_SOC_BYTES("LHPF3 Coefficients", ARIZONA_HPLPF3_2, 1),
-SND_SOC_BYTES("LHPF4 Coefficients", ARIZONA_HPLPF4_2, 1),
+ARIZONA_LHPF_CONTROL("LHPF1 Coefficients", ARIZONA_HPLPF1_2),
+ARIZONA_LHPF_CONTROL("LHPF2 Coefficients", ARIZONA_HPLPF2_2),
+ARIZONA_LHPF_CONTROL("LHPF3 Coefficients", ARIZONA_HPLPF3_2),
+ARIZONA_LHPF_CONTROL("LHPF4 Coefficients", ARIZONA_HPLPF4_2),
 
 SOC_ENUM("ISRC1 FSL", arizona_isrc_fsl[0]),
 SOC_ENUM("ISRC2 FSL", arizona_isrc_fsl[1]),
-- 
1.7.2.5
