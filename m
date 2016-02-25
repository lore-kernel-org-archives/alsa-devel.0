From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: add acpi_dev_present
Date: Thu, 25 Feb 2016 09:20:57 +0100
Message-ID: <1456388457-4957-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 82F77261507
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2016 09:20:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/acpi/acpi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index d7d6cb9..9fd9c86 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -33,4 +33,6 @@ acpi_get_devices(const char *HID,
 	return user_function(NULL, 0, context, NULL);
 }
 
+static inline bool acpi_dev_present(const char *hid) { return true; }
+
 #endif				/* __ACPI_H__ */
-- 
1.9.1
