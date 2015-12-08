From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add dai link for DMIC
	capture" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:23 +0000
Message-ID: <E1a6NfX-000428-39@debutante>
References: <1448703121-5831-15-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8809226058A
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:29 +0100 (CET)
In-Reply-To: <1448703121-5831-15-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Dharageswari.R" <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add dai link for DMIC capture

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

>From 4386b76753c49dfdb940c0e5eeef09b61feaf712 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 3 Dec 2015 23:29:57 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add dai link for DMIC capture

Since in Skylake we support another DAI for DMIC quad capture,
add a dailink for this as well. Also specify constrains for DMIC
FE devices and fixup for DMIC BEs

Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_rt286.c | 51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 57333a476136..e4fc8a1ce471 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -190,6 +190,42 @@ static struct snd_soc_ops skylake_rt286_ops = {
 	.hw_params = skylake_rt286_hw_params,
 };
 
+static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	channels->min = channels->max = 4;
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
+static int skylake_dmic_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = 4;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					   &constraints_dmic_channels);
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+}
+
+static struct snd_soc_ops skylake_dmic_ops = {
+	.startup = skylake_dmic_startup,
+};
+
 /* skylake digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link skylake_rt286_dais[] = {
 	/* Front End DAI links */
@@ -238,6 +274,20 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
+	{
+		.name = "Skl Audio DMIC cap",
+		.stream_name = "dmiccap",
+		.cpu_dai_name = "DMIC Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.init = NULL,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+		.ops = &skylake_dmic_ops,
+	},
 
 	/* Back End DAI links */
 	{
@@ -267,6 +317,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.codec_name = "dmic-codec",
 		.codec_dai_name = "dmic-hifi",
 		.platform_name = "0000:00:1f.3",
+		.be_hw_params_fixup = skylake_dmic_fixup,
 		.ignore_suspend = 1,
 		.dpcm_capture = 1,
 		.no_pcm = 1,
-- 
2.6.2
