From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/18] ALSA: mtpav: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:17 +0100
Message-ID: <1421665891-14475-5-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F02D2606B6
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:36 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D7AC7AC79
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:35 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
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

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/mtpav.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index 15769447688f..30e8a1d5bc87 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -414,8 +414,7 @@ static void snd_mtpav_output_timer(unsigned long data)
 
 	spin_lock_irqsave(&chip->spinlock, flags);
 	/* reprogram timer */
-	chip->timer.expires = 1 + jiffies;
-	add_timer(&chip->timer);
+	mod_timer(&chip->timer, 1 + jiffies);
 	/* process each port */
 	for (p = 0; p <= chip->num_ports * 2 + MTPAV_PIDX_BROADCAST; p++) {
 		struct mtpav_port *portp = &chip->ports[p];
@@ -428,8 +427,7 @@ static void snd_mtpav_output_timer(unsigned long data)
 /* spinlock held! */
 static void snd_mtpav_add_output_timer(struct mtpav *chip)
 {
-	chip->timer.expires = 1 + jiffies;
-	add_timer(&chip->timer);
+	mod_timer(&chip->timer, 1 + jiffies);
 }
 
 /* spinlock held! */
@@ -704,15 +702,13 @@ static int snd_mtpav_probe(struct platform_device *dev)
 
 	mtp_card = card->private_data;
 	spin_lock_init(&mtp_card->spinlock);
-	init_timer(&mtp_card->timer);
 	mtp_card->card = card;
 	mtp_card->irq = -1;
 	mtp_card->share_irq = 0;
 	mtp_card->inmidistate = 0;
 	mtp_card->outmidihwport = 0xffffffff;
-	init_timer(&mtp_card->timer);
-	mtp_card->timer.function = snd_mtpav_output_timer;
-	mtp_card->timer.data = (unsigned long) mtp_card;
+	setup_timer(&mtp_card->timer, snd_mtpav_output_timer,
+		    (unsigned long) mtp_card);
 
 	card->private_free = snd_mtpav_free;
 
-- 
2.2.1
