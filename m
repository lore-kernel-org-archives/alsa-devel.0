From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Add TDM channel mux in DAC side
	of IF1 and IF2
Date: Tue, 11 Nov 2014 15:31:19 +0800
Message-ID: <1415691079-17500-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9857C2614D6
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 08:31:48 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

It is the slot selection in DAC side of IF1 and IF2.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 330 +++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/rt5677.h |  48 ++++++-
 2 files changed, 358 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 4b6f7d5..5d317c68 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1906,6 +1906,126 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5677_if2_adc_tdm_swap_mux =
 	SOC_DAPM_ENUM("IF2 ADC TDM Swap Source", rt5677_if2_adc_tdm_swap_enum);
 
+/* TDM IF1/2 DAC Data Selection */ /* MX-3E[14:12][10:8][6:4][2:0]
+					MX-3F[14:12][10:8][6:4][2:0]
+					MX-43[14:12][10:8][6:4][2:0]
+					MX-44[14:12][10:8][6:4][2:0] */
+static const char * const rt5677_if12_dac_tdm_sel_src[] = {
+	"Slot0", "Slot1", "Slot2", "Slot3", "Slot4", "Slot5", "Slot6", "Slot7"
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_dac0_tdm_sel_enum, RT5677_TDM1_CTRL4,
+	RT5677_IF1_DAC0_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if1_dac0_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC0 TDM Source", rt5677_if1_dac0_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_dac1_tdm_sel_enum, RT5677_TDM1_CTRL4,
+	RT5677_IF1_DAC1_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if1_dac1_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC1 TDM Source", rt5677_if1_dac1_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_dac2_tdm_sel_enum, RT5677_TDM1_CTRL4,
+	RT5677_IF1_DAC2_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if1_dac2_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC2 TDM Source", rt5677_if1_dac2_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_dac3_tdm_sel_enum, RT5677_TDM1_CTRL4,
+	RT5677_IF1_DAC3_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if1_dac3_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC3 TDM Source", rt5677_if1_dac3_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_dac4_tdm_sel_enum, RT5677_TDM1_CTRL5,
+	RT5677_IF1_DAC4_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if1_dac4_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC4 TDM Source", rt5677_if1_dac4_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_dac5_tdm_sel_enum, RT5677_TDM1_CTRL5,
+	RT5677_IF1_DAC5_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if1_dac5_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC5 TDM Source", rt5677_if1_dac5_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_dac6_tdm_sel_enum, RT5677_TDM1_CTRL5,
+	RT5677_IF1_DAC6_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if1_dac6_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC6 TDM Source", rt5677_if1_dac6_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_dac7_tdm_sel_enum, RT5677_TDM1_CTRL5,
+	RT5677_IF1_DAC7_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if1_dac7_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF1 DAC7 TDM Source", rt5677_if1_dac7_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_dac0_tdm_sel_enum, RT5677_TDM2_CTRL4,
+	RT5677_IF2_DAC0_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if2_dac0_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF2 DAC0 TDM Source", rt5677_if2_dac0_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_dac1_tdm_sel_enum, RT5677_TDM2_CTRL4,
+	RT5677_IF2_DAC1_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if2_dac1_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF2 DAC1 TDM Source", rt5677_if2_dac1_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_dac2_tdm_sel_enum, RT5677_TDM2_CTRL4,
+	RT5677_IF2_DAC2_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if2_dac2_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF2 DAC2 TDM Source", rt5677_if2_dac2_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_dac3_tdm_sel_enum, RT5677_TDM2_CTRL4,
+	RT5677_IF2_DAC3_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if2_dac3_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF2 DAC3 TDM Source", rt5677_if2_dac3_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_dac4_tdm_sel_enum, RT5677_TDM2_CTRL5,
+	RT5677_IF2_DAC4_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if2_dac4_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF2 DAC4 TDM Source", rt5677_if2_dac4_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_dac5_tdm_sel_enum, RT5677_TDM2_CTRL5,
+	RT5677_IF2_DAC5_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if2_dac5_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF2 DAC5 TDM Source", rt5677_if2_dac5_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_dac6_tdm_sel_enum, RT5677_TDM2_CTRL5,
+	RT5677_IF2_DAC6_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if2_dac6_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF2 DAC6 TDM Source", rt5677_if2_dac6_tdm_sel_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_dac7_tdm_sel_enum, RT5677_TDM2_CTRL5,
+	RT5677_IF2_DAC7_SFT, rt5677_if12_dac_tdm_sel_src);
+
+static const struct snd_kcontrol_new rt5677_if2_dac7_tdm_sel_mux =
+	SOC_DAPM_ENUM("IF2 DAC7 TDM Source", rt5677_if2_dac7_tdm_sel_enum);
+
 static int rt5677_bst1_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -2389,6 +2509,40 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("SLB ADC4 Mux", SND_SOC_NOPM, 0, 0,
 			&rt5677_slb_adc4_mux),
 
