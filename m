From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: add 1 CPU : 1 Codec
	support again" to the asoc tree
Date: Fri,  4 Jan 2019 17:09:30 +0000 (GMT)
Message-ID: <20190104170930.4F5FC11270A3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 14AB6267C43
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 18:09:30 +0100 (CET)
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

   ASoC: audio-graph-card: add 1 CPU : 1 Codec support again

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

>From de2949fe262197298036989924d05f5de6b9815a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:45:54 +0900
Subject: [PATCH] ASoC: audio-graph-card: add 1 CPU : 1 Codec support again

audio-graph-card is now supporting normal sound and DPCM sound.
For DPCM sound, original sound card (= audio-graph-scu) had been
supported 1 CPU : 1 Codec connection which uses hw_params_fixup()
for convert-rate/channel.
But, merged audio-graph-card is completely forgeting about it.

This patch re-support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 44 ++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index c3e80bc27e80..638333cdac66 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -408,6 +408,7 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	struct device_node *codec_ep		= NULL;
 	struct device_node *codec_port		= NULL;
 	struct device_node *codec_port_old	= NULL;
+	struct asoc_simple_card_data adata;
 	int rc, ret;
 	int link_idx, dai_idx, conf_idx;
 	int cpu;
@@ -453,7 +454,13 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 				dev_dbg(dev, "%pOFf <-> %pOFf\n", cpu_ep, codec_ep);
 
-				if (of_get_child_count(codec_port) > 1) {
+				memset(&adata, 0, sizeof(adata));
+				asoc_graph_card_get_conversion(dev, codec_ep, &adata);
+				asoc_graph_card_get_conversion(dev, cpu_ep,   &adata);
+
+				if ((of_get_child_count(codec_port) > 1) ||
+				    adata.convert_rate ||
+				    adata.convert_channels) {
 					/*
 					 * for DPCM sound
 					 */
@@ -495,7 +502,7 @@ static void asoc_graph_get_dais_count(struct device *dev,
 	struct device_node *codec_ep;
 	struct device_node *codec_port;
 	struct device_node *codec_port_old;
-	struct device_node *codec_port_old2;
+	struct asoc_simple_card_data adata;
 	int rc;
 
 	/*
@@ -534,9 +541,17 @@ static void asoc_graph_get_dais_count(struct device *dev,
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
 	codec_port_old = NULL;
-	codec_port_old2 = NULL;
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
 		cpu_port = it.node;
 		cpu_ep	 = NULL;
@@ -554,17 +569,22 @@ static void asoc_graph_get_dais_count(struct device *dev,
 			(*link_num)++;
 			(*dais_num)++;
 
-			if (codec_port_old == codec_port) {
-				if (codec_port_old2 != codec_port_old) {
-					(*link_num)++;
-					(*ccnf_num)++;
-				}
+			memset(&adata, 0, sizeof(adata));
+			asoc_graph_card_get_conversion(dev, codec_ep, &adata);
+			asoc_graph_card_get_conversion(dev, cpu_ep,   &adata);
 
-				codec_port_old2 = codec_port_old;
-				continue;
-			}
+			if ((of_get_child_count(codec_port) > 1) ||
+			    adata.convert_rate || adata.convert_channels) {
 
-			(*dais_num)++;
+				if (codec_port_old == codec_port)
+					continue;
+
+				(*link_num)++;
+				(*ccnf_num)++;
+				(*dais_num)++;
+			} else {
+				(*dais_num)++;
+			}
 			codec_port_old = codec_port;
 		}
 	}
-- 
2.20.1
