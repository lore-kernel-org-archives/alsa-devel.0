From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_cx2072x: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:07 +0100 (BST)
Message-ID: <20190606212607.37A6E440049@finisterre.sirena.org.uk>
References: <87d0jrfjeg.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1A4DF8973F
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:07 +0200 (CEST)
In-Reply-To: <87d0jrfjeg.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: Intel: bytcht_cx2072x: use modern dai_link style

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

>From 196c52e13eb5ce1c53d6c3a38227b5ca3032d496 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:20:34 +0900
Subject: [PATCH] ASoC: Intel: bytcht_cx2072x: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_cx2072x.c | 37 +++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index 4b985b393dae..54ac2fd41925 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -150,41 +150,49 @@ static struct snd_soc_ops byt_cht_cx2072x_aif1_ops = {
 	.startup = byt_cht_cx2072x_aif1_startup,
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
+SND_SOC_DAILINK_DEF(ssp2,
+	DAILINK_COMP_ARRAY(COMP_CPU("ssp2-port")));
+
+SND_SOC_DAILINK_DEF(cx2072x,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-14F10720:00", "cx2072x-hifi")));
+
+SND_SOC_DAILINK_DEF(platform,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("sst-mfld-platform")));
+
 static struct snd_soc_dai_link byt_cht_cx2072x_dais[] = {
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
 		.ops = &byt_cht_cx2072x_aif1_ops,
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
 		.ops = &byt_cht_cx2072x_aif1_ops,
+		SND_SOC_DAILINK_REG(deepbuffer, dummy, platform),
 	},
 	/* back ends */
 	{
 		.name = "SSP2-Codec",
 		.id = 0,
-		.cpu_dai_name = "ssp2-port",
-		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
-		.codec_dai_name = "cx2072x-hifi",
-		.codec_name = "i2c-14F10720:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 					      | SND_SOC_DAIFMT_CBS_CFS,
 		.init = byt_cht_cx2072x_init,
@@ -192,6 +200,7 @@ static struct snd_soc_dai_link byt_cht_cx2072x_dais[] = {
 		.nonatomic = true,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(ssp2, cx2072x, platform),
 	},
 };
 
@@ -223,7 +232,7 @@ static int snd_byt_cht_cx2072x_probe(struct platform_device *pdev)
 
 	/* fix index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(byt_cht_cx2072x_dais); i++) {
-		if (!strcmp(byt_cht_cx2072x_dais[i].codec_name,
+		if (!strcmp(byt_cht_cx2072x_dais[i].codecs->name,
 			    "i2c-14F10720:00")) {
 			dai_index = i;
 			break;
@@ -236,7 +245,7 @@ static int snd_byt_cht_cx2072x_probe(struct platform_device *pdev)
 		snprintf(codec_name, sizeof(codec_name), "i2c-%s",
 			 acpi_dev_name(adev));
 		put_device(&adev->dev);
-		byt_cht_cx2072x_dais[dai_index].codec_name = codec_name;
+		byt_cht_cx2072x_dais[dai_index].codecs->name = codec_name;
 	}
 
 	/* override plaform name, if required */
-- 
2.20.1
