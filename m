From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH alsa-lib 1/2] Check for thread-specific locale
	support
Date: Wed, 21 Apr 2010 19:37:47 +0300
Message-ID: <1271867868-31501-1-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id B9AB524530
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 18:37:50 +0200 (CEST)
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
	by yop.chewa.net (Postfix) with SMTP id 5E8CC577
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 18:37:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

---
 configure.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/configure.in b/configure.in
index f6df502..abc4687 100644
--- a/configure.in
+++ b/configure.in
@@ -64,6 +64,7 @@ dnl Checks for library functions.
 AC_PROG_GCC_TRADITIONAL
 AC_CHECK_FUNC([hsearch_r], [HAVE_HSEARCH_R=yes])
 AM_CONDITIONAL(ALSA_HSEARCH_R, [test "x$HAVE_HSEARCH_R" != xyes])
+AC_CHECK_FUNCS([uselocale])
 
 SAVE_LIBRARY_VERSION
 AC_SUBST(LIBTOOL_VERSION_INFO)
-- 
1.7.0.4
