From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [alsa-utils PATCH 2/3] Pass -D_GNU_SOURCE together
	with INCLUDES (for the preprocessor).
Date: Thu, 20 Jan 2011 16:02:25 +0100
Message-ID: <1295535746-24051-2-git-send-email-flameeyes@gmail.com>
References: <1295535746-24051-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BCAC024526
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 16:02:40 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 15so676838wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 07:02:40 -0800 (PST)
In-Reply-To: <1295535746-24051-1-git-send-email-flameeyes@gmail.com>
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

This removes this warning when rebuilding autotools:

alsaloop/Makefile.am:3: `CFLAGS' is a user variable, you should not
override it;
alsaloop/Makefile.am:3: use `AM_CFLAGS' instead.
---
 alsaloop/Makefile.am |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/alsaloop/Makefile.am b/alsaloop/Makefile.am
index f76eafd..840448f 100644
--- a/alsaloop/Makefile.am
+++ b/alsaloop/Makefile.am
@@ -1,6 +1,5 @@
-INCLUDES = -I$(top_srcdir)/include
+INCLUDES = -I$(top_srcdir)/include -D_GNU_SOURCE
 LDADD = -lm
-CFLAGS += -D_GNU_SOURCE
 if HAVE_SAMPLERATE
 LDADD += -lsamplerate
 endif
-- 
1.7.4.rc2
