From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:06 +0100 (BST)
Message-ID: <20190606212606.19A69440049@finisterre.sirena.org.uk>
References: <87a7evfje6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 026E3F8973D
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:07 +0200 (CEST)
In-Reply-To: <87a7evfje6.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: Intel: bytcr_rt5640: use modern dai_link style

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

>From e7a712889b299ea4a28c58605baa827396ce973e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:20:44 +0900
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 44 +++++++++++++++++----------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 7aae7b78efba..bd747495ef3c 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1026,41 +1026,51 @@ static const struct snd_soc_ops byt_rt5640_be_ssp2_ops = {
 	.hw_params = byt_rt5640_aif1_hw_params,
 };
 
+SND_SOC_DAILINK_DEF(dummy,
+	DAILINK_COMP_ARRAY(COMP_DUMMY()));
+
+SND_SOC_DAILINK_DEF(media,
+	DAILINK_COMP_ARRAY(COMP_CPU("media-cpu-dai")));
+
+SND_SOC_DAILINK_DEF(deepbuffer,
+	DAILINK_COMP_ARRAY(COMP_CPU("deepbuffer-cpu-dai")));
+
+SND_SOC_DAILINK_DEF(ssp2_port,
+	/* overwritten for ssp0 routing */
+	DAILINK_COMP_ARRAY(COMP_CPU("ssp2-port")));
+SND_SOC_DAILINK_DEF(ssp2_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC(
+	/* overwritten with HID */ "i2c-10EC5640:00",
+	/* changed w/ quirk */	"rt5640-aif1")));
+
+SND_SOC_DAILINK_DEF(platform,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("sst-mfld-platform")));
+
 static struct snd_soc_dai_link byt_rt5640_dais[] = {
 	[MERR_DPCM_AUDIO] = {
 		.name = "Baytrail Audio Port",
 		.stream_name = "Baytrail Audio",
-		.cpu_dai_name = "media-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
 		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ops = &byt_rt5640_aif1_ops,
+		SND_SOC_DAILINK_REG(media, dummy, platform),
 	},
 	[MERR_DPCM_DEEP_BUFFER] = {
 		.name = "Deep-Buffer Audio Port",
 		.stream_name = "Deep-Buffer Audio",
-		.cpu_dai_name = "deepbuffer-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
 		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
 		.ops = &byt_rt5640_aif1_ops,
+		SND_SOC_DAILINK_REG(deepbuffer, dummy, platform),
 	},
 		/* back ends */
 	{
 		.name = "SSP2-Codec",
 		.id = 0,
-		.cpu_dai_name = "ssp2-port", /* overwritten for ssp0 routing */
-		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
-		.codec_dai_name = "rt5640-aif1", /* changed w/ quirk */
-		.codec_name = "i2c-10EC5640:00", /* overwritten with HID */
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 						| SND_SOC_DAIFMT_CBS_CFS,
 		.be_hw_params_fixup = byt_rt5640_codec_fixup,
@@ -1070,6 +1080,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.dpcm_capture = 1,
 		.init = byt_rt5640_init,
 		.ops = &byt_rt5640_be_ssp2_ops,
+		SND_SOC_DAILINK_REG(ssp2_port, ssp2_codec, platform),
 	},
 };
 
@@ -1159,7 +1170,8 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
 	/* fix index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(byt_rt5640_dais); i++) {
-		if (!strcmp(byt_rt5640_dais[i].codec_name, "i2c-10EC5640:00")) {
+		if (!strcmp(byt_rt5640_dais[i].codecs->name,
+			    "i2c-10EC5640:00")) {
 			dai_index = i;
 			break;
 		}
@@ -1171,7 +1183,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
 		put_device(&adev->dev);
-		byt_rt5640_dais[dai_index].codec_name = byt_rt5640_codec_name;
+		byt_rt5640_dais[dai_index].codecs->name = byt_rt5640_codec_name;
 	}
 
 	/*
@@ -1263,7 +1275,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			sizeof(byt_rt5640_codec_aif_name),
 			"%s", "rt5640-aif2");
 
-		byt_rt5640_dais[dai_index].codec_dai_name =
+		byt_rt5640_dais[dai_index].codecs->dai_name =
 			byt_rt5640_codec_aif_name;
 	}
 
@@ -1275,7 +1287,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			sizeof(byt_rt5640_cpu_dai_name),
 			"%s", "ssp0-port");
 
-		byt_rt5640_dais[dai_index].cpu_dai_name =
+		byt_rt5640_dais[dai_index].cpus->dai_name =
 			byt_rt5640_cpu_dai_name;
 	}
 
-- 
2.20.1
