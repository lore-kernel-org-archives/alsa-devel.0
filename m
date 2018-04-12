From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3 2/3] platform/x86: dell-*: Add interface for
	switchable graphics status query
Date: Thu, 12 Apr 2018 18:42:38 +0800
Message-ID: <20180412104239.25584-2-kai.heng.feng@canonical.com>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B23526718B
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 12:42:59 +0200 (CEST)
In-Reply-To: <20180412104239.25584-1-kai.heng.feng@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mjg59@srcf.ucam.org, pali.rohar@gmail.com, dvhart@infradead.org, andy@infradead.org, mario.limonciello@dell.com, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On some Dell platforms, there's a BIOS option "Enable Switchable
Graphics". This information is useful if we want to do different things
based on this value, e.g. disable unused audio controller that comes
with the discrete graphics.

Cc: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3: Simplify dell_switchable_gfx_is_enabled() by returning bool instead
    of error code.
    Use DMI_DEV_TYPE_OEM_STRING to match Dell System.

v2: Mario suggested to squash the HDA part into the same series.

 drivers/platform/x86/dell-laptop.c      | 17 +++++++++++++++++
 drivers/platform/x86/dell-smbios-base.c |  2 ++
 drivers/platform/x86/dell-smbios.h      |  2 ++
 include/linux/dell-common.h             |  1 +
 4 files changed, 22 insertions(+)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 8ba820e6c3d0..033a27b190cc 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -2116,6 +2116,23 @@ int dell_micmute_led_set(int state)
 }
 EXPORT_SYMBOL_GPL(dell_micmute_led_set);
 
+bool dell_switchable_gfx_is_enabled(void)
+{
+	struct calling_interface_buffer buffer;
+	struct calling_interface_token *token;
+
+	token = dell_smbios_find_token(SWITCHABLE_GRAPHICS_ENABLE);
+	if (!token)
+		return false;
+
+	dell_fill_request(&buffer, token->location, 0, 0, 0);
+	if (dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD))
+		return false;
+
+	return !!buffer.output[1];
+}
+EXPORT_SYMBOL_GPL(dell_switchable_gfx_is_enabled);
+
 static int __init dell_init(void)
 {
 	struct calling_interface_token *token;
diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 33fb2a20458a..881ce42f0ca7 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -86,6 +86,8 @@ struct token_range {
 static struct token_range token_whitelist[] = {
 	/* used by userspace: fwupdate */
 	{CAP_SYS_ADMIN,	CAPSULE_EN_TOKEN,	CAPSULE_DIS_TOKEN},
+	/* can indicate to userspace Switchable Graphics enable status */
+	{CAP_SYS_ADMIN,	SWITCHABLE_GRAPHICS_ENABLE,	SWITCHABLE_GRAPHICS_DISABLE},
 	/* can indicate to userspace that WMI is needed */
 	{0x0000,	WSMT_EN_TOKEN,		WSMT_DIS_TOKEN}
 };
diff --git a/drivers/platform/x86/dell-smbios.h b/drivers/platform/x86/dell-smbios.h
index d8adaf959740..7863e6a7cff8 100644
--- a/drivers/platform/x86/dell-smbios.h
+++ b/drivers/platform/x86/dell-smbios.h
@@ -37,6 +37,8 @@
 #define KBD_LED_AUTO_100_TOKEN	0x02F6
 #define GLOBAL_MIC_MUTE_ENABLE	0x0364
 #define GLOBAL_MIC_MUTE_DISABLE	0x0365
+#define SWITCHABLE_GRAPHICS_ENABLE	0x037A
+#define SWITCHABLE_GRAPHICS_DISABLE	0x037B
 
 struct notifier_block;
 
diff --git a/include/linux/dell-common.h b/include/linux/dell-common.h
index 37e4b614dd74..1a90bc9a3bea 100644
--- a/include/linux/dell-common.h
+++ b/include/linux/dell-common.h
@@ -3,5 +3,6 @@
 #define __DELL_COMMON_H__
 
 int dell_micmute_led_set(int on);
+bool dell_switchable_gfx_is_enabled(void);
 
 #endif
-- 
2.17.0