+	SND_SOC_DAPM_MUX("IF1 DAC0 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_dac0_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF1 DAC1 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_dac1_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF1 DAC2 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_dac2_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF1 DAC3 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_dac3_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF1 DAC4 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_dac4_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF1 DAC5 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_dac5_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF1 DAC6 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_dac6_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF1 DAC7 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_dac7_tdm_sel_mux),
+
+	SND_SOC_DAPM_MUX("IF2 DAC0 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_dac0_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF2 DAC1 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_dac1_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF2 DAC2 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_dac2_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF2 DAC3 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_dac3_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF2 DAC4 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_dac4_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF2 DAC5 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_dac5_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF2 DAC6 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_dac6_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("IF2 DAC7 Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_dac7_tdm_sel_mux),
+
 	/* Audio Interface */
 	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
@@ -3036,14 +3190,86 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "IF1 DAC6", NULL, "I2S1" },
 	{ "IF1 DAC7", NULL, "I2S1" },
 
-	{ "IF1 DAC01", NULL, "IF1 DAC0" },
-	{ "IF1 DAC01", NULL, "IF1 DAC1" },
-	{ "IF1 DAC23", NULL, "IF1 DAC2" },
-	{ "IF1 DAC23", NULL, "IF1 DAC3" },
-	{ "IF1 DAC45", NULL, "IF1 DAC4" },
-	{ "IF1 DAC45", NULL, "IF1 DAC5" },
-	{ "IF1 DAC67", NULL, "IF1 DAC6" },
-	{ "IF1 DAC67", NULL, "IF1 DAC7" },
+	{ "IF1 DAC0 Mux", "Slot0", "IF1 DAC0" },
+	{ "IF1 DAC0 Mux", "Slot1", "IF1 DAC1" },
+	{ "IF1 DAC0 Mux", "Slot2", "IF1 DAC2" },
+	{ "IF1 DAC0 Mux", "Slot3", "IF1 DAC3" },
+	{ "IF1 DAC0 Mux", "Slot4", "IF1 DAC4" },
+	{ "IF1 DAC0 Mux", "Slot5", "IF1 DAC5" },
+	{ "IF1 DAC0 Mux", "Slot6", "IF1 DAC6" },
+	{ "IF1 DAC0 Mux", "Slot7", "IF1 DAC7" },
+
+	{ "IF1 DAC1 Mux", "Slot0", "IF1 DAC0" },
+	{ "IF1 DAC1 Mux", "Slot1", "IF1 DAC1" },
+	{ "IF1 DAC1 Mux", "Slot2", "IF1 DAC2" },
+	{ "IF1 DAC1 Mux", "Slot3", "IF1 DAC3" },
+	{ "IF1 DAC1 Mux", "Slot4", "IF1 DAC4" },
+	{ "IF1 DAC1 Mux", "Slot5", "IF1 DAC5" },
+	{ "IF1 DAC1 Mux", "Slot6", "IF1 DAC6" },
+	{ "IF1 DAC1 Mux", "Slot7", "IF1 DAC7" },
+
+	{ "IF1 DAC2 Mux", "Slot0", "IF1 DAC0" },
+	{ "IF1 DAC2 Mux", "Slot1", "IF1 DAC1" },
+	{ "IF1 DAC2 Mux", "Slot2", "IF1 DAC2" },
+	{ "IF1 DAC2 Mux", "Slot3", "IF1 DAC3" },
+	{ "IF1 DAC2 Mux", "Slot4", "IF1 DAC4" },
+	{ "IF1 DAC2 Mux", "Slot5", "IF1 DAC5" },
+	{ "IF1 DAC2 Mux", "Slot6", "IF1 DAC6" },
+	{ "IF1 DAC2 Mux", "Slot7", "IF1 DAC7" },
+
+	{ "IF1 DAC3 Mux", "Slot0", "IF1 DAC0" },
+	{ "IF1 DAC3 Mux", "Slot1", "IF1 DAC1" },
+	{ "IF1 DAC3 Mux", "Slot2", "IF1 DAC2" },
+	{ "IF1 DAC3 Mux", "Slot3", "IF1 DAC3" },
+	{ "IF1 DAC3 Mux", "Slot4", "IF1 DAC4" },
+	{ "IF1 DAC3 Mux", "Slot5", "IF1 DAC5" },
+	{ "IF1 DAC3 Mux", "Slot6", "IF1 DAC6" },
+	{ "IF1 DAC3 Mux", "Slot7", "IF1 DAC7" },
+
+	{ "IF1 DAC4 Mux", "Slot0", "IF1 DAC0" },
+	{ "IF1 DAC4 Mux", "Slot1", "IF1 DAC1" },
+	{ "IF1 DAC4 Mux", "Slot2", "IF1 DAC2" },
+	{ "IF1 DAC4 Mux", "Slot3", "IF1 DAC3" },
+	{ "IF1 DAC4 Mux", "Slot4", "IF1 DAC4" },
+	{ "IF1 DAC4 Mux", "Slot5", "IF1 DAC5" },
+	{ "IF1 DAC4 Mux", "Slot6", "IF1 DAC6" },
+	{ "IF1 DAC4 Mux", "Slot7", "IF1 DAC7" },
+
+	{ "IF1 DAC5 Mux", "Slot0", "IF1 DAC0" },
+	{ "IF1 DAC5 Mux", "Slot1", "IF1 DAC1" },
+	{ "IF1 DAC5 Mux", "Slot2", "IF1 DAC2" },
+	{ "IF1 DAC5 Mux", "Slot3", "IF1 DAC3" },
+	{ "IF1 DAC5 Mux", "Slot4", "IF1 DAC4" },
+	{ "IF1 DAC5 Mux", "Slot5", "IF1 DAC5" },
+	{ "IF1 DAC5 Mux", "Slot6", "IF1 DAC6" },
+	{ "IF1 DAC5 Mux", "Slot7", "IF1 DAC7" },
+
+	{ "IF1 DAC6 Mux", "Slot0", "IF1 DAC0" },
+	{ "IF1 DAC6 Mux", "Slot1", "IF1 DAC1" },
+	{ "IF1 DAC6 Mux", "Slot2", "IF1 DAC2" },
+	{ "IF1 DAC6 Mux", "Slot3", "IF1 DAC3" },
+	{ "IF1 DAC6 Mux", "Slot4", "IF1 DAC4" },
+	{ "IF1 DAC6 Mux", "Slot5", "IF1 DAC5" },
+	{ "IF1 DAC6 Mux", "Slot6", "IF1 DAC6" },
+	{ "IF1 DAC6 Mux", "Slot7", "IF1 DAC7" },
+
+	{ "IF1 DAC7 Mux", "Slot0", "IF1 DAC0" },
+	{ "IF1 DAC7 Mux", "Slot1", "IF1 DAC1" },
+	{ "IF1 DAC7 Mux", "Slot2", "IF1 DAC2" },
+	{ "IF1 DAC7 Mux", "Slot3", "IF1 DAC3" },
+	{ "IF1 DAC7 Mux", "Slot4", "IF1 DAC4" },
+	{ "IF1 DAC7 Mux", "Slot5", "IF1 DAC5" },
+	{ "IF1 DAC7 Mux", "Slot6", "IF1 DAC6" },
+	{ "IF1 DAC7 Mux", "Slot7", "IF1 DAC7" },
+
+	{ "IF1 DAC01", NULL, "IF1 DAC0 Mux" },
+	{ "IF1 DAC01", NULL, "IF1 DAC1 Mux" },
+	{ "IF1 DAC23", NULL, "IF1 DAC2 Mux" },
+	{ "IF1 DAC23", NULL, "IF1 DAC3 Mux" },
+	{ "IF1 DAC45", NULL, "IF1 DAC4 Mux" },
+	{ "IF1 DAC45", NULL, "IF1 DAC5 Mux" },
+	{ "IF1 DAC67", NULL, "IF1 DAC6 Mux" },
+	{ "IF1 DAC67", NULL, "IF1 DAC7 Mux" },
 
 	{ "IF2 DAC0", NULL, "AIF2RX" },
 	{ "IF2 DAC1", NULL, "AIF2RX" },
