From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] snd-usb-us122l: Delete calls to preempt_disable
Date: Fri, 30 Dec 2011 01:42:01 +0100
Message-ID: <201112300142.01658.fzu@wemgehoertderstaat.de>
References: <201101040120.38492.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout6.freenet.de (mout6.freenet.de [195.4.92.96])
	by alsa0.perex.cz (Postfix) with ESMTP id F02EA103A88
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 01:44:49 +0100 (CET)
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
	by mout6.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port
	25) (Exim 4.76 #1) id 1RgQaP-0001Oe-E8
	for alsa-devel@alsa-project.org; Fri, 30 Dec 2011 01:44:41 +0100
Received: from localhost ([::1]:44838 helo=mjail2.freenet.de)
	by mjail2.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (Exim
	4.76 #1) id 1RgQaP-00061d-AN
	for alsa-devel@alsa-project.org; Fri, 30 Dec 2011 01:44:41 +0100
Received: from [195.4.92.27] (port=52295 helo=17.mx.freenet.de)
	by mjail2.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (Exim
	4.76 #1) id 1RgQXs-0005oS-3j
	for alsa-devel@alsa-project.org; Fri, 30 Dec 2011 01:42:04 +0100
Received: from p5dd50250.dip0.t-ipconnect.de ([93.213.2.80]:61770
	helo=a64.localdomain)
	by 17.mx.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port
	25) (Exim 4.76 #1) id 1RgQXr-0005G0-Uo
	for alsa-devel@alsa-project.org; Fri, 30 Dec 2011 01:42:04 +0100
In-Reply-To: <201101040120.38492.fzu@wemgehoertderstaat.de>
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

They are not needed here.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: stable@kernel.org
---

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index 12ae034..dafcf79 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -673,7 +673,7 @@ dotry:
 		inurb->transfer_buffer_length =
 			inurb->number_of_packets *
 			inurb->iso_frame_desc[0].length;
-		preempt_disable();
+
 		if (u == 0) {
 			int now;
 			struct usb_device *dev = inurb->dev;
@@ -685,19 +685,17 @@ dotry:
 		}
 		err = usb_submit_urb(inurb, GFP_ATOMIC);
 		if (err < 0) {
-			preempt_enable();
 			snd_printk(KERN_ERR"usb_submit_urb(sk->inurb[%i])"
 				   " returned %i\n", u, err);
 			return err;
 		}
 		err = usb_submit_urb(outurb, GFP_ATOMIC);
 		if (err < 0) {
-			preempt_enable();
 			snd_printk(KERN_ERR"usb_submit_urb(sk->outurb[%i])"
 				   " returned %i\n", u, err);
 			return err;
 		}
-		preempt_enable();
+
 		if (inurb->start_frame != outurb->start_frame) {
 			snd_printd(KERN_DEBUG
 				   "u[%i] start_frames differ in:%u out:%u\n",
