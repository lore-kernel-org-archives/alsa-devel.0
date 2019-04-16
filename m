From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: emu10k1: Drop superfluous
	id-uniquification behavior
Date: Tue, 16 Apr 2019 20:44:14 +0200
Message-ID: <20190416184415.27837-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCBF4F89616
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 20:44:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A78F2AE7A
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 18:44:16 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The emu10k1 driver tries to create a unique id string by itself when
it's copied from the card list, but it's rather superfluous, as the
same thing will be done in ALSA core side at the card registration.
Let's drop the code.  This allows us removing snd_cards export.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emu10k1_main.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 61f85ff91cd9..0419c75bdf5a 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1882,22 +1882,8 @@ int snd_emu10k1_create(struct snd_card *card,
 			c->name, pci->vendor, pci->device,
 			emu->serial);
 
-	if (!*card->id && c->id) {
-		int i, n = 0;
+	if (!*card->id && c->id)
 		strlcpy(card->id, c->id, sizeof(card->id));
-		for (;;) {
-			for (i = 0; i < snd_ecards_limit; i++) {
-				if (snd_cards[i] && !strcmp(snd_cards[i]->id, card->id))
-					break;
-			}
-			if (i >= snd_ecards_limit)
-				break;
-			n++;
-			if (n >= SNDRV_CARDS)
-				break;
-			snprintf(card->id, sizeof(card->id), "%s_%d", c->id, n);
-		}
-	}
 
 	is_audigy = emu->audigy = c->emu10k2_chip;
 
-- 
2.16.4
