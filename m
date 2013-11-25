From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] alsa-lib: dlmisc: Add a fake dl lib head file
	when dl lib is not supported by the toolchain.
Date: Mon, 25 Nov 2013 15:36:32 +0800
Message-ID: <1385364992-24653-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 by alsa0.perex.cz (Postfix) with ESMTP id E368C261A5E
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 08:37:00 +0100 (CET)
Received: by mail-pb0-f49.google.com with SMTP id jt11so5129585pbb.36
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 23:36:59 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Cc: u-boot@lists.denx.de, Sonic Zhang <sonic.adi@gmail.com>, Gustavo Zacarias <gustavo@zacarias.com.ar>
List-Id: alsa-devel@alsa-project.org

From: sonic <sonic@htpc.(none)>

The FLAT GNU toolchain doesn't include the dlfcn.h header file.

Signed-off-by: Sonic Zhang <sonic.adi@gmail.com>
---
 include/dlmisc.h               |   24 ++++++++++++++++++++++++
 modules/mixer/simple/sbasedl.c |    4 ++++
 src/mixer/simple_abst.c        |    4 ++++
 3 files changed, 32 insertions(+)
 create mode 100644 include/dlmisc.h

diff --git a/include/dlmisc.h b/include/dlmisc.h
new file mode 100644
index 0000000..3be8d43
--- /dev/null
+++ b/include/dlmisc.h
@@ -0,0 +1,24 @@
+/*
+ *   This library is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU Lesser General Public License as
+ *   published by the Free Software Foundation; either version 2.1 of
+ *   the License, or (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU Lesser General Public License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public
+ *   License along with this library; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#ifndef __ALSA_DLMISC_H
+#define __ALSA_DLMISC_H
+
+#define RTLD_NOW	0x00002
+#define RTLD_GLOBAL	0x00100
+
+#endif
diff --git a/modules/mixer/simple/sbasedl.c b/modules/mixer/simple/sbasedl.c
index 494802f..511bebf 100644
--- a/modules/mixer/simple/sbasedl.c
+++ b/modules/mixer/simple/sbasedl.c
@@ -27,7 +27,11 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <math.h>
+#ifdef HAVE_LIBDL
 #include <dlfcn.h>
+#else
+#include <dlmisc.h>
+#endif
 #include "config.h"
 #include "asoundlib.h"
 #include "mixer_abst.h"
diff --git a/src/mixer/simple_abst.c b/src/mixer/simple_abst.c
index 9e9aaf5..dd951fe 100644
--- a/src/mixer/simple_abst.c
+++ b/src/mixer/simple_abst.c
@@ -34,7 +34,11 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <math.h>
+#ifdef HAVE_LIBDL
 #include <dlfcn.h>
+#else
+#include <dlmisc.h>
+#endif
 #include "config.h"
 #include "asoundlib.h"
 #include "mixer_simple.h"
-- 
1.7.9.5
