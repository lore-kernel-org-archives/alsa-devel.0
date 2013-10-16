From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 1/3] thinkpad-acpi: Add mute and mic-mute LED functionality
Date: Wed, 16 Oct 2013 23:10:31 +0200
Message-ID: <1381957833-13788-2-git-send-email-david.henningsson@canonical.com>
References: <1381957833-13788-1-git-send-email-david.henningsson@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1381957833-13788-1-git-send-email-david.henningsson@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org, ibm-acpi@hmh.eng.br, alex.hung@canonical.com, hui.wang@canonical.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The LEDs are currently not visible to userspace, for security
reasons. They are exported through thinkpad_acpi.h for use by the
snd-hda-intel driver.

Thanks to Alex Hung <alex.hung@canonical.com> and Takashi Iwai
<tiwai@suse.de> for writing parts of this patch.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Documentation/laptops/thinkpad-acpi.txt |    7 ++-
 drivers/platform/x86/thinkpad_acpi.c    |   92 ++++++++++++++++++++++++++++++-
 include/linux/thinkpad_acpi.h           |   15 +++++
 3 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/thinkpad_acpi.h

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 86c5236..fc04c14 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1,7 +1,7 @@
 		     ThinkPad ACPI Extras Driver
 
-                            Version 0.24
-                        December 11th,  2009
+                            Version 0.25
+                        October 16th,  2013
 
                Borislav Deianov <borislav@users.sf.net>
              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
@@ -741,6 +741,9 @@ compiled with the CONFIG_THINKPAD_ACPI_UNSAFE_LEDS option enabled.
 Distributions must never enable this option.  Individual users that
 are aware of the consequences are welcome to enabling it.
 
+Audio mute and microphone mute LEDs are supported, but currently not
+visible to userspace. They are used by the snd-hda-intel audio driver.
+
 procfs notes:
 
 The available commands are:
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 03ca6c1..0b7efb2 100644
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
@@ -8350,6 +8351,91 @@ static struct ibm_struct fan_driver_data = {
 	.resume = fan_resume,
 };
 
+/*************************************************************************
+ * Mute LED subdriver
+ */
+
+
+struct tp_led_table {
+	acpi_string name;
+	int on_value;
+	int off_value;
+	int state;
+};
+
+static struct tp_led_table led_tables[] = {
+	[TPACPI_LED_MUTE] = {
+		.name = "SSMS",
+		.on_value = 1,
+		.off_value = 0,
+	},
+	[TPACPI_LED_MICMUTE] = {
+		.name = "MMTS",
+		.on_value = 2,
+		.off_value = 0,
+	},
+};
+
+static int mute_led_on_off(struct tp_led_table *t, bool state)
+{
+	acpi_handle temp;
+	int output;
+
+	if (!ACPI_SUCCESS(acpi_get_handle(hkey_handle, t->name, &temp))) {
+		pr_warn("Thinkpad ACPI has no %s interface.\n", t->name);
+		return -EIO;
+	}
+
+	if (!acpi_evalf(hkey_handle, &output, t->name, "dd",
+			state ? t->on_value : t->off_value))
+		return -EIO;
+
+	t->state = state;
+	return state;
+}
+
+int tpacpi_led_set(int whichled, bool on)
+{
+	struct tp_led_table *t;
+
+	if (whichled < 0 || whichled >= TPACPI_LED_MAX)
+		return -EINVAL;
+
+	t = &led_tables[whichled];
+	if (t->state < 0 || t->state == on)
+		return t->state;
+	return mute_led_on_off(t, on);
+}
+EXPORT_SYMBOL_GPL(tpacpi_led_set);
+
+static int mute_led_init(struct ibm_init_struct *iibm)
+{
+	acpi_handle temp;
+	int i;
+
+	for (i = 0; i < TPACPI_LED_MAX; i++) {
+		struct tp_led_table *t = &led_tables[i];
+		if (ACPI_SUCCESS(acpi_get_handle(hkey_handle, t->name, &temp)))
+			mute_led_on_off(t, false);
+		else
+			t->state = -ENODEV;
+	}
+	return 0;
+}
+
+static void mute_led_exit(void)
+{
+	int i;
+
+	for (i = 0; i < TPACPI_LED_MAX; i++)
+		tpacpi_led_set(i, false);
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
@@ -8768,6 +8854,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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
index 0000000..361de59
--- /dev/null
+++ b/include/linux/thinkpad_acpi.h
@@ -0,0 +1,15 @@
+#ifndef __THINKPAD_ACPI_H__
+#define __THINKPAD_ACPI_H__
+
+/* These two functions return 0 if success, or negative error code
+   (e g -ENODEV if no led present) */
+
+enum {
+	TPACPI_LED_MUTE,
+	TPACPI_LED_MICMUTE,
+	TPACPI_LED_MAX,
+};
+
+int tpacpi_led_set(int whichled, bool on);
+
+#endif
-- 
1.7.9.5
