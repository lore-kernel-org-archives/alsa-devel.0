From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: cs42l56: Move ADC/PCM Swap to DAPM
Date: Tue, 8 Jul 2014 09:56:35 -0500
Message-ID: <1404831395-12940-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 11DEE261721
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 16:53:46 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

The Swap controls for ADC/PCM paths should be in the DAPM domain.

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l56.c |   64 +++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index fdc4bd2..e5ef223 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -318,24 +318,32 @@ static const struct soc_enum adca_swap_enum =
 			      ARRAY_SIZE(left_swap_text),
 			      left_swap_text,
 			      swap_values);
+static const struct snd_kcontrol_new adca_swap_mux =
+	SOC_DAPM_ENUM("Route", adca_swap_enum);
 
 static const struct soc_enum pcma_swap_enum =
 	SOC_VALUE_ENUM_SINGLE(CS42L56_CHAN_MIX_SWAP, 4, 3,
 			      ARRAY_SIZE(left_swap_text),
 			      left_swap_text,
 			      swap_values);
+static const struct snd_kcontrol_new pcma_swap_mux =
+	SOC_DAPM_ENUM("Route", pcma_swap_enum);
 
 static const struct soc_enum adcb_swap_enum =
 	SOC_VALUE_ENUM_SINGLE(CS42L56_CHAN_MIX_SWAP, 2, 3,
 			      ARRAY_SIZE(right_swap_text),
 			      right_swap_text,
 			      swap_values);
+static const struct snd_kcontrol_new adcb_swap_mux =
+	SOC_DAPM_ENUM("Route", adcb_swap_enum);
 
 static const struct soc_enum pcmb_swap_enum =
 	SOC_VALUE_ENUM_SINGLE(CS42L56_CHAN_MIX_SWAP, 6, 3,
 			      ARRAY_SIZE(right_swap_text),
 			      right_swap_text,
 			      swap_values);
+static const struct snd_kcontrol_new pcmb_swap_mux =
+	SOC_DAPM_ENUM("Route", pcmb_swap_enum);
 
 static const struct snd_kcontrol_new hpa_switch =
 	SOC_DAPM_SINGLE("Switch", CS42L56_PWRCTL_2, 6, 1, 1);
