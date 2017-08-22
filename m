From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: pcsp: Use common error handling code in
 snd_card_pcsp_probe()
Date: Tue, 22 Aug 2017 14:10:30 +0200
Message-ID: <08ee0d6b-788b-2845-6964-e1e55c2d2292@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id B7594266D1A
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:11:08 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 22 Aug 2017 14:00:21 +0200

Add a jump target so that a bit of exception handling can be better reused
in this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/drivers/pcsp/pcsp.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 72e2d0012084..c8ea4fed3905 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -108,22 +108,17 @@ static int snd_card_pcsp_probe(int devnum, struct device *dev)
 		return err;
 
 	err = snd_pcsp_create(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err)
+		goto free_card;
+
 	if (!nopcm) {
 		err = snd_pcsp_new_pcm(&pcsp_chip);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err)
+			goto free_card;
 	}
 	err = snd_pcsp_new_mixer(&pcsp_chip, nopcm);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err)
+		goto free_card;
 
 	strcpy(card->driver, "PC-Speaker");
 	strcpy(card->shortname, "pcsp");
@@ -131,7 +126,8 @@ static int snd_card_pcsp_probe(int devnum, struct device *dev)
 		pcsp_chip.port);
 
 	err = snd_card_register(card);
-	if (err < 0) {
+	if (err) {
+free_card:
 		snd_card_free(card);
 		return err;
 	}
-- 
2.14.0
