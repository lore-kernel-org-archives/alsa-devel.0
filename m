From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: broadwell: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:11 +0100 (BST)
Message-ID: <20190606212611.C0560440049@finisterre.sirena.org.uk>
References: <87o93bfjfy.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88B67F8974C
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:12 +0200 (CEST)
In-Reply-To: <87o93bfjfy.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: broadwell: use modern dai_link style

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

>From 4c3db473f77ddb8a632c4b66a35ae1855de3a1b7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:19:40 +0900
Subject: [PATCH] ASoC: Intel: broadwell: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/broadwell.c | 46 +++++++++++++++++-------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 0f18f8964f51..fd8d88550d0b 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -152,67 +152,72 @@ static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 }
 #endif
 
+SND_SOC_DAILINK_DEF(system,
+	DAILINK_COMP_ARRAY(COMP_CPU("System Pin")));
+
+SND_SOC_DAILINK_DEF(offload0,
+	DAILINK_COMP_ARRAY(COMP_CPU("Offload0 Pin")));
+
+SND_SOC_DAILINK_DEF(offload1,
+	DAILINK_COMP_ARRAY(COMP_CPU("Offload1 Pin")));
+
+SND_SOC_DAILINK_DEF(loopback,
+	DAILINK_COMP_ARRAY(COMP_CPU("Loopback Pin")));
+
+SND_SOC_DAILINK_DEF(dummy,
+	DAILINK_COMP_ARRAY(COMP_DUMMY()));
+
+SND_SOC_DAILINK_DEF(platform,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("haswell-pcm-audio")));
+
+SND_SOC_DAILINK_DEF(codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-INT343A:00", "rt286-aif1")));
+
 /* broadwell digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 	/* Front End DAI links */
 	{
 		.name = "System PCM",
 		.stream_name = "System Playback/Capture",
-		.cpu_dai_name = "System Pin",
-		.platform_name = "haswell-pcm-audio",
 		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 #if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 		.init = broadwell_rtd_init,
 #endif
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(system, dummy, platform),
 	},
 	{
 		.name = "Offload0",
 		.stream_name = "Offload0 Playback",
-		.cpu_dai_name = "Offload0 Pin",
-		.platform_name = "haswell-pcm-audio",
 		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(offload0, dummy, platform),
 	},
 	{
 		.name = "Offload1",
 		.stream_name = "Offload1 Playback",
-		.cpu_dai_name = "Offload1 Pin",
-		.platform_name = "haswell-pcm-audio",
 		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(offload1, dummy, platform),
 	},
 	{
 		.name = "Loopback PCM",
 		.stream_name = "Loopback",
-		.cpu_dai_name = "Loopback Pin",
-		.platform_name = "haswell-pcm-audio",
 		.dynamic = 1,
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(loopback, dummy, platform),
 	},
 	/* Back End DAI links */
 	{
 		/* SSP0 - Codec */
 		.name = "Codec",
 		.id = 0,
-		.cpu_dai_name = "snd-soc-dummy-dai",
-		.platform_name = "snd-soc-dummy",
 		.no_pcm = 1,
-		.codec_name = "i2c-INT343A:00",
-		.codec_dai_name = "rt286-aif1",
 		.init = broadwell_rt286_codec_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
@@ -222,6 +227,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.ops = &broadwell_rt286_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(dummy, codec, dummy),
 	},
 };
 
-- 
2.20.1
