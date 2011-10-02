From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/6] ASoC: sh: use correct __iomem annotations
Date: Sun,  2 Oct 2011 22:28:02 +0200
Message-ID: <1317587284-2776-5-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id AF4982417E
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 22:29:12 +0200 (CEST)
In-Reply-To: <1317587284-2776-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This removes a few unnecessary type casts and avoids
sparse warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 sound/soc/sh/fsi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 8e112cc..916b9f9 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -210,7 +210,7 @@ struct fsi_master {
  *		basic read write function
  */
 
-static void __fsi_reg_write(u32 reg, u32 data)
+static void __fsi_reg_write(u32 __iomem *reg, u32 data)
 {
 	/* valid data area is 24bit */
 	data &= 0x00ffffff;
@@ -218,12 +218,12 @@ static void __fsi_reg_write(u32 reg, u32 data)
 	__raw_writel(data, reg);
 }
 
-static u32 __fsi_reg_read(u32 reg)
+static u32 __fsi_reg_read(u32 __iomem *reg)
 {
 	return __raw_readl(reg);
 }
 
-static void __fsi_reg_mask_set(u32 reg, u32 mask, u32 data)
+static void __fsi_reg_mask_set(u32 __iomem *reg, u32 mask, u32 data)
 {
 	u32 val = __fsi_reg_read(reg);
 
@@ -250,7 +250,7 @@ static u32 _fsi_master_read(struct fsi_master *master, u32 reg)
 	unsigned long flags;
 
 	spin_lock_irqsave(&master->lock, flags);
-	ret = __fsi_reg_read((u32)(master->base + reg));
+	ret = __fsi_reg_read(master->base + reg);
 	spin_unlock_irqrestore(&master->lock, flags);
 
 	return ret;
@@ -264,7 +264,7 @@ static void _fsi_master_mask_set(struct fsi_master *master,
 	unsigned long flags;
 
 	spin_lock_irqsave(&master->lock, flags);
-	__fsi_reg_mask_set((u32)(master->base + reg), mask, data);
+	__fsi_reg_mask_set(master->base + reg, mask, data);
 	spin_unlock_irqrestore(&master->lock, flags);
 }
 
-- 
1.7.5.4
