From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] ASoC: neo1973_gta02_wm8753: Remove lm4853_{set,get}_state
Date: Mon,  7 Feb 2011 00:04:20 +0100
Message-ID: <1297033463-14577-4-git-send-email-lars@metafoo.de>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297033463-14577-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch drops the lm4853_{set,get}_state functions and the "Amp State Switch"
control.
Those were noops which existed to maintain alsa state file compatibility. Since
the control names have changed due to internal changes in the ASoC core and
state file compatibility was broken anyway it makes sense to drop them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/neo1973_gta02_wm8753.c |   55 ++++--------------------------
 1 files changed, 7 insertions(+), 48 deletions(-)

diff --git a/sound/soc/samsung/neo1973_gta02_wm8753.c b/sound/soc/samsung/neo1973_gta02_wm8753.c
index 95ebf81..b007dd79 100644
--- a/sound/soc/samsung/neo1973_gta02_wm8753.c
+++ b/sound/soc/samsung/neo1973_gta02_wm8753.c
@@ -194,47 +194,14 @@ static struct snd_soc_ops neo1973_gta02_voice_ops = {
 	.hw_free = neo1973_gta02_voice_hw_free,
 };
 
-#define LM4853_AMP 1
-#define LM4853_SPK 2
-
-static u8 lm4853_state;
-
-/* This has no effect, it exists only to maintain compatibility with
- * existing ALSA state files.
- */
-static int lm4853_set_state(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	int val = ucontrol->value.integer.value[0];
-
-	if (val)
-		lm4853_state |= LM4853_AMP;
-	else
-		lm4853_state &= ~LM4853_AMP;
-
-	return 0;
-}
-
-static int lm4853_get_state(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	ucontrol->value.integer.value[0] = lm4853_state & LM4853_AMP;
-
-	return 0;
-}
+static int gta02_speaker_enabled;
 
 static int lm4853_set_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	int val = ucontrol->value.integer.value[0];
-
-	if (val) {
-		lm4853_state |= LM4853_SPK;
-		gpio_set_value(GTA02_GPIO_HP_IN, 0);
-	} else {
-		lm4853_state &= ~LM4853_SPK;
-		gpio_set_value(GTA02_GPIO_HP_IN, 1);
-	}
+	gta02_speaker_enabled = ucontrol->value.integer.value[0];
+
+	gpio_set_value(GTA02_GPIO_HP_IN, !gta02_speaker_enabled);
 
 	return 0;
 }
@@ -242,14 +209,12 @@ static int lm4853_set_spk(struct snd_kcontrol *kcontrol,
 static int lm4853_get_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = (lm4853_state & LM4853_SPK) >> 1;
-
+	ucontrol->value.integer.value[0] = gta02_speaker_enabled;
 	return 0;
 }
 
 static int lm4853_event(struct snd_soc_dapm_widget *w,
-			struct snd_kcontrol *k,
-			int event)
+			struct snd_kcontrol *k, int event)
 {
 	gpio_set_value(GTA02_GPIO_AMP_SHUT, SND_SOC_DAPM_EVENT_OFF(event));
 
@@ -304,13 +269,7 @@ static const struct snd_kcontrol_new wm8753_neo1973_gta02_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Handset Mic"),
 	SOC_DAPM_PIN_SWITCH("Handset Spk"),
 
-	/* This has no effect, it exists only to maintain compatibility with
-	 * existing ALSA state files.
-	 */
-	SOC_SINGLE_EXT("Amp State Switch", 6, 0, 1, 0,
-		lm4853_get_state,
-		lm4853_set_state),
-	SOC_SINGLE_EXT("Amp Spk Switch", 7, 0, 1, 0,
+	SOC_SINGLE_BOOL_EXT("Amp Spk Switch", 0,
 		lm4853_get_spk,
 		lm4853_set_spk),
 };
-- 
1.7.2.3
