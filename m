From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: rk3399_gru_sound: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:24 +0100 (BST)
Message-ID: <20190606212624.67D2C440049@finisterre.sirena.org.uk>
References: <87lfyfgy4k.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36BD7F89778
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:25 +0200 (CEST)
In-Reply-To: <87lfyfgy4k.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: rockchip: rk3399_gru_sound: use modern dai_link style

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

>From 96a239b7af0f4d502f7a577bd0df9acb715a9ca6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:17:10 +0900
Subject: [PATCH] ASoC: rockchip: rk3399_gru_sound: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 51 +++++++++++++++++++++------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index f2a51ae2b674..5e2700283fa8 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -276,56 +276,85 @@ enum {
 	DAILINK_RT5514_DSP,
 };
 
+SND_SOC_DAILINK_DEFS(cdndp,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "spdif-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(da7219,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "da7219-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(dmic,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "dmic-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(max98357a,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(rt5514,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5514-aif1")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(rt5514_dsp,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static const struct snd_soc_dai_link rockchip_dais[] = {
 	[DAILINK_CDNDP] = {
 		.name = "DP",
 		.stream_name = "DP PCM",
-		.codec_dai_name = "spdif-hifi",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(cdndp),
 	},
 	[DAILINK_DA7219] = {
 		.name = "DA7219",
 		.stream_name = "DA7219 PCM",
-		.codec_dai_name = "da7219-hifi",
 		.init = rockchip_sound_da7219_init,
 		.ops = &rockchip_sound_da7219_ops,
 		/* set da7219 as slave */
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(da7219),
 	},
 	[DAILINK_DMIC] = {
 		.name = "DMIC",
 		.stream_name = "DMIC PCM",
-		.codec_dai_name = "dmic-hifi",
 		.ops = &rockchip_sound_dmic_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(dmic),
 	},
 	[DAILINK_MAX98357A] = {
 		.name = "MAX98357A",
 		.stream_name = "MAX98357A PCM",
-		.codec_dai_name = "HiFi",
 		.ops = &rockchip_sound_max98357a_ops,
 		/* set max98357a as slave */
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(max98357a),
 	},
 	[DAILINK_RT5514] = {
 		.name = "RT5514",
 		.stream_name = "RT5514 PCM",
-		.codec_dai_name = "rt5514-aif1",
 		.ops = &rockchip_sound_rt5514_ops,
 		/* set rt5514 as slave */
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(rt5514),
 	},
 	/* RT5514 DSP for voice wakeup via spi bus */
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
 		.stream_name = "Wake on Voice",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
+		SND_SOC_DAILINK_REG(rt5514_dsp),
 	},
 };
 
@@ -507,10 +536,10 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 		dai = &card->dai_link[card->num_links++];
 		*dai = rockchip_dais[index];
 
-		if (!dai->codec_name)
-			dai->codec_of_node = np_codec;
-		dai->platform_of_node = np_cpu;
-		dai->cpu_of_node = np_cpu;
+		if (!dai->codecs->name)
+			dai->codecs->of_node = np_codec;
+		dai->platforms->of_node = np_cpu;
+		dai->cpus->of_node = np_cpu;
 
 		if (card->num_dapm_routes + rockchip_routes[index].num_routes >
 		    num_routes) {
-- 
2.20.1
