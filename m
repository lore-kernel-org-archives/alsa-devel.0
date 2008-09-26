From: Eran Tromer <eran@tromer.org>
Subject: [PATCH] ALSA: usb-audio: add support for E-Mu Tracker
	Pre
Date: Fri, 26 Sep 2008 01:07:03 -0400
Message-ID: <48DC6DF7.8050807@tromer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outgoing.csail.mit.edu (outgoing.csail.mit.edu [128.30.2.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 94BCC103802
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 07:10:04 +0200 (CEST)
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
Cc: James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add support for the E-Mu "Tracker Pre" USB sound card, following
the example of the (very similar) E-Mu 0202 and E-Mu 0404 USB.

As with the 0202 and 0404 USB, functionality is very limited:
just a couple of sample rates, no volume/mute control, etc.

Signed-off-by: Eran Tromer <eran@tromer.org>
---
 sound/usb/usbaudio.c  |    3 ++-
 sound/usb/usbquirks.h |    7 +++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 410be4a..0cc6fd5 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -481,7 +481,7 @@ static int retire_playback_sync_urb_hs(struct snd_usb_substream *subs,
 }
 
 /*
- * process after E-Mu 0202/0404 high speed playback sync complete
+ * process after E-Mu 0202/0404/Tracker Pre high speed playback sync complete
  *
  * These devices return the number of samples per packet instead of the number
  * of samples per microframe.
@@ -2261,6 +2261,7 @@ static void init_substream(struct snd_usb_stream *as, int stream, struct audiofo
 		switch (as->chip->usb_id) {
 		case USB_ID(0x041e, 0x3f02): /* E-Mu 0202 USB */
 		case USB_ID(0x041e, 0x3f04): /* E-Mu 0404 USB */
+		case USB_ID(0x041e, 0x3f0a): /* E-Mu Tracker Pre */
 			subs->ops.retire_sync = retire_playback_sync_urb_hs_emu;
 			break;
 		}
diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index 82a8d14..b90d98b 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -62,6 +62,13 @@
 	.idProduct = 0x3f04,
 	.bInterfaceClass = USB_CLASS_AUDIO,
 },
+{
+	/* E-Mu Tracker Pre */
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor = 0x041e,
+	.idProduct = 0x3f0a,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+},
 
 /*
  * Logitech QuickCam: bDeviceClass is vendor-specific, so generic interface
