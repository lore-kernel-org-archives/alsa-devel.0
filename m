From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add DMIC 4 channel support for
	bxt machine" to the asoc tree
Date: Tue, 14 Jun 2016 16:09:15 +0100
Message-ID: <E1bCpxr-0001Wz-Sn@finisterre>
References: <1465820944-14774-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 162EA2667E2
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 17:09:25 +0200 (CEST)
In-Reply-To: <1465820944-14774-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add DMIC 4 channel support for bxt machine

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

>From bfcdc6d19008c0f11cba30c2cff1b63ec4e7a744 Mon Sep 17 00:00:00 2001
From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Date: Mon, 13 Jun 2016 17:58:58 +0530
Subject: [PATCH] ASoC: Intel: Add DMIC 4 channel support for bxt machine

Like Skylake, we can support  4 channel for DMIC, so add
hw_params and constraints in the bxt-rt298 machine

While at it, also add codec1 pipe for speaker playback.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index f4787515c0ed..9b649b6cc757 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -33,6 +33,7 @@ enum {
 	BXT_DPCM_AUDIO_PB = 0,
 	BXT_DPCM_AUDIO_CP,
 	BXT_DPCM_AUDIO_REF_CP,
+	BXT_DPCM_AUDIO_DMIC_CP,
 	BXT_DPCM_AUDIO_HDMI1_PB,
 	BXT_DPCM_AUDIO_HDMI2_PB,
 	BXT_DPCM_AUDIO_HDMI3_PB,
@@ -88,6 +89,7 @@ static const struct snd_soc_dapm_route broxton_rt298_map[] = {
 	/* CODEC BE connections */
 	{ "AIF1 Playback", NULL, "ssp5 Tx"},
 	{ "ssp5 Tx", NULL, "codec0_out"},
+	{ "ssp5 Tx", NULL, "codec1_out"},
 
 	{ "codec0_in", NULL, "ssp5 Rx" },
 	{ "ssp5 Rx", NULL, "AIF1 Capture" },
@@ -169,6 +171,55 @@ static struct snd_soc_ops broxton_rt298_ops = {
 	.hw_params = broxton_rt298_hw_params,
 };
 
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
+static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
+				struct snd_pcm_hw_params *params)
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
+static int broxton_dmic_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = 4;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					&constraints_dmic_channels);
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+}
+
+static struct snd_soc_ops broxton_dmic_ops = {
+	.startup = broxton_dmic_startup,
+};
+
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_rt298_dais[] = {
 	/* Front End DAI links */
@@ -211,6 +262,20 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
+	[BXT_DPCM_AUDIO_DMIC_CP]
+	{
+		.name = "Bxt Audio DMIC cap",
+		.stream_name = "dmiccap",
+		.cpu_dai_name = "DMIC Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:0e.0",
+		.init = NULL,
+		.dpcm_capture = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+		.ops = &broxton_dmic_ops,
+	},
 	[BXT_DPCM_AUDIO_HDMI1_PB]
 	{
 		.name = "Bxt HDMI Port1",
@@ -276,6 +341,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.codec_name = "dmic-codec",
 		.codec_dai_name = "dmic-hifi",
 		.platform_name = "0000:00:0e.0",
+		.be_hw_params_fixup = broxton_dmic_fixup,
 		.ignore_suspend = 1,
 		.dpcm_capture = 1,
 		.no_pcm = 1,
-- 
2.8.1
