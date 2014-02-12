From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/24] ALSA: parisc: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:28 +0100
Message-ID: <1392201340-27113-13-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ED775265019
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 82126AC82
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/parisc/harmony.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 67f56a2cee6a..4b20be79c1dd 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -959,8 +959,6 @@ snd_harmony_create(struct snd_card *card,
                 goto free_and_ret;
         }
 
-	snd_card_set_dev(card, &padev->dev);
-
 	*rchip = h;
 
 	return 0;
@@ -977,7 +975,7 @@ snd_harmony_probe(struct parisc_device *padev)
 	struct snd_card *card;
 	struct snd_harmony *h;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(&padev->dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
-- 
1.8.5.2
