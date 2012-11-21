From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: usb-audio: Deprecate async_unlink
	option
Date: Wed, 21 Nov 2012 17:04:35 +0100
Message-ID: <1353513879-401-2-git-send-email-tiwai@suse.de>
References: <1353513879-401-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F095265D75
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 17:04:47 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BFFD2A3CEE
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 17:04:46 +0100 (CET)
In-Reply-To: <1353513879-401-1-git-send-email-tiwai@suse.de>
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

The async unlink behavior has been working over years.  The option was
provided only as a workaround for 2.4.x kernel.  Let's get rid of it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/ALSA-Configuration.txt | 3 ---
 sound/usb/card.c                                | 7 -------
 sound/usb/endpoint.c                            | 2 +-
 sound/usb/usbaudio.h                            | 1 -
 4 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index d90d8ec..b9cfd33 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -1905,7 +1905,6 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
     vid             - Vendor ID for the device (optional)
     pid             - Product ID for the device (optional)
     nrpacks	    - Max. number of packets per URB (default: 8)
-    async_unlink    - Use async unlink mode (default: yes)
     device_setup    - Device specific magic number (optional)
                     - Influence depends on the device
                     - Default: 0x0000 
@@ -1917,8 +1916,6 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
     NB: nrpacks parameter can be modified dynamically via sysfs.
         Don't put the value over 20.  Changing via sysfs has no sanity
 	check.
-    NB: async_unlink=0 would cause Oops.  It remains just for
-        debugging purpose (if any).
     NB: ignore_ctl_error=1 may help when you get an error at accessing
         the mixer element such as URB error -22.  This happens on some
         buggy USB device or the controller.
diff --git a/sound/usb/card.c b/sound/usb/card.c
index dbf7999..ccf95cf 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -25,9 +25,6 @@
  *
  *  NOTES:
  *
- *   - async unlink should be used for avoiding the sleep inside lock.
- *     2.4.22 usb-uhci seems buggy for async unlinking and results in
- *     oops.  in such a cse, pass async_unlink=0 option.
  *   - the linked URBs would be preferred but not used so far because of
  *     the instability of unlinking.
  *   - type II is not supported properly.  there is no device which supports
@@ -83,7 +80,6 @@ static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;/* Enable this card *
 static int vid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 };
 static int pid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 };
 static int nrpacks = 8;		/* max. number of packets per urb */
-static bool async_unlink = 1;
 static int device_setup[SNDRV_CARDS]; /* device parameter for this card */
 static bool ignore_ctl_error;
 
@@ -99,8 +95,6 @@ module_param_array(pid, int, NULL, 0444);
 MODULE_PARM_DESC(pid, "Product ID for the USB audio device.");
 module_param(nrpacks, int, 0644);
 MODULE_PARM_DESC(nrpacks, "Max. number of packets per URB.");
-module_param(async_unlink, bool, 0444);
-MODULE_PARM_DESC(async_unlink, "Use async unlink mode.");
 module_param_array(device_setup, int, NULL, 0444);
 MODULE_PARM_DESC(device_setup, "Specific device setup (if needed).");
 module_param(ignore_ctl_error, bool, 0444);
@@ -345,7 +339,6 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 	chip->card = card;
 	chip->setup = device_setup[idx];
 	chip->nrpacks = nrpacks;
-	chip->async_unlink = async_unlink;
 	chip->probing = 1;
 
 	chip->usb_id = USB_ID(le16_to_cpu(dev->descriptor.idVendor),
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 51a9aa3..d7382a5 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -523,7 +523,7 @@ static int deactivate_urbs(struct snd_usb_endpoint *ep, int force, int can_sleep
 	if (!force && ep->chip->shutdown) /* to be sure... */
 		return -EBADFD;
 
-	async = !can_sleep && ep->chip->async_unlink;
+	async = !can_sleep;
 
 	clear_bit(EP_FLAG_RUNNING, &ep->flags);
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index ef42797..1ac3fd9 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -56,7 +56,6 @@ struct snd_usb_audio {
 
 	int setup;			/* from the 'device_setup' module param */
 	int nrpacks;			/* from the 'nrpacks' module param */
-	int async_unlink;		/* from the 'async_unlink' module param */
 
 	struct usb_host_interface *ctrl_intf;	/* the audio control interface */
 };
-- 
1.8.0
