From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 4/5] ASoC: Blackfin: set the transfer size
	according the ac97_frame size
Date: Tue,  2 Jun 2009 00:18:56 -0400
Message-ID: <1243916337-29953-4-git-send-email-vapier@gentoo.org>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id F067B24335
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 06:19:10 +0200 (CEST)
In-Reply-To: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/bf5xx-sport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-sport.c b/sound/soc/blackfin/bf5xx-sport.c
index b7953c8..469ce7f 100644
--- a/sound/soc/blackfin/bf5xx-sport.c
+++ b/sound/soc/blackfin/bf5xx-sport.c
@@ -190,7 +190,7 @@ static inline int sport_hook_rx_dummy(struct sport_device *sport)
 	desc = get_dma_next_desc_ptr(sport->dma_rx_chan);
 	/* Copy the descriptor which will be damaged to backup */
 	temp_desc = *desc;
-	desc->x_count = 0xa;
+	desc->x_count = sport->dummy_count / 2;
 	desc->y_count = 0;
 	desc->next_desc_addr = sport->dummy_rx_desc;
 	local_irq_restore(flags);
@@ -309,7 +309,7 @@ static inline int sport_hook_tx_dummy(struct sport_device *sport)
 	desc = get_dma_next_desc_ptr(sport->dma_tx_chan);
 	/* Store the descriptor which will be damaged */
 	temp_desc = *desc;
-	desc->x_count = 0xa;
+	desc->x_count = sport->dummy_count / 2;
 	desc->y_count = 0;
 	desc->next_desc_addr = sport->dummy_tx_desc;
 	local_irq_restore(flags);
-- 
1.6.3.1
