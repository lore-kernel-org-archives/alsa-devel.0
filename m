From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/9] ALSA: 6fire: use usb_fill_int_urb()
Date: Tue, 19 Jun 2018 23:55:13 +0200
Message-ID: <20180619215521.13688-2-bigeasy@linutronix.de>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id DEF742675FB
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 23:55:31 +0200 (CEST)
In-Reply-To: <20180619215521.13688-1-bigeasy@linutronix.de>
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
Cc: tglx@linutronix.de, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: alsa-devel@alsa-project.org

Using usb_fill_int_urb() helps to find code which initializes an
URB. A grep for members of the struct (like ->complete) reveal lots
of other things, too.
usb6fire_comm_init_urb() passes no transfer length.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/usb/6fire/comm.c | 20 +++++++-------------
 sound/usb/6fire/pcm.c  | 25 +++++++++++--------------
 2 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/sound/usb/6fire/comm.c b/sound/usb/6fire/comm.c
index 161215d78d95..6adc09a0c6fa 100644
--- a/sound/usb/6fire/comm.c
+++ b/sound/usb/6fire/comm.c
@@ -26,12 +26,9 @@ static void usb6fire_comm_init_urb(struct comm_runtime *rt, struct urb *urb,
 		u8 *buffer, void *context, void(*handler)(struct urb *urb))
 {
 	usb_init_urb(urb);
-	urb->transfer_buffer = buffer;
-	urb->pipe = usb_sndintpipe(rt->chip->dev, COMM_EP);
-	urb->complete = handler;
-	urb->context = context;
-	urb->interval = 1;
-	urb->dev = rt->chip->dev;
+	usb_fill_int_urb(urb, rt->chip->dev,
+			 usb_sndintpipe(rt->chip->dev, COMM_EP),
+			 buffer, 0, handler, context, 1);
 }
 
 static void usb6fire_comm_receiver_handler(struct urb *urb)
@@ -168,13 +165,10 @@ int usb6fire_comm_init(struct sfire_chip *chip)
 	rt->write16 = usb6fire_comm_write16;
 
 	/* submit an urb that receives communication data from device */
-	urb->transfer_buffer = rt->receiver_buffer;
-	urb->transfer_buffer_length = COMM_RECEIVER_BUFSIZE;
-	urb->pipe = usb_rcvintpipe(chip->dev, COMM_EP);
-	urb->dev = chip->dev;
-	urb->complete = usb6fire_comm_receiver_handler;
-	urb->context = rt;
-	urb->interval = 1;
+	usb_fill_int_urb(urb, chip->dev, usb_rcvintpipe(chip->dev, COMM_EP),
+			 rt->receiver_buffer, COMM_RECEIVER_BUFSIZE,
+			 usb6fire_comm_receiver_handler, rt, 1);
+
 	ret = usb_submit_urb(urb, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(rt->receiver_buffer);
diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index 2dd2518a71d3..e32cca0f3c2a 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -569,20 +569,14 @@ static const struct snd_pcm_ops pcm_ops = {
 };
 
 static void usb6fire_pcm_init_urb(struct pcm_urb *urb,
-				  struct sfire_chip *chip, bool in, int ep,
+				  struct sfire_chip *chip, unsigned int pipe,
 				  void (*handler)(struct urb *))
 {
 	urb->chip = chip;
 	usb_init_urb(&urb->instance);
-	urb->instance.transfer_buffer = urb->buffer;
-	urb->instance.transfer_buffer_length =
-			PCM_N_PACKETS_PER_URB * PCM_MAX_PACKET_SIZE;
-	urb->instance.dev = chip->dev;
-	urb->instance.pipe = in ? usb_rcvisocpipe(chip->dev, ep)
-			: usb_sndisocpipe(chip->dev, ep);
-	urb->instance.interval = 1;
-	urb->instance.complete = handler;
-	urb->instance.context = urb;
+	usb_fill_int_urb(&urb->instance, chip->dev, pipe, urb->buffer,
+			 PCM_N_PACKETS_PER_URB * PCM_MAX_PACKET_SIZE,
+			 handler, urb, 1);
 	urb->instance.number_of_packets = PCM_N_PACKETS_PER_URB;
 }
 
@@ -643,10 +637,13 @@ int usb6fire_pcm_init(struct sfire_chip *chip)
 	spin_lock_init(&rt->capture.lock);
 
 	for (i = 0; i < PCM_N_URBS; i++) {
-		usb6fire_pcm_init_urb(&rt->in_urbs[i], chip, true, IN_EP,
-				usb6fire_pcm_in_urb_handler);
-		usb6fire_pcm_init_urb(&rt->out_urbs[i], chip, false, OUT_EP,
-				usb6fire_pcm_out_urb_handler);
+		usb6fire_pcm_init_urb(&rt->in_urbs[i], chip,
+				      usb_rcvisocpipe(chip->dev, IN_EP),
+				      usb6fire_pcm_in_urb_handler);
+
+		usb6fire_pcm_init_urb(&rt->out_urbs[i], chip,
+				      usb_sndisocpipe(chip->dev, OUT_EP),
+				      usb6fire_pcm_out_urb_handler);
 
 		rt->in_urbs[i].peer = &rt->out_urbs[i];
 		rt->out_urbs[i].peer = &rt->in_urbs[i];
-- 
2.17.1
