From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8810: change input PGA mixer stage"
	to the asoc tree
Date: Fri,  4 May 2018 00:18:57 +0100 (BST)
Message-ID: <20180503231857.5160B44007A@finisterre.ee.mobilebroadband>
References: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DFDCA267412
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 01:19:01 +0200 (CEST)
In-Reply-To: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, CFYU0@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, YCPENG7@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8810: change input PGA mixer stage

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

>From a7ea9385d41716f8dd5f69b4a5deaf836d67d968 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Thu, 3 May 2018 10:46:41 +0800
Subject: [PATCH] ASoC: nau8810: change input PGA mixer stage

Organize the paths of the mixer, "Input Boost Stage", including
the routes of the mixer. The control is not used correctly before.
Besides, the driver changes the name of the mixer controls.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8810.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index ca2ba1c7bb9a..bfd74b86c9d2 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -373,9 +373,11 @@ static const struct snd_kcontrol_new nau8810_mono_mixer_controls[] = {
 };
 
 /* PGA Mute */
-static const struct snd_kcontrol_new nau8810_inpga_mute[] = {
+static const struct snd_kcontrol_new nau8810_pgaboost_mixer_controls[] = {
 	SOC_DAPM_SINGLE("PGA Mute Switch", NAU8810_REG_PGAGAIN,
-		NAU8810_PGAMT_SFT, 1, 0),
+		NAU8810_PGAMT_SFT, 1, 1),
+	SOC_DAPM_SINGLE("PMIC PGA Switch", NAU8810_REG_ADCBOOST,
+		NAU8810_PMICBSTGAIN_SFT, 0x7, 0),
 };
 
 /* Input PGA */
@@ -386,11 +388,6 @@ static const struct snd_kcontrol_new nau8810_inpga[] = {
 		NAU8810_PMICPGA_SFT, 1, 0),
 };
 
-/* Mic Input boost vol */
-static const struct snd_kcontrol_new nau8810_mic_boost_controls =
-	SOC_DAPM_SINGLE("Mic Volume", NAU8810_REG_ADCBOOST,
-		NAU8810_PMICBSTGAIN_SFT, 0x7, 0);
-
 /* Loopback Switch */
 static const struct snd_kcontrol_new nau8810_loopback =
 	SOC_DAPM_SINGLE("Switch", NAU8810_REG_COMP,
@@ -429,8 +426,8 @@ static const struct snd_soc_dapm_widget nau8810_dapm_widgets[] = {
 		NAU8810_PGA_EN_SFT, 0, nau8810_inpga,
 		ARRAY_SIZE(nau8810_inpga)),
 	SND_SOC_DAPM_MIXER("Input Boost Stage", NAU8810_REG_POWER2,
-		NAU8810_BST_EN_SFT, 0, nau8810_inpga_mute,
-		ARRAY_SIZE(nau8810_inpga_mute)),
+		NAU8810_BST_EN_SFT, 0, nau8810_pgaboost_mixer_controls,
+		ARRAY_SIZE(nau8810_pgaboost_mixer_controls)),
 
 	SND_SOC_DAPM_SUPPLY("Mic Bias", NAU8810_REG_POWER1,
 		NAU8810_MICBIAS_EN_SFT, 0, NULL, 0),
@@ -469,8 +466,8 @@ static const struct snd_soc_dapm_route nau8810_dapm_routes[] = {
 	/* Input Boost Stage */
 	{"ADC", NULL, "Input Boost Stage"},
 	{"ADC", NULL, "PLL", check_mclk_select_pll},
-	{"Input Boost Stage", NULL, "Input PGA"},
-	{"Input Boost Stage", NULL, "MICP"},
+	{"Input Boost Stage", "PGA Mute Switch", "Input PGA"},
+	{"Input Boost Stage", "PMIC PGA Switch", "MICP"},
 
 	/* Input PGA */
 	{"Input PGA", NULL, "Mic Bias"},
-- 
2.17.0
