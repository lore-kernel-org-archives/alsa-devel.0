From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: tm2_wm5110: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:06 +0100 (BST)
Message-ID: <20190606212707.01CB5440046@finisterre.sirena.org.uk>
References: <87muivl66a.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4B6EF897EE
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:07 +0200 (CEST)
In-Reply-To: <87muivl66a.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: tm2_wm5110: use modern dai_link style

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

>From f1d26f2b947ea6cc3265b0e3c0a265c57a43f945 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:09:44 +0900
Subject: [PATCH] ASoC: samsung: tm2_wm5110: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/tm2_wm5110.c | 42 ++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 31f4256c6c65..c091033d17ad 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -427,38 +427,56 @@ static struct snd_soc_dai_driver tm2_ext_dai[] = {
 	},
 };
 
+SND_SOC_DAILINK_DEFS(aif1,
+	DAILINK_COMP_ARRAY(COMP_CPU(SAMSUNG_I2S_DAI)),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm5110-aif1")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(voice,
+	DAILINK_COMP_ARRAY(COMP_CPU(SAMSUNG_I2S_DAI)),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm5110-aif2")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(bt,
+	DAILINK_COMP_ARRAY(COMP_CPU(SAMSUNG_I2S_DAI)),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm5110-aif3")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(hdmi,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link tm2_dai_links[] = {
 	{
 		.name		= "WM5110 AIF1",
 		.stream_name	= "HiFi Primary",
-		.cpu_dai_name   = SAMSUNG_I2S_DAI,
-		.codec_dai_name = "wm5110-aif1",
 		.ops		= &tm2_aif1_ops,
 		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM,
+		SND_SOC_DAILINK_REG(aif1),
 	}, {
 		.name		= "WM5110 Voice",
 		.stream_name	= "Voice call",
-		.cpu_dai_name   = SAMSUNG_I2S_DAI,
-		.codec_dai_name = "wm5110-aif2",
 		.ops		= &tm2_aif2_ops,
 		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM,
 		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(voice),
 	}, {
 		.name		= "WM5110 BT",
 		.stream_name	= "Bluetooth",
-		.cpu_dai_name   = SAMSUNG_I2S_DAI,
-		.codec_dai_name = "wm5110-aif3",
 		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM,
 		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(bt),
 	}, {
 		.name		= "HDMI",
 		.stream_name	= "i2s1",
 		.ops		= &tm2_hdmi_ops,
 		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(hdmi),
 	}
 };
 
@@ -557,15 +575,15 @@ static int tm2_probe(struct platform_device *pdev)
 	for_each_card_prelinks(card, i, dai_link) {
 		unsigned int dai_index = 0; /* WM5110 */
 
-		dai_link->cpu_name = NULL;
-		dai_link->platform_name = NULL;
+		dai_link->cpus->name = NULL;
+		dai_link->platforms->name = NULL;
 
 		if (num_codecs > 1 && i == card->num_links - 1)
 			dai_index = 1; /* HDMI */
 
-		dai_link->codec_of_node = codec_dai_node[dai_index];
-		dai_link->cpu_of_node = cpu_dai_node[dai_index];
-		dai_link->platform_of_node = cpu_dai_node[dai_index];
+		dai_link->codecs->of_node = codec_dai_node[dai_index];
+		dai_link->cpus->of_node = cpu_dai_node[dai_index];
+		dai_link->platforms->of_node = cpu_dai_node[dai_index];
 	}
 
 	if (num_codecs > 1) {
@@ -579,7 +597,7 @@ static int tm2_probe(struct platform_device *pdev)
 			goto dai_node_put;
 		}
 
-		ret = snd_soc_get_dai_name(&args, &card->dai_link[i].codec_dai_name);
+		ret = snd_soc_get_dai_name(&args, &card->dai_link[i].codecs->dai_name);
 		if (ret) {
 			dev_err(dev, "Unable to get codec_dai_name\n");
 			goto dai_node_put;
-- 
2.20.1
