From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/6] ALSA: snd-usb: add snd_usb_audio-wide mutex
Date: Thu, 12 Apr 2012 13:51:10 +0200
Message-ID: <1334231475-20980-2-git-send-email-zonque@gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id B644B2433D
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 13:51:24 +0200 (CEST)
In-Reply-To: <1334231475-20980-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

This is needed for new card-wide list operations.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/card.c     |    2 ++
 sound/usb/usbaudio.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 4a7be7b..6bc88b7 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -276,6 +276,7 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 
 static int snd_usb_audio_free(struct snd_usb_audio *chip)
 {
+	mutex_destroy(&chip->mutex);
 	kfree(chip);
 	return 0;
 }
@@ -336,6 +337,7 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 		return -ENOMEM;
 	}
 
+	mutex_init(&chip->mutex);
 	mutex_init(&chip->shutdown_mutex);
 	chip->index = idx;
 	chip->dev = dev;
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 3e2b035..a16c21d 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -36,6 +36,7 @@ struct snd_usb_audio {
 	struct snd_card *card;
 	struct usb_interface *pm_intf;
 	u32 usb_id;
+	struct mutex mutex;
 	struct mutex shutdown_mutex;
 	unsigned int shutdown:1;
 	unsigned int probing:1;
-- 
1.7.7.6
