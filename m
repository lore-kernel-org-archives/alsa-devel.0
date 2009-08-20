From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 3/4] tlv320aic3x: fixup board device changes
Date: Thu, 20 Aug 2009 22:50:42 +0100
Message-ID: <20090820215121.950753888@fluff.org>
References: <20090820215039.380849394@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ben-laptop (unknown [78.146.176.60])
	by alsa0.perex.cz (Postfix) with ESMTP id D715E243C7
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 23:52:59 +0200 (CEST)
Content-Disposition: inline;
	filename=asoc-simtec-tlv320aic33-dev-tmp-board.patch
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Fixup the device changes by modifying the files that we just removed the
explicit device creation from with i2c_register_board_info() until this
can be moved into the relevant board files.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 sound/soc/davinci/davinci-evm.c |   10 ++++++++++
 sound/soc/omap/n810.c           |   10 ++++++++++
 sound/soc/s6000/s6105-ipcam.c   |   10 ++++++++++
 3 files changed, 30 insertions(+)

Index: b/sound/soc/s6000/s6105-ipcam.c
===================================================================
--- a/sound/soc/s6000/s6105-ipcam.c	2009-08-20 08:38:01.000000000 +0100
+++ b/sound/soc/s6000/s6105-ipcam.c	2009-08-20 08:45:26.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/i2c.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -209,10 +210,19 @@ static struct s6000_snd_platform_data __
 
 static struct platform_device *s6105_snd_device;
 
+/* temporary i2c device creation until this can be moved into the machine
+ * support file.
+*/
+static struct i2c_board_info i2c_device[] = {
+	{ I2C_BOARD_INFO("tlv320aic33", 0x18), }
+};
+
 static int __init s6105_init(void)
 {
 	int ret;
 
+	i2c_register_board_info(0, i2c_device, ARRAY_SIZE(i2c_device));
+
 	s6105_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!s6105_snd_device)
 		return -ENOMEM;
Index: b/sound/soc/davinci/davinci-evm.c
===================================================================
--- a/sound/soc/davinci/davinci-evm.c	2009-08-20 08:38:01.000000000 +0100
+++ b/sound/soc/davinci/davinci-evm.c	2009-08-20 08:45:26.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/i2c.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -249,6 +250,13 @@ static struct snd_soc_device da850_evm_s
 
 static struct platform_device *evm_snd_device;
 
+/* temporary i2c device creation until this can be moved into the machine
+ * support file.
+*/
+static struct i2c_board_info i2c_device[] = {
+	{ I2C_BOARD_INFO("tlv320aic33", 0x1b), }
+};
+
 static int __init evm_init(void)
 {
 	struct snd_soc_device *evm_snd_dev_data;
@@ -273,6 +281,8 @@ static int __init evm_init(void)
 	} else
 		return -EINVAL;
 
+	i2c_register_board_info(1, i2c_device, ARRAY_SIZE(i2c_device));
+
 	evm_snd_device = platform_device_alloc("soc-audio", index);
 	if (!evm_snd_device)
 		return -ENOMEM;
Index: b/sound/soc/omap/n810.c
===================================================================
--- a/sound/soc/omap/n810.c	2009-08-20 08:38:01.000000000 +0100
+++ b/sound/soc/omap/n810.c	2009-08-20 08:45:26.000000000 +0100
@@ -22,6 +22,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -335,6 +336,13 @@ static struct snd_soc_device n810_snd_de
 
 static struct platform_device *n810_snd_device;
 
+/* temporary i2c device creation until this can be moved into the machine
+ * support file.
+*/
+static struct i2c_board_info i2c_device[] = {
+	{ I2C_BOARD_INFO("tlv320aic3x", 0x1b), }
+};
+
 static int __init n810_soc_init(void)
 {
 	int err;
@@ -343,6 +351,8 @@ static int __init n810_soc_init(void)
 	if (!(machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
 		return -ENODEV;
 
+	i2c_register_board_info(1, i2c_device, ARRAY_SIZE(i2c_device));
+
 	n810_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!n810_snd_device)
 		return -ENOMEM;

-- 
