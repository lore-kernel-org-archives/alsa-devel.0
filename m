From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hdajackretask: Make sure codecs do not show up
	twice under 3.15 kernel
Date: Tue, 27 May 2014 09:12:36 +0200
Message-ID: <1401174756-10729-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E5D226554C
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 09:12:40 +0200 (CEST)
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

On a 3.15 based kernel, both "hdaudioC*D*" and "hwC*D*" shows up under
/sys/class/sound, and pointing to the same object. Make sure we only
match on the hwC*D* name to avoid duplicate entries.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hdajackretask/sysfs-pin-configs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hdajackretask/sysfs-pin-configs.c b/hdajackretask/sysfs-pin-configs.c
index 4044989..5bae0f9 100644
--- a/hdajackretask/sysfs-pin-configs.c
+++ b/hdajackretask/sysfs-pin-configs.c
@@ -20,8 +20,10 @@ int get_codec_name_list(codec_name_t* names, int entries)
         const gchar* dirname = g_dir_read_name(sysdir);
         if (!dirname)
             break;
+        /* Split e g "hwC0D1" into "hw", "0" and "1" */
         cd = g_strsplit_set(dirname, "CD", 9);
         ok = g_strv_length(cd) == 3;
+        ok &= strcmp(cd[0], "hw") == 0;
         if (ok) {
             gchar* filetest = g_strdup_printf("/sys/class/sound/%s/init_pin_configs", dirname);
             ok = g_file_test(filetest, G_FILE_TEST_IS_REGULAR);
-- 
1.9.1
