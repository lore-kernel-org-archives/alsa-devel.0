From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Check Marantz/Denon USB DACs
	in a single place
Date: Thu,  5 Mar 2015 14:45:50 +0100
Message-ID: <1425563150-9725-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 29D272605A2
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 14:45:52 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D068BAC1F
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 13:45:51 +0000 (UTC)
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

There are three places doing the same check.  Let's make them
together.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 753a47de8459..353532b8aee4 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1120,17 +1120,24 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 /* Marantz/Denon USB DACs need a vendor cmd to switch
  * between PCM and native DSD mode
  */
+static bool is_marantz_denon_dac(unsigned int id)
+{
+	switch (id) {
+	case USB_ID(0x154e, 0x1003): /* Denon DA-300USB */
+	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
+	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
+		return true;
+	}
+	return false;
+}
+
 int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 			      struct audioformat *fmt)
 {
 	struct usb_device *dev = subs->dev;
 	int err;
 
-	switch (subs->stream->chip->usb_id) {
-	case USB_ID(0x154e, 0x1003): /* Denon DA-300USB */
-	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
-	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
-
+	if (is_marantz_denon_dac(subs->stream->chip->usb_id)) {
 		/* First switch to alt set 0, otherwise the mode switch cmd
 		 * will not be accepted by the DAC
 		 */
@@ -1203,17 +1210,10 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	/* Marantz/Denon devices with USB DAC functionality need a delay
 	 * after each class compliant request
 	 */
-	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x154e) &&
-	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS) {
-
-		switch (le16_to_cpu(dev->descriptor.idProduct)) {
-		case 0x1003: /* Denon DA300-USB */
-		case 0x3005: /* Marantz HD-DAC1 */
-		case 0x3006: /* Marantz SA-14S1 */
-			mdelay(20);
-			break;
-		}
-	}
+	if (is_marantz_denon_dac(USB_ID(le16_to_cpu(dev->descriptor.idVendor),
+					le16_to_cpu(dev->descriptor.idProduct)))
+	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
+		mdelay(20);
 
 	/* Zoom R16/24 needs a tiny delay here, otherwise requests like
 	 * get/set frequency return as failed despite actually succeeding.
@@ -1268,15 +1268,9 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	}
 
 	/* Denon/Marantz devices with USB DAC functionality */
-	switch (chip->usb_id) {
-	case USB_ID(0x154e, 0x1003): /* Denon DA300-USB */
-	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
-	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
+	if (is_marantz_denon_dac(chip->usb_id)) {
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
-		break;
-	default:
-		break;
 	}
 
 	return 0;
-- 
2.3.1
