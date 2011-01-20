From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [alsa-utils PATCH 1/3] Add missing call to
	AM_PROG_CC_C_O.
Date: Thu, 20 Jan 2011 16:02:24 +0100
Message-ID: <1295535746-24051-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C2B524526
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 16:02:34 +0100 (CET)
Received: by wwe15 with SMTP id 15so676838wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 07:02:32 -0800 (PST)
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

Resolves this warning when rebuilding autotools:

alsactl/Makefile.am:10: compiling `alsactl.c' with per-target flags
requires `AM_PROG_CC_C_O' in `configure.in'
---
 configure.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/configure.in b/configure.in
index 561ca46..6892fbf 100644
--- a/configure.in
+++ b/configure.in
@@ -24,6 +24,7 @@ then
 fi
 
 AC_PROG_CC
+AM_PROG_CC_C_O
 dnl AC_PROG_CXX
 AC_PROG_INSTALL
 AC_PROG_MKDIR_P
-- 
1.7.4.rc2
