From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: recover system clock when
	device changes" to the asoc tree
Date: Thu, 22 Mar 2018 02:13:39 +0000 (GMT)
Message-ID: <20180322021339.973D244007A@finisterre.ee.mobilebroadband>
References: <1521605792-17360-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 56275267282
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 03:13:44 +0100 (CET)
In-Reply-To: <1521605792-17360-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8824: recover system clock when device changes

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

>From b53117c0b881d78d5d66a7e1be11d62a077c1e25 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Wed, 21 Mar 2018 12:16:32 +0800
Subject: [PATCH] ASoC: nau8824: recover system clock when device changes

User reports an issue in Ubuntu about the device switch upon playback.
We find the FLL will disalbe when switching headphone to speaker.
The pulseaudio will stop the headphone and close its power. Then,
it just opens the speaker and turn on its power. Therefore,
the supply of system clock does the OFF event and disables FLL.
But the FLL doesn't enable again when the speaker powers on.

The patch adds the recovery of system clock to enable FLL again
for this case. And it covers the case that system clock from MCLK.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 4d9148a6a080..637e9527805f 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -489,8 +489,12 @@ static int system_clock_control(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8824->regmap;
+	unsigned int value;
+	bool clk_fll, error;
 
 	if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		dev_dbg(nau8824->dev, "system clock control : POWER OFF\n");
 		/* Set clock source to disable or internal clock before the
 		 * playback or capture end. Codec needs clock for Jack
 		 * detection and button press if jack inserted; otherwise,
@@ -502,7 +506,40 @@ static int system_clock_control(struct snd_soc_dapm_widget *w,
 		} else {
 			nau8824_config_sysclk(nau8824, NAU8824_CLK_DIS, 0);
 		}
+	} else {
+		dev_dbg(nau8824->dev, "system clock control : POWER ON\n");
+		/* Check the clock source setting is proper or not
+		 * no matter the source is from FLL or MCLK.
+		 */
+		regmap_read(regmap, NAU8824_REG_FLL1, &value);
+		clk_fll = value & NAU8824_FLL_RATIO_MASK;
+		/* It's error to use internal clock when playback */
+		regmap_read(regmap, NAU8824_REG_FLL6, &value);
+		error = value & NAU8824_DCO_EN;
+		if (!error) {
+			/* Check error depending on source is FLL or MCLK. */
+			regmap_read(regmap, NAU8824_REG_CLK_DIVIDER, &value);
+			if (clk_fll)
+				error = !(value & NAU8824_CLK_SRC_VCO);
+			else
+				error = value & NAU8824_CLK_SRC_VCO;
+		}
+		/* Recover the clock source setting if error. */
+		if (error) {
+			if (clk_fll) {
+				regmap_update_bits(regmap,
+					NAU8824_REG_FLL6, NAU8824_DCO_EN, 0);
+				regmap_update_bits(regmap,
+					NAU8824_REG_CLK_DIVIDER,
+					NAU8824_CLK_SRC_MASK,
+					NAU8824_CLK_SRC_VCO);
+			} else {
+				nau8824_config_sysclk(nau8824,
+					NAU8824_CLK_MCLK, 0);
+			}
+		}
 	}
+
 	return 0;
 }
 
@@ -591,7 +628,8 @@ static const struct snd_kcontrol_new nau8824_dacr_mux =
 
 static const struct snd_soc_dapm_widget nau8824_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("System Clock", SND_SOC_NOPM, 0, 0,
-			system_clock_control, SND_SOC_DAPM_POST_PMD),
+		system_clock_control, SND_SOC_DAPM_POST_PMD |
+		SND_SOC_DAPM_POST_PMU),
 
 	SND_SOC_DAPM_INPUT("HSMIC1"),
 	SND_SOC_DAPM_INPUT("HSMIC2"),
-- 
2.16.2
