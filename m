From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: Fix the default suffix string with
	high card number
Date: Fri, 24 May 2013 16:46:43 +0200
Message-ID: <1369406804-29914-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 50FA32651A9
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 16:46:24 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1FB74A67C5
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 16:46:24 +0200 (CEST)
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

ALSA core tries to add a suffix as "_1" automatically when the given
id string conflicts.  The current code assumes implicitly that the max
card number is 16 so that the single hex "_X" suffix can be put.
However, with the dynamic device management, the card can be at most
32, so it can put even a non-hex character there.  Also, when the max
card number is increased in future, this would result in worse.

This patch rewrites the code to add the suffix string in a simpler
(thus cleaner) way.  It can support up to three digits, so it should
suffice for most requirements.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/init.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 6ef0640..ed4a481 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -549,7 +549,6 @@ static void snd_card_set_id_no_lock(struct snd_card *card, const char *src,
 				    const char *nid)
 {
 	int len, loops;
-	bool with_suffix;
 	bool is_default = false;
 	char *id;
 	
@@ -565,26 +564,23 @@ static void snd_card_set_id_no_lock(struct snd_card *card, const char *src,
 		is_default = true;
 	}
 
-	with_suffix = false;
+	len = strlen(id);
 	for (loops = 0; loops < SNDRV_CARDS; loops++) {
+		char *spos;
+		char sfxstr[5]; /* "_012" */
+		int sfxlen;
+
 		if (card_id_ok(card, id))
 			return; /* OK */
 
-		len = strlen(id);
-		if (!with_suffix) {
-			/* add the "_X" suffix */
-			char *spos = id + len;
-			if (len >  sizeof(card->id) - 3)
-				spos = id + sizeof(card->id) - 3;
-			strcpy(spos, "_1");
-			with_suffix = true;
-		} else {
-			/* modify the existing suffix */
-			if (id[len - 1] != '9')
-				id[len - 1]++;
-			else
-				id[len - 1] = 'A';
-		}
+		/* Add _XYZ suffix */
+		sprintf(sfxstr, "_%X", loops + 1);
+		sfxlen = strlen(sfxstr);
+		if (len + sfxlen >= sizeof(card->id))
+			spos = id + sizeof(card->id) - sfxlen - 1;
+		else
+			spos = id + len;
+		strcpy(spos, sfxstr);
 	}
 	/* fallback to the default id */
 	if (!is_default) {
-- 
1.8.2.3
