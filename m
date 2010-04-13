From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH] Use thread-safe locale functions
Date: Tue, 13 Apr 2010 17:50:17 +0300
Message-ID: <1271170217-10904-1-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id C21131037E3
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 16:50:19 +0200 (CEST)
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
	by yop.chewa.net (Postfix) with SMTP id 16056678
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 16:50:18 +0200 (CEST)
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

setlocale() is not thread-safe. It can actually trigger a crash if
another thread uses locale informations at the same time in the process.
Library code should use POSIX newlocale/duplocale/uselocale/freelocale
instead. Those functions only change the locale data for the calling
thread.
---
 src/conf.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/src/conf.c b/src/conf.c
index 570c90f..ce252ab 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -499,22 +499,20 @@ static int safe_strtod(const char *str, double *val)
 {
 	char *end;
 	double v;
-	char *saved_locale;
-	char locstr[64]; /* enough? */
+	locale_t saved_locale, c_locale;
 	int err;
 
 	if (!*str)
 		return -EINVAL;
-	saved_locale = setlocale(LC_NUMERIC, NULL);
-	if (saved_locale) {
-		snprintf(locstr, sizeof(locstr), "%s", saved_locale);
-		setlocale(LC_NUMERIC, "C");
-	}
+	c_locale = newlocale(LC_NUMERIC_MASK, "C", 0);
+	saved_locale = uselocale(c_locale);
 	errno = 0;
 	v = strtod(str, &end);
 	err = -errno;
-	if (saved_locale)
-		setlocale(LC_NUMERIC, locstr);
+	if (c_locale != (locale_t)0) {
+		uselocale(saved_locale);
+		freelocale(c_locale);
+	}
 	if (err)
 		return err;
 	if (*end)
-- 
1.7.0.4
