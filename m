From: Alex Ivanov <gnidorah@ya.ru>
Subject: [PATCH] [-, JACK, plugin,
	1/1] configure: use $prefix/etc instead of /etc
Date: Tue, 19 Mar 2019 22:04:25 +0300
Message-ID: <20190319190425.14681-1-gnidorah@ya.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward102o.mail.yandex.net (forward102o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::602])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CB7EF8070E
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 20:04:31 +0100 (CET)
Received: from mxback21o.mail.yandex.net (mxback21o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::72])
 by forward102o.mail.yandex.net (Yandex) with ESMTP id 101AE6681F84
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 22:04:30 +0300 (MSK)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use $sysconfdir as prefix for ALSA_LCONF_DIR by default. Otherwise install
fails on non-FHS distros.

Signed-off-by: Alex Ivanov <gnidorah@ya.ru>
---
 configure.ac | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 5b80585..7b8dd66 100644
--- a/configure.ac
+++ b/configure.ac
@@ -219,6 +219,23 @@ AC_DEFINE_UNQUOTED(ALSA_DATA_DIR, "$alsadatadir", [directory containing ALSA dat
 ALSA_DATA_DIR="$alsadatadir"
 AC_SUBST(ALSA_DATA_DIR)
 
+dnl ALSA configuration directory
+AC_ARG_WITH(alsaconfdir,
+    AS_HELP_STRING([--with-alsaconfdir=dir],
+  [path where ALSA configuration files are stored]),
+    alsaconfdir="$withval", alsaconfdir="")
+if test -z "$alsaconfdir"; then
+    eval dir="$sysconfdir"
+    case "$dir" in
+    /*) ;;
+    *) dir="$dir"
+    esac
+    alsaconfdir="$dir/alsa"
+fi
+AC_DEFINE_UNQUOTED(ALSA_CONF_DIR, "$alsaconfdir", [directory containing ALSA configuration files])
+ALSA_CONF_DIR="$alsaconfdir"
+AC_SUBST(ALSA_CONF_DIR)
+
 dnl ALSA add-on global config directory
 AC_ARG_WITH(alsagconfdir,
     AS_HELP_STRING([--with-alsagconfdir=dir],
@@ -237,7 +254,7 @@ AC_ARG_WITH(alsalconfdir,
 	[path where ALSA local add-on config files are stored]),
     alsalconfdir="$withval", alsalconfdir="")
 if test -z "$alsalconfdir"; then
-    alsalconfdir="/etc/alsa/conf.d"
+    alsalconfdir="$ALSA_CONF_DIR/conf.d"
 fi
 AC_DEFINE_UNQUOTED(ALSA_LCONF_DIR, "$alsalconfdir", [directory containing local ALSA add-on config files])
 ALSA_LCONF_DIR="$alsalconfdir"
-- 
2.19.2
