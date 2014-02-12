From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/20] ALSA: usb-audio: Use proper SNDRV_DEV_*
	type
Date: Wed, 12 Feb 2014 11:52:14 +0100
Message-ID: <1392202347-11774-8-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 02DB32651BC
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C73B2AC05
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

Replace SNDRV_DEV_LOWLEVEL with more proper types, SNDRV_DEV_CARD for
the chip objects and SNDRV_DEV_CODEC for the mixer objects.
No functional change at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c  | 2 +-
 sound/usb/mixer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 0cfdc2d3b631..ee914a1166ed 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -384,7 +384,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	INIT_LIST_HEAD(&chip->midi_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, chip, &ops)) < 0) {
 		snd_usb_audio_free(chip);
 		snd_card_free(card);
 		return err;
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index aa9bc19aae68..8c152b02da5a 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2373,7 +2373,7 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 
 	snd_usb_mixer_apply_create_quirk(mixer);
 
-	err = snd_device_new(chip->card, SNDRV_DEV_LOWLEVEL, mixer, &dev_ops);
+	err = snd_device_new(chip->card, SNDRV_DEV_CODEC, mixer, &dev_ops);
 	if (err < 0)
 		goto _error;
 
-- 
1.8.5.2
