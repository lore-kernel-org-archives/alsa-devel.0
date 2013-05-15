From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 8/8] Add AM_MAINTAINER_MODE([enable]) macro to
	all configure scripts.
Date: Wed, 15 May 2013 19:19:11 +0200
Message-ID: <1368638351-29200-9-git-send-email-jordi@debian.org>
References: <1368638351-29200-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 728E62652F4
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:24 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id BDD8362838
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:23 +0200 (CEST)
In-Reply-To: <1368638351-29200-1-git-send-email-jordi@debian.org>
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

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 as10k1/configure.in         |    1 +
 echomixer/configure.in      |    1 +
 envy24control/configure.in  |    1 +
 hda-verb/configure.ac       |    2 +-
 hdajackretask/configure.in  |    1 +
 hdspconf/configure.in       |    1 +
 hdsploader/configure.in     |    1 +
 hdspmixer/configure.in      |    1 +
 hwmixvolume/configure.ac    |    1 +
 ld10k1/configure.in         |    1 +
 mixartloader/configure.in   |    1 +
 pcxhrloader/configure.in    |    1 +
 qlo10k1/configure.in        |    1 +
 rmedigicontrol/configure.in |    1 +
 sb16_csp/configure.in       |    1 +
 sscape_ctl/configure.in     |    1 +
 us428control/configure.in   |    1 +
 usx2yloader/configure.in    |    1 +
 vxloader/configure.in       |    1 +
 19 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/as10k1/configure.in b/as10k1/configure.in
index 37e9e6c..1855eea 100644
--- a/as10k1/configure.in
+++ b/as10k1/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(as10k1.c)
 AM_INIT_AUTOMAKE(as10k1, A0.99)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/echomixer/configure.in b/echomixer/configure.in
index 9228924..b4c50f1 100644
--- a/echomixer/configure.in
+++ b/echomixer/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(echomixer.c)
 AM_INIT_AUTOMAKE(echomixer, 1.0.5)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/envy24control/configure.in b/envy24control/configure.in
index d42aee8..6a7b23a 100644
--- a/envy24control/configure.in
+++ b/envy24control/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(envy24control.c)
 AM_INIT_AUTOMAKE(envy24control, 0.6.0)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/hda-verb/configure.ac b/hda-verb/configure.ac
index 94ca73b..21349b8 100644
--- a/hda-verb/configure.ac
+++ b/hda-verb/configure.ac
@@ -1,7 +1,7 @@
 AC_INIT(hda-verb.c)
 AM_INIT_AUTOMAKE(hda-verb, 0.4)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
-
 AC_OUTPUT(Makefile)
diff --git a/hdajackretask/configure.in b/hdajackretask/configure.in
index f839af3..050c731 100644
--- a/hdajackretask/configure.in
+++ b/hdajackretask/configure.in
@@ -1,6 +1,7 @@
 AC_INIT([hdajackretask], [0.20120413])
 AC_CONFIG_SRCDIR([main-gtk.c])
 AM_INIT_AUTOMAKE
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/hdspconf/configure.in b/hdspconf/configure.in
index a32ff5f..37a18de 100644
--- a/hdspconf/configure.in
+++ b/hdspconf/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(src/hdspconf.cxx)
 AM_INIT_AUTOMAKE(hdspconf, 1.4)
+AM_MAINTAINER_MODE([enable])
 
 AC_PROG_CXX
 AC_PROG_MAKE_SET
diff --git a/hdsploader/configure.in b/hdsploader/configure.in
index 4801124..b530e9c 100644
--- a/hdsploader/configure.in
+++ b/hdsploader/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(hdsploader.c)
 AM_INIT_AUTOMAKE(hdsploader, 1.2)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/hdspmixer/configure.in b/hdspmixer/configure.in
index e47a97d..5e2295b 100644
--- a/hdspmixer/configure.in
+++ b/hdspmixer/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(src/hdspmixer.cxx)
 AM_INIT_AUTOMAKE(hdspmixer, 1.11)
+AM_MAINTAINER_MODE([enable])
 
 AC_PROG_CXX
 AC_PROG_MAKE_SET
