From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: apq8016_sbc: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:24 +0100 (BST)
Message-ID: <20190606212624.EEF31440046@finisterre.sirena.org.uk>
References: <87muivgy4q.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC237F89779
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:25 +0200 (CEST)
In-Reply-To: <87muivgy4q.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: qcom: apq8016_sbc: use modern dai_link style

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

>From 98b232ca9e0e7fb0f3be80653f647c8ce369556d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:17:04 +0900
Subject: [PATCH] ASoC: qcom: apq8016_sbc: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 4b559932adc3..717542c61d04 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -126,6 +126,7 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 	struct snd_soc_dai_link *link;
 	struct device_node *np, *codec, *cpu, *node  = dev->of_node;
 	struct apq8016_sbc_data *data;
+	struct snd_soc_dai_link_component *dlc;
 	int ret, num_links;
 
 	ret = snd_soc_of_parse_card_name(card, "qcom,model");
@@ -158,6 +159,16 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 
 	link = data->dai_link;
 
+	dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
+	if (!dlc)
+		return ERR_PTR(-ENOMEM);
+
+	link->cpus	= &dlc[0];
+	link->platforms	= &dlc[1];
+
+	link->num_cpus		= 1;
+	link->num_platforms	= 1;
+
 	for_each_child_of_node(node, np) {
 		cpu = of_get_child_by_name(np, "cpu");
 		codec = of_get_child_by_name(np, "codec");
@@ -168,14 +179,14 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 			goto error;
 		}
 
-		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
-		if (!link->cpu_of_node) {
+		link->cpus->of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!link->cpus->of_node) {
 			dev_err(card->dev, "error getting cpu phandle\n");
 			ret = -EINVAL;
 			goto error;
 		}
 
-		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpus->dai_name);
 		if (ret) {
 			dev_err(card->dev, "error getting cpu dai name\n");
 			goto error;
@@ -188,7 +199,7 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 			goto error;
 		}
 
-		link->platform_of_node = link->cpu_of_node;
+		link->platforms->of_node = link->cpus->of_node;
 		ret = of_property_read_string(np, "link-name", &link->name);
 		if (ret) {
 			dev_err(card->dev, "error getting codec dai_link name\n");
-- 
2.20.1
