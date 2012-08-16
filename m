From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: add python compiled files to gitignore
Date: Thu, 16 Aug 2012 10:55:35 +0200
Message-ID: <1345107335-2475-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AFCB26505E
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 10:25:52 +0200 (CEST)
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

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 .gitignore |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 2281a23..5ab6918 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,6 +1,7 @@
 *~
 *.o
 *.a
+*.pyc
 hda-emu
 hda-decode-verb
 hda-encode-verb
-- 
1.7.9.5
