From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update ignore suspend
	for rt286 machine" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:19 +0000
Message-ID: <E1a6NfT-00040G-DH@debutante>
References: <1449165601-11226-13-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C14C9260676
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:26 +0100 (CET)
In-Reply-To: <1449165601-11226-13-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Praveen Diwakar <praveen.diwakar@intel.com>, Vunny Sodhi <vunnyx.sodhi@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Update ignore suspend for rt286 machine

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

>From 9ec2053b13f75d7ad9c0e6db9763954bd1a1b9ae Mon Sep 17 00:00:00 2001
From: Praveen Diwakar <praveen.diwakar@intel.com>
Date: Thu, 3 Dec 2015 23:30:01 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update ignore suspend for rt286 machine

We should only add ignore suspend flag for some DAIs and not all.
This patches removes it from the DAIs where we do not support
this

It also marks the endpoints for which ignore_suspend should be
enabled

Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
Signed-off-by: Vunny Sodhi <vunnyx.sodhi@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_rt286.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 51c4eb87e6ec..7396ddb427d8 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -89,6 +89,17 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 
 };
 
+static int skylake_rt286_fe_init(struct snd_soc_pcm_runtime *rtd)
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
 static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
@@ -104,6 +115,9 @@ static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	rt286_mic_detect(codec, &skylake_headset);
 
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "WoV Sink");
+
 	return 0;
 }
 
@@ -241,6 +255,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
+		.init = skylake_rt286_fe_init,
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST,
 			SND_SOC_DPCM_TRIGGER_POST
@@ -286,7 +301,6 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.platform_name = "0000:00:1f.3",
 		.init = NULL,
 		.dpcm_capture = 1,
-		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
 		.ops = &skylake_dmic_ops,
@@ -306,7 +320,6 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S |
 			SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
-		.ignore_suspend = 1,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = skylake_ssp0_fixup,
 		.ops = &skylake_rt286_ops,
-- 
2.6.2
