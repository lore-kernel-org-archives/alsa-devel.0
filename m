From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: Enable HDMI and DP on
	skl_rt286 machine" to the asoc tree
Date: Wed, 24 Feb 2016 17:42:51 +0900
Message-ID: <E1aYV23-0002wf-8i@finisterre>
References: <1456293464-19646-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5680F266821
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 09:43:01 +0100 (CET)
In-Reply-To: <1456293464-19646-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: Enable HDMI and DP on skl_rt286 machine

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

>From 23905cd1ca48cbc852a670a3dbbfc5e7d694580f Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 24 Feb 2016 11:27:38 +0530
Subject: [PATCH] ASoC: Intel: boards: Enable HDMI and DP on skl_rt286 machine

Skylake platform has 3 pin widgets in HDMI codec. This patch adds
3 FE and BE dai links to support these in rt286 machine

Also add jack initialization for each of the device.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig            |   1 +
 sound/soc/intel/boards/skl_rt286.c | 111 +++++++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 6e65085e8bc3..9574b483f249 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -164,6 +164,7 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT286
 	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
 	help
 	   This adds support for ASoC machine driver for Skylake platforms
 	   with RT286 I2S audio codec.
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 2cbcbe412661..00b84c1ff07f 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -26,8 +26,20 @@
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
 #include "../../codecs/rt286.h"
+#include "../../codecs/hdac_hdmi.h"
 
 static struct snd_soc_jack skylake_headset;
+
+enum {
+	SKL_DPCM_AUDIO_PB = 0,
+	SKL_DPCM_AUDIO_CP,
+	SKL_DPCM_AUDIO_REF_CP,
+	SKL_DPCM_AUDIO_DMIC_CP,
+	SKL_DPCM_AUDIO_HDMI1_PB,
+	SKL_DPCM_AUDIO_HDMI2_PB,
+	SKL_DPCM_AUDIO_HDMI3_PB,
+};
+
 /* Headset jack detection DAPM pins */
 static struct snd_soc_jack_pin skylake_headset_pins[] = {
 	{
@@ -53,6 +65,9 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_MIC("DMIC2", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 	SND_SOC_DAPM_SINK("WoV Sink"),
+	SND_SOC_DAPM_SPK("HDMI1", NULL),
+	SND_SOC_DAPM_SPK("HDMI2", NULL),
+	SND_SOC_DAPM_SPK("HDMI3", NULL),
 };
 
 static const struct snd_soc_dapm_route skylake_rt286_map[] = {
@@ -72,6 +87,10 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 
 	{"WoV Sink", NULL, "hwd_in sink"},
 
+	{"HDMI1", NULL, "hif5 Output"},
+	{"HDMI2", NULL, "hif6 Output"},
+	{"HDMI3", NULL, "hif7 Output"},
+
 	/* CODEC BE connections */
 	{ "AIF1 Playback", NULL, "ssp0 Tx"},
 	{ "ssp0 Tx", NULL, "codec0_out"},
@@ -84,8 +103,12 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
 	{ "DMIC01 Rx", NULL, "DMIC AIF" },
 
-	{ "hif1", NULL, "iDisp Tx"},
-	{ "iDisp Tx", NULL, "iDisp_out"},
+	{ "hifi3", NULL, "iDisp3 Tx"},
+	{ "iDisp3 Tx", NULL, "iDisp3_out"},
+	{ "hifi2", NULL, "iDisp2 Tx"},
+	{ "iDisp2 Tx", NULL, "iDisp2_out"},
+	{ "hifi1", NULL, "iDisp1 Tx"},
+	{ "iDisp1 Tx", NULL, "iDisp1_out"},
 
 };
 
@@ -121,6 +144,13 @@ static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int skylake_hdmi_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai = rtd->codec_dai;
+
+	return hdac_hdmi_jack_init(dai, SKL_DPCM_AUDIO_HDMI1_PB + dai->id);
+}
+
 static unsigned int rates[] = {
 	48000,
 };
@@ -249,7 +279,7 @@ static struct snd_soc_ops skylake_dmic_ops = {
 /* skylake digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link skylake_rt286_dais[] = {
 	/* Front End DAI links */
-	{
+	[SKL_DPCM_AUDIO_PB] = {
 		.name = "Skl Audio Port",
 		.stream_name = "Audio",
 		.cpu_dai_name = "System Pin",
@@ -266,7 +296,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &skylake_rt286_fe_ops,
 	},
-	{
+	[SKL_DPCM_AUDIO_CP] = {
 		.name = "Skl Audio Capture Port",
 		.stream_name = "Audio Record",
 		.cpu_dai_name = "System Pin",
@@ -282,7 +312,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &skylake_rt286_fe_ops,
 	},
-	{
+	[SKL_DPCM_AUDIO_REF_CP] = {
 		.name = "Skl Audio Reference cap",
 		.stream_name = "refcap",
 		.cpu_dai_name = "Reference Pin",
@@ -295,7 +325,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	{
+	[SKL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Skl Audio DMIC cap",
 		.stream_name = "dmiccap",
 		.cpu_dai_name = "DMIC Pin",
@@ -308,6 +338,42 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.dynamic = 1,
 		.ops = &skylake_dmic_ops,
 	},
+	[SKL_DPCM_AUDIO_HDMI1_PB] = {
+		.name = "Skl HDMI Port1",
+		.stream_name = "Hdmi1",
+		.cpu_dai_name = "HDMI1 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[SKL_DPCM_AUDIO_HDMI2_PB] = {
+		.name = "Skl HDMI Port2",
+		.stream_name = "Hdmi2",
+		.cpu_dai_name = "HDMI2 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[SKL_DPCM_AUDIO_HDMI3_PB] = {
+		.name = "Skl HDMI Port3",
+		.stream_name = "Hdmi3",
+		.cpu_dai_name = "HDMI3 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
 
 	/* Back End DAI links */
 	{
@@ -341,6 +407,39 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.dpcm_capture = 1,
 		.no_pcm = 1,
 	},
+	{
+		.name = "iDisp1",
+		.be_id = 2,
+		.cpu_dai_name = "iDisp1 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi1",
+		.platform_name = "0000:00:1f.3",
+		.init = skylake_hdmi_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp2",
+		.be_id = 3,
+		.cpu_dai_name = "iDisp2 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi2",
+		.platform_name = "0000:00:1f.3",
+		.init = skylake_hdmi_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp3",
+		.be_id = 4,
+		.cpu_dai_name = "iDisp3 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi3",
+		.platform_name = "0000:00:1f.3",
+		.init = skylake_hdmi_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
 };
 
 /* skylake audio machine driver for SPT + RT286S */
-- 
2.7.0
