From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 24/37] drivers/char: use .dev.of_node instead
	of .node in	struct of_device
Date: Thu, 11 Mar 2010 11:06:00 -0700
Message-ID: <20100311180600.4824.44001.stgit__12451.7950731844$1268330934$gmane$org@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 77B02103A41
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:06:03 +0100 (CET)
Received: by mail-pz0-f203.google.com with SMTP id 41so172871pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:06:03 -0800 (PST)
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

 drivers/char/hw_random/n2-drv.c     |    2 +-
 drivers/char/hw_random/pasemi-rng.c |    2 +-
 drivers/char/ipmi/ipmi_si_intf.c    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index 9b3e09c..4d05003 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -660,7 +660,7 @@ static int __devinit n2rng_probe(struct of_device *op,
 				np->hvapi_major);
 			goto out_hvapi_unregister;
 		}
-		np->num_units = of_getintprop_default(op->node,
+		np->num_units = of_getintprop_default(op->dev.of_node,
 						      "rng-#units", 0);
 		if (!np->num_units) {
 			dev_err(&op->dev, "VF RNG lacks rng-#units property\n");
diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index 7fa61dd..b213855 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -98,7 +98,7 @@ static int __devinit rng_probe(struct of_device *ofdev,
 			       const struct of_device_id *match)
 {
 	void __iomem *rng_regs;
-	struct device_node *rng_np = ofdev->node;
+	struct device_node *rng_np = ofdev->dev.of_node;
 	struct resource res;
 	int err = 0;
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 176f175..45305f2 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2406,7 +2406,7 @@ static int __devinit ipmi_of_probe(struct of_device *dev,
 	struct smi_info *info;
 	struct resource resource;
 	const int *regsize, *regspacing, *regshift;
-	struct device_node *np = dev->node;
+	struct device_node *np = dev->dev.of_node;
 	int ret;
 	int proplen;
 
@@ -2462,7 +2462,7 @@ static int __devinit ipmi_of_probe(struct of_device *dev,
 	info->io.regspacing	= regspacing ? *regspacing : DEFAULT_REGSPACING;
 	info->io.regshift	= regshift ? *regshift : 0;
 
-	info->irq		= irq_of_parse_and_map(dev->node, 0);
+	info->irq		= irq_of_parse_and_map(dev->dev.of_node, 0);
 	info->dev		= &dev->dev;
 
 	dev_dbg(&dev->dev, "addr 0x%lx regsize %d spacing %d irq %x\n",
