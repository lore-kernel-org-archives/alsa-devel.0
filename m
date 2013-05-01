From: Doug Goldstein <cardoe@cardoe.com>
Subject: [PATCH] alsactl: sprintf to snprintf prevent buffer
	overflow
Date: Wed,  1 May 2013 11:30:26 -0500
Message-ID: <1367425826-10970-1-git-send-email-cardoe@cardoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DBFF260309
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2013 18:30:32 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id ar20so2140166iec.28
 for <alsa-devel@alsa-project.org>; Wed, 01 May 2013 09:30:31 -0700 (PDT)
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
Cc: Doug Goldstein <cardoe@cardoe.com>
List-Id: alsa-devel@alsa-project.org

sprintf() is a bit dangerous unless you explicitly know your type size
and want to keep it in sync always. Its safer to just use snprintf() and
ensure your string doesn't overflow and is NULL terminated.

Signed-off-by: Doug Goldstein <cardoe@cardoe.com>
---
This was written to fix the buffer overflow crash in alsactl with the
1.0.27 release, which is documented in Gentoo bug #468160 [1]. The
issue is actually already fixed upstream by
95788fea25c1a59985828d4b91af0772d077600b however the fix just changes
the size and continues to use sprintf() which IMHO is still dangerous.
The attached patch will fix the issue in a safer manner for good.

[1] https://bugs.gentoo.org/show_bug.cgi?id=468160
---
 alsactl/lock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/alsactl/lock.c b/alsactl/lock.c
index fce208b..587a109 100644
--- a/alsactl/lock.c
+++ b/alsactl/lock.c
@@ -53,9 +53,9 @@ static int state_lock_(const char *file, int lock, int timeout)
 	lck.l_len = 11;
 	lck.l_pid = 0;
 	if (lock) {
-		sprintf(lcktxt, "%10li\n", (long)getpid());
+		snprintf(lcktxt, sizeof(lcktxt), "%10li\n", (long)getpid());
 	} else {
-		sprintf(lcktxt, "%10s\n", "");
+		snprintf(lcktxt, sizeof(lcktxt), "%10s\n", "");
 	}
 	while (fd < 0 && timeout-- > 0) {
 		fd = open(nfile, O_RDWR);
-- 
1.8.2.1
