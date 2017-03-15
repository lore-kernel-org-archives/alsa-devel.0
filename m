From: fuweix.tang@intel.com
Subject: [PATCH v1 1/3] ucm-conf: Set up for installation
Date: Wed, 15 Mar 2017 14:47:01 +0800
Message-ID: <04a4f7a2fd088ee8206167ba783d0af7c4cfaaa2.1487897097.git.fuweix.tang@intel.com>
References: <cover.1487897097.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E5B13266FA4
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 07:46:56 +0100 (CET)
In-Reply-To: <cover.1487897097.git.fuweix.tang@intel.com>
In-Reply-To: <cover.1487897097.git.fuweix.tang@intel.com>
References: <cover.1487897097.git.fuweix.tang@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Fuwei Tang <fuweix.tang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Fuwei Tang <fuweix.tang@intel.com>

This add autoconf and automake script and Makefile.am for conf files to be installed automatically.

Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..e612a96
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,13 @@
+aclocal.m4
+AUTHORS
+autom4te.cache
+autoscan.log
+config.log
+config.status
+configure
+install-sh
+Makefile
+Makefile.in
+missing
+NEWS
+COPYING
diff --git a/ChangeLog b/ChangeLog
new file mode 100644
index 0000000..2a8eb65
--- /dev/null
+++ b/ChangeLog
@@ -0,0 +1 @@
+Move all conf files to alsa-ucm-conf repo from alsa-lib repo.
diff --git a/INSTALL b/INSTALL
new file mode 120000
index 0000000..ddcdb76
--- /dev/null
+++ b/INSTALL
@@ -0,0 +1 @@
+/usr/share/automake-1.15/INSTALL
\ No newline at end of file
diff --git a/Makefile.am b/Makefile.am
new file mode 100644
index 0000000..e2baa04
--- /dev/null
+++ b/Makefile.am
@@ -0,0 +1 @@
+SUBDIRS=
diff --git a/configure.ac b/configure.ac
new file mode 100644
index 0000000..8aac3c8
--- /dev/null
+++ b/configure.ac
@@ -0,0 +1,22 @@
+#                                               -*- Autoconf -*-
+# Process this file with autoconf to produce a configure script.
+
+AC_PREREQ([2.69])
+AC_INIT(alsa-ucm, 1.1.3)
+AM_INIT_AUTOMAKE
+# Checks for programs.
+
+# Checks for libraries.
+
+# Checks for header files.
+
+# Checks for typedefs, structures, and compiler characteristics.
+
+# Checks for library functions.
+AC_CONFIG_FILES([Makefile])
+
+ALSA_CONFIG_DIR="/usr/share/alsa"
+AC_SUBST(ALSA_CONFIG_DIR)
+
+AC_OUTPUT
+
diff --git a/gitcompile b/gitcompile
new file mode 100755
index 0000000..fff6769
--- /dev/null
+++ b/gitcompile
@@ -0,0 +1,5 @@
+#!/bin/bash
+
+aclocal
+autoconf
+automake --add-missing
-- 
2.7.4
