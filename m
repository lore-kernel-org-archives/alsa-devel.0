From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl_da7219_max98927: remove
	headset" to the asoc tree
Date: Mon,  8 Apr 2019 14:23:59 +0700 (+07)
Message-ID: <20190408072359.64299441D3C@finisterre.ee.mobilebroadband>
References: <1553620856-21428-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F716F896DD
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 09:24:16 +0200 (CEST)
In-Reply-To: <1553620856-21428-1-git-send-email-jenny.tc@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jenny TC <jenny.tc@intel.com>
Cc: alsa-devel@alsa-project.org, N Harshapriya <harshapriya.n@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mac Chiang <mac.chiang@intel.com>, Mark Brown <broonie@kernel.org>, Nujella Sathyanarayana <sathyanarayana.nujella@intel.com>, M R Sathya Prakash <sathya.prakash.m.r@intel.com>, M Naveen <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl_da7219_max98927: remove headset

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

>From 2390c9b473da217ee086e5382869ade82c217a30 Mon Sep 17 00:00:00 2001
From: Jenny TC <jenny.tc@intel.com>
Date: Tue, 26 Mar 2019 22:50:56 +0530
Subject: [PATCH] ASoC: Intel: kbl_da7219_max98927: remove headset

kbl_da7219_max98927 supports two configurations - One with da7219 &
max98927/373 and other one with max98927/373 alone. This patch
removes the headset dais from max98927/373 configuration. Since the
snd_soc_dapm_ignore_suspend for DMIC is called from da7219_codec_init,
the code is re-arranged to invoke snd_soc_dapm_ignore_suspend from
kabylake_dmic_init.

Signed-off-by: Jenny TC <jenny.tc@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98927.c | 52 +++++++++-----------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 2768a572d065..f72a7bf028d7 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -52,7 +52,6 @@ struct kbl_codec_private {
 
 enum {
 	KBL_DPCM_AUDIO_PB = 0,
-	KBL_DPCM_AUDIO_CP,
 	KBL_DPCM_AUDIO_ECHO_REF_CP,
 	KBL_DPCM_AUDIO_REF_CP,
 	KBL_DPCM_AUDIO_DMIC_CP,
@@ -60,6 +59,7 @@ enum {
 	KBL_DPCM_AUDIO_HDMI2_PB,
 	KBL_DPCM_AUDIO_HDMI3_PB,
 	KBL_DPCM_AUDIO_HS_PB,
+	KBL_DPCM_AUDIO_CP,
 };
 
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
@@ -311,6 +311,12 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	da7219_aad_jack_det(component, &ctx->kabylake_headset);
 
+	return 0;
+}
+
+static int kabylake_dmic_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
 	ret = snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
 	if (ret)
 		dev_err(rtd->dev, "SoC DMIC - Ignore suspend failed %d\n", ret);
@@ -581,20 +587,6 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &kabylake_da7219_fe_ops,
 	},
-	[KBL_DPCM_AUDIO_CP] = {
-		.name = "Kbl Audio Capture Port",
-		.stream_name = "Audio Record",
-		.cpu_dai_name = "System Pin",
-		.platform_name = "0000:00:1f.3",
-		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.nonatomic = 1,
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
-		.dpcm_capture = 1,
-		.ops = &kabylake_da7219_fe_ops,
-	},
 	[KBL_DPCM_AUDIO_ECHO_REF_CP] = {
 		.name = "Kbl Audio Echo Reference cap",
 		.stream_name = "Echoreference Capture",
@@ -690,6 +682,20 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.ops = &kabylake_da7219_fe_ops,
 
 	},
+	[KBL_DPCM_AUDIO_CP] = {
+		.name = "Kbl Audio Capture Port",
+		.stream_name = "Audio Record",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:1f.3",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.nonatomic = 1,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_capture = 1,
+		.ops = &kabylake_da7219_fe_ops,
+	},
 
 	/* Back End DAI links */
 	{
@@ -733,6 +739,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.cpu_dai_name = "DMIC01 Pin",
 		.codec_name = "dmic-codec",
 		.codec_dai_name = "dmic-hifi",
+		.init = kabylake_dmic_init,
 		.platform_name = "0000:00:1f.3",
 		.be_hw_params_fixup = kabylake_dmic_fixup,
 		.ignore_suspend = 1,
@@ -792,20 +799,6 @@ static struct snd_soc_dai_link kabylake_max98_927_373_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &kabylake_da7219_fe_ops,
 	},
-	[KBL_DPCM_AUDIO_CP] = {
-		.name = "Kbl Audio Capture Port",
-		.stream_name = "Audio Record",
-		.cpu_dai_name = "System Pin",
-		.platform_name = "0000:00:1f.3",
-		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.nonatomic = 1,
-		.trigger = {
-			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
-		.dpcm_capture = 1,
-		.ops = &kabylake_da7219_fe_ops,
-	},
 	[KBL_DPCM_AUDIO_ECHO_REF_CP] = {
 		.name = "Kbl Audio Echo Reference cap",
 		.stream_name = "Echoreference Capture",
@@ -911,6 +904,7 @@ static struct snd_soc_dai_link kabylake_max98_927_373_dais[] = {
 		.cpu_dai_name = "DMIC01 Pin",
 		.codec_name = "dmic-codec",
 		.codec_dai_name = "dmic-hifi",
+		.init = kabylake_dmic_init,
 		.platform_name = "0000:00:1f.3",
 		.be_hw_params_fixup = kabylake_dmic_fixup,
 		.ignore_suspend = 1,
-- 
2.20.1
