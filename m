From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: sh: Don't opencode DMAengine API
	calls
Date: Tue, 19 Aug 2014 17:48:06 +0200
Message-ID: <1408463287-5546-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-176.synserver.de (smtp-out-176.synserver.de
 [212.40.185.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A817265845
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 17:48:11 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Lars-Peter Clausen <lars@metafoo.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the proper wrapper functions instead of directly calling the DMAengine
callback functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sh/siu_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 488f9be..32eb6da 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -139,7 +139,7 @@ static int siu_pcm_wr_set(struct siu_port *port_info,
 
 	desc->callback = siu_dma_tx_complete;
 	desc->callback_param = siu_stream;
-	cookie = desc->tx_submit(desc);
+	cookie = dmaengine_submit(desc);
 	if (cookie < 0) {
 		dev_err(dev, "Failed to submit a dma transfer\n");
 		return cookie;
@@ -189,7 +189,7 @@ static int siu_pcm_rd_set(struct siu_port *port_info,
 
 	desc->callback = siu_dma_tx_complete;
 	desc->callback_param = siu_stream;
-	cookie = desc->tx_submit(desc);
+	cookie = dmaengine_submit(desc);
 	if (cookie < 0) {
 		dev_err(dev, "Failed to submit dma descriptor\n");
 		return cookie;
-- 
1.8.0
