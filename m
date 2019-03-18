From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Check JD status when system
	resume" to the asoc tree
Date: Mon, 18 Mar 2019 14:51:07 +0000 (GMT)
Message-ID: <20190318145107.580771128874@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8192F8971A
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:51:08 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Shuming Fan <shumingf@realtek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: Check JD status when system resume

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

>From 4834d7070c85a5fb69637265dbbb05d13043280c Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Fri, 8 Mar 2019 11:36:08 +0800
Subject: [PATCH] ASoC: rt5682: Check JD status when system resume

The IRQ function may not work when system suspend.
We remove snd_soc_dapm_force_enable_pin function call to
make sure the bias off when idle and run into suspend/resume function.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 9d5acd2d04ab..b7e2e9937e6d 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -910,13 +910,20 @@ static int rt5682_headset_detect(struct snd_soc_component *component,
 		int jack_insert)
 {
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
-	struct snd_soc_dapm_context *dapm =
-		snd_soc_component_get_dapm(component);
 	unsigned int val, count;
 
 	if (jack_insert) {
-		snd_soc_dapm_force_enable_pin(dapm, "CBJ Power");
-		snd_soc_dapm_sync(dapm);
+
+		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_1,
+			RT5682_PWR_VREF2, RT5682_PWR_VREF2);
+		snd_soc_component_update_bits(component,
+				RT5682_PWR_ANLG_1, RT5682_PWR_FV2, 0);
+		usleep_range(15000, 20000);
+		snd_soc_component_update_bits(component,
+				RT5682_PWR_ANLG_1, RT5682_PWR_FV2, RT5682_PWR_FV2);
+		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_3,
+			RT5682_PWR_CBJ, RT5682_PWR_CBJ);
+
 		snd_soc_component_update_bits(component, RT5682_CBJ_CTRL_1,
 			RT5682_TRIG_JD_MASK, RT5682_TRIG_JD_HIGH);
 
@@ -944,8 +951,10 @@ static int rt5682_headset_detect(struct snd_soc_component *component,
 		rt5682_enable_push_button_irq(component, false);
 		snd_soc_component_update_bits(component, RT5682_CBJ_CTRL_1,
 			RT5682_TRIG_JD_MASK, RT5682_TRIG_JD_LOW);
-		snd_soc_dapm_disable_pin(dapm, "CBJ Power");
-		snd_soc_dapm_sync(dapm);
+		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_1,
+			RT5682_PWR_VREF2, 0);
+		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_3,
+			RT5682_PWR_CBJ, 0);
 
 		rt5682->jack_type = 0;
 	}
@@ -1591,8 +1600,6 @@ static const struct snd_soc_dapm_widget rt5682_dapm_widgets[] = {
 		0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("Vref1", RT5682_PWR_ANLG_1, RT5682_PWR_VREF1_BIT, 0,
 		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_SUPPLY("Vref2", RT5682_PWR_ANLG_1, RT5682_PWR_VREF2_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
 	/* ASRC */
 	SND_SOC_DAPM_SUPPLY_S("DAC STO1 ASRC", 1, RT5682_PLL_TRACK_1,
@@ -1627,9 +1634,6 @@ static const struct snd_soc_dapm_widget rt5682_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("BST1 CBJ", SND_SOC_NOPM,
 		0, 0, NULL, 0),
 
-	SND_SOC_DAPM_SUPPLY("CBJ Power", RT5682_PWR_ANLG_3,
-		RT5682_PWR_CBJ_BIT, 0, NULL, 0),
-
 	/* REC Mixer */
 	SND_SOC_DAPM_MIXER("RECMIX1L", SND_SOC_NOPM, 0, 0, rt5682_rec1_l_mix,
 		ARRAY_SIZE(rt5682_rec1_l_mix)),
@@ -1792,17 +1796,13 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 
 	/*Vref*/
 	{"MICBIAS1", NULL, "Vref1"},
-	{"MICBIAS1", NULL, "Vref2"},
 	{"MICBIAS2", NULL, "Vref1"},
-	{"MICBIAS2", NULL, "Vref2"},
 
 	{"CLKDET SYS", NULL, "CLKDET"},
 
 	{"IN1P", NULL, "LDO2"},
 
 	{"BST1 CBJ", NULL, "IN1P"},
-	{"BST1 CBJ", NULL, "CBJ Power"},
-	{"CBJ Power", NULL, "Vref2"},
 
 	{"RECMIX1L", "CBJ Switch", "BST1 CBJ"},
 	{"RECMIX1L", NULL, "RECMIX1L Power"},
@@ -1912,9 +1912,7 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 	{"HP Amp", NULL, "Capless"},
 	{"HP Amp", NULL, "Charge Pump"},
 	{"HP Amp", NULL, "CLKDET SYS"},
-	{"HP Amp", NULL, "CBJ Power"},
 	{"HP Amp", NULL, "Vref1"},
-	{"HP Amp", NULL, "Vref2"},
 	{"HPOL Playback", "Switch", "HP Amp"},
 	{"HPOR Playback", "Switch", "HP Amp"},
 	{"HPOL", NULL, "HPOL Playback"},
@@ -2363,6 +2361,8 @@ static int rt5682_resume(struct snd_soc_component *component)
 	regcache_cache_only(rt5682->regmap, false);
 	regcache_sync(rt5682->regmap);
 
+	rt5682_irq(0, rt5682);
+
 	return 0;
 }
 #else
-- 
2.20.1
