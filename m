From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] snd_usb_caiaq: use likely()/unlikely()
Date: Sat, 12 Apr 2008 22:13:31 +0200
Message-ID: <20080412201331.GA13041@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ADC424473
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 22:13:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id A01037F4036
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 22:13:34 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uYabnee953Rz for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 22:13:32 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use likely() and unlikely() in code which is called regularily.

Signed-off-by: Daniel Mack <daniel@caiaq.de>


--fdj2RfSjLxBAspz7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="snd-caiaq-1.3.7.diff"

diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index 24970a5..8cb417f 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -365,10 +365,10 @@ static void read_in_urb_mode2(struct snd_usb_caiaqdev *dev,
 
 				check_byte = MAKE_CHECKBYTE(dev, stream, i);
 				
-				if ((usb_buf[i] & 0x3f) != check_byte)
+				if (unlikely((usb_buf[i] & 0x3f) != check_byte))
 					dev->input_panic = 1;
 
-				if (usb_buf[i] & 0x80)
+				if (unlikely(usb_buf[i] & 0x80))
 					dev->output_panic = 1;
 			}
 		}
@@ -394,7 +394,7 @@ static void read_in_urb(struct snd_usb_caiaqdev *dev,
 			const struct urb *urb,
 			const struct usb_iso_packet_descriptor *iso)
 {
-	if (!dev->streaming)
+	if (unlikely(!dev->streaming))
 		return;
 
 	switch (dev->spec.data_alignment) {
@@ -406,7 +406,7 @@ static void read_in_urb(struct snd_usb_caiaqdev *dev,
 		break;
 	}
 
-	if (dev->input_panic || dev->output_panic) {
+	if (unlikely(dev->input_panic || dev->output_panic)) {
 		debug("streaming error detected %s %s\n", 
 				dev->input_panic ? "(input)" : "",
 				dev->output_panic ? "(output)" : "");
@@ -454,12 +454,12 @@ static void read_completed(struct urb *urb)
 	struct urb *out;
 	int frame, len, send_it = 0, outframe = 0;
 
-	if (urb->status || !info)
+	if (unlikely(urb->status || !info))
 		return;
 
 	dev = info->dev;
 
-	if (!dev->streaming)
+	if (unlikely(!dev->streaming))
 		return;
 
 	out = dev->data_urbs_out[info->index];
@@ -467,7 +467,7 @@ static void read_completed(struct urb *urb)
 	/* read the recently received packet and send back one which has
 	 * the same layout */
 	for (frame = 0; frame < FRAMES_PER_URB; frame++) {
-		if (urb->iso_frame_desc[frame].status)
+		if (unlikely(urb->iso_frame_desc[frame].status != 0))
 			continue;
 
 		len = urb->iso_frame_desc[outframe].actual_length;
@@ -488,7 +488,7 @@ static void read_completed(struct urb *urb)
 		outframe++;
 	}
 
-	if (send_it) {
+	if (likely(send_it)) {
 		out->number_of_packets = FRAMES_PER_URB;
 		out->transfer_flags = URB_ISO_ASAP;
 		usb_submit_urb(out, GFP_ATOMIC);
@@ -511,7 +511,7 @@ static void write_completed(struct urb *urb)
 	struct snd_usb_caiaq_cb_info *info = urb->context;
 	struct snd_usb_caiaqdev *dev = info->dev;
 
-	if (!dev->output_running) {
+	if (unlikely(!dev->output_running)) {
 		dev->output_running = 1;
 		wake_up(&dev->prepare_wait_queue);
 	}
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index e97d8b2..e1dbce5 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -42,7 +42,7 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.6");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.7");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
@@ -119,7 +119,7 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 	struct snd_usb_caiaqdev *dev = urb->context;
 	unsigned char *buf = urb->transfer_buffer;
 
-	if (urb->status || !dev) {
+	if (unlikely(urb->status || !dev)) {
 		log("received EP1 urb->status = %i\n", urb->status);
 		return;
 	}

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--fdj2RfSjLxBAspz7--
