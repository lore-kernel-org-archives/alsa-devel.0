From: ben.stanley@exemail.com.au
Subject: [PATCH] autoconf problems
Date: Tue, 1 Jul 2008 13:47:56 +1000 (EST)
Message-ID: <4548.125.7.7.9.1214884076.squirrel@webmail.exetel.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acorn.exetel.com.au (acorn.exetel.com.au [220.233.0.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A6C5247AE
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 05:48:00 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=webmail.exetel.com.au)
	by acorn.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <ben.stanley@exemail.com.au>) id 1KDWqS-0000Xa-Oc
	for alsa-devel@alsa-project.org; Tue, 01 Jul 2008 13:47:56 +1000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear List,

A month ago I was having trouble building alsa-drivers on RHEL5.

The following patch fixes the problems.

The root of the problem is that including the header
include/linux/config.h produces a warning on RHEL5. This interferes with
several autoconf tests that treat warnings as errors. Therefore it seemed
best to globally check use of
#include <linux/config.h>
in the same pattern as was already done for init_utsname.

Furthermore, the check for is_power_of_2 would produce 2 warnings: one for
the use of an undeclared function (desired), and another warning for an
un-used variable. Still the test would succeed, because the required
condition is flagged by warnings, not errors. This was fixed by following
the pattern from init_utsname.

Signed-off-by: Ben Stanley <Ben.Stanley@exemail.com.au>

--- a/configure.in	2008-07-01 13:09:02.000000000 +1000
+++ b/configure.in	2008-07-01 13:26:12.000000000 +1000
@@ -1567,7 +1567,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/kernel.h>
 #include <linux/string.h>
 ],[
@@ -1595,7 +1599,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/kernel.h>
 ],[
   char buf[128];
@@ -1622,7 +1630,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/kernel.h>
 void f(const char *fmt, ...)
 {
@@ -1656,7 +1668,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/kernel.h>
 ],[
   char buf[128];
@@ -1683,7 +1699,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/kernel.h>
 ],[
   unsigned int i;
@@ -1710,7 +1730,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/time.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
@@ -1740,7 +1764,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/kmod.h>
 ],[
 	request_module("abcd", "def", "ixj");
@@ -1766,7 +1794,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 ],[
@@ -1794,7 +1826,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/pci.h>
 ],[
 	int (*func)();
@@ -1820,7 +1856,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/pci.h>
 ],[
 	int (*func)();
@@ -1846,7 +1886,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/delay.h>
 ],[
   void (*func)(unsigned int);
@@ -1874,7 +1918,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/delay.h>
 ],[
   unsigned long (*func)(unsigned int);
@@ -1902,7 +1950,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/jiffies.h>
 #include <linux/time.h>
 ],[
@@ -1930,7 +1982,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/tty.h>
 ],[
 	struct tty_struct tty;
@@ -1957,7 +2013,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/videodev.h>
 #include "media/v4l2-dev.h"
 ],[
@@ -1995,7 +2055,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/mm.h>
 ],[
   static pgprot_t p;
@@ -2020,7 +2084,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/mm.h>
 ],[
   static pgprot_t p;
@@ -2046,7 +2114,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/slab.h>
 ],[
   void * (*func)(size_t, size_t, int);
@@ -2073,7 +2145,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/string.h>
 ],[
   char * (*func)(const char *, int);
@@ -2100,7 +2176,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/slab.h>
 ],[
   void * (*func)(size_t, int);
@@ -2128,7 +2208,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/workqueue.h>
 ],[
     create_workqueue("abcd", 0);
@@ -2155,7 +2239,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/pci.h>
 ],[
   struct pci_dev dev;
@@ -2183,7 +2271,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/pci.h>
 ],[
   struct pci_dev *pci;
@@ -2209,7 +2301,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/sound.h>
 ],[
   void (*func)(struct file_operations *, int, struct device *);
@@ -2453,7 +2549,11 @@
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/device.h>
 ],[
   struct class_simple *(*foo)(struct module *, char *) =
class_simple_create;
@@ -2482,7 +2582,11 @@
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/device.h>
 ],[
   static struct device_driver driver;
@@ -2511,7 +2615,11 @@
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/mm.h>
 ],[
   void (*func)(struct vm_area_struct *, pte_t, unsigned long) =
print_bad_pte;
@@ -2539,7 +2647,11 @@
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/device.h>
 ],[
   struct class_device dev;
@@ -2568,7 +2680,11 @@
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/interrupt.h>
 ],[
   irq_handler_t handle = 0;
@@ -2596,7 +2712,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/types.h>
 #include <linux/gfp.h>
 ],[
@@ -2623,7 +2743,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/types.h>
 #include <linux/gfp.h>
 ],[
@@ -2650,7 +2774,11 @@
 CC=$KCC
 AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/types.h>
 #include <linux/mm.h>
 ],[
@@ -2716,14 +2844,19 @@
   is_power_of_2="0"
   ac_save_CFLAGS="$CFLAGS"
   ac_save_CC="$CC"
-  CFLAGS="$KERNEL_CHECK_CFLAGS"
+  CFLAGS="$KERNEL_CHECK_CFLAGS -Werror"
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/log2.h>
 ],[
   int a = is_power_of_2(2);
+  a = 2;
 ],
     AC_MSG_RESULT(yes);is_power_of_2="1",
     AC_MSG_RESULT(no);is_power_of_2="0",
@@ -2750,7 +2883,11 @@
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/bitops.h>
 ],[
   unsigned long (*x)(unsigned long);
@@ -2779,7 +2916,11 @@
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/pnp.h>
 ],[
   struct pnp_driver pnp;
@@ -2808,7 +2949,11 @@
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/device.h>
 ],[
   struct device *(*foo)() = device_create_drvdata;
@@ -2836,7 +2981,11 @@
   CC=$KCC
   AC_TRY_COMPILE([
 #define __KERNEL__
+#ifdef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#include <linux/autoconf.h>
+#else
 #include <linux/config.h>
+#endif
 #include <linux/fs.h>
 ],[
   struct file_operations ops;
@@ -3005,4 +3154,4 @@
 dnl avoid changing include/sound/version.h
 if test "$update_versoin" != "yes"; then
   touch alsa-kernel/include/version.h
-fi
\ No newline at end of file
+fi
