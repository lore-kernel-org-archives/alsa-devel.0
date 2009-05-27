From: =?utf-8?q?Diego=20Elio=20=27Flameeyes=27=20Petten=C3=B2?=
	<flameeyes@gmail.com>
Subject: [PATCH 1/2] Don't redeclare isblank().
Date: Wed, 27 May 2009 23:20:33 +0200
Message-ID: <1243459234-1067-2-git-send-email-flameeyes@gmail.com>
References: <1243459234-1067-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 5364B24426
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 23:20:54 +0200 (CEST)
Received: by mail-fx0-f170.google.com with SMTP id 18so5283602fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2009 14:20:54 -0700 (PDT)
In-Reply-To: <1243459234-1067-1-git-send-email-flameeyes@gmail.com>
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

While technically isblank() is a C library function, nothing stops it from
being a macro, and indeed it seems to be on glibc-2.10.

This should not be a problem because ctype.h already declares it on
probably all the systems where it's used.
---
 envy24control/strstr_icase_blank.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/envy24control/strstr_icase_blank.c b/envy24control/strstr_icase_blank.c
index af44854..4c325cf 100644
--- a/envy24control/strstr_icase_blank.c
+++ b/envy24control/strstr_icase_blank.c
@@ -48,7 +48,6 @@ int strstr_icase_blank(const char * const string1, const char * const string2)
 	char search_string[MAX_SEARCH_FIELD_LENGTH];
 	char *pstr;
 	int pos_first_non_blank;
-	int isblank(int c);
 
 	strncpy(search_string, string2, MAX_SEARCH_FIELD_LENGTH);
 	search_string[MAX_SEARCH_FIELD_LENGTH - 1] = '\0';
-- 
1.6.3.1
