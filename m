From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel: sam9g20_wm8731: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:41 +0100 (BST)
Message-ID: <20190606212641.36DD8440046@finisterre.sirena.org.uk>
References: <87sgsnicuo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F09DAF897A9
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:41 +0200 (CEST)
In-Reply-To: <87sgsnicuo.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: atmel: sam9g20_wm8731: use modern dai_link style

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

>From d83923c576f985e8442734d4d89f72af7661fec2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:13:46 +0900
Subject: [PATCH] ASoC: atmel: sam9g20_wm8731: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/sam9g20_wm8731.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 98f93e79c654..a5b4c3905ae8 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -129,16 +129,18 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+SND_SOC_DAILINK_DEFS(pcm,
+	DAILINK_COMP_ARRAY(COMP_CPU("at91rm9200_ssc.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8731.0-001b", "wm8731-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("at91rm9200_ssc.0")));
+
 static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.name = "WM8731",
 	.stream_name = "WM8731 PCM",
-	.cpu_dai_name = "at91rm9200_ssc.0",
-	.codec_dai_name = "wm8731-hifi",
 	.init = at91sam9g20ek_wm8731_init,
-	.platform_name = "at91rm9200_ssc.0",
-	.codec_name = "wm8731.0-001b",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
+	SND_SOC_DAILINK_REG(pcm),
 };
 
 static struct snd_soc_card snd_soc_at91sam9g20ek = {
@@ -211,24 +213,24 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 		goto err;
 
 	/* Parse codec info */
-	at91sam9g20ek_dai.codec_name = NULL;
+	at91sam9g20ek_dai.codecs->name = NULL;
 	codec_np = of_parse_phandle(np, "atmel,audio-codec", 0);
 	if (!codec_np) {
 		dev_err(&pdev->dev, "codec info missing\n");
 		return -EINVAL;
 	}
-	at91sam9g20ek_dai.codec_of_node = codec_np;
+	at91sam9g20ek_dai.codecs->of_node = codec_np;
 
 	/* Parse dai and platform info */
-	at91sam9g20ek_dai.cpu_dai_name = NULL;
-	at91sam9g20ek_dai.platform_name = NULL;
+	at91sam9g20ek_dai.cpus->dai_name = NULL;
+	at91sam9g20ek_dai.platforms->name = NULL;
 	cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "dai and pcm info missing\n");
 		return -EINVAL;
 	}
-	at91sam9g20ek_dai.cpu_of_node = cpu_np;
-	at91sam9g20ek_dai.platform_of_node = cpu_np;
+	at91sam9g20ek_dai.cpus->of_node = cpu_np;
+	at91sam9g20ek_dai.platforms->of_node = cpu_np;
 
 	of_node_put(codec_np);
 	of_node_put(cpu_np);
-- 
2.20.1
