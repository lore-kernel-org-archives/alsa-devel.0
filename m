From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH] Check if uselocale() is present
Date: Tue, 13 Apr 2010 18:54:53 +0300
Message-ID: <1271174093-2559-1-git-send-email-remi@remlab.net>
References: <4BC48B96.7040002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id A5842103830
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 17:54:55 +0200 (CEST)
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
	by yop.chewa.net (Postfix) with SMTP id E2215678
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 17:54:53 +0200 (CEST)
In-Reply-To: <4BC48B96.7040002@ladisch.de>
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
List-Id: alsa-devel@alsa-project.org

Otherwise, assume the C run-time does not depend on the locale (at least
not to format floating point numbers).
---
 configure.in |    1 +
 src/conf.c   |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/configure.in b/configure.in
index 9d985b8..e62e3bd 100644
--- a/configure.in
+++ b/configure.in
@@ -64,6 +64,7 @@ dnl Checks for library functions.
 AC_PROG_GCC_TRADITIONAL
 AC_CHECK_FUNC([hsearch_r], [HAVE_HSEARCH_R=yes])
 AM_CONDITIONAL(ALSA_HSEARCH_R, [test "x$HAVE_HSEARCH_R" != xyes])
+AC_CHECK_FUNCS([uselocale])
 
 SAVE_LIBRARY_VERSION
 AC_SUBST(LIBTOOL_VERSION_INFO)
diff --git a/src/conf.c b/src/conf.c
index ce252ab..d1d4a5f 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -499,20 +499,26 @@ static int safe_strtod(const char *str, double *val)
 {
 	char *end;
 	double v;
+#ifdef HAVE_USELOCALE
 	locale_t saved_locale, c_locale;
+#endif
 	int err;
 
 	if (!*str)
 		return -EINVAL;
+#ifdef HAVE_USELOCALE
 	c_locale = newlocale(LC_NUMERIC_MASK, "C", 0);
 	saved_locale = uselocale(c_locale);
+#endif
 	errno = 0;
 	v = strtod(str, &end);
 	err = -errno;
+#ifdef HAVE_USELOCALE
 	if (c_locale != (locale_t)0) {
 		uselocale(saved_locale);
 		freelocale(c_locale);
 	}
+#endif
 	if (err)
 		return err;
 	if (*end)
-- 
1.7.0.4
