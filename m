From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH alsa-lib 2/2] Use thread-safe locale functions
	if available
Date: Wed, 21 Apr 2010 19:37:48 +0300
Message-ID: <1271867868-31501-2-git-send-email-remi@remlab.net>
References: <1271867868-31501-1-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id F26E724531
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 18:37:50 +0200 (CEST)
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
	by yop.chewa.net (Postfix) with SMTP id B5772678
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 18:37:49 +0200 (CEST)
In-Reply-To: <1271867868-31501-1-git-send-email-remi@remlab.net>
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

setlocale() is not thread-safe. It can actually trigger a crash if
another thread uses locale informations at the same time in the process.
Library code should use POSIX newlocale/duplocale/uselocale/freelocale
instead. Those functions only change the locale data for the calling
thread.
---
 src/conf.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index 570c90f..5d8c5c9 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -499,22 +499,38 @@ static int safe_strtod(const char *str, double *val)
 {
 	char *end;
 	double v;
+#ifdef HAVE_USELOCALE
+	locale_t saved_locale, c_locale;
+#else
 	char *saved_locale;
 	char locstr[64]; /* enough? */
+#endif
 	int err;
 
 	if (!*str)
 		return -EINVAL;
+#ifdef HAVE_USELOCALE
+	c_locale = newlocale(LC_NUMERIC_MASK, "C", 0);
+	saved_locale = uselocale(c_locale);
+#else
 	saved_locale = setlocale(LC_NUMERIC, NULL);
 	if (saved_locale) {
 		snprintf(locstr, sizeof(locstr), "%s", saved_locale);
 		setlocale(LC_NUMERIC, "C");
 	}
+#endif
 	errno = 0;
 	v = strtod(str, &end);
 	err = -errno;
+#ifdef HAVE_USELOCALE
+	if (c_locale != (locale_t)0) {
+		uselocale(saved_locale);
+		freelocale(c_locale);
+	}
+#else
 	if (saved_locale)
 		setlocale(LC_NUMERIC, locstr);
+#endif
 	if (err)
 		return err;
 	if (*end)
-- 
1.7.0.4
