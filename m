From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] configure.in: fix --without-softfloat
Date: Mon, 16 Nov 2009 11:14:54 +0100
Message-ID: <1258366495-10815-2-git-send-email-mkl@pengutronix.de>
References: <1258366495-10815-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B2C8E103897
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 11:15:07 +0100 (CET)
In-Reply-To: <1258366495-10815-1-git-send-email-mkl@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Using --without-softfloat or --with-softfloat=no results in using
softfloat. This patch fixes the problem.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 configure.in |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure.in b/configure.in
index cc8950f..040a3e7 100644
--- a/configure.in
+++ b/configure.in
@@ -206,9 +206,12 @@ AC_MSG_CHECKING(for softfloat)
 AC_ARG_WITH(softfloat,
   AS_HELP_STRING([--with-softfloat],
     [do you have floating point unit on this machine? (optional)]),
-  [  AC_DEFINE(HAVE_SOFT_FLOAT, "1", [Avoid calculation in float])
-     softfloat=yes ],)
+  [case "$withval" in
+  	y|yes) softfloat=yes ;;
+	*) softfloat=no ;;
+   esac],)
 if test "$softfloat" = "yes" ; then
+  AC_DEFINE(HAVE_SOFT_FLOAT, "1", [Avoid calculation in float])
   AC_MSG_RESULT(yes)
 else
   AC_MSG_RESULT(no)
-- 
1.6.5.2
