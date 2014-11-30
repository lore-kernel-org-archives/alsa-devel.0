From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: [PATCH v2] ALSA: usb: Add support for Zoom R16/24
	capture and midi interfaces
Date: Sun, 30 Nov 2014 18:45:40 +0200
Message-ID: <1417365940-25381-1-git-send-email-pmatilai@laiskiainen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a58.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id C05EF2605E5
 for <alsa-devel@alsa-project.org>; Sun, 30 Nov 2014 17:45:49 +0100 (CET)
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
Cc: Panu Matilainen <pmatilai@laiskiainen.org>
List-Id: alsa-devel@alsa-project.org

This makes the midi interface and capture work out of the box with
R16 (and presumably R24 too but untested). Playback stream would also
seem to function fine except for one caveat: no sound is produced,
so it is disabled for now. Mixer descriptors are garbage and will
require further quirks to enable functionality, also disabled here.

Signed-off-by: Panu Matilainen <pmatilai@laiskiainen.org>
---
 sound/usb/quirks-table.h | 40 ++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks.c       |  8 ++++++++
 2 files changed, 48 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index c657752..c955663 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3203,6 +3203,46 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 
 {
 	/*
+	 * ZOOM R16/24 in audio interface mode.
+	 * Mixer descriptors are garbage, further quirks will be needed
+	 * to make any of it functional, thus disabled for now.
+	 * Playback stream appears to start and run fine but no sound
+	 * is produced, so also disabled for now.
+	 */
+	USB_DEVICE(0x1686, 0x00dd),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				/* Mixer */
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			{
+				/* Playback  */
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			{
+				/* Capture */
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+			},
+			{
+				/* Midi */
+				.ifnum = 3,
+				.type = QUIRK_MIDI_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = -1
+			},
+		}
+	}
+},
+
+{
+	/*
 	 * Some USB MIDI devices don't have an audio control interface,
 	 * so we have to grab MIDI streaming interfaces here.
 	 */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a5941f8..2e49193 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1160,6 +1160,14 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			break;
 		}
 	}
+
+	/* Zoom R16/24 needs a tiny delay here, otherwise requests like
+	 * get/set frequency return as failed despite actually succeeding.
+	 */
+	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x1686) &&
+	    (le16_to_cpu(dev->descriptor.idProduct) == 0x00dd) &&
+	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
+		mdelay(1);
 }
 
 /*
-- 
1.9.3
