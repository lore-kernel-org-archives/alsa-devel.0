From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/13] libhinawa: support GObject Introspection for language
	bindings
Date: Sun, 25 Jan 2015 20:34:26 +0900
Message-ID: <1422185674-16431-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

GObject Introspection is a mechanism to give a metadata of library
to each language bindings. The library should be written by GObject
way.

This commit applies this mechanism to this library to produce language
bindings, thus adds a dependency with:
 - GObject Introspaction 1.32.1 or later

The comments in each methods and signals are important for GObject
Introspection scanner because of a hint to create better metadata.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/README          |  1 +
 libhinawa/configure.ac    |  6 +++++-
 libhinawa/src/Makefile.am | 29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/libhinawa/README b/libhinawa/README
index f6a0650..1bd0d52 100644
--- a/libhinawa/README
+++ b/libhinawa/README
@@ -4,6 +4,7 @@ Requirements
 - GNU libtool 2.2.6 or later
 - Glib 2.32.4 or later
 - GTK-Doc 1.18-2
+- GObject Introspection 1.32.1 or later
 
 How to build
  $ ./autogen.sh
diff --git a/libhinawa/configure.ac b/libhinawa/configure.ac
index 28ca374..b0d9517 100644
--- a/libhinawa/configure.ac
+++ b/libhinawa/configure.ac
@@ -26,7 +26,8 @@ AC_CONFIG_SRCDIR([src])
 AC_CONFIG_HEADERS([config.h])
 
 # Automake 1.13 or later
-AM_INIT_AUTOMAKE([1.10.1])
+# GObject Introspection uses GNU Make-specific functionality.
+AM_INIT_AUTOMAKE([1.10.1  -Wno-portability])
 # Don't output command lines
 AM_SILENT_RULES([yes])
 
@@ -48,6 +49,9 @@ AM_PATH_GLIB_2_0([2.32.4], [], [], [gobject])
 # GTK-Doc 1.18-2 or later
 GTK_DOC_CHECK([1.18-2])
 
+# GObject introspection 1.32.1 or later
+GOBJECT_INTROSPECTION_REQUIRE([1.32.1])
+
 # The files generated from *.in
 AC_CONFIG_FILES([
   Makefile
diff --git a/libhinawa/src/Makefile.am b/libhinawa/src/Makefile.am
index 9eda8f4..d9519ab 100644
--- a/libhinawa/src/Makefile.am
+++ b/libhinawa/src/Makefile.am
@@ -43,3 +43,32 @@ hinawa_sigs_marshal.h: hinawa_sigs_marshal.list
 hinawa_sigs_marshal.c: hinawa_sigs_marshal.list hinawa_sigs_marshal.h
 	$(AM_V_GEN)(echo '#include "hinawa_sigs_marshal.h"';		\
 		glib-genmarshal --body --prefix=hinawa_sigs_marshal $< ) > $@
+
+-include $(INTROSPECTION_MAKEFILE)
+INTROSPECTION_GIRS =
+INTROSPECTION_SCANNER_ARGS = --warn-all
+INTROSPECTION_COMPILER_ARGS =
+
+if HAVE_INTROSPECTION
+Hinawa-1.0.gir: libhinawa.la
+Hinawa_1_0_gir_PACKAGES =
+Hinawa_1_0_gir_EXPORT_PACKAGES = hinawa
+Hinawa_1_0_gir_INCLUDES = GObject-2.0
+Hinawa_1_0_gir_CFLAGS =
+Hinawa_1_0_gir_LIBS = libhinawa.la
+Hinawa_1_0_gir_FILES = $(libhinawa_la_SOURCES)
+Hinawa_1_0_gir_SCANNERFLAGS =			\
+	--identifier-prefix=Hinawa		\
+	--symbol-prefix=hinawa
+INTROSPECTION_GIRS += Hinawa-1.0.gir
+
+girdir = $(datadir)/gir-1.0
+gir_DATA = $(INTROSPECTION_GIRS)
+
+typelibdir = $(libdir)/girepository-1.0
+typelib_DATA = $(INTROSPECTION_GIRS:.gir=.typelib)
+
+CLEANFILES +=					\
+	$(gir_DATA)				\
+	$(typelib_DATA)
+endif
-- 
2.1.0


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
