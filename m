From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: skl_nau88l25_ssm4567: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:00 +0100 (BST)
Message-ID: <20190606212600.3E4D0440046@finisterre.sirena.org.uk>
References: <87v9xje4sa.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A9A8F89710
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:01 +0200 (CEST)
In-Reply-To: <87v9xje4sa.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: skl_nau88l25_ssm4567: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 502a522b7b8b98bd453ef948dbe47eddc787826c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:21:36 +0900
Subject: [PATCH] ASoC: Intel: skl_nau88l25_ssm4567: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 132 +++++++++---------
 1 file changed, 69 insertions(+), 63 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 8433c521d39f..36ab838c77f1 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -164,17 +164,6 @@ static struct snd_soc_codec_conf ssm4567_codec_conf[] = {
 	},
 };
 
-static struct snd_soc_dai_link_component ssm4567_codec_components[] = {
-	{ /* Left */
-		.name = "i2c-INT343B:00",
-		.dai_name = SKL_SSM_CODEC_DAI,
-	},
-	{ /* Right */
-		.name = "i2c-INT343B:01",
-		.dai_name = SKL_SSM_CODEC_DAI,
-	},
-};
-
 static int skylake_ssm4567_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
@@ -453,105 +442,140 @@ static const struct snd_soc_ops skylake_refcap_ops = {
 	.startup = skylake_refcap_startup,
 };
 
+SND_SOC_DAILINK_DEF(dummy,
+	DAILINK_COMP_ARRAY(COMP_DUMMY()));
+
+SND_SOC_DAILINK_DEF(system,
+	DAILINK_COMP_ARRAY(COMP_CPU("System Pin")));
+
+SND_SOC_DAILINK_DEF(reference,
+	DAILINK_COMP_ARRAY(COMP_CPU("Reference Pin")));
+
+SND_SOC_DAILINK_DEF(dmic,
+	DAILINK_COMP_ARRAY(COMP_CPU("DMIC Pin")));
+
+SND_SOC_DAILINK_DEF(hdmi1,
+	DAILINK_COMP_ARRAY(COMP_CPU("HDMI1 Pin")));
+
+SND_SOC_DAILINK_DEF(hdmi2,
+	DAILINK_COMP_ARRAY(COMP_CPU("HDMI2 Pin")));
+
+SND_SOC_DAILINK_DEF(hdmi3,
+	DAILINK_COMP_ARRAY(COMP_CPU("HDMI3 Pin")));
+
+SND_SOC_DAILINK_DEF(ssp0_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("SSP0 Pin")));
+SND_SOC_DAILINK_DEF(ssp0_codec,
+	DAILINK_COMP_ARRAY(
+	/* Left */	COMP_CODEC("i2c-INT343B:00", SKL_SSM_CODEC_DAI),
+	/* Right */	COMP_CODEC("i2c-INT343B:01", SKL_SSM_CODEC_DAI)));
+
+SND_SOC_DAILINK_DEF(ssp1_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("SSP1 Pin")));
+SND_SOC_DAILINK_DEF(ssp1_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10508825:00", SKL_NUVOTON_CODEC_DAI)));
+
+SND_SOC_DAILINK_DEF(dmic01_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("DMIC01 Pin")));
+SND_SOC_DAILINK_DEF(dmic_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec", "dmic-hifi")));
+
+SND_SOC_DAILINK_DEF(idisp1_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("iDisp1 Pin")));
+SND_SOC_DAILINK_DEF(idisp1_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("ehdaudio0D2", "intel-hdmi-hifi1")));
+
+SND_SOC_DAILINK_DEF(idisp2_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("iDisp2 Pin")));
+SND_SOC_DAILINK_DEF(idisp2_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("ehdaudio0D2", "intel-hdmi-hifi2")));
+
+SND_SOC_DAILINK_DEF(idisp3_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("iDisp3 Pin")));
+SND_SOC_DAILINK_DEF(idisp3_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("ehdaudio0D2", "intel-hdmi-hifi3")));
+
+SND_SOC_DAILINK_DEF(platform,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("0000:00:1f.3")));
+
 /* skylake digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link skylake_dais[] = {
 	/* Front End DAI links */
 	[SKL_DPCM_AUDIO_PB] = {
 		.name = "Skl Audio Port",
 		.stream_name = "Audio",
-		.cpu_dai_name = "System Pin",
-		.platform_name = "0000:00:1f.3",
 		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.nonatomic = 1,
 		.init = skylake_nau8825_fe_init,
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
 		.ops = &skylake_nau8825_fe_ops,
+		SND_SOC_DAILINK_REG(system, dummy, platform),
 	},
 	[SKL_DPCM_AUDIO_CP] = {
 		.name = "Skl Audio Capture Port",
 		.stream_name = "Audio Record",
-		.cpu_dai_name = "System Pin",
-		.platform_name = "0000:00:1f.3",
 		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.nonatomic = 1,
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_capture = 1,
 		.ops = &skylake_nau8825_fe_ops,
+		SND_SOC_DAILINK_REG(system, dummy, platform),
 	},
 	[SKL_DPCM_AUDIO_REF_CP] = {
 		.name = "Skl Audio Reference cap",
 		.stream_name = "Wake on Voice",
-		.cpu_dai_name = "Reference Pin",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.platform_name = "0000:00:1f.3",
 		.init = NULL,
 		.dpcm_capture = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
 		.ops = &skylake_refcap_ops,
+		SND_SOC_DAILINK_REG(reference, dummy, platform),
 	},
 	[SKL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Skl Audio DMIC cap",
 		.stream_name = "dmiccap",
-		.cpu_dai_name = "DMIC Pin",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.platform_name = "0000:00:1f.3",
 		.init = NULL,
 		.dpcm_capture = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
 		.ops = &skylake_dmic_ops,
+		SND_SOC_DAILINK_REG(dmic, dummy, platform),
 	},
 	[SKL_DPCM_AUDIO_HDMI1_PB] = {
 		.name = "Skl HDMI Port1",
 		.stream_name = "Hdmi1",
-		.cpu_dai_name = "HDMI1 Pin",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.platform_name = "0000:00:1f.3",
 		.dpcm_playback = 1,
 		.init = NULL,
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.nonatomic = 1,
 		.dynamic = 1,
+		SND_SOC_DAILINK_REG(hdmi1, dummy, platform),
 	},
 	[SKL_DPCM_AUDIO_HDMI2_PB] = {
 		.name = "Skl HDMI Port2",
 		.stream_name = "Hdmi2",
-		.cpu_dai_name = "HDMI2 Pin",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.platform_name = "0000:00:1f.3",
 		.dpcm_playback = 1,
 		.init = NULL,
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.nonatomic = 1,
 		.dynamic = 1,
+		SND_SOC_DAILINK_REG(hdmi2, dummy, platform),
 	},
 	[SKL_DPCM_AUDIO_HDMI3_PB] = {
 		.name = "Skl HDMI Port3",
 		.stream_name = "Hdmi3",
-		.cpu_dai_name = "HDMI3 Pin",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.platform_name = "0000:00:1f.3",
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
 		.init = NULL,
 		.nonatomic = 1,
 		.dynamic = 1,
+		SND_SOC_DAILINK_REG(hdmi3, dummy, platform),
 	},
 
 	/* Back End DAI links */
