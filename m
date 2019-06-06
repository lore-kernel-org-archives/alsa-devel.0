From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: storm: use modern dai_link style"
	to the asoc tree
Date: Thu,  6 Jun 2019 22:26:26 +0100 (BST)
Message-ID: <20190606212626.186B2440046@finisterre.sirena.org.uk>
References: <87pnnrgy53.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDE31F8973A
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:26 +0200 (CEST)
In-Reply-To: <87pnnrgy53.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: qcom: storm: use modern dai_link style

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

>From fa350b770b57d6e17b73d259bfec7e40099f7261 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:16:51 +0900
Subject: [PATCH] ASoC: qcom: storm: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/storm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
index a9fa972466ad..672edee2ea93 100644
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -61,11 +61,16 @@ static const struct snd_soc_ops storm_soc_ops = {
 	.hw_params	= storm_ops_hw_params,
 };
 
+SND_SOC_DAILINK_DEFS(hifi,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link storm_dai_link = {
 	.name		= "Primary",
 	.stream_name	= "Primary",
-	.codec_dai_name	= "HiFi",
 	.ops		= &storm_soc_ops,
+	SND_SOC_DAILINK_REG(hifi),
 };
 
 static int storm_parse_of(struct snd_soc_card *card)
@@ -73,15 +78,15 @@ static int storm_parse_of(struct snd_soc_card *card)
 	struct snd_soc_dai_link *dai_link = card->dai_link;
 	struct device_node *np = card->dev->of_node;
 
-	dai_link->cpu_of_node = of_parse_phandle(np, "cpu", 0);
-	if (!dai_link->cpu_of_node) {
+	dai_link->cpus->of_node = of_parse_phandle(np, "cpu", 0);
+	if (!dai_link->cpus->of_node) {
 		dev_err(card->dev, "error getting cpu phandle\n");
 		return -EINVAL;
 	}
-	dai_link->platform_of_node = dai_link->cpu_of_node;
+	dai_link->platforms->of_node = dai_link->cpus->of_node;
 
-	dai_link->codec_of_node = of_parse_phandle(np, "codec", 0);
-	if (!dai_link->codec_of_node) {
+	dai_link->codecs->of_node = of_parse_phandle(np, "codec", 0);
+	if (!dai_link->codecs->of_node) {
 		dev_err(card->dev, "error getting codec phandle\n");
 		return -EINVAL;
 	}
-- 
2.20.1
