From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/13] libhinawa: support GTK-Doc to generate references
Date: Sun, 25 Jan 2015 20:34:24 +0900
Message-ID: <1422185674-16431-4-git-send-email-o-takashi@sakamocchi.jp>
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

The GTK-Doc project gives a way to generate API documentation from C
source code, mainly from comments. This library uses this mechanism
to give references.

This commit adds a dependency with:
 - GTK-Doc 1.18-2 or later

The reference is available to give '--enable-gtk-doc' option for
./configure script.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/Makefile.am                    |  3 ++-
 libhinawa/README                         |  7 +++++
 libhinawa/autogen.sh                     |  1 +
 libhinawa/configure.ac                   |  6 +++++
 libhinawa/doc/Makefile.am                |  2 ++
 libhinawa/doc/reference/Makefile.am      | 46 ++++++++++++++++++++++++++++++++
 libhinawa/doc/reference/hinawa-docs.sgml | 39 +++++++++++++++++++++++++++
 libhinawa/doc/reference/version.xml.in   |  1 +
 8 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 libhinawa/doc/Makefile.am
 create mode 100644 libhinawa/doc/reference/Makefile.am
 create mode 100644 libhinawa/doc/reference/hinawa-docs.sgml
 create mode 100644 libhinawa/doc/reference/version.xml.in

diff --git a/libhinawa/Makefile.am b/libhinawa/Makefile.am
index 05f5d58..3fd84c5 100644
--- a/libhinawa/Makefile.am
+++ b/libhinawa/Makefile.am
@@ -2,4 +2,5 @@
 ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
 
 SUBDIRS =					\
-	src
+	src					\
+	doc
diff --git a/libhinawa/README b/libhinawa/README
index db9b82a..f6a0650 100644
--- a/libhinawa/README
+++ b/libhinawa/README
@@ -3,9 +3,16 @@ Requirements
 - GNU Automake 1.10.1 or later
 - GNU libtool 2.2.6 or later
 - Glib 2.32.4 or later
+- GTK-Doc 1.18-2
 
 How to build
  $ ./autogen.sh
  $ ./configure
  $ make
  $ make install
+
+How to refer document
+ $ ./autogen.sh
+ $ ./configure --enable-gtk-doc
+ $ make
+ $ make install
diff --git a/libhinawa/autogen.sh b/libhinawa/autogen.sh
index 54ecfa2..98f6dbf 100755
--- a/libhinawa/autogen.sh
+++ b/libhinawa/autogen.sh
@@ -7,4 +7,5 @@ if [ ! -e m4 ] ; then
 	mkdir -p m4
 fi
 
+gtkdocize --copy --docdir doc/reference
 autoreconf --install
diff --git a/libhinawa/configure.ac b/libhinawa/configure.ac
index 5ecb7ec..28ca374 100644
--- a/libhinawa/configure.ac
+++ b/libhinawa/configure.ac
@@ -45,10 +45,16 @@ AC_PROG_CC
 # Glib 2.32 or later
 AM_PATH_GLIB_2_0([2.32.4], [], [], [gobject])
 
+# GTK-Doc 1.18-2 or later
+GTK_DOC_CHECK([1.18-2])
+
 # The files generated from *.in
 AC_CONFIG_FILES([
   Makefile
   src/Makefile
+  doc/Makefile
+  doc/reference/Makefile
+  doc/reference/version.xml
 ])
 
 # Generate scripts and launch
diff --git a/libhinawa/doc/Makefile.am b/libhinawa/doc/Makefile.am
new file mode 100644
index 0000000..66af18f
--- /dev/null
+++ b/libhinawa/doc/Makefile.am
@@ -0,0 +1,2 @@
+SUBDIRS =			\
+	reference
diff --git a/libhinawa/doc/reference/Makefile.am b/libhinawa/doc/reference/Makefile.am
new file mode 100644
index 0000000..b7e28d2
--- /dev/null
+++ b/libhinawa/doc/reference/Makefile.am
@@ -0,0 +1,46 @@
+# The name of this module
+DOC_MODULE = hinawa
+
+# THe entry point
+DOC_MAIN_SGML_FILE = hinawa-docs.sgml
+
+# The directory with sources
+DOC_SOURCE_DIR =				\
+	$(top_srcdir)/src
+
+# The tag for deprecates
+SCAN_OPTIONS =
+
+# The prefix
+MKDB_OPTIONS =					\
+	--name-space=hinawa
+
+# The patterns for headers
+HFILE_GLOB =					\
+	$(top_srcdir)/src/*.h
+
+# The patterns for sources
+CFILE_GLOB =					\
+	$(top_srcdir)/src/*.c
+
+# The options for C Pre-Processor
+AM_CPPFLAGS =					\
+	-I$(top_srcdir)				\
+	-I$(top_srcdir)/src
+
+# The options for C compiler
+AM_CFLAGS =					\
+	$(GLIB_CFLAGS)				\
+	-Wall
+
+# The options to link
+GTKDOC_LIBS =					\
+	$(top_builddir)/src/libhinawa.la	\
+	$(GLIB_LIBS)
+
+# Include Makefile generated by GTK-Doc
+include $(top_srcdir)/doc/reference/gtk-doc.make
+
+CLEANFILES +=					\
+	$(DOC_MODULE)-sections.txt		\
+	$(DOC_MODULE).types
diff --git a/libhinawa/doc/reference/hinawa-docs.sgml b/libhinawa/doc/reference/hinawa-docs.sgml
new file mode 100644
index 0000000..43c5c4e
--- /dev/null
+++ b/libhinawa/doc/reference/hinawa-docs.sgml
@@ -0,0 +1,39 @@
+<?xml version="1.0" encoding="utf-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN" "http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" [
+<!ENTITY version SYSTEM "version.xml">
+]>
+<book xmlns:xi="http://www.w3.org/2003/XInclude" id="index" lang="en">
+    <bookinfo>
+        <title>Hinawa Reference Manual</title>
+    <releaseinfo>This document is for the Hinawa library, version &version;.
+    </releaseinfo>
+    </bookinfo>
+
+    <part id="reference">
+        <title>Reference</title>
+
+        <chapter id="introduction">
+            <title>Introduction</title>
+            <para>
+            Hinawa is an gobject introspection library for devices connected to
+            IEEE 1394 bus. This library supports any types of transactions
+            over IEEE 1394 bus.
+            This library also supports some functionality which ALSA firewire
+            stack produces.
+            </para>
+        </chapter>
+
+        <chapter id="libhinawa">
+            <title>libhinawa</title>
+            <para>
+            This library gives 7 objects, 3 objects are abstraction of the
+            functionality in ALSA firewire stack, the others are abstractions
+            of the transaction functionality in Linux firewire stack.
+            </para>
+        </chapter>
+    </part>
+
+    <index id="index-all">
+        <title>Index of all symbols</title>
+    </index>
+</book>
diff --git a/libhinawa/doc/reference/version.xml.in b/libhinawa/doc/reference/version.xml.in
new file mode 100644
index 0000000..d78bda9
--- /dev/null
+++ b/libhinawa/doc/reference/version.xml.in
@@ -0,0 +1 @@
+@VERSION@
-- 
2.1.0


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
