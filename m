From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: Enable HDMI and DP on
	nau88l2 machine" to the asoc tree
Date: Wed, 24 Feb 2016 17:42:38 +0900
Message-ID: <E1aYV1q-0002w8-QJ@finisterre>
References: <1456293464-19646-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A8DE2667D3
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 09:42:49 +0100 (CET)
In-Reply-To: <1456293464-19646-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: Enable HDMI and DP on nau88l2 machine

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

>From bc5f6ac9a66f90f8e16e568ebd463cbe44f46b81 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 24 Feb 2016 11:27:39 +0530
Subject: [PATCH] ASoC: Intel: boards: Enable HDMI and DP on nau88l2 machine

This patch adds 2 HDMI FE and BE dai links and also
initializes the jack for each device.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig                       |   1 +
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 120 +++++++++++++++++++++++---
 2 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 9574b483f249..e29a7c5295a5 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -179,6 +179,7 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	select SND_SOC_NAU8825
 	select SND_SOC_SSM4567
 	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
 	help
 	  This adds support for ASoC Onboard Codec I2S machine driver. This will
 	  create an alsa sound card for NAU88L25 + SSM4567.
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index c071812f31e5..ccc3d4a4f4b6 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -26,6 +26,7 @@
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
 #include "../../codecs/nau8825.h"
+#include "../../codecs/hdac_hdmi.h"
 
 #define SKL_NUVOTON_CODEC_DAI	"nau8825-hifi"
 #define SKL_SSM_CODEC_DAI	"ssm4567-hifi"
@@ -33,6 +34,16 @@
 static struct snd_soc_jack skylake_headset;
 static struct snd_soc_card skylake_audio_card;
 
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
 static inline struct snd_soc_dai *skl_get_codec_dai(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
@@ -131,8 +142,14 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	/* DMIC */
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
 	{ "DMIC01 Rx", NULL, "DMIC AIF" },
-	{ "hifi1", NULL, "iDisp Tx"},
-	{ "iDisp Tx", NULL, "iDisp_out"},
+
+	{ "hifi3", NULL, "iDisp3 Tx"},
+	{ "iDisp3 Tx", NULL, "iDisp3_out"},
+	{ "hifi2", NULL, "iDisp2 Tx"},
+	{ "iDisp2 Tx", NULL, "iDisp2_out"},
+	{ "hifi1", NULL, "iDisp1 Tx"},
+	{ "iDisp1 Tx", NULL, "iDisp1_out"},
+
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
 };
@@ -202,6 +219,28 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
+static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai = rtd->codec_dai;
+
+	return hdac_hdmi_jack_init(dai, SKL_DPCM_AUDIO_HDMI1_PB);
+}
+
+static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai = rtd->codec_dai;
+
+	return hdac_hdmi_jack_init(dai, SKL_DPCM_AUDIO_HDMI2_PB);
+}
+
+
+static int skylake_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai = rtd->codec_dai;
+
+	return hdac_hdmi_jack_init(dai, SKL_DPCM_AUDIO_HDMI3_PB);
+}
+
 static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dapm_context *dapm;
@@ -362,7 +401,7 @@ static struct snd_soc_ops skylaye_refcap_ops = {
 /* skylake digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link skylake_dais[] = {
 	/* Front End DAI links */
-	{
+	[SKL_DPCM_AUDIO_PB] = {
 		.name = "Skl Audio Port",
 		.stream_name = "Audio",
 		.cpu_dai_name = "System Pin",
@@ -377,7 +416,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &skylake_nau8825_fe_ops,
 	},
-	{
+	[SKL_DPCM_AUDIO_CP] = {
 		.name = "Skl Audio Capture Port",
 		.stream_name = "Audio Record",
 		.cpu_dai_name = "System Pin",
@@ -391,7 +430,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &skylake_nau8825_fe_ops,
 	},
-	{
+	[SKL_DPCM_AUDIO_REF_CP] = {
 		.name = "Skl Audio Reference cap",
 		.stream_name = "Wake on Voice",
 		.cpu_dai_name = "Reference Pin",
@@ -405,7 +444,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.dynamic = 1,
 		.ops = &skylaye_refcap_ops,
 	},
-	{
+	[SKL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Skl Audio DMIC cap",
 		.stream_name = "dmiccap",
 		.cpu_dai_name = "DMIC Pin",
@@ -418,15 +457,45 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.dynamic = 1,
 		.ops = &skylake_dmic_ops,
 	},
-	{
-		.name = "Skl HDMI Port",
-		.stream_name = "Hdmi",
-		.cpu_dai_name = "HDMI Pin",
+	[SKL_DPCM_AUDIO_HDMI1_PB] = {
+		.name = "Skl HDMI Port1",
+		.stream_name = "Hdmi1",
+		.cpu_dai_name = "HDMI1 Pin",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.platform_name = "0000:00:1f.3",
 		.dpcm_playback = 1,
 		.init = NULL,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
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
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
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
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+		.init = NULL,
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
@@ -452,7 +521,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	{
 		/* SSP1 - Codec */
 		.name = "SSP1-Codec",
-		.be_id = 0,
+		.be_id = 1,
 		.cpu_dai_name = "SSP1 Pin",
 		.platform_name = "0000:00:1f.3",
 		.no_pcm = 1,
@@ -469,7 +538,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "dmic01",
-		.be_id = 1,
+		.be_id = 2,
 		.cpu_dai_name = "DMIC01 Pin",
 		.codec_name = "dmic-codec",
 		.codec_dai_name = "dmic-hifi",
@@ -480,13 +549,36 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.no_pcm = 1,
 	},
 	{
-		.name = "iDisp",
+		.name = "iDisp1",
 		.be_id = 3,
-		.cpu_dai_name = "iDisp Pin",
+		.cpu_dai_name = "iDisp1 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi1",
 		.platform_name = "0000:00:1f.3",
 		.dpcm_playback = 1,
+		.init = skylake_hdmi1_init,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp2",
+		.be_id = 4,
+		.cpu_dai_name = "iDisp2 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi2",
+		.platform_name = "0000:00:1f.3",
+		.init = skylake_hdmi2_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp3",
+		.be_id = 5,
+		.cpu_dai_name = "iDisp3 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi3",
+		.platform_name = "0000:00:1f.3",
+		.init = skylake_hdmi3_init,
+		.dpcm_playback = 1,
 		.no_pcm = 1,
 	},
 };
-- 
2.7.0
