From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: remove endpoint
	bidirectional check" to the asoc tree
Date: Tue,  6 Nov 2018 17:53:51 +0000 (GMT)
Message-ID: <20181106175351.6E5DB112266B@debutante.sirena.org.uk>
References: <87in1ax22f.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E83942678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:53:51 +0100 (CET)
In-Reply-To: <87in1ax22f.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-scu-card: remove endpoint bidirectional check

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

>From 1a115f3a5418459aabc10628eb25dff1bae64bca Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 04:36:41 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: remove endpoint bidirectional
 check

DTC commit df536831d02c ("checks: add graph binding checks")
is checking endpoint bidirectional, and it is upstreamed to linux by
commit 50aafd60898a ("scripts/dtc: Update to upstream version
v1.4.6-21-g84e414b0b5bc").
Let's remove own bidirectional check

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index b83bb31021a9..ba7b0cf028b7 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -186,7 +186,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	struct device_node *cpu_port;
 	struct device_node *cpu_ep;
 	struct device_node *codec_ep;
-	struct device_node *rcpu_ep;
 	struct device_node *codec_port;
 	struct device_node *codec_port_old;
 	unsigned int daifmt = 0;
@@ -217,22 +216,13 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 		cpu_port = it.node;
 		cpu_ep   = of_get_next_child(cpu_port, NULL);
 		codec_ep = of_graph_get_remote_endpoint(cpu_ep);
-		rcpu_ep  = of_graph_get_remote_endpoint(codec_ep);
 
 		of_node_put(cpu_ep);
 		of_node_put(codec_ep);
-		of_node_put(rcpu_ep);
 
 		if (!codec_ep)
 			continue;
 
-		if (rcpu_ep != cpu_ep) {
-			dev_err(dev, "remote-endpoint missmatch (%s/%s/%s)\n",
-				cpu_ep->name, codec_ep->name, rcpu_ep->name);
-			ret = -EINVAL;
-			goto parse_of_err;
-		}
-
 		ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
 							    NULL, &daifmt);
 		if (ret < 0) {
-- 
2.19.0.rc2