@@ -3062,14 +3288,86 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "IF2 DAC6", NULL, "I2S2" },
 	{ "IF2 DAC7", NULL, "I2S2" },
 
-	{ "IF2 DAC01", NULL, "IF2 DAC0" },
-	{ "IF2 DAC01", NULL, "IF2 DAC1" },
-	{ "IF2 DAC23", NULL, "IF2 DAC2" },
-	{ "IF2 DAC23", NULL, "IF2 DAC3" },
-	{ "IF2 DAC45", NULL, "IF2 DAC4" },
-	{ "IF2 DAC45", NULL, "IF2 DAC5" },
-	{ "IF2 DAC67", NULL, "IF2 DAC6" },
-	{ "IF2 DAC67", NULL, "IF2 DAC7" },
+	{ "IF2 DAC0 Mux", "Slot0", "IF2 DAC0" },
+	{ "IF2 DAC0 Mux", "Slot1", "IF2 DAC1" },
+	{ "IF2 DAC0 Mux", "Slot2", "IF2 DAC2" },
+	{ "IF2 DAC0 Mux", "Slot3", "IF2 DAC3" },
+	{ "IF2 DAC0 Mux", "Slot4", "IF2 DAC4" },
+	{ "IF2 DAC0 Mux", "Slot5", "IF2 DAC5" },
+	{ "IF2 DAC0 Mux", "Slot6", "IF2 DAC6" },
+	{ "IF2 DAC0 Mux", "Slot7", "IF2 DAC7" },
+
+	{ "IF2 DAC1 Mux", "Slot0", "IF2 DAC0" },
+	{ "IF2 DAC1 Mux", "Slot1", "IF2 DAC1" },
+	{ "IF2 DAC1 Mux", "Slot2", "IF2 DAC2" },
+	{ "IF2 DAC1 Mux", "Slot3", "IF2 DAC3" },
+	{ "IF2 DAC1 Mux", "Slot4", "IF2 DAC4" },
+	{ "IF2 DAC1 Mux", "Slot5", "IF2 DAC5" },
+	{ "IF2 DAC1 Mux", "Slot6", "IF2 DAC6" },
+	{ "IF2 DAC1 Mux", "Slot7", "IF2 DAC7" },
+
+	{ "IF2 DAC2 Mux", "Slot0", "IF2 DAC0" },
+	{ "IF2 DAC2 Mux", "Slot1", "IF2 DAC1" },
+	{ "IF2 DAC2 Mux", "Slot2", "IF2 DAC2" },
+	{ "IF2 DAC2 Mux", "Slot3", "IF2 DAC3" },
+	{ "IF2 DAC2 Mux", "Slot4", "IF2 DAC4" },
+	{ "IF2 DAC2 Mux", "Slot5", "IF2 DAC5" },
+	{ "IF2 DAC2 Mux", "Slot6", "IF2 DAC6" },
+	{ "IF2 DAC2 Mux", "Slot7", "IF2 DAC7" },
+
+	{ "IF2 DAC3 Mux", "Slot0", "IF2 DAC0" },
+	{ "IF2 DAC3 Mux", "Slot1", "IF2 DAC1" },
+	{ "IF2 DAC3 Mux", "Slot2", "IF2 DAC2" },
+	{ "IF2 DAC3 Mux", "Slot3", "IF2 DAC3" },
+	{ "IF2 DAC3 Mux", "Slot4", "IF2 DAC4" },
+	{ "IF2 DAC3 Mux", "Slot5", "IF2 DAC5" },
+	{ "IF2 DAC3 Mux", "Slot6", "IF2 DAC6" },
+	{ "IF2 DAC3 Mux", "Slot7", "IF2 DAC7" },
+
+	{ "IF2 DAC4 Mux", "Slot0", "IF2 DAC0" },
+	{ "IF2 DAC4 Mux", "Slot1", "IF2 DAC1" },
+	{ "IF2 DAC4 Mux", "Slot2", "IF2 DAC2" },
+	{ "IF2 DAC4 Mux", "Slot3", "IF2 DAC3" },
+	{ "IF2 DAC4 Mux", "Slot4", "IF2 DAC4" },
+	{ "IF2 DAC4 Mux", "Slot5", "IF2 DAC5" },
+	{ "IF2 DAC4 Mux", "Slot6", "IF2 DAC6" },
+	{ "IF2 DAC4 Mux", "Slot7", "IF2 DAC7" },
+
+	{ "IF2 DAC5 Mux", "Slot0", "IF2 DAC0" },
+	{ "IF2 DAC5 Mux", "Slot1", "IF2 DAC1" },
+	{ "IF2 DAC5 Mux", "Slot2", "IF2 DAC2" },
+	{ "IF2 DAC5 Mux", "Slot3", "IF2 DAC3" },
+	{ "IF2 DAC5 Mux", "Slot4", "IF2 DAC4" },
+	{ "IF2 DAC5 Mux", "Slot5", "IF2 DAC5" },
+	{ "IF2 DAC5 Mux", "Slot6", "IF2 DAC6" },
+	{ "IF2 DAC5 Mux", "Slot7", "IF2 DAC7" },
+
+	{ "IF2 DAC6 Mux", "Slot0", "IF2 DAC0" },
+	{ "IF2 DAC6 Mux", "Slot1", "IF2 DAC1" },
+	{ "IF2 DAC6 Mux", "Slot2", "IF2 DAC2" },
+	{ "IF2 DAC6 Mux", "Slot3", "IF2 DAC3" },
+	{ "IF2 DAC6 Mux", "Slot4", "IF2 DAC4" },
+	{ "IF2 DAC6 Mux", "Slot5", "IF2 DAC5" },
+	{ "IF2 DAC6 Mux", "Slot6", "IF2 DAC6" },
+	{ "IF2 DAC6 Mux", "Slot7", "IF2 DAC7" },
+
+	{ "IF2 DAC7 Mux", "Slot0", "IF2 DAC0" },
+	{ "IF2 DAC7 Mux", "Slot1", "IF2 DAC1" },
+	{ "IF2 DAC7 Mux", "Slot2", "IF2 DAC2" },
+	{ "IF2 DAC7 Mux", "Slot3", "IF2 DAC3" },
+	{ "IF2 DAC7 Mux", "Slot4", "IF2 DAC4" },
+	{ "IF2 DAC7 Mux", "Slot5", "IF2 DAC5" },
+	{ "IF2 DAC7 Mux", "Slot6", "IF2 DAC6" },
+	{ "IF2 DAC7 Mux", "Slot7", "IF2 DAC7" },
+
+	{ "IF2 DAC01", NULL, "IF2 DAC0 Mux" },
+	{ "IF2 DAC01", NULL, "IF2 DAC1 Mux" },
+	{ "IF2 DAC23", NULL, "IF2 DAC2 Mux" },
+	{ "IF2 DAC23", NULL, "IF2 DAC3 Mux" },
+	{ "IF2 DAC45", NULL, "IF2 DAC4 Mux" },
+	{ "IF2 DAC45", NULL, "IF2 DAC5 Mux" },
+	{ "IF2 DAC67", NULL, "IF2 DAC6 Mux" },
+	{ "IF2 DAC67", NULL, "IF2 DAC7 Mux" },
 
 	{ "IF3 DAC", NULL, "AIF3RX" },
 	{ "IF3 DAC", NULL, "I2S3" },
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 9d473b2..2979d5a 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -799,7 +799,7 @@
 #define RT5677_PDM2_I2C_EXE			(0x1 << 1)
 #define RT5677_PDM2_I2C_BUSY			(0x1 << 0)
 
