From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 23/24] staging/media: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:39 +0100
Message-ID: <1392201340-27113-24-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F0F2265053
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C0EA4AC9D
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
 drivers/staging/media/go7007/snd-go7007.c      | 5 ++---
 drivers/staging/media/solo6x10/solo6x10-g723.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/go7007/snd-go7007.c b/drivers/staging/media/go7007/snd-go7007.c
index 16dd64920767..9eb2a20ae40a 100644
--- a/drivers/staging/media/go7007/snd-go7007.c
+++ b/drivers/staging/media/go7007/snd-go7007.c
@@ -245,8 +245,8 @@ int go7007_snd_init(struct go7007 *go)
 	spin_lock_init(&gosnd->lock);
 	gosnd->hw_ptr = gosnd->w_idx = gosnd->avail = 0;
 	gosnd->capturing = 0;
-	ret = snd_card_create(index[dev], id[dev], THIS_MODULE, 0,
-			      &gosnd->card);
+	ret = snd_card_new(go->dev, index[dev], id[dev], THIS_MODULE, 0,
+			   &gosnd->card);
 	if (ret < 0) {
 		kfree(gosnd);
 		return ret;
@@ -257,7 +257,6 @@ int go7007_snd_init(struct go7007 *go)
 		kfree(gosnd);
 		return ret;
 	}
-	snd_card_set_dev(gosnd->card, go->dev);
 	ret = snd_pcm_new(gosnd->card, "go7007", 0, 0, 1, &gosnd->pcm);
 	if (ret < 0) {
 		snd_card_free(gosnd->card);
diff --git a/drivers/staging/media/solo6x10/solo6x10-g723.c b/drivers/staging/media/solo6x10/solo6x10-g723.c
index 1db18c7972a0..74f037b6166c 100644
--- a/drivers/staging/media/solo6x10/solo6x10-g723.c
+++ b/drivers/staging/media/solo6x10/solo6x10-g723.c
@@ -366,8 +366,9 @@ int solo_g723_init(struct solo_dev *solo_dev)
 	/* Allows for easier mapping between video and audio */
 	sprintf(name, "Softlogic%d", solo_dev->vfd->num);
 
-	ret = snd_card_create(SNDRV_DEFAULT_IDX1, name, THIS_MODULE, 0,
-			      &solo_dev->snd_card);
+	ret = snd_card_new(&solo_dev->pdev->dev,
+			   SNDRV_DEFAULT_IDX1, name, THIS_MODULE, 0,
+			   &solo_dev->snd_card);
 	if (ret < 0)
 		return ret;
 
@@ -377,7 +378,6 @@ int solo_g723_init(struct solo_dev *solo_dev)
 	strcpy(card->shortname, "SOLO-6x10 Audio");
 	sprintf(card->longname, "%s on %s IRQ %d", card->shortname,
 		pci_name(solo_dev->pdev), solo_dev->pdev->irq);
-	snd_card_set_dev(card, &solo_dev->pdev->dev);
 
 	ret = snd_device_new(card, SNDRV_DEV_LOWLEVEL, solo_dev, &ops);
 	if (ret < 0)
-- 
1.8.5.2
