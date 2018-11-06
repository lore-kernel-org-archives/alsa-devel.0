From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove endpoint bidirectional
	check" to the asoc tree
Date: Tue,  6 Nov 2018 17:53:29 +0000 (GMT)
Message-ID: <20181106175329.72AF0112266B@debutante.sirena.org.uk>
References: <87efbyx043.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3194D267AAE
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:53:29 +0100 (CET)
In-Reply-To: <87efbyx043.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove endpoint bidirectional check

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

>From c8b222bf110ccb54d787f695fb3eb2fb6b723903 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 05:18:58 +0000
Subject: [PATCH] ASoC: rsnd: remove endpoint bidirectional check

DTC commit df536831d02c ("checks: add graph binding checks")
is checking endpoint bidirectional, and it is upstreamed to linux by
commit 50aafd60898a ("scripts/dtc: Update to upstream version
v1.4.6-21-g84e414b0b5bc").
Let's remove own bidirectional check

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index a032819044f7..10a53e2adcad 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1095,11 +1095,7 @@ void rsnd_ssi_parse_hdmi_connection(struct rsnd_priv *priv,
 				    int dai_i)
 {
 	struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
-	struct device_node *remote_ep;
-
-	remote_ep = of_graph_get_remote_endpoint(endpoint);
-	if (!remote_ep)
-		return;
+	struct device_node *remote_ep = of_graph_get_remote_endpoint(endpoint);
 
 	__rsnd_ssi_parse_hdmi_connection(priv, &rdai->playback, remote_ep);
 	__rsnd_ssi_parse_hdmi_connection(priv, &rdai->capture,  remote_ep);
-- 
2.19.0.rc2
