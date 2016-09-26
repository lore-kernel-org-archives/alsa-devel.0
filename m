From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add DMIC channel constraint for
	bxt machine" to the asoc tree
Date: Mon, 26 Sep 2016 14:06:03 -0700
Message-ID: <E1bod6B-0000mi-64@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87037265598
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 23:06:19 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add DMIC channel constraint for bxt machine

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

>From 43c02ede76a60de38504f4f4fd6042f677be093a Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Mon, 26 Sep 2016 13:02:29 -0700
Subject: [PATCH] ASoC: Intel: Add DMIC channel constraint for bxt machine

Add channel and rate constraints for Refcap and dmiccap devices
respectively.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 63 +++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3774b117d365..bb4533c305c7 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -37,6 +37,7 @@ enum {
 	BXT_DPCM_AUDIO_PB = 0,
 	BXT_DPCM_AUDIO_CP,
 	BXT_DPCM_AUDIO_REF_CP,
+	BXT_DPCM_AUDIO_DMIC_CP,
 	BXT_DPCM_AUDIO_HDMI1_PB,
 	BXT_DPCM_AUDIO_HDMI2_PB,
 	BXT_DPCM_AUDIO_HDMI3_PB,
@@ -252,6 +253,52 @@ static struct snd_soc_ops broxton_da7219_ops = {
 	.hw_free = broxton_da7219_hw_free,
 };
 
+static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	channels->min = channels->max = DUAL_CHANNEL;
+
+	return 0;
+}
+
+static int broxton_dmic_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+			&constraints_channels);
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+}
+
+static const struct snd_soc_ops broxton_dmic_ops = {
+	.startup = broxton_dmic_startup,
+};
+
+static const unsigned int rates_16000[] = {
+	16000,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_16000 = {
+	.count = ARRAY_SIZE(rates_16000),
+	.list  = rates_16000,
+};
+
+static int broxton_refcap_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_16000);
+};
+
+static struct snd_soc_ops broxton_refcap_ops = {
+	.startup = broxton_refcap_startup,
+};
+
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_dais[] = {
 	/* Front End DAI links */
@@ -299,6 +346,21 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
+		.ops = &broxton_refcap_ops,
+	},
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
 	},
 	[BXT_DPCM_AUDIO_HDMI1_PB]
 	{
@@ -382,6 +444,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.codec_dai_name = "dmic-hifi",
 		.platform_name = "0000:00:0e.0",
 		.ignore_suspend = 1,
+		.be_hw_params_fixup = broxton_dmic_fixup,
 		.dpcm_capture = 1,
 		.no_pcm = 1,
 	},
-- 
2.9.3