-/* MX3B TDM1 control 1 (0x3b) */
+/* TDM1 control 1 (0x3b) */
 #define RT5677_IF1_ADC_MODE_MASK		(0x1 << 12)
 #define RT5677_IF1_ADC_MODE_SFT			12
 #define RT5677_IF1_ADC_MODE_I2S			(0x0 << 12)
@@ -813,7 +813,7 @@
 #define RT5677_IF1_ADC4_SWAP_MASK		(0x3 << 0)
 #define RT5677_IF1_ADC4_SWAP_SFT		0
 
-/* MX3C TDM1 control 2 (0x3c) */
+/* TDM1 control 2 (0x3c) */
 #define RT5677_IF1_ADC4_MASK			(0x3 << 10)
 #define RT5677_IF1_ADC4_SFT			10
 #define RT5677_IF1_ADC3_MASK			(0x3 << 8)
@@ -825,7 +825,27 @@
 #define RT5677_IF1_ADC_CTRL_MASK		(0x7 << 0)
 #define RT5677_IF1_ADC_CTRL_SFT			0
 
-/* MX40 TDM2 control 1 (0x40) */
+/* TDM1 control 4 (0x3e) */
+#define RT5677_IF1_DAC0_MASK			(0x7 << 12)
+#define RT5677_IF1_DAC0_SFT			12
+#define RT5677_IF1_DAC1_MASK			(0x7 << 8)
+#define RT5677_IF1_DAC1_SFT			8
+#define RT5677_IF1_DAC2_MASK			(0x7 << 4)
+#define RT5677_IF1_DAC2_SFT			4
+#define RT5677_IF1_DAC3_MASK			(0x7 << 0)
+#define RT5677_IF1_DAC3_SFT			0
+
+/* TDM1 control 5 (0x3f) */
+#define RT5677_IF1_DAC4_MASK			(0x7 << 12)
+#define RT5677_IF1_DAC4_SFT			12
+#define RT5677_IF1_DAC5_MASK			(0x7 << 8)
+#define RT5677_IF1_DAC5_SFT			8
+#define RT5677_IF1_DAC6_MASK			(0x7 << 4)
+#define RT5677_IF1_DAC6_SFT			4
+#define RT5677_IF1_DAC7_MASK			(0x7 << 0)
+#define RT5677_IF1_DAC7_SFT			0
+
+/* TDM2 control 1 (0x40) */
 #define RT5677_IF2_ADC_MODE_MASK		(0x1 << 12)
 #define RT5677_IF2_ADC_MODE_SFT			12
 #define RT5677_IF2_ADC_MODE_I2S			(0x0 << 12)
