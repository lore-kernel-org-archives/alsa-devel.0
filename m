From: Tanu Kaskinen <tanu.kaskinen@digia.com>
Subject: [PATCH] Add *.swp to .gitignore.
Date: Fri, 10 Aug 2012 13:24:44 +0300
Message-ID: <1344594284-21279-1-git-send-email-tanu.kaskinen@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.digia.com (smtp1.digia.com [82.118.214.156])
 by alsa0.perex.cz (Postfix) with ESMTP id 44BC6266429
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 11:55:15 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@digia.com>
List-Id: alsa-devel@alsa-project.org

These are vim swap files.

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@digia.com>
---
 .gitignore |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 64d0bc6..7f1827e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -27,6 +27,7 @@ ltconfig
 *.pc
 *.o
 *~
+*.swp
 include/config.h
 include/stamp-h1
 include/stamp-vh
-- 
1.7.9.5
