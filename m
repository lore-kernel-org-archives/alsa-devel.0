From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: rockchip_rt5645: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:23 +0100 (BST)
Message-ID: <20190606212623.46959440046@finisterre.sirena.org.uk>
References: <87h893gy3t.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EECACF89770
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:23 +0200 (CEST)
In-Reply-To: <87h893gy3t.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: rockchip: rockchip_rt5645: use modern dai_link style

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

>From 0209bf2b2a765cd5c705a1f97e8f57895e3b9821 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:17:37 +0900
Subject: [PATCH] ASoC: rockchip: rockchip_rt5645: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_rt5645.c | 33 ++++++++++++++++------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 881c32498808..e17f01635bba 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -135,15 +135,20 @@ static const struct snd_soc_ops rk_aif1_ops = {
 	.hw_params = rk_aif1_hw_params,
 };
 
+SND_SOC_DAILINK_DEFS(pcm,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5645-aif1")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link rk_dailink = {
 	.name = "rt5645",
 	.stream_name = "rt5645 PCM",
-	.codec_dai_name = "rt5645-aif1",
 	.init = rk_init,
 	.ops = &rk_aif1_ops,
 	/* set rt5645 as slave */
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		SND_SOC_DAIFMT_CBS_CFS,
+	SND_SOC_DAILINK_REG(pcm),
 };
 
 static struct snd_soc_card snd_soc_card_rk = {
@@ -168,24 +173,24 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	/* register the soc card */
 	card->dev = &pdev->dev;
 
-	rk_dailink.codec_of_node = of_parse_phandle(np,
+	rk_dailink.codecs->of_node = of_parse_phandle(np,
 			"rockchip,audio-codec", 0);
-	if (!rk_dailink.codec_of_node) {
+	if (!rk_dailink.codecs->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'rockchip,audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
 
-	rk_dailink.cpu_of_node = of_parse_phandle(np,
+	rk_dailink.cpus->of_node = of_parse_phandle(np,
 			"rockchip,i2s-controller", 0);
-	if (!rk_dailink.cpu_of_node) {
+	if (!rk_dailink.cpus->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'rockchip,i2s-controller' missing or invalid\n");
 		ret = -EINVAL;
 		goto put_codec_of_node;
 	}
 
-	rk_dailink.platform_of_node = rk_dailink.cpu_of_node;
+	rk_dailink.platforms->of_node = rk_dailink.cpus->of_node;
 
 	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
 	if (ret) {
@@ -204,21 +209,21 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	return ret;
 
 put_cpu_of_node:
-	of_node_put(rk_dailink.cpu_of_node);
-	rk_dailink.cpu_of_node = NULL;
+	of_node_put(rk_dailink.cpus->of_node);
+	rk_dailink.cpus->of_node = NULL;
 put_codec_of_node:
-	of_node_put(rk_dailink.codec_of_node);
-	rk_dailink.codec_of_node = NULL;
+	of_node_put(rk_dailink.codecs->of_node);
+	rk_dailink.codecs->of_node = NULL;
 
 	return ret;
 }
 
 static int snd_rk_mc_remove(struct platform_device *pdev)
 {
-	of_node_put(rk_dailink.cpu_of_node);
-	rk_dailink.cpu_of_node = NULL;
-	of_node_put(rk_dailink.codec_of_node);
-	rk_dailink.codec_of_node = NULL;
+	of_node_put(rk_dailink.cpus->of_node);
+	rk_dailink.cpus->of_node = NULL;
+	of_node_put(rk_dailink.codecs->of_node);
+	rk_dailink.codecs->of_node = NULL;
 
 	return 0;
 }
-- 
2.20.1
