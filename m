From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC: fsl_ssi: properly initialize the sysfs
	attribute object
Date: Mon, 14 Nov 2011 16:35:26 -0600
Message-ID: <1321310126-12614-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 551722446E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 23:36:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit 6992f533 ("sysfs: Use one lockdep class per sysfs attribute")
requires 'struct attribute' objects to be initialized with sysfs_attr_init().

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0268cf9..83c4bd5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -694,6 +694,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 
 	/* Initialize the the device_attribute structure */
 	dev_attr = &ssi_private->dev_attr;
+	sysfs_attr_init(&dev_attr->attr);
 	dev_attr->attr.name = "statistics";
 	dev_attr->attr.mode = S_IRUGO;
 	dev_attr->show = fsl_sysfs_ssi_show;
-- 
1.7.3.4
