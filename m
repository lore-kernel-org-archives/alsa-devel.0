From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: Intel: boards: update constraints for
	nau88l25_ssm4567 machine" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:32 +0000
Message-ID: <E1a9twa-00068M-SR@debutante>
References: <1449862153-68738-6-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 014FA26663F
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:38 +0100 (CET)
In-Reply-To: <1449862153-68738-6-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Fang Yang A <yang.a.fang@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Yong Zhi <yong.zhi@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: Intel: boards: update constraints for nau88l25_ssm4567 machine

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

>From 2616e27efb21f82e666312cbbab53e6600225ef1 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Fri, 11 Dec 2015 11:29:11 -0800
Subject: [PATCH] ASoc: Intel: boards: update constraints for nau88l25_ssm4567
 machine

We have specific constraints for FE device (48KHz, stereo, 16
bits) and fixups for BE DMIC links (2 or 4 ch), so add those.

Also add one more FE DAIlink for dmiccap

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 136 ++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 8aa821c6b106..1b54613132c1 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -192,6 +192,65 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
+static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dapm_context *dapm;
+	struct snd_soc_component *component = rtd->cpu_dai->component;
+
+	dapm = snd_soc_component_get_dapm(component);
+	snd_soc_dapm_ignore_suspend(dapm, "Reference Capture");
+
+	return 0;
+}
+
+static unsigned int rates[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list  = rates,
+	.mask = 0,
+};
+
+static unsigned int channels[] = {
+	2,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int skl_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * on this platform for PCM device we support,
+	 *	48Khz
+	 *	stereo
+	 *	16 bit audio
+	 */
+
+	runtime->hw.channels_max = 2;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					   &constraints_channels);
+
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
+
+	snd_pcm_hw_constraint_list(runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+
+	return 0;
+}
+
+static const struct snd_soc_ops skylake_nau8825_fe_ops = {
+	.startup = skl_fe_startup,
+};
+
 static int skylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
@@ -211,6 +270,19 @@ static int skylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	if (params_channels(params) == 2)
+		channels->min = channels->max = 2;
+	else
+		channels->min = channels->max = 4;
+
+	return 0;
+}
+
 static int skylake_nau8825_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -231,6 +303,52 @@ static struct snd_soc_ops skylake_nau8825_ops = {
 	.hw_params = skylake_nau8825_hw_params,
 };
 
+static unsigned int channels_dmic[] = {
+	2, 4,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
+	.count = ARRAY_SIZE(channels_dmic),
+	.list = channels_dmic,
+	.mask = 0,
+};
+
+static int skylake_dmic_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = 4;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+			&constraints_dmic_channels);
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+}
+
+static struct snd_soc_ops skylake_dmic_ops = {
+	.startup = skylake_dmic_startup,
+};
+
+static unsigned int rates_16000[] = {
+	16000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_16000 = {
+	.count = ARRAY_SIZE(rates_16000),
+	.list  = rates_16000,
+};
+
+static int skylake_refcap_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_16000);
+}
+
+static struct snd_soc_ops skylaye_refcap_ops = {
+	.startup = skylake_refcap_startup,
+};
+
 /* skylake digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link skylake_dais[] = {
 	/* Front End DAI links */
@@ -243,9 +361,11 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.nonatomic = 1,
+		.init = skylake_nau8825_fe_init,
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
+		.ops = &skylake_nau8825_fe_ops,
 	},
 	{
 		.name = "Skl Audio Capture Port",
@@ -259,6 +379,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_capture = 1,
+		.ops = &skylake_nau8825_fe_ops,
 	},
 	{
 		.name = "Skl Audio Reference cap",
@@ -272,6 +393,20 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
+		.ops = &skylaye_refcap_ops,
+	},
+	{
+		.name = "Skl Audio DMIC cap",
+		.stream_name = "dmiccap",
+		.cpu_dai_name = "DMIC Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.init = NULL,
+		.dpcm_capture = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+		.ops = &skylake_dmic_ops,
 	},
 	/* Back End DAI links */
 	{
@@ -317,6 +452,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.codec_dai_name = "dmic-hifi",
 		.platform_name = "0000:00:1f.3",
 		.ignore_suspend = 1,
+		.be_hw_params_fixup = skylake_dmic_fixup,
 		.dpcm_capture = 1,
 		.no_pcm = 1,
 	},
-- 
2.6.2
