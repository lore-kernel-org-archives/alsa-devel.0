From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: rcar: Fix dma direction type
Date: Thu, 19 Jun 2014 09:40:30 +0200
Message-ID: <1403163631-26215-5-git-send-email-lars@metafoo.de>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 326A5265282
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 09:40:46 +0200 (CEST)
In-Reply-To: <1403163631-26215-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

dmaengine_prep_slave_single() expects a enum dma_transfer_direction and not a
enum dma_data_direction. Since the integer representations of both DMA_TO_DEVICE
and DMA_MEM_TO_DEV aswell as DMA_FROM_DEVICE and DMA_DEV_TO_MEM have the same
value the code worked fine even though it was using the wrong type.

Fixes the following warning from sparse:
	sound/soc/sh/rcar/core.c:227:49: warning: mixing different enum types
	sound/soc/sh/rcar/core.c:227:49:     int enum dma_data_direction  versus
	sound/soc/sh/rcar/core.c:227:49:     int enum dma_transfer_direction

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sh/rcar/core.c | 2 +-
 sound/soc/sh/rcar/rsnd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 4e86265..518a78c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -363,7 +363,7 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma,
 	if (ret < 0)
 		goto rsnd_dma_init_err;
 
-	dma->dir = is_play ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	dma->dir = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 	INIT_WORK(&dma->work, rsnd_dma_do_work);
 
 	return 0;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 39d98af..067a89e 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -158,7 +158,7 @@ struct rsnd_dma {
 	struct sh_dmae_slave	slave;
 	struct work_struct	work;
 	struct dma_chan		*chan;
-	enum dma_data_direction dir;
+	enum dma_transfer_direction dir;
 
 	int submit_loop;
 	int offset; /* it cares A/B plane */
-- 
1.8.0
