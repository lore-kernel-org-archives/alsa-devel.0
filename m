From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8824: recover system clock when
	device changes
Date: Wed, 21 Mar 2018 12:16:32 +0800
Message-ID: <1521605792-17360-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A155267219
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 05:16:42 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

User reports an issue in Ubuntu about the device switch upon playback.
We find the FLL will disalbe when switching headphone to speaker.
The pulseaudio will stop the headphone and close its power. Then,
it just opens the speaker and turn on its power. Therefore,
the supply of system clock does the OFF event and disables FLL.
But the FLL doesn't enable again when the speaker powers on.

The patch adds the recovery of system clock to enable FLL again
for this case. And it covers the case that system clock from MCLK.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8824.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 4d9148a..637e952 100644
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
2.6.4
