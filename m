From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 34/37] sound/sparc: use .dev.of_node instead of
	.node in	struct of_device
Date: Thu, 11 Mar 2010 11:06:55 -0700
Message-ID: <20100311180655.4824.33693.stgit@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 0560D1039E0
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:06:58 +0100 (CET)
Received: by mail-pz0-f203.google.com with SMTP id 41so172871pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:06:58 -0800 (PST)
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

 sound/sparc/cs4231.c |    6 +++---
 sound/sparc/dbri.c   |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 8d13d93..14cb87c 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -2076,12 +2076,12 @@ static int __devinit cs4231_ebus_probe(struct of_device *op, const struct of_dev
 static int __devinit cs4231_probe(struct of_device *op, const struct of_device_id *match)
 {
 #ifdef EBUS_SUPPORT
-	if (!strcmp(op->node->parent->name, "ebus"))
+	if (!strcmp(op->dev.of_node->parent->name, "ebus"))
 		return cs4231_ebus_probe(op, match);
 #endif
 #ifdef SBUS_SUPPORT
-	if (!strcmp(op->node->parent->name, "sbus") ||
-	    !strcmp(op->node->parent->name, "sbi"))
+	if (!strcmp(op->dev.of_node->parent->name, "sbus") ||
+	    !strcmp(op->dev.of_node->parent->name, "sbi"))
 		return cs4231_sbus_probe(op, match);
 #endif
 	return -ENODEV;
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 1d2e51b..2734c36 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2650,7 +2650,7 @@ static int __devinit dbri_probe(struct of_device *op, const struct of_device_id
 
 	printk(KERN_INFO "audio%d at %p (irq %d) is DBRI(%c)+CS4215(%d)\n",
 	       dev, dbri->regs,
-	       dbri->irq, op->node->name[9], dbri->mm.version);
+	       dbri->irq, op->dev.of_node->name[9], dbri->mm.version);
 	dev++;
 
 	return 0;
