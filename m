From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: SND_SOC_DAPM_MICBIAS is
	deprecated" to the asoc tree
Date: Wed,  9 Jan 2019 19:34:52 +0000 (GMT)
Message-ID: <20190109193452.373B31127528@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 65020267445
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 20:34:53 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: b-ak <anur.bhargav@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: SND_SOC_DAPM_MICBIAS is deprecated

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 04d979d7a7bac2f645cd827ea37e5ffa5b4e1f97 Mon Sep 17 00:00:00 2001
From: b-ak <anur.bhargav@gmail.com>
Date: Wed, 9 Jan 2019 22:41:21 +0530
Subject: [PATCH] ASoC: tlv320aic32x4: SND_SOC_DAPM_MICBIAS is deprecated

SND_SOC_DAPM_MICBIAS is deprecated, replace it with SND_SOC_DAPM_SUPPLY.

MICBIAS voltage wasn't supplied to the microphone with the older
SND_SOC_DAPM_MICBIAS widget, hence the microphone wouldn't work.

This patch fixes the problem.

Signed-off-by: b-ak <anur.bhargav@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 30 +++++++++++++++++++++++++++++-
 sound/soc/codecs/tlv320aic32x4.h |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e2b5a11b16d1..521663d8b585 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -79,6 +79,32 @@ struct aic32x4_priv {
 	struct device *dev;
 };
 
+static int mic_bias_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Change Mic Bias Registor */
+		snd_soc_component_update_bits(component, AIC32X4_MICBIAS,
+				AIC32x4_MICBIAS_MASK,
+				AIC32X4_MICBIAS_LDOIN |
+				AIC32X4_MICBIAS_2075V);
+		printk(KERN_DEBUG "%s: Mic Bias will be turned ON\n", __func__);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_component_update_bits(component, AIC32X4_MICBIAS,
+				AIC32x4_MICBIAS_MASK, 0);
+		printk(KERN_DEBUG "%s: Mic Bias will be turned OFF\n",
+				__func__);
+		break;
+	}
+
+	return 0;
+}
+
+
 static int aic32x4_get_mfp1_gpio(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -450,7 +476,9 @@ static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("IN3_R to Left Mixer Negative Resistor", SND_SOC_NOPM, 0, 0,
 			in3r_to_lmixer_controls),
 
-	SND_SOC_DAPM_MICBIAS("Mic Bias", AIC32X4_MICBIAS, 6, 0),
+	SND_SOC_DAPM_SUPPLY("Mic Bias", AIC32X4_MICBIAS, 6, 0, mic_bias_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
 
 	SND_SOC_DAPM_OUTPUT("HPL"),
 	SND_SOC_DAPM_OUTPUT("HPR"),
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index e9df49edbf19..c2d74025bf4b 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -195,6 +195,7 @@ int aic32x4_remove(struct device *dev);
 /* AIC32X4_MICBIAS */
 #define AIC32X4_MICBIAS_LDOIN		BIT(3)
 #define AIC32X4_MICBIAS_2075V		0x60
+#define AIC32x4_MICBIAS_MASK            GENMASK(6, 3)
 
 /* AIC32X4_LMICPGANIN */
 #define AIC32X4_LMICPGANIN_IN2R_10K	0x10
-- 
2.20.1