diff --git a/hwmixvolume/configure.ac b/hwmixvolume/configure.ac
index ad318ad..5572412 100644
--- a/hwmixvolume/configure.ac
+++ b/hwmixvolume/configure.ac
@@ -1,6 +1,7 @@
 dnl Process this file with autoconf to produce a configure script.
 AC_INIT([hwmixvolume], [0.9])
 AM_INIT_AUTOMAKE
+AM_MAINTAINER_MODE([enable])
 AC_CONFIG_SRCDIR([hwmixvolume])
 AC_PROG_INSTALL
 AC_OUTPUT([Makefile])
diff --git a/ld10k1/configure.in b/ld10k1/configure.in
index b04fa34..6249e03 100644
--- a/ld10k1/configure.in
+++ b/ld10k1/configure.in
@@ -1,6 +1,7 @@
 AC_INIT(src/ld10k1.c)
 AM_INIT_AUTOMAKE(ld10k1, 0.1.8p1)
 AC_CONFIG_MACRO_DIR([m4])
+AM_MAINTAINER_MODE([enable])
 
 AC_CONFIG_HEADERS(config.h)
 AC_PROG_CC
diff --git a/mixartloader/configure.in b/mixartloader/configure.in
index e5d14f8..6ad5ca7 100644
--- a/mixartloader/configure.in
+++ b/mixartloader/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(mixartloader.c)
 AM_INIT_AUTOMAKE(mixartloader, 1.0)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/pcxhrloader/configure.in b/pcxhrloader/configure.in
index 0565dcf..b8ee5d1 100644
--- a/pcxhrloader/configure.in
+++ b/pcxhrloader/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(pcxhrloader.c)
 AM_INIT_AUTOMAKE(pcxhrloader, 1.0)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/qlo10k1/configure.in b/qlo10k1/configure.in
index da6ea97..574754e 100644
--- a/qlo10k1/configure.in
+++ b/qlo10k1/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(src/main.cpp)
 AM_INIT_AUTOMAKE(qlo10k1, 0.1.2p1)
+AM_MAINTAINER_MODE([enable])
 AC_CONFIG_MACRO_DIR([m4])
 AC_CONFIG_HEADERS(config.h)
 AC_PROG_CXX
diff --git a/rmedigicontrol/configure.in b/rmedigicontrol/configure.in
index bc4c605..bf8c3f4 100644
--- a/rmedigicontrol/configure.in
+++ b/rmedigicontrol/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(rmedigicontrol.c)
 AM_INIT_AUTOMAKE(rmedigicontrol, 0.3.5a)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/sb16_csp/configure.in b/sb16_csp/configure.in
index d0b90ca..5e04236 100644
--- a/sb16_csp/configure.in
+++ b/sb16_csp/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(cspctl.c)
 AM_INIT_AUTOMAKE(cspctl, 0.2.0)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/sscape_ctl/configure.in b/sscape_ctl/configure.in
index 282a56b..98eed8b 100644
--- a/sscape_ctl/configure.in
+++ b/sscape_ctl/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(sscape_ctl.c)
 AM_INIT_AUTOMAKE(sscape_ctl, 0.1.0)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/us428control/configure.in b/us428control/configure.in
index 66aff9e..031ef3e 100644
--- a/us428control/configure.in
+++ b/us428control/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(us428control.cc)
 AM_INIT_AUTOMAKE(us428control, 0.4.6)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CXX
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/usx2yloader/configure.in b/usx2yloader/configure.in
index e91f28a..800e6e0 100644
--- a/usx2yloader/configure.in
+++ b/usx2yloader/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(usx2yloader.c)
 AM_INIT_AUTOMAKE(usx2yloader, 0.3)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff --git a/vxloader/configure.in b/vxloader/configure.in
index e3597ba..2035af3 100644
--- a/vxloader/configure.in
+++ b/vxloader/configure.in
@@ -1,5 +1,6 @@
 AC_INIT(vxloader.c)
 AM_INIT_AUTOMAKE(vxloader, 1.0)
+AM_MAINTAINER_MODE([enable])
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
-- 
1.7.10.4
