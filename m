From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: common: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:25 +0100 (BST)
Message-ID: <20190606212625.82B3E440046@finisterre.sirena.org.uk>
References: <87o93bgy4w.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29BD0F89771
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:26 +0200 (CEST)
In-Reply-To: <87o93bgy4w.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: qcom: common: use modern dai_link style

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

>From 1e36ea360ab98e9c20329a3d9364705d1347e411 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:16:58 +0900
Subject: [PATCH] ASoC: qcom: common: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/common.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 5661025e8cec..c7a878507220 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -14,6 +14,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	struct device *dev = card->dev;
 	struct snd_soc_dai_link *link;
 	struct of_phandle_args args;
+	struct snd_soc_dai_link_component *dlc;
 	int ret, num_links;
 
 	ret = snd_soc_of_parse_card_name(card, "model");
@@ -40,6 +41,17 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 
 	card->num_links = num_links;
 	link = card->dai_link;
+
+	dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
+	if (!dlc)
+		return -ENOMEM;
+
+	link->cpus	= &dlc[0];
+	link->platforms	= &dlc[1];
+
+	link->num_cpus		= 1;
+	link->num_platforms	= 1;
+
 	for_each_child_of_node(dev->of_node, np) {
 		cpu = of_get_child_by_name(np, "cpu");
 		platform = of_get_child_by_name(np, "platform");
@@ -57,20 +69,20 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			dev_err(card->dev, "error getting cpu phandle\n");
 			goto err;
 		}
-		link->cpu_of_node = args.np;
+		link->cpus->of_node = args.np;
 		link->id = args.args[0];
 
-		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpus->dai_name);
 		if (ret) {
 			dev_err(card->dev, "error getting cpu dai name\n");
 			goto err;
 		}
 
 		if (codec && platform) {
-			link->platform_of_node = of_parse_phandle(platform,
+			link->platforms->of_node = of_parse_phandle(platform,
 					"sound-dai",
 					0);
-			if (!link->platform_of_node) {
+			if (!link->platforms->of_node) {
 				dev_err(card->dev, "platform dai not found\n");
 				ret = -EINVAL;
 				goto err;
@@ -84,9 +96,16 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			link->no_pcm = 1;
 			link->ignore_pmdown_time = 1;
 		} else {
-			link->platform_of_node = link->cpu_of_node;
-			link->codec_dai_name = "snd-soc-dummy-dai";
-			link->codec_name = "snd-soc-dummy";
+			dlc = devm_kzalloc(dev, sizeof(*dlc), GFP_KERNEL);
+			if (!dlc)
+				return -ENOMEM;
+
+			link->codecs	 = dlc;
+			link->num_codecs = 1;
+
+			link->platforms->of_node = link->cpus->of_node;
+			link->codecs->dai_name = "snd-soc-dummy-dai";
+			link->codecs->name = "snd-soc-dummy";
 			link->dynamic = 1;
 		}
 
-- 
2.20.1
