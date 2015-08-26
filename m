From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: usb-audio: Replace probing flag with
	active refcount
Date: Wed, 26 Aug 2015 16:16:08 +0200
Message-ID: <1440598569-4473-3-git-send-email-tiwai@suse.de>
References: <1440598569-4473-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DC1D2657A5
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 16:16:14 +0200 (CEST)
In-Reply-To: <1440598569-4473-1-git-send-email-tiwai@suse.de>
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
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: alsa-devel@alsa-project.org

We can use active refcount for preventing autopm during probe.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c     | 12 ++++--------
 sound/usb/usbaudio.h |  1 -
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index b6621bcba2dc..73c5833e7657 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -371,7 +371,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	chip->card = card;
 	chip->setup = device_setup[idx];
 	chip->autoclock = autoclock;
-	chip->probing = 1;
+	atomic_set(&chip->active, 1); /* avoid autopm during probing */
 	atomic_set(&chip->usage_count, 0);
 	atomic_set(&chip->shutdown, 0);
 
@@ -503,7 +503,7 @@ static int usb_audio_probe(struct usb_interface *intf,
 				goto __error;
 			}
 			chip = usb_chip[i];
-			chip->probing = 1;
+			atomic_inc(&chip->active); /* avoid autopm */
 			break;
 		}
 	}
@@ -563,8 +563,8 @@ static int usb_audio_probe(struct usb_interface *intf,
 
 	usb_chip[chip->index] = chip;
 	chip->num_interfaces++;
-	chip->probing = 0;
 	usb_set_intfdata(intf, chip);
+	atomic_dec(&chip->active);
 	mutex_unlock(&register_mutex);
 	return 0;
 
@@ -572,7 +572,7 @@ static int usb_audio_probe(struct usb_interface *intf,
 	if (chip) {
 		if (!chip->num_interfaces)
 			snd_card_free(chip->card);
-		chip->probing = 0;
+		atomic_dec(&chip->active);
 	}
 	mutex_unlock(&register_mutex);
 	return err;
@@ -668,8 +668,6 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
 {
 	if (atomic_read(&chip->shutdown))
 		return -EIO;
-	if (chip->probing)
-		return 0;
 	if (atomic_inc_return(&chip->active) == 1)
 		return usb_autopm_get_interface(chip->pm_intf);
 	return 0;
@@ -677,8 +675,6 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
 
 void snd_usb_autosuspend(struct snd_usb_audio *chip)
 {
-	if (chip->probing)
-		return;
 	if (atomic_dec_and_test(&chip->active))
 		usb_autopm_put_interface(chip->pm_intf);
 }
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index eb1ea7182cdd..33a176437e2e 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -37,7 +37,6 @@ struct snd_usb_audio {
 	struct usb_interface *pm_intf;
 	u32 usb_id;
 	struct mutex mutex;
-	unsigned int probing:1;
 	unsigned int autosuspended:1;	
 	atomic_t active;
 	atomic_t shutdown;
-- 
2.5.0
