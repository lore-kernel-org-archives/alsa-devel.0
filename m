From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Correct the mixer switch
	setting and remove redundant routing path" to the asoc tree
Date: Wed, 19 Jul 2017 12:27:12 +0100
Message-ID: <E1dXn8K-0002dQ-8f@debutante>
References: <1500430823-29164-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BB42626731F
 for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2017 13:27:21 +0200 (CEST)
In-Reply-To: <1500430823-29164-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Correct the mixer switch setting and remove redundant routing path

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

>From 1d5c5b6582cf829fc4c0c8eef6b9f9f0dc29c7b2 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Wed, 19 Jul 2017 10:20:23 +0800
Subject: [PATCH] ASoC: rt5663: Correct the mixer switch setting and remove
 redundant routing path

The patch corrects the mixer siwtch setting that was the mistake in the
previous commitment. And remove the redundant routing paths.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index d3f7bc2173e8..45f8a9888f7d 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -59,7 +59,7 @@ struct rt5663_priv {
 };
 
 static const struct reg_sequence rt5663_patch_list[] = {
-	{ 0x002a, 0x8080 },
+	{ 0x002a, 0x8020 },
 	{ 0x0086, 0x0028 },
 };
 
@@ -482,7 +482,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0023, 0x0039 },
 	{ 0x0026, 0xc0c0 },
 	{ 0x0029, 0x8080 },
-	{ 0x002a, 0x8080 },
+	{ 0x002a, 0x8020 },
 	{ 0x002c, 0x000c },
 	{ 0x002d, 0x0000 },
 	{ 0x0040, 0x0808 },
@@ -1967,8 +1967,8 @@ static const struct snd_kcontrol_new rt5663_sto1_dac_l_mix[] = {
 };
 
 static const struct snd_kcontrol_new rt5663_sto1_dac_r_mix[] = {
-	SOC_DAPM_SINGLE("DAC L Switch", RT5663_STO_DAC_MIXER,
-			RT5663_M_DAC_L1_STO_R_SHIFT, 1, 1),
+	SOC_DAPM_SINGLE("DAC R Switch", RT5663_STO_DAC_MIXER,
+			RT5663_M_DAC_R1_STO_R_SHIFT, 1, 1),
 };
 
 /* Out Switch */
@@ -2358,11 +2358,9 @@ static const struct snd_soc_dapm_route rt5663_dapm_routes[] = {
 	{ "DAC R1", NULL, "ADDA MIXR" },
 
 	{ "STO1 DAC MIXL", "DAC L Switch", "DAC L1" },
-	{ "STO1 DAC MIXL", "DAC R Switch", "DAC R1" },
 	{ "STO1 DAC MIXL", NULL, "STO1 DAC L Power" },
 	{ "STO1 DAC MIXL", NULL, "STO1 DAC Filter" },
 	{ "STO1 DAC MIXR", "DAC R Switch", "DAC R1" },
-	{ "STO1 DAC MIXR", "DAC L Switch", "DAC L1" },
 	{ "STO1 DAC MIXR", NULL, "STO1 DAC R Power" },
 	{ "STO1 DAC MIXR", NULL, "STO1 DAC Filter" },
 
-- 
2.13.2
