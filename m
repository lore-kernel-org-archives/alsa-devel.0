From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 1/2] ASoC: nau8810: change input PGA mixer stage
Date: Thu, 3 May 2018 10:46:41 +0800
Message-ID: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EF1A266F4E
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 04:46:50 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, CFYU0@nuvoton.com, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, YCPENG7@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Organize the paths of the mixer, "Input Boost Stage", including
the routes of the mixer. The control is not used correctly before.
Besides, the driver changes the name of the mixer controls.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8810.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index ca2ba1c..bfd74b8 100644
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
2.6.4
