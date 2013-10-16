From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH 1/2] thinkpad-acpi: Add mute and mic-mute LED functionality
Date: Wed, 16 Oct 2013 14:15:35 +0200
Message-ID: <1381925736-11399-2-git-send-email-david.henningsson@canonical.com>
References: <1381925736-11399-1-git-send-email-david.henningsson@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1381925736-11399-1-git-send-email-david.henningsson@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org, ibm-acpi@hmh.eng.br, alex.hung@canonical.com, hui.wang@canonical.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Questions / notes:

This patch supersedes the second of Alex Hung's patches posted earlier at
http://www.spinics.net/lists/platform-driver-x86/msg04673.html

Not sure if thinkpad_acpi should be dropped into include/linux
though, any better suggestion?

Should TPACPI_VERSION be increased because we added a new LED driver?

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 drivers/platform/x86/thinkpad_acpi.c |   94 +++++++++++++++++++++++++++++++++-
 include/linux/thinkpad_acpi.h        |   10 ++++
 2 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/thinkpad_acpi.h

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 03ca6c1..ecdfeae 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -23,7 +23,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#define TPACPI_VERSION "0.24"
+#define TPACPI_VERSION "0.25"
 #define TPACPI_SYSFS_VERSION 0x020700
 
 /*
@@ -88,6 +88,7 @@
 
 #include <linux/pci_ids.h>
 
+#include <linux/thinkpad_acpi.h>
 
 /* ThinkPad CMOS commands */
 #define TP_CMOS_VOLUME_DOWN	0
@@ -8350,6 +8351,93 @@ static struct ibm_struct fan_driver_data = {
 	.resume = fan_resume,
 };
 
+/*************************************************************************
+ * Mute LED subdriver
+ */
+
+#define MUTE_LED_INDEX 0
+#define MICMUTE_LED_INDEX 1
+
+static int mute_led_on_off(int whichled, int state)
+{
+	int output;
+	acpi_handle temp;
+
+	acpi_string m;
+	if (whichled == MICMUTE_LED_INDEX) {
+		state = state > 0 ? 2 : 0;
+		m = "MMTS";
+	} else {
+		state = state > 0 ? 1 : 0;
+		m = "SSMS";
+	}
+
+	if (!ACPI_SUCCESS(acpi_get_handle(hkey_handle, m, &temp))) {
+		pr_warn("Thinkpad ACPI has no %s interface.\n", m);
+		return -EIO;
+	}
+
+	if (!acpi_evalf(hkey_handle, &output, m, "dd", state))
+		return -EIO;
+
+	return 0;
+}
+
+static unsigned int mute_led_state;
+static unsigned int micmute_led_state;
+
+int tpacpi_mute_led_set(int on)
+{
+	int err;
+	int state = on ? 1 : 0;
+	if (mute_led_state < 0 || mute_led_state == state)
+		return mute_led_state;
+	err = mute_led_on_off(MUTE_LED_INDEX, state);
+	mute_led_state = err ? err : state;
+	return err;
+}
+EXPORT_SYMBOL(tpacpi_mute_led_set);
+
+int tpacpi_micmute_led_set(int on)
+{
+	int err;
+	int state = on ? 1 : 0;
+	if (micmute_led_state < 0 || micmute_led_state == state)
+		return micmute_led_state;
+	err = mute_led_on_off(MICMUTE_LED_INDEX, state);
+	micmute_led_state = err ? err : state;
+	return err;
+}
+EXPORT_SYMBOL(tpacpi_micmute_led_set);
+
+static int mute_led_init(struct ibm_init_struct *iibm)
+{
+	acpi_handle temp;
+
+	if (ACPI_SUCCESS(acpi_get_handle(hkey_handle, "MMTG", &temp)))
+		micmute_led_state = mute_led_on_off(MICMUTE_LED_INDEX, 0);
+	else
+		micmute_led_state = -ENODEV;
+
+	if (ACPI_SUCCESS(acpi_get_handle(hkey_handle, "GSMS", &temp)))
+		mute_led_state = mute_led_on_off(MUTE_LED_INDEX, 0);
+	else
+		mute_led_state = -ENODEV;
+
+	return 0;
+}
+
+static void mute_led_exit(void)
+{
+	tpacpi_mute_led_set(0);
+	tpacpi_micmute_led_set(0);
+}
+
+static struct ibm_struct mute_led_driver_data = {
+	.name = "mute_led",
+	.exit = mute_led_exit,
+};
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -8768,6 +8856,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = fan_init,
 		.data = &fan_driver_data,
 	},
+	{
+		.init = mute_led_init,
+		.data = &mute_led_driver_data,
+	},
 };
 
 static int __init set_ibm_param(const char *val, struct kernel_param *kp)
diff --git a/include/linux/thinkpad_acpi.h b/include/linux/thinkpad_acpi.h
new file mode 100644
index 0000000..9fecd15
--- /dev/null
+++ b/include/linux/thinkpad_acpi.h
@@ -0,0 +1,10 @@
+#ifndef __THINKPAD_ACPI_H__
+#define __THINKPAD_ACPI_H__
+
+/* These two functions return 0 if success, or negative error code
+   (e g -ENODEV if no led present) */
+
+int tpacpi_mute_led_set(int on);
+int tpacpi_micmute_led_set(int on);
+
+#endif
-- 
1.7.9.5
