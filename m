From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: remove endpoint
	bidirectional check" to the asoc tree
Date: Tue,  6 Nov 2018 17:54:01 +0000 (GMT)
Message-ID: <20181106175401.A02F9112266B@debutante.sirena.org.uk>
References: <87k1lqx22s.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 17C6D267AB5
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:54:02 +0100 (CET)
In-Reply-To: <87k1lqx22s.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-card: remove endpoint bidirectional check

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

>From 39ee0b3401feac5932dca6a98d538438aa5f6236 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 04:36:27 +0000
Subject: [PATCH] ASoC: audio-graph-card: remove endpoint bidirectional check

DTC commit df536831d02c ("checks: add graph binding checks")
is checking endpoint bidirectional, and it is upstreamed to linux by
commit 50aafd60898a ("scripts/dtc: Update to upstream version
v1.4.6-21-g84e414b0b5bc").
Let's remove own bidirectional check

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 25c819e402e1..26eb6ff9b9f3 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -167,16 +167,8 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	struct asoc_simple_dai *codec_dai = &dai_props->codec_dai;
 	struct device_node *cpu_ep    = of_get_next_child(cpu_port, NULL);
 	struct device_node *codec_ep = of_graph_get_remote_endpoint(cpu_ep);
-	struct device_node *rcpu_ep = of_graph_get_remote_endpoint(codec_ep);
 	int ret;
 
-	if (rcpu_ep != cpu_ep) {
-		dev_err(dev, "remote-endpoint mismatch (%s/%s/%s)\n",
-			cpu_ep->name, codec_ep->name, rcpu_ep->name);
-		ret = -EINVAL;
-		goto dai_link_of_err;
-	}
-
 	ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
 					    NULL, &dai_link->dai_fmt);
 	if (ret < 0)
@@ -228,7 +220,6 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 
 dai_link_of_err:
 	of_node_put(cpu_ep);
-	of_node_put(rcpu_ep);
 	of_node_put(codec_ep);
 
 	return ret;
-- 
2.19.0.rc2
