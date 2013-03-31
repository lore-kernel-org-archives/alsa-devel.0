From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 08/10] ALSA: usb-audio: UAC2: auto clock
	selection module param
Date: Sun, 31 Mar 2013 17:52:30 +0200
Message-ID: <1364745152-1762-9-git-send-email-eldad@fogrefinery.com>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id CEAFA26172D
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 17:53:26 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id e19so664059bku.26
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 08:53:26 -0700 (PDT)
In-Reply-To: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Add a module param to disable auto clock selection.
This is provided for users that expect the audio stream to
fail when the clock source is invalid (e.g., the word clock
was unintentionally disconnected).

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/card.c     | 4 ++++
 sound/usb/clock.c    | 2 +-
 sound/usb/usbaudio.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 314e8a2..dfbf317 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -82,6 +82,7 @@ static int pid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 };
 static int nrpacks = 8;		/* max. number of packets per urb */
 static int device_setup[SNDRV_CARDS]; /* device parameter for this card */
 static bool ignore_ctl_error;
+static bool noautoclk;
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for the USB audio adapter.");
@@ -100,6 +101,8 @@ MODULE_PARM_DESC(device_setup, "Specific device setup (if needed).");
 module_param(ignore_ctl_error, bool, 0444);
 MODULE_PARM_DESC(ignore_ctl_error,
 		 "Ignore errors from USB controller for mixer interfaces.");
+module_param(noautoclk, bool, 0444);
+MODULE_PARM_DESC(noautoclk, "Disables auto-clock selection for UAC2 devices.");
 
 /*
  * we keep the snd_usb_audio_t instances by ourselves for merging
@@ -354,6 +357,7 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 	chip->card = card;
 	chip->setup = device_setup[idx];
 	chip->nrpacks = nrpacks;
+	chip->noautoclk = noautoclk;
 	chip->probing = 1;
 
 	chip->usb_id = USB_ID(le16_to_cpu(dev->descriptor.idVendor),
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 6b79e25..e3075ca 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -216,7 +216,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 		cur = ret;
 		ret = __uac_clock_find_source(chip, selector->baCSourceID[ret - 1],
 					       visited, validate);
-		if (!validate || ret > 0)
+		if (!validate || ret > 0 || chip->noautoclk)
 			return ret;
 
 		/* The current clock source is invalid, try others. */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 1ac3fd9..4852eb0 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -56,6 +56,7 @@ struct snd_usb_audio {
 
 	int setup;			/* from the 'device_setup' module param */
 	int nrpacks;			/* from the 'nrpacks' module param */
+	bool noautoclk;			/* from the 'noautoclk' module param */
 
 	struct usb_host_interface *ctrl_intf;	/* the audio control interface */
 };
-- 
1.8.1.5
