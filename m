From: Grace Kao <grace.kao@intel.com>
Subject: [PATCH] CHROMIUM: ASoC: Intel: boards: Use FS as
	nau8825 sysclk in nau88l25_max98357a machine
Date: Thu, 17 Nov 2016 14:35:15 +0800
Message-ID: <1479364515-29019-1-git-send-email-grace.kao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D70C266621
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 07:32:35 +0100 (CET)
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
Cc: Vinod.koul@intel.com, Grace Kao <grace.kao@intel.com>
List-Id: alsa-devel@alsa-project.org

256FS sysclk gives the best audio quality per nau8825 datasheet.

Loud headphone pop happens if there is no sysclk during nau8825
playback power up sequence. Currently Skylake does not output MCLK/FS
when the back-end DAI op hw_param is called, so we cannot switch to
MCLK/FS in hw_param. This patch reduces pop by leting nau8825 keep
using its internal VCO clock during widget power up sequence, until
SNDRV_PCM_TRIGGER_START when MCLK/FS is available.

This is a temporary fix before Intel ADSP can output MCLK/FS early.

BUG=chrome-os-partner:50471
TEST=`emerge-sentry sys-kernel/chromeos-kernel-3_18`. Verified a local
build that could reduce the pop sound.

Change-Id: I4943fffa8eb1c874cc66b50f0897092bf48dd579
Signed-off-by: Grace Kao <grace.kao@intel.com>
Reviewed-on: https://chromium-review.googlesource.com/333180
Reviewed-by: Ben Zhang <benzh@chromium.org>

Series-to: alsa-devel@alsa-project.org
Series-cc: Vinod.koul@intel.com
---

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 0f89602..6ad8f52 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -70,14 +70,7 @@
 		return -EIO;
 	}
 
-	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		ret = snd_soc_dai_set_sysclk(codec_dai,
-				NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
-		if (ret < 0) {
-			dev_err(card->dev, "set sysclk err = %d\n", ret);
-			return -EIO;
-		}
-	} else {
+	if (!SND_SOC_DAPM_EVENT_ON(event)) {
 		ret = snd_soc_dai_set_sysclk(codec_dai,
 				NAU8825_CLK_INTERNAL, 0, SND_SOC_CLOCK_IN);
 		if (ret < 0) {
@@ -272,25 +265,7 @@
 	.startup = skl_fe_startup,
 };
 
-static int skylake_nau8825_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
 
-	ret = snd_soc_dai_set_sysclk(codec_dai,
-			NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
-
-	if (ret < 0)
-		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
-
-	return ret;
-}
-
-static struct snd_soc_ops skylake_nau8825_ops = {
-	.hw_params = skylake_nau8825_hw_params,
-};
 
 static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 		struct snd_pcm_hw_params *params)
@@ -306,6 +281,33 @@
 	return 0;
 }
 
+static int skylake_nau8825_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		ret = snd_soc_dai_set_sysclk(codec_dai,	NAU8825_CLK_FLL_FS, 0,
+			SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
+		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
+			runtime->rate * 256);
+		if (ret < 0)
+			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
+		break;
+	}
+
+	return ret;
+}
+
+static struct snd_soc_ops skylake_nau8825_ops = {
+	.trigger = skylake_nau8825_trigger,
+};
+
 static unsigned int channels_dmic[] = {
 	2, 4,
 };
