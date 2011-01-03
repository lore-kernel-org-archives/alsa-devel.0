From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] snd-usb-us122l: Fix MIDI output
Date: Mon, 3 Jan 2011 02:41:58 +0100
Message-ID: <201101030241.58904.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout8.freenet.de (mout8.freenet.de [195.4.92.98])
	by alsa0.perex.cz (Postfix) with ESMTP id 0865224772
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 02:42:02 +0100 (CET)
Received: from [195.4.92.20] (helo=10.mx.freenet.de)
	by mout8.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port
	25) (Exim 4.72 #3) id 1PZZQv-00031u-Bs
	for alsa-devel@alsa-project.org; Mon, 03 Jan 2011 02:42:01 +0100
Received: from p5dd50aee.dip0.t-ipconnect.de ([93.213.10.238]:63013
	helo=a64.localdomain)
	by 10.mx.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port
	25) (Exim 4.72 #3) id 1PZZQv-0006RP-5R
	for alsa-devel@alsa-project.org; Mon, 03 Jan 2011 02:42:01 +0100
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
List-Id: alsa-devel@alsa-project.org


The US-122L always reads 9 bytes per urb unless they are set to 0xFD.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: stable@kernel.org
---
 sound/usb/midi.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 25bce7e..b1f9ec9 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -850,8 +850,8 @@ static void snd_usbmidi_us122l_output(struct snd_usb_midi_out_endpoint *ep,
 		return;
 	}
 
-	memset(urb->transfer_buffer + count, 0xFD, 9 - count);
-	urb->transfer_buffer_length = count;
+	memset(urb->transfer_buffer + count, 0xFD, ep->max_transfer - count);
+	urb->transfer_buffer_length = ep->max_transfer;
 }
 
 static struct usb_protocol_ops snd_usbmidi_122l_ops = {
@@ -1295,6 +1295,13 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi* umidi,
 	case USB_ID(0x1a86, 0x752d): /* QinHeng CH345 "USB2.0-MIDI" */
 		ep->max_transfer = 4;
 		break;
+		/*
+		 * Some devices only work with 9 bytes packet size:
+		 */
+	case USB_ID(0x0644, 0x800E): /* Tascam US-122L */
+	case USB_ID(0x0644, 0x800F): /* Tascam US-144 */
+		ep->max_transfer = 9;
+		break;
 	}
 	for (i = 0; i < OUTPUT_URBS; ++i) {
 		buffer = usb_alloc_coherent(umidi->dev,
-- 
1.7.2.3