@@ -839,7 +859,7 @@
 #define RT5677_IF2_ADC4_SWAP_MASK		(0x3 << 0)
 #define RT5677_IF2_ADC4_SWAP_SFT		0
 
-/* MX41 TDM2 control 2 (0x41) */
+/* TDM2 control 2 (0x41) */
 #define RT5677_IF2_ADC4_MASK			(0x3 << 10)
 #define RT5677_IF2_ADC4_SFT			10
 #define RT5677_IF2_ADC3_MASK			(0x3 << 8)
@@ -851,6 +871,26 @@
 #define RT5677_IF2_ADC_CTRL_MASK		(0x7 << 0)
 #define RT5677_IF2_ADC_CTRL_SFT			0
 
+/* TDM2 control 4 (0x43) */
+#define RT5677_IF2_DAC0_MASK			(0x7 << 12)
+#define RT5677_IF2_DAC0_SFT			12
+#define RT5677_IF2_DAC1_MASK			(0x7 << 8)
+#define RT5677_IF2_DAC1_SFT			8
+#define RT5677_IF2_DAC2_MASK			(0x7 << 4)
+#define RT5677_IF2_DAC2_SFT			4
+#define RT5677_IF2_DAC3_MASK			(0x7 << 0)
+#define RT5677_IF2_DAC3_SFT			0
+
+/* TDM2 control 5 (0x44) */
+#define RT5677_IF2_DAC4_MASK			(0x7 << 12)
+#define RT5677_IF2_DAC4_SFT			12
+#define RT5677_IF2_DAC5_MASK			(0x7 << 8)
+#define RT5677_IF2_DAC5_SFT			8
+#define RT5677_IF2_DAC6_MASK			(0x7 << 4)
+#define RT5677_IF2_DAC6_SFT			4
+#define RT5677_IF2_DAC7_MASK			(0x7 << 0)
+#define RT5677_IF2_DAC7_SFT			0
+
 /* Digital Microphone Control 1 (0x50) */
 #define RT5677_DMIC_1_EN_MASK			(0x1 << 15)
 #define RT5677_DMIC_1_EN_SFT			15
-- 
1.8.1.1.439.g50a6b54
