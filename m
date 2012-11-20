From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 02/10] ASoC: kirkwood-dma: don't ignore other
 irq causes on error
Date: Tue, 20 Nov 2012 12:18:11 +0000
Message-ID: <E1TammJ-0007X7-Tt@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id D094B265361
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:18:13 +0100 (CET)
In-Reply-To: <20121120121726.GN3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Liam Girdwood <lrg@ti.com>, Rabeeh Khoury <rabeeh@solid-run.com>
List-Id: alsa-devel@alsa-project.org

Ignoring the real cause of the interrupt is not a good idea; this
behaviour has been observed to bring Dove platforms to silently
lockup.  Instead, on error fall through to the normal interrupt
processing.

This is especially important on Dove platforms as errors are
handled separately, and allows us to clear down the real cause of
the interrupt.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-dma.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index afe1930..2ba0814 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -71,7 +71,6 @@ static irqreturn_t kirkwood_dma_irq(int irq, void *dev_id)
 		printk(KERN_WARNING "%s: got err interrupt 0x%lx\n",
 				__func__, cause);
 		writel(cause, priv->io + KIRKWOOD_ERR_CAUSE);
-		return IRQ_HANDLED;
 	}
 
 	/* we've enabled only bytes interrupts ... */
-- 
1.7.4.4
