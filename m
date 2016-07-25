From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] sound: oss: Use kernel_read_file_from_path()
	for mod_firmware_load()
Date: Mon, 25 Jul 2016 15:45:15 +0200
Message-ID: <20160725134515.30888-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DF79265857
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2016 15:45:17 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C58F6ABBD
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2016 13:45:16 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since recently we have kernel_read_file_from_path(), and it's doing
the same thing as our own home-baked mod_firmware_load().  Let's use
the official API function and clean up the old code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/Makefile             |  1 -
 sound/oss/sound_firmware.h | 29 ++++++++++++++++-
 sound/sound_firmware.c     | 77 ----------------------------------------------
 3 files changed, 28 insertions(+), 79 deletions(-)
 delete mode 100644 sound/sound_firmware.c

diff --git a/sound/Makefile b/sound/Makefile
index 77320709fd26..c41bdf5fdf24 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -2,7 +2,6 @@
 #
 
 obj-$(CONFIG_SOUND) += soundcore.o
-obj-$(CONFIG_SOUND_PRIME) += sound_firmware.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ usb/ \
diff --git a/sound/oss/sound_firmware.h b/sound/oss/sound_firmware.h
index 0a0cbfdfb855..da4c67e005ed 100644
--- a/sound/oss/sound_firmware.h
+++ b/sound/oss/sound_firmware.h
@@ -1,2 +1,29 @@
-extern int mod_firmware_load(const char *fn, char **fp);
+#include <linux/fs.h>
 
+/**
+ *	mod_firmware_load - load sound driver firmware
+ *	@fn: filename
+ *	@fp: return for the buffer.
+ *
+ *	Load the firmware for a sound module (up to 128K) into a buffer.
+ *	The buffer is returned in *fp. It is allocated with vmalloc so is
+ *	virtually linear and not DMAable. The caller should free it with
+ *	vfree when finished.
+ *
+ *	The length of the buffer is returned on a successful load, the
+ *	value zero on a failure.
+ *
+ *	Caution: This API is not recommended. Firmware should be loaded via
+ *	request_firmware.
+ */
+static inline int mod_firmware_load(const char *fn, char **fp)
+{
+	loff_t size;
+	int err;
+
+	err = kernel_read_file_from_path((char *)fn, (void **)fp, &size,
+					 131072, READING_FIRMWARE);
+	if (err < 0)
+		return 0;
+	return size;
+}
diff --git a/sound/sound_firmware.c b/sound/sound_firmware.c
deleted file mode 100644
index 026347643c81..000000000000
--- a/sound/sound_firmware.c
+++ /dev/null
@@ -1,77 +0,0 @@
-#include <linux/vmalloc.h>
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <asm/uaccess.h>
-#include "oss/sound_firmware.h"
-
-static int do_mod_firmware_load(const char *fn, char **fp)
-{
-	struct file* filp;
-	long l;
-	char *dp;
-
-	filp = filp_open(fn, 0, 0);
-	if (IS_ERR(filp))
-	{
-		printk(KERN_INFO "Unable to load '%s'.\n", fn);
-		return 0;
-	}
-	l = i_size_read(file_inode(filp));
-	if (l <= 0 || l > 131072)
-	{
-		printk(KERN_INFO "Invalid firmware '%s'\n", fn);
-		fput(filp);
-		return 0;
-	}
-	dp = vmalloc(l);
-	if (dp == NULL)
-	{
-		printk(KERN_INFO "Out of memory loading '%s'.\n", fn);
-		fput(filp);
-		return 0;
-	}
-	if (kernel_read(filp, 0, dp, l) != l)
-	{
-		printk(KERN_INFO "Failed to read '%s'.\n", fn);
-		vfree(dp);
-		fput(filp);
-		return 0;
-	}
-	fput(filp);
-	*fp = dp;
-	return (int) l;
-}
-
-/**
- *	mod_firmware_load - load sound driver firmware
- *	@fn: filename
- *	@fp: return for the buffer.
- *
- *	Load the firmware for a sound module (up to 128K) into a buffer.
- *	The buffer is returned in *fp. It is allocated with vmalloc so is
- *	virtually linear and not DMAable. The caller should free it with
- *	vfree when finished.
- *
- *	The length of the buffer is returned on a successful load, the
- *	value zero on a failure.
- *
- *	Caution: This API is not recommended. Firmware should be loaded via
- *	request_firmware.
- */
- 
-int mod_firmware_load(const char *fn, char **fp)
-{
-	int r;
-	mm_segment_t fs = get_fs();
-
-	set_fs(get_ds());
-	r = do_mod_firmware_load(fn, fp);
-	set_fs(fs);
-	return r;
-}
-EXPORT_SYMBOL(mod_firmware_load);
-
-MODULE_LICENSE("GPL");
-- 
2.9.2
