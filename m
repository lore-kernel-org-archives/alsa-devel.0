From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add FE rate & channel
	constraints for bxt-rt298" to the asoc tree
Date: Tue, 14 Jun 2016 16:09:12 +0100
Message-ID: <E1bCpxo-0001Vt-MM@finisterre>
References: <1465820944-14774-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D16A2667C2
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 17:09:22 +0200 (CEST)
In-Reply-To: <1465820944-14774-3-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Add FE rate & channel constraints for bxt-rt298

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

>From 4cdf33feb2c67ef1ff45bc5160b261b8c1fd2428 Mon Sep 17 00:00:00 2001
From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Date: Mon, 13 Jun 2016 17:58:59 +0530
Subject: [PATCH] ASoC: Intel: Add FE rate & channel constraints for bxt-rt298

We support stereo 48Khz audio, so add these as constraints
for this card

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 9b649b6cc757..10eb5cbf57e4 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -220,6 +220,40 @@ static struct snd_soc_ops broxton_dmic_ops = {
 	.startup = broxton_dmic_startup,
 };
 
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
+static int bxt_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * on this platform for PCM device we support:
+	 *      48Khz
+	 *      stereo
+	 */
+
+	runtime->hw.channels_max = 2;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				&constraints_channels);
+
+	snd_pcm_hw_constraint_list(runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+
+	return 0;
+}
+
+static const struct snd_soc_ops broxton_rt286_fe_ops = {
+	.startup = bxt_fe_startup,
+};
+
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_rt298_dais[] = {
 	/* Front End DAI links */
@@ -235,6 +269,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
+		.ops = &broxton_rt286_fe_ops,
 	},
 	[BXT_DPCM_AUDIO_CP]
 	{
@@ -248,6 +283,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_capture = 1,
+		.ops = &broxton_rt286_fe_ops,
 	},
 	[BXT_DPCM_AUDIO_REF_CP]
 	{
-- 
2.8.1
