From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: CONFIG_GCD is never defined in the latest alsa-driver
Date: Sat, 26 Dec 2009 12:55:24 +0200
Message-ID: <4B35EB9C.9030501@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 3590E103807
	for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2009 11:55:21 +0100 (CET)
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
Cc: "tiwa >> Takashi Iwai" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Compiling the latest alsa-driver with kernel > 2.6.31 results in gcd()
symbol duplication. Although there's a check in configure for
linux/gcd.h, no boolean is adjusted according to that.

In acore/wrappers.c, gcd() is exported if CONFIG_GCD is not defined
which seems always the case for now.

Something like the following fixes the problem for me:

Index: alsa-driver/acore/wrappers.c
===================================================================
--- alsa-driver.orig/acore/wrappers.c
+++ alsa-driver/acore/wrappers.c
@@ -339,7 +339,7 @@ char *compat_skip_spaces(const char *str
 EXPORT_SYMBOL(compat_skip_spaces);
 #endif /* < 2.6.33 */

-#ifndef CONFIG_GCD
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 31)
 /* Greatest common divisor */
 unsigned long gcd(unsigned long a, unsigned long b)
 {
@@ -356,4 +356,4 @@ unsigned long gcd(unsigned long a, unsig
    return b;
 }
 EXPORT_SYMBOL(gcd);
-#endif /* !CONFIG_GCD */
+#endif

Thanks!
