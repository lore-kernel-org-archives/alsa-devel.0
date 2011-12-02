From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2/2] ASoC: fsl/powerpc: don't rely on the
	cell-index property
Date: Thu, 1 Dec 2011 19:52:47 -0600
Message-ID: <1322790767-25846-2-git-send-email-timur@freescale.com>
References: <1322790767-25846-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id BEC3C24589
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 02:52:57 +0100 (CET)
In-Reply-To: <1322790767-25846-1-git-send-email-timur@freescale.com>
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

Instead of using the 'cell-index' property in the I2C adapter node to
determine the adapter number, just query the i2c_adapter object directly.

Previously, the I2C nodes always appeared in cell-index order, so the
dynamic numbering coincided with the cell-index property.  With commit
ab827d97 ("powerpc/85xx: Rework P1022DS device tree"), the I2C nodes are
unintentionally reversed in the device tree, and so the machine driver
guesses the wrong I2C adapter number.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/mpc8610_hpcd.c |   13 ++++++++-----
 sound/soc/fsl/p1022_ds.c     |   13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 31af405..c3cbad0 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
+#include <linux/of_i2c.h>
 #include <sound/soc.h>
 #include <asm/fsl_guts.h>
 
@@ -249,8 +250,9 @@ static int get_parent_cell_index(struct device_node *np)
 static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 {
 	const u32 *iprop;
-	int bus, addr;
+	int addr;
 	char temp[DAI_NAME_SIZE];
+	struct i2c_client *i2c;
 
 	of_modalias_node(np, temp, DAI_NAME_SIZE);
 
@@ -260,11 +262,12 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 
 	addr = be32_to_cpup(iprop);
 
-	bus = get_parent_cell_index(np);
-	if (bus < 0)
-		return bus;
+	/* We need the adapter number */
+	i2c = of_find_i2c_device_by_node(np);
+	if (!i2c)
+		return -ENODEV;
 
-	snprintf(buf, len, "%s-codec.%u-%04x", temp, bus, addr);
+	snprintf(buf, len, "%s-codec.%u-%04x", temp, i2c->adapter->nr, addr);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 3091626..a5d4e80 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
+#include <linux/of_i2c.h>
 #include <sound/soc.h>
 #include <asm/fsl_guts.h>
 
@@ -252,8 +253,9 @@ static int get_parent_cell_index(struct device_node *np)
 static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 {
 	const u32 *iprop;
-	int bus, addr;
+	int addr;
 	char temp[DAI_NAME_SIZE];
+	struct i2c_client *i2c;
 
 	of_modalias_node(np, temp, DAI_NAME_SIZE);
 
@@ -263,11 +265,12 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 
 	addr = be32_to_cpup(iprop);
 
-	bus = get_parent_cell_index(np);
-	if (bus < 0)
-		return bus;
+	/* We need the adapter number */
+	i2c = of_find_i2c_device_by_node(np);
+	if (!i2c)
+		return -ENODEV;
 
-	snprintf(buf, len, "%s.%u-%04x", temp, bus, addr);
+	snprintf(buf, len, "%s.%u-%04x", temp, i2c->adapter->nr, addr);
 
 	return 0;
 }
-- 
1.7.4.4
