From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH 1/2] 6fire: make buffers DMA-able (pcm)
Date: Sun, 11 Aug 2013 11:11:19 +0200
Message-ID: <20130811111119.fdcc2d884cb4ca71a08d56b3@zoho.com>
References: <s5hli4d5uj7.wl%tiwai@suse.de>
 <Pine.LNX.4.44L0.1308071334590.886-100000@iolanthe.rowland.org>
 <s5hy58cafd0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
 by alsa0.perex.cz (Postfix) with ESMTP id 73EE1261688
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 11:11:26 +0200 (CEST)
In-Reply-To: <s5hy58cafd0.wl%tiwai@suse.de>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Patch makes pcm buffers DMA-able by allocating each one separately.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>
---
diff -Nur a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
--- a/sound/usb/6fire/pcm.c	2013-08-04 22:46:46.000000000 +0200
+++ b/sound/usb/6fire/pcm.c	2013-08-11 11:02:38.305774934 +0200
@@ -582,6 +582,33 @@
 	urb->instance.number_of_packets = PCM_N_PACKETS_PER_URB;
 }
 
+static int usb6fire_pcm_buffers_init(struct pcm_runtime *rt)
+{
+	int i;
+
+	for (i = 0; i < PCM_N_URBS; i++) {
+		rt->out_urbs[i].buffer = kzalloc(PCM_N_PACKETS_PER_URB
+				* PCM_MAX_PACKET_SIZE, GFP_KERNEL);
+		if (!rt->out_urbs[i].buffer)
+			return -ENOMEM;
+		rt->in_urbs[i].buffer = kzalloc(PCM_N_PACKETS_PER_URB
+				* PCM_MAX_PACKET_SIZE, GFP_KERNEL);
+		if (!rt->in_urbs[i].buffer)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static void usb6fire_pcm_buffers_destroy(struct pcm_runtime *rt)
+{
+	int i;
+
+	for (i = 0; i < PCM_N_URBS; i++) {
+		kfree(rt->out_urbs[i].buffer);
+		kfree(rt->in_urbs[i].buffer);
+	}
+}
+
 int usb6fire_pcm_init(struct sfire_chip *chip)
 {
 	int i;
@@ -593,6 +620,13 @@
 	if (!rt)
 		return -ENOMEM;
 
+	ret = usb6fire_pcm_buffers_init(rt);
+	if (ret) {
+		usb6fire_pcm_buffers_destroy(rt);
+		kfree(rt);
+		return ret;
+	}
+
 	rt->chip = chip;
 	rt->stream_state = STREAM_DISABLED;
 	rt->rate = ARRAY_SIZE(rates);
@@ -614,6 +648,7 @@
 
 	ret = snd_pcm_new(chip->card, "DMX6FireUSB", 0, 1, 1, &pcm);
 	if (ret < 0) {
+		usb6fire_pcm_buffers_destroy(rt);
 		kfree(rt);
 		snd_printk(KERN_ERR PREFIX "cannot create pcm instance.\n");
 		return ret;
@@ -625,6 +660,7 @@
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_ops);
 
 	if (ret) {
+		usb6fire_pcm_buffers_destroy(rt);
 		kfree(rt);
 		snd_printk(KERN_ERR PREFIX
 				"error preallocating pcm buffers.\n");
@@ -669,6 +705,9 @@
 
 void usb6fire_pcm_destroy(struct sfire_chip *chip)
 {
-	kfree(chip->pcm);
+	struct pcm_runtime *rt = chip->pcm;
+
+	usb6fire_pcm_buffers_destroy(rt);
+	kfree(rt);
 	chip->pcm = NULL;
 }
diff -Nur a/sound/usb/6fire/pcm.h b/sound/usb/6fire/pcm.h
--- a/sound/usb/6fire/pcm.h	2013-08-04 22:46:46.000000000 +0200
+++ b/sound/usb/6fire/pcm.h	2013-08-11 10:49:28.779700620 +0200
@@ -32,7 +32,7 @@
 	struct urb instance;
 	struct usb_iso_packet_descriptor packets[PCM_N_PACKETS_PER_URB];
 	/* END DO NOT SEPARATE */
-	u8 buffer[PCM_N_PACKETS_PER_URB * PCM_MAX_PACKET_SIZE];
+	u8 *buffer;
 
 	struct pcm_urb *peer;
 };
