From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 09/37] drivers/atm: use .dev.of_node instead of
	.node in	struct of_device
Date: Thu, 11 Mar 2010 11:04:37 -0700
Message-ID: <20100311180437.4824.86345.stgit@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B0CE31039E0
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:04:45 +0100 (CET)
Received: by pvg12 with SMTP id 12so108850pvg.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:04:43 -0800 (PST)
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infrade
List-Id: alsa-devel@alsa-project.org

.node is being removed

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/atm/fore200e.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index f7d6eba..593a03a 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -789,7 +789,7 @@ static int __init fore200e_sba_map(struct fore200e *fore200e)
 	fore200e->bus->write(0x02, fore200e->regs.sba.isr); /* XXX hardwired interrupt level */
 
 	/* get the supported DVMA burst sizes */
-	bursts = of_getintprop_default(op->node->parent, "burst-sizes", 0x00);
+	bursts = of_getintprop_default(op->dev.of_node->parent, "burst-sizes", 0x00);
 
 	if (sbus_can_dma_64bit())
 		sbus_set_sbus64(&op->dev, bursts);
@@ -820,18 +820,20 @@ static int __init fore200e_sba_prom_read(struct fore200e *fore200e, struct prom_
 	const u8 *prop;
 	int len;
 
-	prop = of_get_property(op->node, "madaddrlo2", &len);
+	prop = of_get_property(op->dev.of_node, "madaddrlo2", &len);
 	if (!prop)
 		return -ENODEV;
 	memcpy(&prom->mac_addr[4], prop, 4);
 
-	prop = of_get_property(op->node, "madaddrhi4", &len);
+	prop = of_get_property(op->dev.of_node, "madaddrhi4", &len);
 	if (!prop)
 		return -ENODEV;
 	memcpy(&prom->mac_addr[2], prop, 4);
 
-	prom->serial_number = of_getintprop_default(op->node, "serialnumber", 0);
-	prom->hw_revision = of_getintprop_default(op->node, "promversion", 0);
+	prom->serial_number = of_getintprop_default(op->dev.of_node,
+						    "serialnumber", 0);
+	prom->hw_revision = of_getintprop_default(op->dev.of_node,
+						  "promversion", 0);
     
 	return 0;
 }
@@ -841,10 +843,10 @@ static int fore200e_sba_proc_read(struct fore200e *fore200e, char *page)
 	struct of_device *op = fore200e->bus_dev;
 	const struct linux_prom_registers *regs;
 
-	regs = of_get_property(op->node, "reg", NULL);
+	regs = of_get_property(op->dev.of_node, "reg", NULL);
 
 	return sprintf(page, "   SBUS slot/device:\t\t%d/'%s'\n",
-		       (regs ? regs->which_io : 0), op->node->name);
+		       (regs ? regs->which_io : 0), op->dev.of_node->name);
 }
 #endif /* CONFIG_SBUS */
