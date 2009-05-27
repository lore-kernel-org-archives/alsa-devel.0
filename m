From: =?utf-8?q?Diego=20Elio=20=27Flameeyes=27=20Petten=C3=B2?=
	<flameeyes@gmail.com>
Subject: [PATCH 2/2] Also fix the configure for hdspconf for
	LIBS/LDFLAGS mistakes.
Date: Wed, 27 May 2009 23:20:34 +0200
Message-ID: <1243459234-1067-3-git-send-email-flameeyes@gmail.com>
References: <1243459234-1067-1-git-send-email-flameeyes@gmail.com>
	<1243459234-1067-2-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id C619724439
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 23:21:00 +0200 (CEST)
Received: by mail-fx0-f170.google.com with SMTP id 18so5283602fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2009 14:21:00 -0700 (PDT)
In-Reply-To: <1243459234-1067-2-git-send-email-flameeyes@gmail.com>
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

Commit 56970e8143b4d171a118d114b1ddfa7621401127 already took care of this
for the other tools, but hdspconf somewhat was excluded, fix this now.
---
 hdspconf/configure.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/hdspconf/configure.in b/hdspconf/configure.in
index 1aa6feb..a32ff5f 100644
--- a/hdspconf/configure.in
+++ b/hdspconf/configure.in
@@ -36,6 +36,6 @@ FLTK_CXXFLAGS="`$FLTK_CONFIG $fltk_config_args --cxxflags` -fno-exceptions"
 FLTK_LIBS=`$FLTK_CONFIG $fltk_config_args --ldflags`
 
 CXXFLAGS="$CXXFLAGS $ALSA_CFLAGS $FLTK_CXXFLAGS"
-LDFLAGS="$LDFLAGS $ALSA_LIBS $FLTK_LIBS"
+LIBS="$LIBS $ALSA_LIBS $FLTK_LIBS"
 
 AC_OUTPUT(Makefile src/Makefile pixmaps/Makefile)
-- 
1.6.3.1
