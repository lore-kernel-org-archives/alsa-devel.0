From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 4/5] ALSA: usbmixer: bail out early when
	parsing audio class v2 descriptors
Date: Mon, 22 Feb 2010 23:49:12 +0100
Message-ID: <1266878953-9184-5-git-send-email-daniel@caiaq.de>
References: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4526E2446F
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 23:49:51 +0100 (CET)
In-Reply-To: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This is just a quick hack that needs to be removed once the new units
defined by the audio class v2.0 standard are supported.

However, it allows using these devices for now, without mixer support.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/usbmixer.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 5c21400..525caec 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -2211,7 +2211,8 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 		.dev_free = snd_usb_mixer_dev_free
 	};
 	struct usb_mixer_interface *mixer;
-	int err;
+	struct usb_host_interface *host_iface;
+	int err, protocol;
 
 	strcpy(chip->card->mixername, "USB Mixer");
 
@@ -2227,6 +2228,16 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 		return -ENOMEM;
 	}
 
+	host_iface = &usb_ifnum_to_if(chip->dev, ctrlif)->altsetting[0];
+	protocol = host_iface->desc.bInterfaceProtocol;
+
+	/* FIXME! */
+	if (protocol != UAC_VERSION_1) {
+		snd_printk(KERN_WARNING "mixer interface protocol 0x%02x not yet supported\n",
+					protocol);
+		return 0;
+	}
+
 	if ((err = snd_usb_mixer_controls(mixer)) < 0 ||
 	    (err = snd_usb_mixer_status_create(mixer)) < 0)
 		goto _error;
-- 
1.6.6.2
