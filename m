From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr-rt5651: add support for
	Line In" to the asoc tree
Date: Mon, 08 Jan 2018 16:22:57 +0000
Message-ID: <E1eYaCP-0002BW-Vn@debutante>
References: <20180105192023.11229-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D486A26754E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 17:23:21 +0100 (CET)
In-Reply-To: <20180105192023.11229-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, Carlo Caione <carlo@caione.org>, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr-rt5651: add support for Line In

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

>From ea39bdcf22b084c6e6db0078f3140f0655a1e572 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 5 Jan 2018 13:20:23 -0600
Subject: [PATCH] ASoC: Intel: bytcr-rt5651: add support for Line In

Add the DAPM widgets and routes.

Tested with MinnowMax Turbot + rt5651 eval board with Speaker
(LineOut) -> LineIn loopback

Thanks to Bard Liao @ Realtek for providing the 0dB settings

"IN Capture Volume" = 23
"ADC Capture Volume" = 47
"OUT Playback Volume" = 31
"DAC1 Playback Volume" = 175

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.15.1
