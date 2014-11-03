From: Andreas Schwab <schwab@suse.de>
Subject: [PATCH] snd_user_file: fix memory leak
Date: Mon, 03 Nov 2014 17:22:28 +0100
Message-ID: <mvmtx2ggsor.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E41726052A
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 17:22:29 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 18086AC0F
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 16:22:29 +0000 (UTC)
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

Call wordfree if and only if wordfree returns zero or WRDE_NOSPACE

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 src/userfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/userfile.c b/src/userfile.c
index 3a73836..72779da 100644
--- a/src/userfile.c
+++ b/src/userfile.c
@@ -44,19 +44,20 @@ int snd_user_file(const char *file, char **result)
 	err = wordexp(file, &we, WRDE_NOCMD);
 	switch (err) {
 	case WRDE_NOSPACE:
+		wordfree(&we);
 		return -ENOMEM;
 	case 0:
 		if (we.we_wordc == 1)
 			break;
+		wordfree(&we);
 		/* fall thru */
 	default:
-		wordfree(&we);
 		return -EINVAL;
 	}
 	*result = strdup(we.we_wordv[0]);
+	wordfree(&we);
 	if (*result == NULL)
 		return -ENOMEM;
-	wordfree(&we);
 	return 0;
 }
 
-- 
2.1.3

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
