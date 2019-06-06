From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: arndale_rt5631: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:08 +0100 (BST)
Message-ID: <20190606212708.1B994440049@finisterre.sirena.org.uk>
References: <87pnnrl66o.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B953AF897F3
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:08 +0200 (CEST)
In-Reply-To: <87pnnrl66o.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: arndale_rt5631: use modern dai_link style

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

>From 930f74a171f5f3a5acc551568c6a1515344ceef1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:09:30 +0900
Subject: [PATCH] ASoC: samsung: arndale_rt5631: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/arndale_rt5631.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/arndale_rt5631.c b/sound/soc/samsung/arndale_rt5631.c
index cc334e1866f6..c213913eb984 100644
--- a/sound/soc/samsung/arndale_rt5631.c
+++ b/sound/soc/samsung/arndale_rt5631.c
@@ -50,15 +50,20 @@ static struct snd_soc_ops arndale_ops = {
 	.hw_params = arndale_hw_params,
 };
 
+SND_SOC_DAILINK_DEFS(rt5631_hifi,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5631-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link arndale_rt5631_dai[] = {
 	{
 		.name = "RT5631 HiFi",
 		.stream_name = "Primary",
-		.codec_dai_name = "rt5631-hifi",
 		.dai_fmt = SND_SOC_DAIFMT_I2S
 			| SND_SOC_DAIFMT_NB_NF
 			| SND_SOC_DAIFMT_CBS_CFS,
 		.ops = &arndale_ops,
+		SND_SOC_DAILINK_REG(rt5631_hifi),
 	},
 };
 
@@ -78,24 +83,24 @@ static int arndale_audio_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 
 	for (n = 0; np && n < ARRAY_SIZE(arndale_rt5631_dai); n++) {
-		if (!arndale_rt5631_dai[n].cpu_dai_name) {
-			arndale_rt5631_dai[n].cpu_of_node = of_parse_phandle(np,
+		if (!arndale_rt5631_dai[n].cpus->dai_name) {
+			arndale_rt5631_dai[n].cpus->of_node = of_parse_phandle(np,
 					"samsung,audio-cpu", n);
 
-			if (!arndale_rt5631_dai[n].cpu_of_node) {
+			if (!arndale_rt5631_dai[n].cpus->of_node) {
 				dev_err(&pdev->dev,
 				"Property 'samsung,audio-cpu' missing or invalid\n");
 				return -EINVAL;
 			}
 		}
-		if (!arndale_rt5631_dai[n].platform_name)
-			arndale_rt5631_dai[n].platform_of_node =
-					arndale_rt5631_dai[n].cpu_of_node;
+		if (!arndale_rt5631_dai[n].platforms->name)
+			arndale_rt5631_dai[n].platforms->of_node =
+					arndale_rt5631_dai[n].cpus->of_node;
 
-		arndale_rt5631_dai[n].codec_name = NULL;
-		arndale_rt5631_dai[n].codec_of_node = of_parse_phandle(np,
+		arndale_rt5631_dai[n].codecs->name = NULL;
+		arndale_rt5631_dai[n].codecs->of_node = of_parse_phandle(np,
 					"samsung,audio-codec", n);
-		if (!arndale_rt5631_dai[0].codec_of_node) {
+		if (!arndale_rt5631_dai[0].codecs->of_node) {
 			dev_err(&pdev->dev,
 			"Property 'samsung,audio-codec' missing or invalid\n");
 			return -EINVAL;
-- 
2.20.1
