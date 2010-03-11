From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 25/37] drivers/infiniband: use .dev.of_node
	instead of .node	in struct of_device
Date: Thu, 11 Mar 2010 11:06:06 -0700
Message-ID: <20100311180605.4824.3613.stgit__10900.7367319011$1268330948$gmane$org@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f203.google.com (mail-pz0-f203.google.com
	[209.85.222.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 64139103A48
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:06:10 +0100 (CET)
Received: by mail-pz0-f203.google.com with SMTP id 41so172871pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:06:10 -0800 (PST)
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

 drivers/infiniband/hw/ehca/ehca_main.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 129a6be..2639185 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -291,8 +291,9 @@ static int ehca_sense_attributes(struct ehca_shca *shca)
 	};
 
 	ehca_gen_dbg("Probing adapter %s...",
-		     shca->ofdev->node->full_name);
-	loc_code = of_get_property(shca->ofdev->node, "ibm,loc-code", NULL);
+		     shca->ofdev->dev.of_node->full_name);
+	loc_code = of_get_property(shca->ofdev->dev.of_node, "ibm,loc-code",
+				   NULL);
 	if (loc_code)
 		ehca_gen_dbg(" ... location lode=%s", loc_code);
 
@@ -720,16 +721,16 @@ static int __devinit ehca_probe(struct of_device *dev,
 	int ret, i, eq_size;
 	unsigned long flags;
 
-	handle = of_get_property(dev->node, "ibm,hca-handle", NULL);
+	handle = of_get_property(dev->dev.of_node, "ibm,hca-handle", NULL);
 	if (!handle) {
 		ehca_gen_err("Cannot get eHCA handle for adapter: %s.",
-			     dev->node->full_name);
+			     dev->dev.of_node->full_name);
 		return -ENODEV;
 	}
 
 	if (!(*handle)) {
 		ehca_gen_err("Wrong eHCA handle for adapter: %s.",
-			     dev->node->full_name);
+			     dev->dev.of_node->full_name);
 		return -ENODEV;
 	}
