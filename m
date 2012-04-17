From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Keep AIF3 tristated when not in
	use
Date: Tue, 17 Apr 2012 21:04:24 +0100
Message-ID: <1334693065-26579-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8306F24141
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 22:04:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since AIF3 shares clock signals with other audio interfaces in order to
ensure it doesn't drive undesirable clocks we need to tristate it. Rather
than forcing the machine driver to do so have the driver do this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 36c338f..35c8a2a 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1735,6 +1735,7 @@ SND_SOC_DAPM_MUX("AIF3ADC Mux", SND_SOC_NOPM, 0, 0, &wm8994_aif3adc_mux),
 };
 
 static const struct snd_soc_dapm_widget wm8958_dapm_widgets[] = {
+SND_SOC_DAPM_SUPPLY("AIF3", WM8994_POWER_MANAGEMENT_6, 5, 1, NULL, 0),
 SND_SOC_DAPM_MUX("Mono PCM Out Mux", SND_SOC_NOPM, 0, 0, &mono_pcm_out_mux),
 SND_SOC_DAPM_MUX("AIF2DACL Mux", SND_SOC_NOPM, 0, 0, &aif2dacl_src_mux),
 SND_SOC_DAPM_MUX("AIF2DACR Mux", SND_SOC_NOPM, 0, 0, &aif2dacr_src_mux),
@@ -1975,6 +1976,9 @@ static const struct snd_soc_dapm_route wm8958_intercon[] = {
 	{ "AIF2DACR Mux", "AIF2", "AIF2DAC Mux" },
 	{ "AIF2DACR Mux", "AIF3", "AIF3DACDAT" },
 
+	{ "AIF3DACDAT", NULL, "AIF3" },
+	{ "AIF3ADCDAT", NULL, "AIF3" },
+
 	{ "Mono PCM Out Mux", "AIF2ADCL", "AIF2ADCL" },
 	{ "Mono PCM Out Mux", "AIF2ADCR", "AIF2ADCR" },
 
@@ -2845,10 +2849,6 @@ static int wm8994_set_tristate(struct snd_soc_dai *codec_dai, int tristate)
 		reg = WM8994_AIF2_MASTER_SLAVE;
 		mask = WM8994_AIF2_TRI;
 		break;
-	case 3:
-		reg = WM8994_POWER_MANAGEMENT_6;
-		mask = WM8994_AIF3_TRI;
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -2901,7 +2901,6 @@ static const struct snd_soc_dai_ops wm8994_aif2_dai_ops = {
 
 static const struct snd_soc_dai_ops wm8994_aif3_dai_ops = {
 	.hw_params	= wm8994_aif3_hw_params,
-	.set_tristate	= wm8994_set_tristate,
 };
 
 static struct snd_soc_dai_driver wm8994_dai[] = {
-- 
1.7.10
