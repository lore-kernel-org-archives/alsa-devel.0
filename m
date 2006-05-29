From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] undeclared TASK_(UN)INTERRUPTIBLE fixed
Date: Mon, 29 May 2006 15:37:23 +0200
Message-ID: <20060529133723.GA4194@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 55B68168
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 15:31:07 +0200 (MEST)
Received: from ml by tuba with local (Exim 4.50) id 1Fkhvw-000166-3j
	for alsa-devel@alsa-project.org; Mon, 29 May 2006 15:37:24 +0200
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes a compilation problem of undeclared 
TASK_INTERRUPTIBLE and TASK_UNINTERRUPTIBLE in acore/wrappers.c

Detected on an alpha machine w/ 2.4.27, gcc 3.3.5

Signed-off-by: Martin Langer <martin-langer@gmx.de>

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="compilationfix.patch"

--- wrappers.c~	2005-11-17 12:14:24.000000000 +0100
+++ wrappers.c	2006-05-29 15:04:53.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/version.h>
 #include <linux/config.h>
 #include <linux/string.h>
+#include <linux/sched.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 #if defined(CONFIG_MODVERSIONS) && !defined(__GENKSYMS__) && !defined(__DEPEND__)

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--AhhlLboLdkugWU4S--
