From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: add 1 CPU : 1 Codec
	support again" to the asoc tree
Date: Mon,  7 Jan 2019 12:31:13 +0000 (GMT)
Message-ID: <20190107123113.C02F11127490@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DCBE267C94
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:31:14 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: add 1 CPU : 1 Codec support again

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7adee60ee2732f23f703ff83ee35caad561490ba Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:46:47 +0900
Subject: [PATCH] ASoC: simple-card: add 1 CPU : 1 Codec support again

simple-card is now supporting normal sound and DPCM sound.
For DPCM sound, original sound card (= simple-scu-card) had been
supported 1 CPU : 1 Codec connection which uses hw_params_fixup()
for convert-rate/channel.
But, merged simple-card is completely forgeting about it.

This patch re-support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 52048069b25a..b15651409c7f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -453,6 +453,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	struct device_node *node;
 	struct device_node *np;
 	struct device_node *codec;
+	struct asoc_simple_card_data adata;
 	bool is_fe;
 	int ret, loop;
 	int dai_idx, link_idx, conf_idx;
@@ -480,8 +481,13 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	}
 
 	do  {
+		memset(&adata, 0, sizeof(adata));
+		for_each_child_of_node(node, np)
+			asoc_simple_card_get_conversion(dev, np, &adata);
+
 		/* DPCM */
-		if (of_get_child_count(node) > 2) {
+		if (of_get_child_count(node) > 2 ||
+		    adata.convert_rate || adata.convert_channels) {
 			for_each_child_of_node(node, np) {
 				codec = of_get_child_by_name(node,
 							loop ?	"codec" :
@@ -495,14 +501,16 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 						top, node, np, codec, priv,
 						&dai_idx, link_idx++, &conf_idx,
 						is_fe, !loop);
+				if (ret < 0)
+					return ret;
 			}
 		} else {
 			ret = asoc_simple_card_dai_link_of(
 						top, node, priv,
 						&dai_idx, link_idx++, !loop);
+			if (ret < 0)
+				return ret;
 		}
-		if (ret < 0)
-			return ret;
 
 		node = of_get_next_child(top, node);
 	} while (loop && node);
@@ -523,6 +531,8 @@ static void asoc_simple_card_get_dais_count(struct device *dev,
 {
 	struct device_node *top = dev->of_node;
 	struct device_node *node;
+	struct device_node *np;
+	struct asoc_simple_card_data adata;
 	int loop;
 	int num;
 
@@ -562,6 +572,15 @@ static void asoc_simple_card_get_dais_count(struct device *dev,
 	 *	=> 6 links = 0xCPU-Codec + 4xCPU-dummy + 2xdummy-Codec
 	 *	=> 6 DAIs  = 4xCPU + 2xCodec
 	 *	=> 2 ccnf  = 2xdummy-Codec
+	 *
+	 * ex4)
+	 * CPU0 --- Codec0 (convert-rate)	link : 3
+	 * CPU1 --- Codec1			dais : 4
+	 *					ccnf : 1
+	 *
+	 *	=> 3 links = 1xCPU-Codec + 1xCPU-dummy + 1xdummy-Codec
+	 *	=> 4 DAIs  = 2xCPU + 2xCodec
+	 *	=> 1 ccnf  = 1xdummy-Codec
 	 */
 	if (!top) {
 		(*link_num) = 1;
@@ -578,9 +597,14 @@ static void asoc_simple_card_get_dais_count(struct device *dev,
 	}
 
 	do {
+		memset(&adata, 0, sizeof(adata));
+		for_each_child_of_node(node, np)
+			asoc_simple_card_get_conversion(dev, np, &adata);
+
 		num = of_get_child_count(node);
 		(*dais_num) += num;
-		if (num > 2) {
+		if (num > 2 ||
+		    adata.convert_rate || adata.convert_channels) {
 			(*link_num) += num;
 			(*ccnf_num)++;
 		} else {
-- 
2.20.1
