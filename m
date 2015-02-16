From: Joe Turner <joe@oampo.co.uk>
Subject: [PATCH v2] ALSA: usb-audio: Don't attempt to get
	Lifecam HD-5000 sample rate
Date: Mon, 16 Feb 2015 20:44:33 +0000
Message-ID: <1424119473-1830-1-git-send-email-joe@oampo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 229212606A3
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 21:45:04 +0100 (CET)
Received: by mail-we0-f170.google.com with SMTP id q59so31345060wes.1
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 12:45:03 -0800 (PST)
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
Cc: tiwai@suse.de, Joe Turner <joe@oampo.co.uk>
List-Id: alsa-devel@alsa-project.org

Adds a quirk to disable the check that the sample rate has been set correctly, as the Lifecam does not support getting the sample rate.

This means that we don't need to wait for the USB timeout when attempting to get the sample rate. Waiting for the timeout causes problems in some applications, which give up on the device acquisition process before it has had time to complete, resulting in no sound.

Signed-off-by: Joe Turner <joe@oampo.co.uk>
---
Changes in v2:
    - Fixed code style, as suggested by Takashi Iwai <tiwai@suse.de>

 sound/usb/clock.c  | 5 +++++
 sound/usb/quirks.c | 5 +++++
 sound/usb/quirks.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 03fed66..9d6e709 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -303,6 +303,11 @@ static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
 		return err;
 	}
 
+	/* Don't check the sample rate for devices which we know don't
+	* support reading */
+	if (snd_usb_get_sample_rate_quirk(chip))
+		return 0;
+
 	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
 				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
 				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a739841..50add5e 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1111,6 +1111,11 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	}
 }
 
+int snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
+{
+	/* MS Lifecam HD-5000 doesn't support reading the sample rate. */
+	return chip->usb_id == USB_ID(0x045E, 0x076D);
+}
 
 /* Marantz/Denon USB DACs need a vendor cmd to switch
  * between PCM and native DSD mode
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 1b86238..428c158 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -21,6 +21,8 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 			      struct audioformat *fmt);
 
+int snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip);
+
 int snd_usb_is_big_endian_format(struct snd_usb_audio *chip,
 				 struct audioformat *fp);
 
-- 
2.3.0
