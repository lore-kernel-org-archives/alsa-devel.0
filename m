From: Aaron Wu <aaron.wu@analog.com>
Subject: [PATCH] Add nommu support for alsa-utils
Date: Wed, 27 Nov 2013 18:03:59 +0800
Message-ID: <1385546639-14041-1-git-send-email-aaron.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BC512652DA
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 11:06:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: thomas.petazzoni@free-electrons.com, sonic.zhang@analog.com, arnout@mind.be, adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
Cc: Aaron Wu <aaron.wu@analog.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Add nommu support for alsa-utils mainly for Blackfin
---
 package/alsa-utils/alsa-utils-nommu.patch |   54 +++++++++++++++++++++++++++++
 package/alsa-utils/alsa-utils.mk          |    1 +
 2 files changed, 55 insertions(+)
 create mode 100644 package/alsa-utils/alsa-utils-nommu.patch

diff --git a/package/alsa-utils/alsa-utils-nommu.patch b/package/alsa-utils/alsa-utils-nommu.patch
new file mode 100644
index 0000000..c0227f5
--- /dev/null
+++ b/package/alsa-utils/alsa-utils-nommu.patch
@@ -0,0 +1,54 @@
+diff -Nur alsa-utils-1.0.26/alsactl/init_utils_run.c alsa-utils-1.0.26-new/alsactl/init_utils_run.c
+--- alsa-utils-1.0.26/alsactl/init_utils_run.c	2012-09-06 15:52:57.000000000 +0800
++++ alsa-utils-1.0.26-new/alsactl/init_utils_run.c	2013-10-22 02:19:06.210649921 +0800
+@@ -88,8 +88,11 @@
+ 		strlcat(program, argv[0], sizeof(program));
+ 		argv[0] = program;
+ 	}
+-
++#ifdef HAVE_FORK
+ 	pid = fork();
++#else
++	pid = vfork();
++#endif
+ 	switch(pid) {
+ 	case 0:
+ 		/* child closes parent ends of pipes */
+diff -Nur alsa-utils-1.0.26/alsaloop/alsaloop.c alsa-utils-1.0.26-new/alsaloop/alsaloop.c
+--- alsa-utils-1.0.26/alsaloop/alsaloop.c	2012-09-06 15:52:57.000000000 +0800
++++ alsa-utils-1.0.26-new/alsaloop/alsaloop.c	2013-10-22 02:21:26.994650695 +0800
+@@ -850,14 +850,22 @@
+ 			logit(LOG_CRIT, "daemon() failed: %s\n", strerror(errno));
+ 			exit(EXIT_FAILURE);
+ 		}
++		#ifdef HAVE_FORK
+ 		i = fork();
++		#else
++		i = vfork();
++		#endif
+ 		if (i < 0) {
+ 			logit(LOG_CRIT, "fork() failed: %s\n", strerror(errno));
+ 			exit(EXIT_FAILURE);
+ 		}
+ 		if (i > 0) {
+ 			/* wait(&i); */
++			#ifdef HAVE_FORK
+ 			exit(EXIT_SUCCESS);
++			#else
++			_exit(EXIT_SUCCESS);
++			#endif
+ 		}
+ 	}
+ 
+diff -Nur alsa-utils-1.0.26/configure.in alsa-utils-1.0.26-new/configure.in
+--- alsa-utils-1.0.26/configure.in	2012-09-06 16:45:44.000000000 +0800
++++ alsa-utils-1.0.26-new/configure.in	2013-10-23 02:25:40.391127379 +0800
+@@ -23,6 +23,8 @@
+   AC_MSG_RESULT($CC)
+ fi
+ 
++
++AC_CHECK_FUNC([fork])
+ AC_PROG_CC
+ dnl AC_PROG_CXX
+ AC_PROG_INSTALL
diff --git a/package/alsa-utils/alsa-utils.mk b/package/alsa-utils/alsa-utils.mk
index b951112..4956e04 100644
--- a/package/alsa-utils/alsa-utils.mk
+++ b/package/alsa-utils/alsa-utils.mk
@@ -9,6 +9,7 @@ ALSA_UTILS_SOURCE = alsa-utils-$(ALSA_UTILS_VERSION).tar.bz2
 ALSA_UTILS_SITE = http://alsa.cybermirror.org/utils
 ALSA_UTILS_LICENSE = GPLv2
 ALSA_UTILS_LICENSE_FILES = COPYING
+ALSA_UTILS_AUTORECONF = YES
 ALSA_UTILS_INSTALL_STAGING = YES
 ALSA_UTILS_DEPENDENCIES = host-gettext alsa-lib \
 	$(if $(BR2_PACKAGE_NCURSES),ncurses)
-- 
1.7.9.5
