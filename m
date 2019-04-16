From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: core: Fix card races between
	register and disconnect
Date: Tue, 16 Apr 2019 17:21:03 +0200
Message-ID: <20190416152103.6189-3-tiwai@suse.de>
References: <20190416152103.6189-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98D81F896E4
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 17:21:05 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id F11BDAF1F
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 15:21:04 +0000 (UTC)
In-Reply-To: <20190416152103.6189-1-tiwai@suse.de>
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

There is a small race window in the card disconnection code that
allows the registration of another card with the very same card id.
This leads to a warning in procfs creation as caught by syzkaller.

The problem is that we delete snd_cards and snd_cards_lock entries at
the very beginning of the disconnection procedure.  This makes the
slot available to be assigned for another card object while the
disconnection procedure is being processed.  Then it becomes possible
to issue a procfs registration with the existing file name although we
check the conflict beforehand.

The fix is simply to move the snd_cards and snd_cards_lock clearances
at the end of the disconnection procedure.  The references to these
entries are merely either from the global proc files like
/proc/asound/cards or from the card registration / disconnection, so
it should be fine to shift at the very end.

Reported-by: syzbot+48df349490c36f9f54ab@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/init.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 0c4dc40376a7..079c12d64b0e 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -382,14 +382,7 @@ int snd_card_disconnect(struct snd_card *card)
 	card->shutdown = 1;
 	spin_unlock(&card->files_lock);
 
-	/* phase 1: disable fops (user space) operations for ALSA API */
-	mutex_lock(&snd_card_mutex);
-	snd_cards[card->number] = NULL;
-	clear_bit(card->number, snd_cards_lock);
-	mutex_unlock(&snd_card_mutex);
-	
-	/* phase 2: replace file->f_op with special dummy operations */
-	
+	/* replace file->f_op with special dummy operations */
 	spin_lock(&card->files_lock);
 	list_for_each_entry(mfile, &card->files_list, list) {
 		/* it's critical part, use endless loop */
@@ -405,7 +398,7 @@ int snd_card_disconnect(struct snd_card *card)
 	}
 	spin_unlock(&card->files_lock);	
 
-	/* phase 3: notify all connected devices about disconnection */
+	/* notify all connected devices about disconnection */
 	/* at this point, they cannot respond to any calls except release() */
 
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
@@ -421,6 +414,13 @@ int snd_card_disconnect(struct snd_card *card)
 		device_del(&card->card_dev);
 		card->registered = false;
 	}
+
+	/* disable fops (user space) operations for ALSA API */
+	mutex_lock(&snd_card_mutex);
+	snd_cards[card->number] = NULL;
+	clear_bit(card->number, snd_cards_lock);
+	mutex_unlock(&snd_card_mutex);
+
 #ifdef CONFIG_PM
 	wake_up(&card->power_sleep);
 #endif
-- 
2.16.4
