From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: smdk_wm8994: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:10 +0100 (BST)
Message-ID: <20190606212710.4E1ED440046@finisterre.sirena.org.uk>
References: <87v9xjl67c.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D448F89766
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:11 +0200 (CEST)
In-Reply-To: <87v9xjl67c.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: smdk_wm8994: use modern dai_link style

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

>From 2f8ea84e3a8c9d57a6c893088a3f6145c96d72ee Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:09:06 +0900
Subject: [PATCH] ASoC: samsung: smdk_wm8994: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/smdk_wm8994.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 135d8c2745be..28f8be000aa1 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -100,28 +100,32 @@ static int smdk_wm8994_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+SND_SOC_DAILINK_DEFS(aif1,
+	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8994-codec", "wm8994-aif1")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
+
+SND_SOC_DAILINK_DEFS(fifo_tx,
+	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s-sec")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8994-codec", "wm8994-aif1")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s-sec")));
+
 static struct snd_soc_dai_link smdk_dai[] = {
 	{ /* Primary DAI i/f */
 		.name = "WM8994 AIF1",
 		.stream_name = "Pri_Dai",
-		.cpu_dai_name = "samsung-i2s.0",
-		.codec_dai_name = "wm8994-aif1",
-		.platform_name = "samsung-i2s.0",
-		.codec_name = "wm8994-codec",
 		.init = smdk_wm8994_init_paiftx,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBM_CFM,
 		.ops = &smdk_ops,
+		SND_SOC_DAILINK_REG(aif1),
 	}, { /* Sec_Fifo Playback i/f */
 		.name = "Sec_FIFO TX",
 		.stream_name = "Sec_Dai",
-		.cpu_dai_name = "samsung-i2s-sec",
-		.codec_dai_name = "wm8994-aif1",
-		.platform_name = "samsung-i2s-sec",
-		.codec_name = "wm8994-codec",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBM_CFM,
 		.ops = &smdk_ops,
+		SND_SOC_DAILINK_REG(fifo_tx),
 	},
 };
 
@@ -153,17 +157,17 @@ static int smdk_audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (np) {
-		smdk_dai[0].cpu_dai_name = NULL;
-		smdk_dai[0].cpu_of_node = of_parse_phandle(np,
+		smdk_dai[0].cpus->dai_name = NULL;
+		smdk_dai[0].cpus->of_node = of_parse_phandle(np,
 				"samsung,i2s-controller", 0);
-		if (!smdk_dai[0].cpu_of_node) {
+		if (!smdk_dai[0].cpus->of_node) {
 			dev_err(&pdev->dev,
 			   "Property 'samsung,i2s-controller' missing or invalid\n");
 			ret = -EINVAL;
 		}
 
-		smdk_dai[0].platform_name = NULL;
-		smdk_dai[0].platform_of_node = smdk_dai[0].cpu_of_node;
+		smdk_dai[0].platforms->name = NULL;
+		smdk_dai[0].platforms->of_node = smdk_dai[0].cpus->of_node;
 	}
 
 	id = of_match_device(of_match_ptr(samsung_wm8994_of_match), &pdev->dev);
-- 
2.20.1
