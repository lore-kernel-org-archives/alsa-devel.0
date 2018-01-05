From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/4] ASoC: Intel: bytcr-rt5651: add support for
	Line In
Date: Fri,  5 Jan 2018 13:20:23 -0600
Message-ID: <20180105192023.11229-7-pierre-louis.bossart@linux.intel.com>
References: <20180105192023.11229-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F8BE267AC3
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 20:20:38 +0100 (CET)
In-Reply-To: <20180105192023.11229-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, Carlo Caione <carlo@caione.org>, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

Add the DAPM widgets and routes.

Tested with MinnowMax Turbot + rt5651 eval board with Speaker
(LineOut) -> LineIn loopback

Thanks to Bard Liao @ Realtek for providing the 0dB settings

"IN Capture Volume" = 23
"ADC Capture Volume" = 47
"OUT Playback Volume" = 31
"DAC1 Playback Volume" = 175

Cc: Bard Liao <bardliao@realtek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index dfe6435f8ed0..22c9cc5d135e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -131,6 +131,7 @@ static const struct snd_soc_dapm_widget byt_rt5651_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Internal Mic", NULL),
 	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			    platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			    SND_SOC_DAPM_POST_PMD),
@@ -142,6 +143,7 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 	{"Headset Mic", NULL, "Platform Clock"},
 	{"Internal Mic", NULL, "Platform Clock"},
 	{"Speaker", NULL, "Platform Clock"},
+	{"Line In", NULL, "Platform Clock"},
 
 	{"AIF1 Playback", NULL, "ssp2 Tx"},
 	{"ssp2 Tx", NULL, "codec_out0"},
@@ -155,6 +157,9 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 	{"Headphone", NULL, "HPOR"},
 	{"Speaker", NULL, "LOUTL"},
 	{"Speaker", NULL, "LOUTR"},
+	{"IN2P", NULL, "Line In"},
+	{"IN2N", NULL, "Line In"},
+
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
@@ -193,6 +198,7 @@ static const struct snd_kcontrol_new byt_rt5651_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Internal Mic"),
 	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Line In"),
 };
 
 static struct snd_soc_jack_pin bytcr_jack_pins[] = {
-- 
2.14.1
