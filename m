From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Fix typo in HAVE_COMMON_PREPARE
Date: Tue, 12 Mar 2013 15:58:44 +0100
Message-ID: <1363100324-13026-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D107E265D79
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 15:58:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This typo caused snd_hda_codec_prepare never to be executed by hda-emu.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 configure.ac |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4b20f50..01a3a16 100644
--- a/configure.ac
+++ b/configure.ac
@@ -501,7 +501,7 @@ if grep -q snd_hda_codec_prepare hda/hda_codec.h; then
 else
   AC_MSG_RESULT(no)
 fi
-if test "$HAVE_COMMON_PREAPRE" = "yes"; then
+if test "$HAVE_COMMON_PREPARE" = "yes"; then
   AC_DEFINE(HAVE_COMMON_PREPARE)
 fi
 
-- 
1.7.9.5