@@ -559,11 +583,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		/* SSP0 - Codec */
 		.name = "SSP0-Codec",
 		.id = 0,
-		.cpu_dai_name = "SSP0 Pin",
-		.platform_name = "0000:00:1f.3",
 		.no_pcm = 1,
-		.codecs = ssm4567_codec_components,
-		.num_codecs = ARRAY_SIZE(ssm4567_codec_components),
 		.dai_fmt = SND_SOC_DAIFMT_DSP_A |
 			SND_SOC_DAIFMT_IB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
@@ -572,16 +592,13 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.be_hw_params_fixup = skylake_ssp_fixup,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(ssp0_pin, ssp0_codec, platform),
 	},
 	{
 		/* SSP1 - Codec */
 		.name = "SSP1-Codec",
 		.id = 1,
-		.cpu_dai_name = "SSP1 Pin",
-		.platform_name = "0000:00:1f.3",
 		.no_pcm = 1,
-		.codec_name = "i2c-10508825:00",
-		.codec_dai_name = SKL_NUVOTON_CODEC_DAI,
 		.init = skylake_nau8825_codec_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
@@ -590,51 +607,40 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.ops = &skylake_nau8825_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(ssp1_pin, ssp1_codec, platform),
 	},
 	{
 		.name = "dmic01",
 		.id = 2,
-		.cpu_dai_name = "DMIC01 Pin",
-		.codec_name = "dmic-codec",
-		.codec_dai_name = "dmic-hifi",
-		.platform_name = "0000:00:1f.3",
 		.ignore_suspend = 1,
 		.be_hw_params_fixup = skylake_dmic_fixup,
 		.dpcm_capture = 1,
 		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(dmic01_pin, dmic_codec, platform),
 	},
 	{
 		.name = "iDisp1",
 		.id = 3,
-		.cpu_dai_name = "iDisp1 Pin",
-		.codec_name = "ehdaudio0D2",
-		.codec_dai_name = "intel-hdmi-hifi1",
-		.platform_name = "0000:00:1f.3",
 		.dpcm_playback = 1,
 		.init = skylake_hdmi1_init,
 		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(idisp1_pin, idisp1_codec, platform),
 	},
 	{
 		.name = "iDisp2",
 		.id = 4,
-		.cpu_dai_name = "iDisp2 Pin",
-		.codec_name = "ehdaudio0D2",
-		.codec_dai_name = "intel-hdmi-hifi2",
-		.platform_name = "0000:00:1f.3",
 		.init = skylake_hdmi2_init,
 		.dpcm_playback = 1,
 		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(idisp2_pin, idisp2_codec, platform),
 	},
 	{
 		.name = "iDisp3",
 		.id = 5,
-		.cpu_dai_name = "iDisp3 Pin",
-		.codec_name = "ehdaudio0D2",
-		.codec_dai_name = "intel-hdmi-hifi3",
-		.platform_name = "0000:00:1f.3",
 		.init = skylake_hdmi3_init,
 		.dpcm_playback = 1,
 		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(idisp3_pin, idisp3_codec, platform),
 	},
 };
 
-- 
2.20.1
