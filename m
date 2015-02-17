From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb: Fix support for Denon DA-300USB DAC
	(ID 154e:1003)
Date: Tue, 17 Feb 2015 22:15:02 +0100
Message-ID: <1424207702-3426-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C43D261685
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 22:15:05 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 664E9AB0C
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 21:15:04 +0000 (UTC)
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

From: Frank C Guenther <bugzilla.frnkcg@spamgourmet.com>

Fix problem where playback of Denon DA-300USB DAC sometimes does not
start and leads to error messages like "clock source 41 is not valid,
cannot use".

Solution: Treat this device the same as other Denon/Marantz devices in
sound/usb/quirks.c.

Tested with both PCM and DSD formats.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=93261
Signed-off-by: Frank C Guenther <bugzilla.frnkcg@spamgourmet.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 5c0c05314df0..753a47de8459 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1127,6 +1127,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 	int err;
 
 	switch (subs->stream->chip->usb_id) {
+	case USB_ID(0x154e, 0x1003): /* Denon DA-300USB */
 	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
 	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
 
@@ -1206,6 +1207,7 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS) {
 
 		switch (le16_to_cpu(dev->descriptor.idProduct)) {
+		case 0x1003: /* Denon DA300-USB */
 		case 0x3005: /* Marantz HD-DAC1 */
 		case 0x3006: /* Marantz SA-14S1 */
 			mdelay(20);
@@ -1267,6 +1269,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 
 	/* Denon/Marantz devices with USB DAC functionality */
 	switch (chip->usb_id) {
+	case USB_ID(0x154e, 0x1003): /* Denon DA300-USB */
 	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
 	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
 		if (fp->altsetting == 2)
-- 
2.3.0
