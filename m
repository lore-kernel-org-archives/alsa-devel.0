From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: mixart: Delete an error message for a
 failed memory allocation in snd_mixart_create()
Date: Sat, 12 Aug 2017 18:51:51 +0200
Message-ID: <b5d2cdc9-a2d7-a264-7802-99217cee65c4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B5326701A
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 18:51:58 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 18:45:42 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/mixart/mixart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 6d7fbf30618b..84f6b2651bf3 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1052,10 +1052,8 @@ static int snd_mixart_create(struct mixart_mgr *mgr, struct snd_card *card, int
 	};
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (! chip) {
-		dev_err(card->dev, "cannot allocate chip\n");
+	if (!chip)
 		return -ENOMEM;
-	}
 
 	chip->card = card;
 	chip->chip_idx = idx;
-- 
2.14.0
