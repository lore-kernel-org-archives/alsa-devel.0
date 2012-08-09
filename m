From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH 2/2] ASoC: bfin: fix memory leak in sport3
	controller driver
Date: Thu, 9 Aug 2012 18:08:40 -0400
Message-ID: <1344550120-30901-2-git-send-email-scott.jiang.linux@gmail.com>
References: <1344550120-30901-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 302F1266049
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 11:06:16 +0200 (CEST)
In-Reply-To: <1344550120-30901-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, uclinux-dist-devel@blackfin.uclinux.org
Cc: Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/bf6xx-sport.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
index 318c5ba..dfb7443 100644
--- a/sound/soc/blackfin/bf6xx-sport.c
+++ b/sound/soc/blackfin/bf6xx-sport.c
@@ -413,7 +413,14 @@ EXPORT_SYMBOL(sport_create);
 
 void sport_delete(struct sport_device *sport)
 {
+	if (sport->tx_desc)
+		dma_free_coherent(NULL, sport->tx_desc_size,
+				sport->tx_desc, 0);
+	if (sport->rx_desc)
+		dma_free_coherent(NULL, sport->rx_desc_size,
+				sport->rx_desc, 0);
 	sport_free_resource(sport);
+	kfree(sport);
 }
 EXPORT_SYMBOL(sport_delete);
 
-- 
1.7.0.4