@@ -467,11 +475,6 @@ static const struct snd_kcontrol_new cs42l56_snd_controls[] = {
 	SOC_SINGLE("ADCA Invert", CS42L56_MISC_ADC_CTL, 2, 1, 1),
 	SOC_SINGLE("ADCB Invert", CS42L56_MISC_ADC_CTL, 3, 1, 1),
 
-	SOC_ENUM("PCMA Swap", pcma_swap_enum),
-	SOC_ENUM("PCMB Swap", pcmb_swap_enum),
-	SOC_ENUM("ADCA Swap", adca_swap_enum),
-	SOC_ENUM("ADCB Swap", adcb_swap_enum),
-
 	SOC_DOUBLE("HPF Switch", CS42L56_HPF_CTL, 5, 7, 1, 1),
 	SOC_DOUBLE("HPF Freeze Switch", CS42L56_HPF_CTL, 4, 6, 1, 1),
 	SOC_ENUM("HPFA Corner Freq", hpfa_freq_enum),
@@ -570,6 +573,16 @@ static const struct snd_soc_dapm_widget cs42l56_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("ADCA", NULL, CS42L56_PWRCTL_1, 1, 1),
 	SND_SOC_DAPM_ADC("ADCB", NULL, CS42L56_PWRCTL_1, 2, 1),
 
+	SND_SOC_DAPM_MUX("ADCA Swap Mux", SND_SOC_NOPM, 0, 0,
+		&adca_swap_mux),
+	SND_SOC_DAPM_MUX("ADCB Swap Mux", SND_SOC_NOPM, 0, 0,
+		&adcb_swap_mux),
+
+	SND_SOC_DAPM_MUX("PCMA Swap Mux", SND_SOC_NOPM, 0, 0,
+		&pcma_swap_mux),
+	SND_SOC_DAPM_MUX("PCMB Swap Mux", SND_SOC_NOPM, 0, 0,
+		&pcmb_swap_mux),
+
 	SND_SOC_DAPM_DAC("DACA", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DACB", NULL, SND_SOC_NOPM, 0, 0),
 
@@ -607,8 +620,19 @@ static const struct snd_soc_dapm_route cs42l56_audio_map[] = {
 	{"Digital Output Mux", NULL, "ADCA"},
 	{"Digital Output Mux", NULL, "ADCB"},
 
-	{"ADCB", NULL, "ADCB Mux"},
-	{"ADCA", NULL, "ADCA Mux"},
+	{"ADCB", NULL, "ADCB Swap Mux"},
+	{"ADCA", NULL, "ADCA Swap Mux"},
+
+	{"ADCA Swap Mux", NULL, "ADCA"},
+	{"ADCB Swap Mux", NULL, "ADCB"},
+
+	{"DACA", "Left", "ADCA Swap Mux"},
+	{"DACA", "LR 2", "ADCA Swap Mux"},
+	{"DACA", "Right", "ADCA Swap Mux"},
+
+	{"DACB", "Left", "ADCB Swap Mux"},
+	{"DACB", "LR 2", "ADCB Swap Mux"},
+	{"DACB", "Right", "ADCB Swap Mux"},
 
 	{"ADCA Mux", NULL, "AIN3A"},
 	{"ADCA Mux", NULL, "AIN2A"},
@@ -633,30 +657,32 @@ static const struct snd_soc_dapm_route cs42l56_audio_map[] = {
 	{"PGAB Input Mux", NULL, "AIN2B"},
 	{"PGAB Input Mux", NULL, "AIN3B"},
 
-	{"LOB", NULL, "Lineout Right"},
-	{"LOA", NULL, "Lineout Left"},
-
-	{"Lineout Right", "Switch", "LINEOUTB Input Mux"},
-	{"Lineout Left", "Switch", "LINEOUTA Input Mux"},
+	{"LOB", "Switch", "LINEOUTB Input Mux"},
+	{"LOA", "Switch", "LINEOUTA Input Mux"},
 
 	{"LINEOUTA Input Mux", "PGAA", "PGAA"},
 	{"LINEOUTB Input Mux", "PGAB", "PGAB"},
 	{"LINEOUTA Input Mux", "DACA", "DACA"},
 	{"LINEOUTB Input Mux", "DACB", "DACB"},
 
-	{"HPA", NULL, "Headphone Left"},
-	{"HPB", NULL, "Headphone Right"},
-
-	{"Headphone Right", "Switch", "HPB Input Mux"},
-	{"Headphone Left", "Switch", "HPA Input Mux"},
+	{"HPA", "Switch", "HPB Input Mux"},
+	{"HPB", "Switch", "HPA Input Mux"},
 
 	{"HPA Input Mux", "PGAA", "PGAA"},
 	{"HPB Input Mux", "PGAB", "PGAB"},
 	{"HPA Input Mux", "DACA", "DACA"},
 	{"HPB Input Mux", "DACB", "DACB"},
 
-	{"DACB", NULL, "HiFi Playback"},
-	{"DACA", NULL, "HiFi Playback"},
+	{"DACA", NULL, "PCMA Swap Mux"},
+	{"DACB", NULL, "PCMB Swap Mux"},
+
+	{"PCMB Swap Mux", "Left", "HiFi Playback"},
+	{"PCMB Swap Mux", "LR 2", "HiFi Playback"},
+	{"PCMB Swap Mux", "Right", "HiFi Playback"},
+
+	{"PCMA Swap Mux", "Left", "HiFi Playback"},
+	{"PCMA Swap Mux", "LR 2", "HiFi Playback"},
+	{"PCMA Swap Mux", "Right", "HiFi Playback"},
 
 };
 
-- 
1.7.9.5
