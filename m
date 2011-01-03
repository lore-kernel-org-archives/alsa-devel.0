From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH] ASoC: Samsung: Debug register
Date: Mon,  3 Jan 2011 10:51:11 +0900
Message-ID: <1294019471-17044-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 54B702479F
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 03:15:14 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The DMA channel status is read from I2SCON register.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/samsung/i2s.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index fab25b6..26ed01b 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -192,7 +192,7 @@ static inline bool tx_active(struct i2s_dai *i2s)
 	if (!i2s)
 		return false;
 
-	active = readl(i2s->addr + I2SMOD);
+	active = readl(i2s->addr + I2SCON);
 
 	if (is_secondary(i2s))
 		active &= CON_TXSDMA_ACTIVE;
@@ -224,7 +224,7 @@ static inline bool rx_active(struct i2s_dai *i2s)
 	if (!i2s)
 		return false;
 
-	active = readl(i2s->addr + I2SMOD) & CON_RXDMA_ACTIVE;
+	active = readl(i2s->addr + I2SCON) & CON_RXDMA_ACTIVE;
 
 	return active ? true : false;
 }
-- 
1.6.2.5
