From: Sangbeom Kim <sbkim73@samsung.com>
Subject: [PATCH] ASoC: SAMSUNG: Fix the incorrect referencing
	of I2SCON register
Date: Fri, 10 Jun 2011 10:36:54 +0900
Message-ID: <1307669814-9375-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (unknown [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id A19FA24438
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 03:43:50 +0200 (CEST)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, jassisinghbrar@gmail.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

If DMA active status should be checked, I2SCON register should be referenced.
In this patch, Fix the incorrect referencing of I2SCON register.

Reported-by : Lakkyung Jung <lakkyung.jung@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/i2s.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index ffa09b3..992a732 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -191,7 +191,7 @@ static inline bool tx_active(struct i2s_dai *i2s)
 	if (!i2s)
 		return false;
 
-	active = readl(i2s->addr + I2SMOD);
+	active = readl(i2s->addr + I2SCON);
 
 	if (is_secondary(i2s))
 		active &= CON_TXSDMA_ACTIVE;
@@ -223,7 +223,7 @@ static inline bool rx_active(struct i2s_dai *i2s)
 	if (!i2s)
 		return false;
 
-	active = readl(i2s->addr + I2SMOD) & CON_RXDMA_ACTIVE;
+	active = readl(i2s->addr + I2SCON) & CON_RXDMA_ACTIVE;
 
 	return active ? true : false;
 }
-- 
1.7.1
