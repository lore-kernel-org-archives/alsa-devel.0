From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] Fix compiler warnings and magic numbers in sscape
Date: Sat, 11 Oct 2003 23:51:07 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310112251.h9BMp8ie014756@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm not entirely sure why this change was made because the microcode structure was never being copied
onto the kernel stack. However, there is certainly no need for the magic number of 65536 to be included
everywhere. There was also a compiler warning in the sscape_ctl tool.

Cheers,
Chris

Index: alsa-kernel/isa/sscape.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/sscape.c,v
retrieving revision 1.5
diff -u -u -r1.5 sscape.c
--- alsa-kernel/isa/sscape.c	25 Sep 2003 18:55:43 -0000	1.5
+++ alsa-kernel/isa/sscape.c	11 Oct 2003 22:44:17 -0000
@@ -616,10 +616,10 @@
 	 */
 	if (get_user(code, &mc->code))
 		return -EFAULT;
-	if ((err = verify_area(VERIFY_READ, code, 65536)) != 0)
+	if ((err = verify_area(VERIFY_READ, code, SSCAPE_MICROCODE_SIZE)) != 0)
 		return err;
 
-	if ((ret = upload_dma_data(sscape, code, 65536)) == 0) {
+	if ((ret = upload_dma_data(sscape, code, SSCAPE_MICROCODE_SIZE)) == 0) {
 		snd_printk(KERN_INFO "sscape: MIDI firmware loaded\n");
 	}
 
Index: alsa-kernel/include/sscape_ioctl.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/sscape_ioctl.h,v
retrieving revision 1.2
diff -u -u -r1.2 sscape_ioctl.h
--- alsa-kernel/include/sscape_ioctl.h	25 Sep 2003 18:55:43 -0000	1.2
+++ alsa-kernel/include/sscape_ioctl.h	11 Oct 2003 22:45:06 -0000
@@ -8,9 +8,11 @@
   unsigned version;
 };
 
+#define SSCAPE_MICROCODE_SIZE  65536
+
 struct sscape_microcode
 {
-  unsigned char *code;	/* 65536 chars */
+  unsigned char *code;
 };
 
 #define SND_SSCAPE_LOAD_BOOTB  _IOWR('P', 100, struct sscape_bootblock)
Index: alsa-tools/sscape_ctl/sscape_ctl.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/sscape_ctl/sscape_ctl.c,v
retrieving revision 1.3
diff -u -u -r1.3 sscape_ctl.c
--- alsa-tools/sscape_ctl/sscape_ctl.c	25 Sep 2003 19:52:14 -0000	1.3
+++ alsa-tools/sscape_ctl/sscape_ctl.c	11 Oct 2003 22:45:54 -0000
@@ -14,7 +14,7 @@
 
 const char default_dir[] = "/sndscape";
 const char scope[] = "scope.cod";
-char _microcode[65536];
+unsigned char _microcode[SSCAPE_MICROCODE_SIZE];
 
 static void
 show_usage(void)
@@ -205,7 +205,7 @@
     struct sscape_bootblock  boot;
     struct sscape_microcode  microcode;
 
-    microcode.code = &_microcode;
+    microcode.code = _microcode;
     if ((len = get_directory(directory, filename, sizeof(filename))) == 0)
     {
       fprintf(stderr, "Invalid directory - pathname too long\n");


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
