From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ALSA: sound_firmware: fix style issues
Date: Thu,  5 Jun 2014 14:12:26 +0200
Message-ID: <1401970346-9043-2-git-send-email-zonque@gmail.com>
References: <1401970346-9043-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 937D126565F
 for <alsa-devel@alsa-project.org>; Thu,  5 Jun 2014 14:12:35 +0200 (CEST)
Received: by mail-wi0-f174.google.com with SMTP id r20so10382874wiv.1
 for <alsa-devel@alsa-project.org>; Thu, 05 Jun 2014 05:12:34 -0700 (PDT)
In-Reply-To: <1401970346-9043-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix some style issues in sound/sound_firmware.c. No functional change.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/sound_firmware.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/sound_firmware.c b/sound/sound_firmware.c
index b155137..247858d 100644
--- a/sound/sound_firmware.c
+++ b/sound/sound_firmware.c
@@ -4,46 +4,47 @@
 #include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include "oss/sound_firmware.h"
 
 static int do_mod_firmware_load(const char *fn, char **fp)
 {
-	struct file* filp;
+	struct file *filp;
 	long l;
 	char *dp;
 	loff_t pos;
 
 	filp = filp_open(fn, 0, 0);
-	if (IS_ERR(filp))
-	{
+	if (IS_ERR(filp)) {
 		printk(KERN_INFO "Unable to load '%s'.\n", fn);
 		return 0;
 	}
+
 	l = i_size_read(file_inode(filp));
-	if (l <= 0 || l > 131072)
-	{
+	if (l <= 0 || l > 131072) {
 		printk(KERN_INFO "Invalid firmware '%s'\n", fn);
 		fput(filp);
 		return 0;
 	}
+
 	dp = vmalloc(l);
-	if (dp == NULL)
-	{
+	if (dp == NULL) {
 		printk(KERN_INFO "Out of memory loading '%s'.\n", fn);
 		fput(filp);
 		return 0;
 	}
+
 	pos = 0;
-	if (vfs_read(filp, dp, l, &pos) != l)
-	{
+	if (vfs_read(filp, dp, l, &pos) != l) {
 		printk(KERN_INFO "Failed to read '%s'.\n", fn);
 		vfree(dp);
 		fput(filp);
 		return 0;
 	}
+
 	fput(filp);
 	*fp = dp;
+
 	return (int) l;
 }
 
@@ -63,7 +64,7 @@ static int do_mod_firmware_load(const char *fn, char **fp)
  *	Caution: This API is not recommended. Firmware should be loaded via
  *	request_firmware.
  */
- 
+
 int mod_firmware_load(const char *fn, char **fp)
 {
 	int r;
-- 
1.9.3
