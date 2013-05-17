From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH alsa-utils] Require alsa-lib 1.0.27.
Date: Fri, 17 May 2013 14:30:46 +0200
Message-ID: <1368793846-32124-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id E973A2607D7
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 14:30:53 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 3C3B2628E6
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 14:30:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Both aplay and speaker-test use the new snd_pcm_abort() function, which was
introduced in alsa-lib 1.0.27.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 configure.in |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.in b/configure.in
index aae3e66..0023e4d 100644
--- a/configure.in
+++ b/configure.in
@@ -32,7 +32,7 @@ AC_PROG_MKDIR_P
 AC_PROG_LN_S
 AC_PROG_SED
 PKG_PROG_PKG_CONFIG
-AM_PATH_ALSA(1.0.24)
+AM_PATH_ALSA(1.0.27)
 if test "x$enable_alsatest" = "xyes"; then
 AC_CHECK_FUNC([snd_ctl_elem_add_enumerated],
 	      , [AC_ERROR([No user enum control support in alsa-lib])])
-- 
1.7.10.4
