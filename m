From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/3] ALSA: usb: use TEAC UD-H01 quirk for more
	devices
Date: Mon, 22 Aug 2016 08:53:37 +0200
Message-ID: <1471848818-11860-2-git-send-email-daniel@zonque.org>
References: <1471848818-11860-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 89256266021
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 08:53:49 +0200 (CEST)
In-Reply-To: <1471848818-11860-1-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: norman.nolte@gmx.net, T.Gresens@intershop.de, clemens@ladisch.de, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The quirk seems to be necessary not only for TEAC UD-H01 devices, but to
more that are based on the Tenor 8802TL chipset. Devices built by T+A
are affected too, and they apparently all use the same USB PID:PID.

Extend the quirky handling for that device as well, and rename the
quirks flag.

Reported-and-tested-by: Thomas Gresens <T.Gresens@intershop.de>
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/usb/card.h     | 2 +-
 sound/usb/endpoint.c | 5 +++--
 sound/usb/quirks.c   | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 71778ca..111b0f0 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -92,7 +92,7 @@ struct snd_usb_endpoint {
 	unsigned int curframesize;      /* current packet size in frames (for capture) */
 	unsigned int syncmaxsize;	/* sync endpoint packet size */
 	unsigned int fill_max:1;	/* fill max packet size always */
-	unsigned int udh01_fb_quirk:1;	/* corrupted feedback data */
+	unsigned int tenor_fb_quirk:1;	/* corrupted feedback data */
 	unsigned int datainterval;      /* log_2 of data packet interval */
 	unsigned int syncinterval;	/* P for adaptive mode, 0 otherwise */
 	unsigned char silence_value;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 4b4ffa0..c317a8d 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1167,9 +1167,10 @@ void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 	if (f == 0)
 		return;
 
-	if (unlikely(sender->udh01_fb_quirk)) {
+	if (unlikely(sender->tenor_fb_quirk)) {
 		/*
-		 * The TEAC UD-H01 firmware sometimes changes the feedback value
+		 * Devices based on Tenor 8802 chipsets (TEAC UD-H01
+		 * and others) sometimes change the feedback value
 		 * by +/- 0x1.0000.
 		 */
 		if (f < ep->freqn - 0x8000)
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 299813f..d47d927 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1218,9 +1218,10 @@ void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 		ep->skip_packets = 16;
 
 	/* Work around devices that report unreasonable feedback data */
-	if (ep->chip->usb_id == USB_ID(0x0644, 0x8038) /* TEAC UD-H01 */ &&
+	if ((ep->chip->usb_id == USB_ID(0x0644, 0x8038) ||  /* TEAC UD-H01 */
+	     ep->chip->usb_id == USB_ID(0x1852, 0x5034)) && /* T+A Dac8 */
 	    ep->syncmaxsize == 4)
-		ep->udh01_fb_quirk = 1;
+		ep->tenor_fb_quirk = 1;
 }
 
 void snd_usb_set_interface_quirk(struct usb_device *dev)
-- 
2.5.5
