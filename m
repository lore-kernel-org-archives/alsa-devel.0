From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/13] libhinawa: add hinawa context
Date: Sun, 25 Jan 2015 20:34:23 +0900
Message-ID: <1422185674-16431-3-git-send-email-o-takashi@sakamocchi.jp>
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

In this library, 'transaction' consists of a pair of a request and
a response. To achieve the transaction, a requester should wait for
a response from the receiver.

Typically, to achieve the transaction, applications which transfer
requests are blocked with read(2) or poll(2) to wait responses. But
this operation is not good for GUI applications because these
blocking API stops a thread of event loop.

To avoid this situation, this commit adds own 'context'. The context
is running on own thread and execute poll(2). This context can be
written directly with pthreads(7) and select(2)/poll(2)/epoll(7),
but in this time I apply GMainContext/GThread in glib to save my
time.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 libhinawa/Makefile.am          |  3 +++
 libhinawa/README               |  1 +
 libhinawa/configure.ac         |  7 +++++
 libhinawa/src/Makefile.am      | 24 +++++++++++++++++
 libhinawa/src/hinawa_context.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 libhinawa/src/hinawa_context.h | 10 +++++++
 6 files changed, 105 insertions(+)
 create mode 100644 libhinawa/src/Makefile.am
 create mode 100644 libhinawa/src/hinawa_context.c
 create mode 100644 libhinawa/src/hinawa_context.h

diff --git a/libhinawa/Makefile.am b/libhinawa/Makefile.am
index e39f07b..05f5d58 100644
--- a/libhinawa/Makefile.am
+++ b/libhinawa/Makefile.am
@@ -1,2 +1,5 @@
 # Include m4 macros
 ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
+
+SUBDIRS =					\
+	src
diff --git a/libhinawa/README b/libhinawa/README
index 234ed91..db9b82a 100644
--- a/libhinawa/README
+++ b/libhinawa/README
@@ -2,6 +2,7 @@ Requirements
 - GNU Autoconf 2.62 or later
 - GNU Automake 1.10.1 or later
 - GNU libtool 2.2.6 or later
+- Glib 2.32.4 or later
 
 How to build
  $ ./autogen.sh
diff --git a/libhinawa/configure.ac b/libhinawa/configure.ac
index 2eeef0d..5ecb7ec 100644
--- a/libhinawa/configure.ac
+++ b/libhinawa/configure.ac
@@ -19,6 +19,9 @@ AC_INIT([hinawa], [my_version], [o-takashi@sakamocchi.jp])
 AC_CONFIG_AUX_DIR([config])
 # The directory for M4 macros
 AC_CONFIG_MACRO_DIR([m4])
+
+# The directory for sources
+AC_CONFIG_SRCDIR([src])
 # The header for variables with AC_DEFINE
 AC_CONFIG_HEADERS([config.h])
 
@@ -39,9 +42,13 @@ AC_SUBST(LT_IFACE)
 # Detect C language compiler
 AC_PROG_CC
 
+# Glib 2.32 or later
+AM_PATH_GLIB_2_0([2.32.4], [], [], [gobject])
+
 # The files generated from *.in
 AC_CONFIG_FILES([
   Makefile
+  src/Makefile
 ])
 
 # Generate scripts and launch
diff --git a/libhinawa/src/Makefile.am b/libhinawa/src/Makefile.am
new file mode 100644
index 0000000..5673255
--- /dev/null
+++ b/libhinawa/src/Makefile.am
@@ -0,0 +1,24 @@
+# Remove auto-generated files when cleaning
+CLEANFILES =
+
+AM_CPPFLAGS =					\
+	 -I$(top_builddir)			\
+	 -I$(top_srcdir)
+
+AM_CFLAGS =					\
+	$(GLIB_CFLAGS)				\
+	-Wall
+
+lib_LTLIBRARIES =				\
+	libhinawa.la
+
+libhinawa_la_LDFLAGS =				\
+	-version-info $(LT_IFACE)
+
+libhinawa_la_LIBADD =				\
+	$(GLIB_LIBS)
+
+libhinawa_la_SOURCES =				\
+	hinawa_context.c
+
+pkginclude_HEADERS =
diff --git a/libhinawa/src/hinawa_context.c b/libhinawa/src/hinawa_context.c
new file mode 100644
index 0000000..dd20d21
--- /dev/null
+++ b/libhinawa/src/hinawa_context.c
@@ -0,0 +1,60 @@
+#include "hinawa_context.h"
+
+static GMainContext *ctx;
+static GThread *thread;
+
+static gboolean running;
+static gint counter;
+
+static gpointer run_main_loop(gpointer data)
+{
+	while (running)
+		g_main_context_iteration(ctx, TRUE);
+
+	g_thread_exit(NULL);
+
+	return NULL;
+}
+
+static GMainContext *get_my_context(GError **exception)
+{
+	if (ctx == NULL)
+		ctx = g_main_context_new();
+
+	if (thread == NULL) {
+		thread = g_thread_try_new("gmain", run_main_loop, NULL,
+					  exception);
+		if (*exception != NULL) {
+			g_main_context_unref(ctx);
+			ctx = NULL;
+		}
+	}
+
+	return ctx;
+}
+
+gpointer hinawa_context_add_src(GSource *src, gint fd, GIOCondition event,
+				GError **exception)
+{
+	GMainContext *ctx;
+
+	ctx = get_my_context(exception);
+	if (*exception != NULL)
+		return NULL;
+	running = TRUE;
+
+	/* NOTE: The returned ID is never used. */
+	g_source_attach(src, ctx);
+
+	return g_source_add_unix_fd(src, fd, event);
+}
+
+void hinawa_context_remove_src(GSource *src)
+{
+	g_source_destroy(src);
+	if (g_atomic_int_dec_and_test(&counter)) {
+		running = FALSE;
+		g_thread_join(thread);
+		thread = NULL;
+	}
+}
diff --git a/libhinawa/src/hinawa_context.h b/libhinawa/src/hinawa_context.h
new file mode 100644
index 0000000..97666c6
--- /dev/null
+++ b/libhinawa/src/hinawa_context.h
@@ -0,0 +1,10 @@
+#ifndef __ALSA_TOOLS_HINAWA_CONTEXT_H__
+#define __ALSA_TOOLS_HINAWA_CONTEXT_H__
+
+#include <glib.h>
+#include <glib-object.h>
+
+gpointer hinawa_context_add_src(GSource *src, gint fd, GIOCondition event,
+				GError **exception);
+
+#endif
-- 
2.1.0


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
