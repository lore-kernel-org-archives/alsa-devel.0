From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v3] ALSA: pcsp: Use common error handling code
 in snd_card_pcsp_probe()
Date: Tue, 22 Aug 2017 17:47:26 +0200
Message-ID: <49a7aeef-ba4d-7962-83cc-60d90a5a02cf@users.sourceforge.net>
References: <08ee0d6b-788b-2845-6964-e1e55c2d2292@users.sourceforge.net>
 <20170822121625.syvr64kwyh5xjexg@mwanda> <s5hziar9483.wl-tiwai@suse.de>
 <f138ba40-a61f-cdab-3d9b-699dbcacad9d@users.sourceforge.net>
 <s5ho9r792yl.wl-tiwai@suse.de>
 <fc4d8c96-7de2-e8f0-4cb4-5dda795d298a@users.sourceforge.net>
 <s5hbmn78zmg.wl-tiwai@suse.de>
 <139363f6-e059-defb-357e-f18645ba9768@users.sourceforge.net>
 <s5h378j8xos.wl-tiwai@suse.de>
 <b434f976-33a1-7ced-55b5-b55487f2fb14@users.sourceforge.net>
 <s5hwp5v7i9h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CBBA266F0E
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 17:47:33 +0200 (CEST)
In-Reply-To: <s5hwp5v7i9h.wl-tiwai@suse.de>
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
To: alsa-devel@alsa-project.org, Dan Carpenter <dan.carpenter@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 22 Aug 2017 17:33:33 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v3:
* An approach to make a few checks for a failure predicate a bit safer
  was rejected today.

* An extra blank line was added before a label.

v2:
Two statements were moved together with an additional jump label to the end
of this function.

 sound/drivers/pcsp/pcsp.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 72e2d0012084..0dd3f46eb03e 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -108,22 +108,17 @@ static int snd_card_pcsp_probe(int devnum, struct device *dev)
 		return err;
 
 	err = snd_pcsp_create(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	if (!nopcm) {
 		err = snd_pcsp_new_pcm(&pcsp_chip);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err < 0)
+			goto free_card;
 	}
 	err = snd_pcsp_new_mixer(&pcsp_chip, nopcm);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	strcpy(card->driver, "PC-Speaker");
 	strcpy(card->shortname, "pcsp");
@@ -131,12 +126,14 @@ static int snd_card_pcsp_probe(int devnum, struct device *dev)
 		pcsp_chip.port);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static int alsa_card_pcsp_init(struct device *dev)
-- 
2.14.0
