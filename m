From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/20] ALSA: parisc: Use SNDRV_DEV_CARD for
	card objects
Date: Wed, 12 Feb 2014 11:52:17 +0100
Message-ID: <1392202347-11774-11-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B65E2651C6
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CF5A4AC6E
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
 sound/parisc/harmony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 4b20be79c1dd..8664bfc4185c 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -954,7 +954,7 @@ snd_harmony_create(struct snd_card *card,
 	spin_lock_init(&h->mixer_lock);
 	spin_lock_init(&h->lock);
 
-        if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
+        if ((err = snd_device_new(card, SNDRV_DEV_CARD,
                                   h, &ops)) < 0) {
                 goto free_and_ret;
         }
-- 
1.8.5.2
