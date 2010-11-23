From: Kay Sievers <kay.sievers@vrfy.org>
Subject: [PATCH] alsa: support module on-demand loading for seq
	and timer
Date: Tue, 23 Nov 2010 11:42:44 +0100
Message-ID: <1290508964.1164.3.camel@yio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B0D8D103894
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 11:42:46 +0100 (CET)
Received: by bwz8 with SMTP id 8so7126348bwz.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 02:42:46 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: tiwai@suse.de, jkysela@redhat.com
List-Id: alsa-devel@alsa-project.org

From: Kay Sievers <kay.sievers@vrfy.org>
Subject: alsa: support module on-demand loading for seq and timer

If CONFIG_SND_DYNAMIC_MINORS is used, assign /dev/snd/seq and
/dev/snd/timer the usual static minors, and export specific
module aliases to generate udev module on-demand loading
instructions:

  $ cat /lib/modules/$(uname -r)/modules.devname
  # Device nodes to trigger on-demand module loading.
  microcode cpu/microcode c10:184
  fuse fuse c10:229
  ppp_generic ppp c108:0
  tun net/tun c10:200
  uinput uinput c10:223
  dm_mod mapper/control c10:236
  snd_timer snd/timer c116:33
  snd_seq snd/seq c116:1

The last two lines instruct udev to create device nodes, even
when the modules are not loaded at that time.

As soon as userspace accesses any of these nodes, the in-kernel
module-loader will load the module, and the device can be used.

The header file minor calculation needed to be simplified to
make __stringify() (supports only two indirections) in
the MODULE_ALIAS macro work.

This is part of systemd's effort to get rid of unconditional
module load instructions and needless init scripts.

Cc: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

diff --git a/include/sound/minors.h b/include/sound/minors.h
index a81798a..8f76420 100644
--- a/include/sound/minors.h
+++ b/include/sound/minors.h
@@ -31,8 +31,8 @@
 /* these minors can still be used for autoloading devices (/dev/aload*) */
 #define SNDRV_MINOR_CONTROL		0	/* 0 */
 #define SNDRV_MINOR_GLOBAL		1	/* 1 */
-#define SNDRV_MINOR_SEQUENCER		(SNDRV_MINOR_GLOBAL + 0 * 32)
-#define SNDRV_MINOR_TIMER		(SNDRV_MINOR_GLOBAL + 1 * 32)
+#define SNDRV_MINOR_SEQUENCER		1	/* SNDRV_MINOR_GLOBAL + 0 * 32 */
+#define SNDRV_MINOR_TIMER		33	/* SNDRV_MINOR_GLOBAL + 1 * 32 */
 
 #ifndef CONFIG_SND_DYNAMIC_MINORS
 						/* 2 - 3 (reserved) */
diff --git a/sound/core/seq/seq.c b/sound/core/seq/seq.c
index bf09a5a..119fddb6 100644
--- a/sound/core/seq/seq.c
+++ b/sound/core/seq/seq.c
@@ -32,6 +32,7 @@
 #include "seq_timer.h"
 #include "seq_system.h"
 #include "seq_info.h"
+#include <sound/minors.h>
 #include <sound/seq_device.h>
 
 #if defined(CONFIG_SND_SEQ_DUMMY_MODULE)
@@ -73,6 +74,9 @@ MODULE_PARM_DESC(seq_default_timer_subdevice, "The default timer subdevice numbe
 module_param(seq_default_timer_resolution, int, 0644);
 MODULE_PARM_DESC(seq_default_timer_resolution, "The default timer resolution in Hz.");
 
+MODULE_ALIAS_CHARDEV(CONFIG_SND_MAJOR, SNDRV_MINOR_SEQUENCER);
+MODULE_ALIAS("devname:snd/seq");
+
 /*
  *  INIT PART
  */
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 66691fe..1c7a3ef 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -188,14 +188,22 @@ static const struct file_operations snd_fops =
 };
 
 #ifdef CONFIG_SND_DYNAMIC_MINORS
-static int snd_find_free_minor(void)
+static int snd_find_free_minor(int type)
 {
 	int minor;
 
+	/* static minors for module auto loading */
+	if (type == SNDRV_DEVICE_TYPE_SEQUENCER)
+		return SNDRV_MINOR_SEQUENCER;
+	if (type == SNDRV_DEVICE_TYPE_TIMER)
+		return SNDRV_MINOR_TIMER;
+
 	for (minor = 0; minor < ARRAY_SIZE(snd_minors); ++minor) {
-		/* skip minors still used statically for autoloading devices */
-		if (SNDRV_MINOR_DEVICE(minor) == SNDRV_MINOR_CONTROL ||
-		    minor == SNDRV_MINOR_SEQUENCER)
+		/* skip static minors still used for module auto loading */
+		if (SNDRV_MINOR_DEVICE(minor) == SNDRV_MINOR_CONTROL)
+			continue;
+		if (minor == SNDRV_MINOR_SEQUENCER ||
+		    minor == SNDRV_MINOR_TIMER)
 			continue;
 		if (!snd_minors[minor])
 			return minor;
@@ -269,7 +277,7 @@ int snd_register_device_for_dev(int type, struct snd_card *card, int dev,
 	preg->private_data = private_data;
 	mutex_lock(&sound_mutex);
 #ifdef CONFIG_SND_DYNAMIC_MINORS
-	minor = snd_find_free_minor();
+	minor = snd_find_free_minor(type);
 #else
 	minor = snd_kernel_minor(type, card, dev);
 	if (minor >= 0 && snd_minors[minor])
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 13afb60..17df52a 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -52,6 +52,9 @@ MODULE_PARM_DESC(timer_limit, "Maximum global timers in system.");
 module_param(timer_tstamp_monotonic, int, 0444);
 MODULE_PARM_DESC(timer_tstamp_monotonic, "Use posix monotonic clock source for timestamps (default).");
 
+MODULE_ALIAS_CHARDEV(CONFIG_SND_MAJOR, SNDRV_MINOR_TIMER);
+MODULE_ALIAS("devname:snd/timer");
+
 struct snd_timer_user {
 	struct snd_timer_instance *timeri;
 	int tread;		/* enhanced read with timestamps and events */
