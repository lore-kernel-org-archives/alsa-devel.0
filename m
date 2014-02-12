From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/20] ALSA: sparc: Use SNDRV_DEV_CARD for card
	objects
Date: Wed, 12 Feb 2014 11:52:20 +0100
Message-ID: <1392202347-11774-14-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 105402651C8
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D8E3FAC86
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
 sound/sparc/amd7930.c | 2 +-
 sound/sparc/cs4231.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 4a85e1433472..a543172cad60 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -992,7 +992,7 @@ static int snd_amd7930_create(struct snd_card *card,
 
 	spin_unlock_irqrestore(&amd->lock, flags);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD,
 				  amd, &snd_amd7930_dev_ops)) < 0) {
 		snd_amd7930_free(amd);
 		return err;
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index dabc1ad331e2..72a4b53e4d33 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1855,7 +1855,7 @@ static int snd_cs4231_sbus_create(struct snd_card *card,
 	}
 	snd_cs4231_init(chip);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD,
 				  chip, &snd_cs4231_sbus_dev_ops)) < 0) {
 		snd_cs4231_sbus_free(chip);
 		return err;
@@ -2047,7 +2047,7 @@ static int snd_cs4231_ebus_create(struct snd_card *card,
 	}
 	snd_cs4231_init(chip);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD,
 				  chip, &snd_cs4231_ebus_dev_ops)) < 0) {
 		snd_cs4231_ebus_free(chip);
 		return err;
-- 
1.8.5.2
