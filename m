From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] alsactl: Fix potential NULL dereferences in
	daemon mode
Date: Fri,  9 Dec 2016 17:31:28 +0100
Message-ID: <20161209163128.22291-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 361CD2677F6
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 17:31:29 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 74D79ACC9
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 16:31:29 +0000 (UTC)
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

The code releasing the each card object may access to NULL when a
bogus count is given.  Add a NULL check just to make sure.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Something I forgot to merge, casually found in the working directory...

 alsactl/daemon.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/alsactl/daemon.c b/alsactl/daemon.c
index 127701efaf0f..4f0a935a3987 100644
--- a/alsactl/daemon.c
+++ b/alsactl/daemon.c
@@ -451,8 +451,10 @@ save:
 out:
 	free(pfd);
 	remove(pidfile);
-	for (i = 0; i < count; i++)
-		card_free(&cards[i]);
-	free(cards);
+	if (cards) {
+		for (i = 0; i < count; i++)
+			card_free(&cards[i]);
+		free(cards);
+	}
 	return 0;
 }
-- 
2.11.0
