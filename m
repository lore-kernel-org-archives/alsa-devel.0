From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/20] staging: Use SNDRV_DEV_CARD for card
	objects
Date: Wed, 12 Feb 2014 11:52:24 +0100
Message-ID: <1392202347-11774-18-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B0592651CF
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3667AC8F
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
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

... instead of SNDRV_DEV_LOWLEVEL.
No functional change at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/media/go7007/snd-go7007.c      | 2 +-
 drivers/staging/media/solo6x10/solo6x10-g723.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/go7007/snd-go7007.c b/drivers/staging/media/go7007/snd-go7007.c
index 9eb2a20ae40a..32c5032284a3 100644
--- a/drivers/staging/media/go7007/snd-go7007.c
+++ b/drivers/staging/media/go7007/snd-go7007.c
@@ -251,7 +251,7 @@ int go7007_snd_init(struct go7007 *go)
 		kfree(gosnd);
 		return ret;
 	}
-	ret = snd_device_new(gosnd->card, SNDRV_DEV_LOWLEVEL, go,
+	ret = snd_device_new(gosnd->card, SNDRV_DEV_CARD, go,
 			&go7007_snd_device_ops);
 	if (ret < 0) {
 		kfree(gosnd);
diff --git a/drivers/staging/media/solo6x10/solo6x10-g723.c b/drivers/staging/media/solo6x10/solo6x10-g723.c
index 74f037b6166c..e825256a1f48 100644
--- a/drivers/staging/media/solo6x10/solo6x10-g723.c
+++ b/drivers/staging/media/solo6x10/solo6x10-g723.c
@@ -379,7 +379,7 @@ int solo_g723_init(struct solo_dev *solo_dev)
 	sprintf(card->longname, "%s on %s IRQ %d", card->shortname,
 		pci_name(solo_dev->pdev), solo_dev->pdev->irq);
 
-	ret = snd_device_new(card, SNDRV_DEV_LOWLEVEL, solo_dev, &ops);
+	ret = snd_device_new(card, SNDRV_DEV_CARD, solo_dev, &ops);
 	if (ret < 0)
 		goto snd_error;
 
-- 
1.8.5.2
