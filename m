From: Antonio Ospite <ao2@ao2.it>
Subject: [alsa-utils][PATCH 2/5] configure.ac: fix the check
	for xmlto availability
Date: Fri,  9 Dec 2016 14:02:29 +0100
Message-ID: <20161209130232.19457-3-ao2@ao2.it>
References: <20161209130232.19457-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F1102677AE
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 14:02:59 +0100 (CET)
In-Reply-To: <20161209130232.19457-1-ao2@ao2.it>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Antonio Ospite <ao2@ao2.it>
List-Id: alsa-devel@alsa-project.org

The same $xmlto variable is used both in AC_ARG_ENABLE and
AC_CHECK_PROG, but the latter is not setting a value to it when the
program is not found.

These two facts result in the "yes" value from the AC_ARG_ENABLE macro
to be still kept in the variable when the program is not found by
AC_CHECK_PROG, causing USE_XMLTO to be always set, finally resulting in
a build failure in case the xmlto program is not actually in the PATH.

As possible fix could have been to set "no" as a value in AC_CHECK_PROG
when program is not found.

However using two separate variables is more explicit, so fix the issue
this way.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2221617..c9629bb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -166,14 +166,14 @@ AC_ARG_ENABLE(alsaloop,
      esac],[alsaloop=true])
 AM_CONDITIONAL(ALSALOOP, test x$alsaloop = xtrue)
 
-xmlto=""
+xmlto_available=""
 AC_ARG_ENABLE(xmlto,
  AS_HELP_STRING([--disable-xmlto], [Disable man page creation via xmlto]),
  xmlto="$enableval", xmlto="yes")
 if test "$xmlto" = "yes"; then
-  AC_CHECK_PROG([xmlto], [xmlto], [yes])
+  AC_CHECK_PROG([xmlto_available], [xmlto], [yes])
 fi
-AM_CONDITIONAL(USE_XMLTO, test x"$xmlto" = xyes)
+AM_CONDITIONAL(USE_XMLTO, test x"$xmlto_available" = xyes)
 
 AC_ARG_WITH(
         [udev-rules-dir],
-- 
2.11.0
