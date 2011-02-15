From: tapio.vihuri@nokia.com
Subject: [PATCH v7 2/2] ECI: adding platform data for ECI driver
Date: Tue, 15 Feb 2011 15:12:00 +0200
Message-ID: <1297775520-1993-3-git-send-email-tapio.vihuri@nokia.com>
References: <1297775520-1993-1-git-send-email-tapio.vihuri@nokia.com>
	<1297775520-1993-2-git-send-email-tapio.vihuri@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id D68C2103868
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 14:12:29 +0100 (CET)
In-Reply-To: <1297775520-1993-2-git-send-email-tapio.vihuri@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dmitry.torokhov@gmail.com
Cc: randy.dunlap@oracle.com, alsa-devel@alsa-project.org, samu.p.onkalo@nokia.com, peter.ujfalusi@nokia.com, linux-kernel@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: alsa-devel@alsa-project.org

From: Tapio Vihuri <tapio.vihuri@nokia.com>

Gives platform data for ECI accessory input driver.

Signed-off-by: Tapio Vihuri <tapio.vihuri@nokia.com>
---
 arch/x86/platform/mrst/mrst.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
index ea6529e..e9cec91 100644
--- a/arch/x86/platform/mrst/mrst.c
+++ b/arch/x86/platform/mrst/mrst.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/input/eci.h>
 
 #include <asm/setup.h>
 #include <asm/mpspec_def.h>
@@ -478,6 +479,30 @@ static void __init *no_platform_data(void *info)
 	return NULL;
 }
 
+/*
+ * This is just example, should be implented in platform audio driver,
+ * ie. sound/...
+ * Then audio driver can call like hsmic_event->event(hsmic_event->private, 0);
+ * to set hsmic bias off
+ */
+static struct audio_hsmic_event *hsmic_event;
+static void mrst_register_hsmic_event_cb(struct audio_hsmic_event *event)
+{
+	hsmic_event = event;
+}
+EXPORT_SYMBOL(mrst_register_hsmic_event_cb);
+
+static void *eci_platform_data_init(void *info)
+{
+	static struct eci_platform_data mrst_eci_data = {
+		.eci_rst_gpio = GPIO_ECI_RSTn,
+		.eci_sw_ctrl_gpio = GPIO_ECI_SW_CTRL,
+		.eci_int_gpio = GPIO_ECI_INT,
+		.register_hsmic_event_cb = mrst_register_hsmic_event_cb,
+	};
+	return &mrst_eci_data;
+}
+
 static const struct devs_id __initconst device_ids[] = {
 	{"pmic_gpio", SFI_DEV_TYPE_SPI, 1, &pmic_gpio_platform_data},
 	{"spi_max3111", SFI_DEV_TYPE_SPI, 0, &max3111_platform_data},
@@ -487,6 +512,7 @@ static const struct devs_id __initconst device_ids[] = {
 	{"i2c_accel", SFI_DEV_TYPE_I2C, 0, &lis331dl_platform_data},
 	{"pmic_audio", SFI_DEV_TYPE_IPC, 1, &no_platform_data},
 	{"msic_audio", SFI_DEV_TYPE_IPC, 1, &no_platform_data},
+	{"eci_ctrl", SFI_DEV_TYPE_I2C, 0, &eci_platform_data_init},
 	{},
 };
 
@@ -659,6 +685,12 @@ static void __init sfi_handle_i2c_dev(int bus, struct i2c_board_info *i2c_info)
 		i2c_register_board_info(bus, i2c_info, 1);
  }
 
+static int __init mrst_eci_init(void)
+{
+	/* Turn on vprog2 */
+	return intel_scu_ipc_iowrite8(AvP_MSIC_VPROG2, AvP_MSIC_VPROG2_2V5_ON);
+}
+device_initcall(mrst_eci_init);
 
 static int __init sfi_parse_devs(struct sfi_table_header *table)
 {
-- 
1.6.5
