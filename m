From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: remove error
	check which never happen" to the asoc tree
Date: Tue,  6 Nov 2018 17:53:40 +0000 (GMT)
Message-ID: <20181106175340.94EDA112266B@debutante.sirena.org.uk>
References: <87h8gux221.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5184C267AB0
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:53:41 +0100 (CET)
In-Reply-To: <87h8gux221.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: audio-graph-scu-card: remove error check which never happen

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

>From 5049a6e7316cdbf4370d5479e9628d8f5e906635 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 04:36:55 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: remove error check which never
 happen

Current driver is checking situation that can not happen.
This patch removes over-kill check

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index ba7b0cf028b7..2ba35bdd3b38 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -250,9 +250,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 			of_node_put(codec_port);
 
 			if (codec) {
-				if (!codec_port)
-					continue;
-
 				if (codec_port_old == codec_port)
 					continue;
 
@@ -308,11 +305,7 @@ static int asoc_graph_get_dais_count(struct device *dev)
 		of_node_put(codec_ep);
 		of_node_put(codec_port);
 
-		if (cpu_ep)
-			count++;
-
-		if (!codec_port)
-			continue;
+		count++;
 
 		if (codec_port_old == codec_port)
 			continue;
-- 
2.19.0.rc2
