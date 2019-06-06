From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_nau8824: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:03 +0100 (BST)
Message-ID: <20190606212603.BA6BA440046@finisterre.sirena.org.uk>
References: <874l53fjdj.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 842ADF89732
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:04 +0200 (CEST)
In-Reply-To: <874l53fjdj.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: Intel: cht_bsw_nau8824: use modern dai_link style

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

>From 5ae4641f5a2b2d83adfb51988961ab76f94fd51e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:21:07 +0900
Subject: [PATCH] ASoC: Intel: cht_bsw_nau8824: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_nau8824.c | 41 +++++++++++++++---------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 02c2fa239331..5165e5d13a8a 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -175,51 +175,59 @@ static const struct snd_soc_ops cht_be_ssp2_ops = {
 	.hw_params = cht_aif1_hw_params,
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
+SND_SOC_DAILINK_DEF(compress,
+	DAILINK_COMP_ARRAY(COMP_CPU("compress-cpu-dai")));
+
+SND_SOC_DAILINK_DEF(ssp2_port,
+	DAILINK_COMP_ARRAY(COMP_CPU("ssp2-port")));
+SND_SOC_DAILINK_DEF(ssp2_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10508824:00",
+				      NAU8824_CODEC_DAI)));
+
+SND_SOC_DAILINK_DEF(platform,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("sst-mfld-platform")));
+
 static struct snd_soc_dai_link cht_dailink[] = {
 	/* Front End DAI links */
 	[MERR_DPCM_AUDIO] = {
 		.name = "Audio Port",
 		.stream_name = "Audio",
-		.cpu_dai_name = "media-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
 		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ops = &cht_aif1_ops,
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
 		.ops = &cht_aif1_ops,
+		SND_SOC_DAILINK_REG(deepbuffer, dummy, platform),
 	},
 	[MERR_DPCM_COMPR] = {
 		.name = "Compressed Port",
 		.stream_name = "Compress",
-		.cpu_dai_name = "compress-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
+		SND_SOC_DAILINK_REG(compress, dummy, platform),
 	},
 	/* Back End DAI links */
 	{
 		/* SSP2 - Codec */
 		.name = "SSP2-Codec",
 		.id = 1,
-		.cpu_dai_name = "ssp2-port",
-		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
-		.codec_dai_name = NAU8824_CODEC_DAI,
-		.codec_name = "i2c-10508824:00",
 		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
 			| SND_SOC_DAIFMT_CBS_CFS,
 		.init = cht_codec_init,
@@ -227,6 +235,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ops = &cht_be_ssp2_ops,
+		SND_SOC_DAILINK_REG(ssp2_port, ssp2_codec, platform),
 	},
 };
 
-- 
2.20.1
