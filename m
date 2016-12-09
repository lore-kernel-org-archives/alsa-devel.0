From: Antonio Ospite <ao2@ao2.it>
Subject: [alsa-utils][PATCH 3/5] configure.ac: add a check for
	rst2man, a reStructuredText man page generator
Date: Fri,  9 Dec 2016 14:02:30 +0100
Message-ID: <20161209130232.19457-4-ao2@ao2.it>
References: <20161209130232.19457-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp209.alice.it (smtp209.alice.it [82.57.200.105])
 by alsa0.perex.cz (Postfix) with ESMTP id D5D2F267718
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 14:03:00 +0100 (CET)
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

Define a USE_RST2MAN conditional so that, when available, rst2man can be
used to generate man pages from reStructuredText source files.

The code follows what is done to check for xmlto.

On Debian system, the rst2man executable is provided by python-docutils
or python3-docutils.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 configure.ac | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configure.ac b/configure.ac
index c9629bb..d8fcf0f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -175,6 +175,15 @@ if test "$xmlto" = "yes"; then
 fi
 AM_CONDITIONAL(USE_XMLTO, test x"$xmlto_available" = xyes)
 
+rst2man_available=""
+AC_ARG_ENABLE(rst2man,
+ AS_HELP_STRING([--disable-rst2man], [Disable man page creation via rst2man]),
+ rst2man="$enableval", rst2man="yes")
+if test "$rst2man" = "yes"; then
+  AC_CHECK_PROG([rst2man_available], [rst2man], [yes])
+fi
+AM_CONDITIONAL(USE_RST2MAN, test x"$rst2man_available" = xyes)
+
 AC_ARG_WITH(
         [udev-rules-dir],
         AS_HELP_STRING([--with-udev-rules-dir=DIR],[Directory where to install udev rules to (default=auto)]),
-- 
2.11.0
