From: Ingmar Vanhassel <ingmar@exherbo.org>
Subject: [PATCH] Allow opt-out from speex dependency
Date: Thu,  2 Jul 2009 13:42:05 +0200
Message-ID: <1246534925-21921-1-git-send-email-ingmar@exherbo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bach.exherbo.org (bach.exherbo.org [78.47.197.147])
	by alsa0.perex.cz (Postfix) with ESMTP id D61191037FA
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 13:59:38 +0200 (CEST)
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
Cc: Ingmar Vanhassel <ingmar@exherbo.org>
List-Id: alsa-devel@alsa-project.org

---
 configure.in |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

This patch makes the --with-speex configure option work as intended, allowing
to explicitly disable speex linking.

diff --git a/configure.in b/configure.in
index 36740e9..36d0d2a 100644
--- a/configure.in
+++ b/configure.in
@@ -106,14 +106,16 @@ AC_SUBST(AVCODEC_CFLAGS)
 AC_SUBST(AVCODEC_LIBS)
 AC_SUBST(AVCODEC_HEADER)
 
-PKG_CHECK_MODULES(speexdsp, [speexdsp >= 1.2], [HAVE_SPEEXDSP="yes"], [HAVE_SPEEXDSP=""])
-AM_CONDITIONAL(HAVE_SPEEXDSP, test "$HAVE_SPEEXDSP" = "yes")
-
 AC_ARG_WITH([speex],
 	AS_HELP_STRING([--with-speex={builtin|lib|no}],
 		[build speex resampler (built-in code, link with external lib, or no build)]),
 	[PPH=$withval], [PPH="lib"])
 
+if test "x$with_speex" != "xno"; then
+	PKG_CHECK_MODULES(speexdsp, [speexdsp >= 1.2], [HAVE_SPEEXDSP="yes"], [HAVE_SPEEXDSP=""])
+fi
+AM_CONDITIONAL(HAVE_SPEEXDSP, test "$HAVE_SPEEXDSP" = "yes")
+
 USE_LIBSPEEX=""
 if test "$PPH" = "lib"; then
 	if test "$HAVE_SPEEXDSP" = "yes"; then
-- 
1.6.3.3
