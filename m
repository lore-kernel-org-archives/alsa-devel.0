From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2 2.6.38] ASoC: WM8994: Ensure late enable
	events are processed for the ADCs
Date: Mon, 28 Feb 2011 17:24:12 +0000
Message-ID: <1298913852-22766-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1298913852-22766-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7729E103848
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 18:24:14 +0100 (CET)
In-Reply-To: <1298913852-22766-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Ensure that the ADCs are provided with a clock as the previous patch
"ASoC: WM8994: Improve playback robustness" did not handle this case
properly.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 9e91525..f330ad0 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1096,6 +1096,13 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int adc_mux_ev(struct snd_soc_dapm_widget *w,
+		      struct snd_kcontrol *kcontrol, int event)
+{
+	late_enable_ev(w, kcontrol, event);
+	return 0;
+}
+
 static int dac_ev(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event)
 {
@@ -1510,8 +1517,10 @@ SND_SOC_DAPM_ADC("DMIC1R", NULL, WM8994_POWER_MANAGEMENT_4, 2, 0),
 SND_SOC_DAPM_ADC("ADCL", NULL, SND_SOC_NOPM, 1, 0),
 SND_SOC_DAPM_ADC("ADCR", NULL, SND_SOC_NOPM, 0, 0),
 
-SND_SOC_DAPM_MUX("ADCL Mux", WM8994_POWER_MANAGEMENT_4, 1, 0, &adcl_mux),
-SND_SOC_DAPM_MUX("ADCR Mux", WM8994_POWER_MANAGEMENT_4, 0, 0, &adcr_mux),
+SND_SOC_DAPM_MUX_E("ADCL Mux", WM8994_POWER_MANAGEMENT_4, 1, 0, &adcl_mux,
+		   adc_mux_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_MUX_E("ADCR Mux", WM8994_POWER_MANAGEMENT_4, 0, 0, &adcr_mux,
+		   adc_mux_ev, SND_SOC_DAPM_PRE_PMU),
 
 SND_SOC_DAPM_MUX("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &hpl_mux),
 SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &hpr_mux),
-- 
1.7.4.1
