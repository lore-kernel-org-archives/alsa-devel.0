From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 10/37] drivers/video: use .dev.of_node instead
	of .node in	struct of_device
Date: Thu, 11 Mar 2010 11:04:43 -0700
Message-ID: <20100311180442.4824.14836.stgit@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A3801039FA
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 19:04:46 +0100 (CET)
Received: by pvg12 with SMTP id 12so108867pvg.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 10:04:46 -0800 (PST)
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

 drivers/video/cg6.c |    2 +-
 drivers/video/ffb.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 0d47c60..978c15f 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -741,7 +741,7 @@ static void cg6_unmap_regs(struct of_device *op, struct fb_info *info,
 static int __devinit cg6_probe(struct of_device *op,
 				const struct of_device_id *match)
 {
-	struct device_node *dp = op->node;
+	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
 	struct cg6_par *par;
 	int linebytes, err;
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 9dbb964..be0c982 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -897,7 +897,7 @@ static void ffb_init_fix(struct fb_info *info)
 static int __devinit ffb_probe(struct of_device *op,
 			       const struct of_device_id *match)
 {
-	struct device_node *dp = op->node;
+	struct device_node *dp = op->dev.of_node;
 	struct ffb_fbc __iomem *fbc;
 	struct ffb_dac __iomem *dac;
 	struct fb_info *info;
