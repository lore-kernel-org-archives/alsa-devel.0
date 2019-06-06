From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: acp-da7219-max98357a: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:43 +0100 (BST)
Message-ID: <20190606212643.691C7440046@finisterre.sirena.org.uk>
References: <87y32ficv5.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24653F89731
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:44 +0200 (CEST)
In-Reply-To: <87y32ficv5.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: amd: acp-da7219-max98357a: use modern dai_link style

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

>From 48696d0a6d8e5bd2c9e03b70e93f9cf0db31705f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:13:29 +0900
Subject: [PATCH] ASoC: amd: acp-da7219-max98357a: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 42 +++++++++++++++-------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 16b0ea3a3d72..f4ee6798154a 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -298,69 +298,71 @@ static const struct snd_soc_ops cz_dmic1_cap_ops = {
 	.hw_params = cz_da7219_params,
 };
 
+SND_SOC_DAILINK_DEF(designware1,
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.1.auto")));
+SND_SOC_DAILINK_DEF(designware2,
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2.auto")));
+SND_SOC_DAILINK_DEF(designware3,
+	DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.3.auto")));
+
+SND_SOC_DAILINK_DEF(dlgs,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-DLGS7219:00", "da7219-hifi")));
+SND_SOC_DAILINK_DEF(mx,
+	DAILINK_COMP_ARRAY(COMP_CODEC("MX98357A:00", "HiFi")));
+SND_SOC_DAILINK_DEF(adau,
+	DAILINK_COMP_ARRAY(COMP_CODEC("ADAU7002:00", "adau7002-hifi")));
+
+SND_SOC_DAILINK_DEF(platform,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.0.auto")));
+
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
 		.name = "amd-da7219-play",
 		.stream_name = "Playback",
-		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.1.auto",
-		.codec_dai_name = "da7219-hifi",
-		.codec_name = "i2c-DLGS7219:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_da7219_init,
 		.dpcm_playback = 1,
 		.ops = &cz_da7219_play_ops,
+		SND_SOC_DAILINK_REG(designware1, dlgs, platform),
 	},
 	{
 		.name = "amd-da7219-cap",
 		.stream_name = "Capture",
-		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.2.auto",
-		.codec_dai_name = "da7219-hifi",
-		.codec_name = "i2c-DLGS7219:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
 		.ops = &cz_da7219_cap_ops,
+		SND_SOC_DAILINK_REG(designware2, dlgs, platform),
 	},
 	{
 		.name = "amd-max98357-play",
 		.stream_name = "HiFi Playback",
-		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.3.auto",
-		.codec_dai_name = "HiFi",
-		.codec_name = "MX98357A:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_playback = 1,
 		.ops = &cz_max_play_ops,
+		SND_SOC_DAILINK_REG(designware3, mx, platform),
 	},
 	{
 		/* C panel DMIC */
 		.name = "dmic0",
 		.stream_name = "DMIC0 Capture",
-		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.3.auto",
-		.codec_dai_name = "adau7002-hifi",
-		.codec_name = "ADAU7002:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
 		.ops = &cz_dmic0_cap_ops,
+		SND_SOC_DAILINK_REG(designware3, adau, platform),
 	},
 	{
 		/* A/B panel DMIC */
 		.name = "dmic1",
 		.stream_name = "DMIC1 Capture",
-		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.2.auto",
-		.codec_dai_name = "adau7002-hifi",
-		.codec_name = "ADAU7002:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
 		.ops = &cz_dmic1_cap_ops,
+		SND_SOC_DAILINK_REG(designware2, adau, platform),
 	},
 };
 
-- 
2.20.1
