From: "Phil Jordan" <lists@philjordan.eu>
Subject: [PATCH] snd_usb_audio: fix SB Extigy IR Remote
	regression
Date: Tue, 5 Aug 2008 11:01:00 +0200
Message-ID: <f31582140808050201o578663f9lc28f455b5d3dc726@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 388F424553
	for <Alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 11:01:01 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1486934ywk.2
	for <Alsa-devel@alsa-project.org>; Tue, 05 Aug 2008 02:01:00 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Phillip Michael Jordan <phil@philjordan.eu>

The support for the SB Extigy's remote seems to be broken in all
recent ALSA versions, including 1.0.17. The driver detects the event
correctly, then submits a URB to query the RC code. On the Extigy, the
URB is submitted with a length of 2 bytes. My hardware, however, only
replies with 1 byte, containing the correct RC button code. The
current implementation discards this as being too short. (line 1784 of
usbmixer.c)

This patch specifies a "minimum packet length" in the remote control
configuration. I've left the values for the Audigy 2/Live! the same as
the packet length, as I'm assuming the existing code works with them.
(I don't have the hardware to confirm) This fixes the Extigy RC
support, e.g. for use with Lirc.

Signed-off-by: Phillip Michael Jordan <phil@philjordan.eu>

---

An alternative, simpler fix would be to change the check on line 1784 to

if (urb->status < 0 || urb->actual_length < rc->offset + rc->length)

On the Extigy, this works out the same as the fix proposed in the
patch (urb->actual_length < 1), but I have no idea how this would
behave with the other types of hardware.

Comments & suggestions welcome!

phil


--- a/sound/usb/usbmixer.c	2008-08-05 10:30:12.729535006 +0200
+++ b/sound/usb/usbmixer.c	2008-08-05 10:29:23.497533626 +0200
@@ -59,12 +59,13 @@ static const struct rc_config {
 	u8  offset;
 	u8  length;
 	u8  packet_length;
+	u8  min_packet_length; /* minimum accepted length of the URB result */
 	u8  mute_mixer_id;
 	u32 mute_code;
 } rc_configs[] = {
-	{ USB_ID(0x041e, 0x3000), 0, 1, 2,  18, 0x0013 }, /* Extigy       */
-	{ USB_ID(0x041e, 0x3020), 2, 1, 6,  18, 0x0013 }, /* Audigy 2 NX  */
-	{ USB_ID(0x041e, 0x3040), 2, 2, 6,  2,  0x6e91 }, /* Live! 24-bit */
+	{ USB_ID(0x041e, 0x3000), 0, 1, 2, 1,  18, 0x0013 }, /* Extigy       */
+	{ USB_ID(0x041e, 0x3020), 2, 1, 6, 6,  18, 0x0013 }, /* Audigy 2 NX  */
+	{ USB_ID(0x041e, 0x3040), 2, 2, 6, 6,  2,  0x6e91 }, /* Live! 24-bit */
 };

 struct usb_mixer_interface {
@@ -1781,7 +1782,7 @@ static void snd_usb_soundblaster_remote_
 	const struct rc_config *rc = mixer->rc_cfg;
 	u32 code;

-	if (urb->status < 0 || urb->actual_length < rc->packet_length)
+	if (urb->status < 0 || urb->actual_length < rc->min_packet_length)
 		return;

 	code = mixer->rc_buffer[rc->offset];
