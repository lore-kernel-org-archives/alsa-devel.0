From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: move RT5645 muxes to
	rt5645_specific_dapm_widgets" to the asoc tree
Date: Tue, 07 Jul 2015 14:58:04 +0100
Message-ID: <E1ZCTNs-0005bl-UA@finisterre>
References: <1435558850-2040-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F6392654E6
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:15 +0200 (CEST)
In-Reply-To: <1435558850-2040-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: move RT5645 muxes to rt5645_specific_dapm_widgets

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

>From 83c09290adfb025d9a109d9c3c2956c81bcb241b Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 29 Jun 2015 14:20:50 +0800
Subject: [PATCH] ASoC: rt5645: move RT5645 muxes to
 rt5645_specific_dapm_widgets

This is a similar patch to "move RT5650 muxes to rt5650_specific_
dapm_widgets" patch. The purpose is to silence the "has no paths"
warnings.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a07966b..1d821da 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1697,15 +1697,6 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("IF1_ADC4", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* IF1 2 Mux */
-	SND_SOC_DAPM_MUX("RT5645 IF1 ADC1 Swap Mux", SND_SOC_NOPM,
-		0, 0, &rt5645_if1_adc1_in_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 ADC2 Swap Mux", SND_SOC_NOPM,
-		0, 0, &rt5645_if1_adc2_in_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 ADC3 Swap Mux", SND_SOC_NOPM,
-		0, 0, &rt5645_if1_adc3_in_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 ADC Mux", SND_SOC_NOPM,
-		0, 0, &rt5645_if1_adc_in_mux),
-
 	SND_SOC_DAPM_MUX("IF2 ADC Mux", SND_SOC_NOPM,
 		0, 0, &rt5645_if2_adc_in_mux),
 
@@ -1716,14 +1707,6 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("IF1 DAC1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 DAC2", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 DAC3", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 L Mux", SND_SOC_NOPM, 0, 0,
-		&rt5645_if1_dac0_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 R Mux", SND_SOC_NOPM, 0, 0,
-		&rt5645_if1_dac1_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 L Mux", SND_SOC_NOPM, 0, 0,
-		&rt5645_if1_dac2_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 R Mux", SND_SOC_NOPM, 0, 0,
-		&rt5645_if1_dac3_tdm_sel_mux),
 	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 ADC L", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 ADC R", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -1856,6 +1839,25 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("SPOR"),
 };
 
+static const struct snd_soc_dapm_widget rt5645_specific_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac0_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac1_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac2_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac3_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc_in_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC1 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc1_in_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC2 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc2_in_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC3 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc3_in_mux),
+};
+
 static const struct snd_soc_dapm_widget rt5650_specific_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("A DAC1 L Mux", SND_SOC_NOPM,
 		0, 0, &rt5650_a_dac1_l_mux),
@@ -3049,6 +3051,9 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 
 	switch (rt5645->codec_type) {
 	case CODEC_TYPE_RT5645:
+		snd_soc_dapm_new_controls(&codec->dapm,
+			rt5645_specific_dapm_widgets,
+			ARRAY_SIZE(rt5645_specific_dapm_widgets));
 		snd_soc_dapm_add_routes(&codec->dapm,
 			rt5645_specific_dapm_routes,
 			ARRAY_SIZE(rt5645_specific_dapm_routes));
-- 
2.1.4
