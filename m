From: Alexander Maassen <outsider@key2peace.org>
Subject: alsa-drivers1.0.0rc2 won't compile on stock 2.6.1rc2 kernel - fixed
 it
Date: Wed, 07 Jan 2004 20:35:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FFC5F92.9000808@key2peace.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040206050605050507010605"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040206050605050507010605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I had several issues getting alsa to compile and to load correctly, 
after some debugging and lots of coffee I've been able to fix those.
Included is a unified diff so you all can enjoy the work in case you 
have the same error.

Kind regards,
Alexander Maassen

--------------040206050605050507010605
Content-Type: text/plain;
 name="alsa-driver-1.0.0rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver-1.0.0rc2.diff"

diff -burd alsa-driver-1.0.0rc2/acore/memory_wrapper.c alsa-driver-1.0.0rc2.new/acore/memory_wrapper.c
--- alsa-driver-1.0.0rc2/acore/memory_wrapper.c	2003-11-10 18:32:37.000000000 +0100
+++ alsa-driver-1.0.0rc2.new/acore/memory_wrapper.c	2004-01-07 20:00:10.000000000 +0100
@@ -21,6 +21,10 @@
 #endif
 #endif
 
+#ifndef VMALLOC_VMADDR
+#define VMALLOC_VMADDR(x) ((unsigned long)(x))
+#endif
+
 /* vmalloc_to_page wrapper */
 #ifndef CONFIG_HAVE_VMALLOC_TO_PAGE
 #include <linux/highmem.h>
@@ -38,7 +42,11 @@
 #endif
 	pgd = pgd_offset(&init_mm, lpage);
 	pmd = pmd_offset(pgd, lpage);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+	pte = pte_offset_kernel(pmd, lpage);
+#else
 	pte = pte_offset(pmd, lpage);
+#endif
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
 	page = virt_to_page(pte_page(*pte));
 #else
 
diff -burd alsa-driver-1.0.0rc2/acore/sgbuf.c alsa-driver-1.0.0rc2.new/acore/sgbuf.c
--- alsa-driver-1.0.0rc2/acore/sgbuf.c	2003-11-10 18:32:37.000000000 +0100
+++ alsa-driver-1.0.0rc2.new/acore/sgbuf.c	2004-01-07 20:01:00.000000000 +0100
@@ -44,7 +44,11 @@
 	lpage = VMALLOC_VMADDR(pageptr);
 	pgd = pgd_offset_k(lpage);
 	pmd = pmd_offset(pgd, lpage);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
+	pte = pte_offset_kernel(pmd, lpage);
+#else
 	pte = pte_offset(pmd, lpage);
+#endif
 	return (void *)pte_page(*pte);
 }    
 #endif
 
diff -burd alsa-driver-1.0.0rc2/include/adriver.h alsa-driver-1.0.0rc2.new/include/adriver.h
--- alsa-driver-1.0.0rc2/include/adriver.h	2003-11-20 14:23:27.000000000 +0100
+++ alsa-driver-1.0.0rc2.new/include/adriver.h	2004-01-07 19:04:43.000000000 +0100
@@ -128,6 +128,7 @@
 #define need_resched() (current->need_resched)
 #endif
 #ifndef CONFIG_HAVE_PDE
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 1)
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 static inline struct proc_dir_entry *PDE(const struct inode *inode)
@@ -135,6 +136,7 @@
 	return (struct proc_dir_entry *) inode->u.generic_ip;
 }
 #endif
+#endif
 #ifndef cond_resched
 #define cond_resched() \
 	do { \

--------------040206050605050507010605--



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
