From: Mario Kicherer <dev@kicherer.org>
Subject: [PATCH 1/3] snd-bcd2000: move MIDI part into own files
Date: Sat, 31 Jan 2015 22:34:23 +0100
Message-ID: <1422740065-20196-2-git-send-email-dev@kicherer.org>
References: <1422740065-20196-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F4D3260523
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 22:34:31 +0100 (CET)
In-Reply-To: <1422740065-20196-1-git-send-email-dev@kicherer.org>
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
Cc: Mario Kicherer <dev@kicherer.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mario Kicherer <dev@kicherer.org>
---
 sound/usb/bcd2000/Makefile  |   2 +-
 sound/usb/bcd2000/bcd2000.c | 353 +++-----------------------------------------
 sound/usb/bcd2000/bcd2000.h |  25 ++++
 sound/usb/bcd2000/midi.c    | 324 ++++++++++++++++++++++++++++++++++++++++
 sound/usb/bcd2000/midi.h    |  31 ++++
 5 files changed, 404 insertions(+), 331 deletions(-)
 create mode 100644 sound/usb/bcd2000/bcd2000.h
 create mode 100644 sound/usb/bcd2000/midi.c
 create mode 100644 sound/usb/bcd2000/midi.h

diff --git a/sound/usb/bcd2000/Makefile b/sound/usb/bcd2000/Makefile
index f09ccc0..bc64a21 100644
--- a/sound/usb/bcd2000/Makefile
+++ b/sound/usb/bcd2000/Makefile
@@ -1,3 +1,3 @@
-snd-bcd2000-y := bcd2000.o
+snd-bcd2000-y := bcd2000.o midi.o
 
 obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
\ No newline at end of file
diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 820d6ca..0f22bd9 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -20,52 +20,15 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/bitmap.h>
-#include <linux/usb.h>
-#include <linux/usb/audio.h>
-#include <sound/core.h>
-#include <sound/initval.h>
-#include <sound/rawmidi.h>
 
-#define PREFIX "snd-bcd2000: "
-#define BUFSIZE 64
+#include "bcd2000.h"
+#include "midi.h"
 
 static struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x1397, 0x00bd) },
 	{ },
 };
 
-static unsigned char device_cmd_prefix[] = {0x03, 0x00};
-
-static unsigned char bcd2000_init_sequence[] = {
-	0x07, 0x00, 0x00, 0x00, 0x78, 0x48, 0x1c, 0x81,
-	0xc4, 0x00, 0x00, 0x00, 0x5e, 0x53, 0x4a, 0xf7,
-	0x18, 0xfa, 0x11, 0xff, 0x6c, 0xf3, 0x90, 0xff,
-	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
-	0x18, 0xfa, 0x11, 0xff, 0x14, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0xf2, 0x34, 0x4a, 0xf7,
-	0x18, 0xfa, 0x11, 0xff
-};
-
-struct bcd2000 {
-	struct usb_device *dev;
-	struct snd_card *card;
-	struct usb_interface *intf;
-	int card_index;
-
-	int midi_out_active;
-	struct snd_rawmidi *rmidi;
-	struct snd_rawmidi_substream *midi_receive_substream;
-	struct snd_rawmidi_substream *midi_out_substream;
-
-	unsigned char midi_in_buf[BUFSIZE];
-	unsigned char midi_out_buf[BUFSIZE];
-
-	struct urb *midi_out_urb;
-	struct urb *midi_in_urb;
-
-	struct usb_anchor anchor;
-};
-
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 
@@ -74,291 +37,40 @@ DECLARE_BITMAP(devices_used, SNDRV_CARDS);
 static struct usb_driver bcd2000_driver;
 
 #ifdef CONFIG_SND_DEBUG
-static void bcd2000_dump_buffer(const char *prefix, const char *buf, int len)
+void bcd2000_dump_buffer(const char *prefix, const char *buf, int len)
 {
 	print_hex_dump(KERN_DEBUG, prefix,
 			DUMP_PREFIX_NONE, 16, 1,
 			buf, len, false);
 }
 #else
-static void bcd2000_dump_buffer(const char *prefix, const char *buf, int len) {}
+void bcd2000_dump_buffer(const char *prefix, const char *buf, int len) {}
 #endif
 
-static int bcd2000_midi_input_open(struct snd_rawmidi_substream *substream)
-{
-	return 0;
-}
-
-static int bcd2000_midi_input_close(struct snd_rawmidi_substream *substream)
-{
-	return 0;
-}
-
-/* (de)register midi substream from client */
-static void bcd2000_midi_input_trigger(struct snd_rawmidi_substream *substream,
-						int up)
-{
-	struct bcd2000 *bcd2k = substream->rmidi->private_data;
-	bcd2k->midi_receive_substream = up ? substream : NULL;
-}
-
-static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
-				const unsigned char *buf, unsigned int buf_len)
-{
-	unsigned int payload_length, tocopy;
-	struct snd_rawmidi_substream *midi_receive_substream;
-
-	midi_receive_substream = ACCESS_ONCE(bcd2k->midi_receive_substream);
-	if (!midi_receive_substream)
-		return;
-
-	bcd2000_dump_buffer(PREFIX "received from device: ", buf, buf_len);
-
-	if (buf_len < 2)
-		return;
-
-	payload_length = buf[0];
-
-	/* ignore packets without payload */
-	if (payload_length == 0)
-		return;
-
-	tocopy = min(payload_length, buf_len-1);
-
-	bcd2000_dump_buffer(PREFIX "sending to userspace: ",
-					&buf[1], tocopy);
-
-	snd_rawmidi_receive(midi_receive_substream,
-					&buf[1], tocopy);
-}
-
-static void bcd2000_midi_send(struct bcd2000 *bcd2k)
-{
-	int len, ret;
-	struct snd_rawmidi_substream *midi_out_substream;
-
-	BUILD_BUG_ON(sizeof(device_cmd_prefix) >= BUFSIZE);
-
-	midi_out_substream = ACCESS_ONCE(bcd2k->midi_out_substream);
-	if (!midi_out_substream)
-		return;
-
-	/* copy command prefix bytes */
-	memcpy(bcd2k->midi_out_buf, device_cmd_prefix,
-		sizeof(device_cmd_prefix));
-
-	/*
-	 * get MIDI packet and leave space for command prefix
-	 * and payload length
-	 */
-	len = snd_rawmidi_transmit(midi_out_substream,
-				bcd2k->midi_out_buf + 3, BUFSIZE - 3);
-
-	if (len < 0)
-		dev_err(&bcd2k->dev->dev, "%s: snd_rawmidi_transmit error %d\n",
-				__func__, len);
-
-	if (len <= 0)
-		return;
-
-	/* set payload length */
-	bcd2k->midi_out_buf[2] = len;
-	bcd2k->midi_out_urb->transfer_buffer_length = BUFSIZE;
-
-	bcd2000_dump_buffer(PREFIX "sending to device: ",
-			bcd2k->midi_out_buf, len+3);
-
-	/* send packet to the BCD2000 */
-	ret = usb_submit_urb(bcd2k->midi_out_urb, GFP_ATOMIC);
-	if (ret < 0)
-		dev_err(&bcd2k->dev->dev, PREFIX
-			"%s (%p): usb_submit_urb() failed, ret=%d, len=%d\n",
-			__func__, midi_out_substream, ret, len);
-	else
-		bcd2k->midi_out_active = 1;
-}
-
-static int bcd2000_midi_output_open(struct snd_rawmidi_substream *substream)
-{
-	return 0;
-}
-
-static int bcd2000_midi_output_close(struct snd_rawmidi_substream *substream)
-{
-	struct bcd2000 *bcd2k = substream->rmidi->private_data;
-
-	if (bcd2k->midi_out_active) {
-		usb_kill_urb(bcd2k->midi_out_urb);
-		bcd2k->midi_out_active = 0;
-	}
-
-	return 0;
-}
-
-/* (de)register midi substream from client */
-static void bcd2000_midi_output_trigger(struct snd_rawmidi_substream *substream,
-						int up)
-{
-	struct bcd2000 *bcd2k = substream->rmidi->private_data;
-
-	if (up) {
-		bcd2k->midi_out_substream = substream;
-		/* check if there is data userspace wants to send */
-		if (!bcd2k->midi_out_active)
-			bcd2000_midi_send(bcd2k);
-	} else {
-		bcd2k->midi_out_substream = NULL;
-	}
-}
-
-static void bcd2000_output_complete(struct urb *urb)
-{
-	struct bcd2000 *bcd2k = urb->context;
-
-	bcd2k->midi_out_active = 0;
-
-	if (urb->status)
-		dev_warn(&urb->dev->dev,
-			PREFIX "output urb->status: %d\n", urb->status);
-
-	if (urb->status == -ESHUTDOWN)
-		return;
-
-	/* check if there is more data userspace wants to send */
-	bcd2000_midi_send(bcd2k);
-}
-
-static void bcd2000_input_complete(struct urb *urb)
+static void bcd2000_disconnect(struct usb_interface *interface)
 {
-	int ret;
-	struct bcd2000 *bcd2k = urb->context;
-
-	if (urb->status)
-		dev_warn(&urb->dev->dev,
-			PREFIX "input urb->status: %i\n", urb->status);
+	struct bcd2000 *bcd2k = usb_get_intfdata(interface);
 
-	if (!bcd2k || urb->status == -ESHUTDOWN)
+	if (!bcd2k)
 		return;
 
-	if (urb->actual_length > 0)
-		bcd2000_midi_handle_input(bcd2k, urb->transfer_buffer,
-					urb->actual_length);
-
-	/* return URB to device */
-	ret = usb_submit_urb(bcd2k->midi_in_urb, GFP_ATOMIC);
-	if (ret < 0)
-		dev_err(&bcd2k->dev->dev, PREFIX
-			"%s: usb_submit_urb() failed, ret=%d\n",
-			__func__, ret);
-}
-
-static struct snd_rawmidi_ops bcd2000_midi_output = {
-	.open =    bcd2000_midi_output_open,
-	.close =   bcd2000_midi_output_close,
-	.trigger = bcd2000_midi_output_trigger,
-};
-
-static struct snd_rawmidi_ops bcd2000_midi_input = {
-	.open =    bcd2000_midi_input_open,
-	.close =   bcd2000_midi_input_close,
-	.trigger = bcd2000_midi_input_trigger,
-};
-
-static void bcd2000_init_device(struct bcd2000 *bcd2k)
-{
-	int ret;
-
-	init_usb_anchor(&bcd2k->anchor);
-	usb_anchor_urb(bcd2k->midi_out_urb, &bcd2k->anchor);
-	usb_anchor_urb(bcd2k->midi_in_urb, &bcd2k->anchor);
-
-	/* copy init sequence into buffer */
-	memcpy(bcd2k->midi_out_buf, bcd2000_init_sequence, 52);
-	bcd2k->midi_out_urb->transfer_buffer_length = 52;
-
-	/* submit sequence */
-	ret = usb_submit_urb(bcd2k->midi_out_urb, GFP_KERNEL);
-	if (ret < 0)
-		dev_err(&bcd2k->dev->dev, PREFIX
-			"%s: usb_submit_urb() out failed, ret=%d: ",
-			__func__, ret);
-	else
-		bcd2k->midi_out_active = 1;
-
-	/* pass URB to device to enable button and controller events */
-	ret = usb_submit_urb(bcd2k->midi_in_urb, GFP_KERNEL);
-	if (ret < 0)
-		dev_err(&bcd2k->dev->dev, PREFIX
-			"%s: usb_submit_urb() in failed, ret=%d: ",
-			__func__, ret);
-
-	/* ensure initialization is finished */
-	usb_wait_anchor_empty_timeout(&bcd2k->anchor, 1000);
-}
-
-static int bcd2000_init_midi(struct bcd2000 *bcd2k)
-{
-	int ret;
-	struct snd_rawmidi *rmidi;
-
-	ret = snd_rawmidi_new(bcd2k->card, bcd2k->card->shortname, 0,
-					1, /* output */
-					1, /* input */
-					&rmidi);
-
-	if (ret < 0)
-		return ret;
-
-	strlcpy(rmidi->name, bcd2k->card->shortname, sizeof(rmidi->name));
-
-	rmidi->info_flags = SNDRV_RAWMIDI_INFO_DUPLEX;
-	rmidi->private_data = bcd2k;
-
-	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
-					&bcd2000_midi_output);
-
-	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
-					&bcd2000_midi_input);
-
-	bcd2k->rmidi = rmidi;
-
-	bcd2k->midi_in_urb = usb_alloc_urb(0, GFP_KERNEL);
-	bcd2k->midi_out_urb = usb_alloc_urb(0, GFP_KERNEL);
-
-	if (!bcd2k->midi_in_urb || !bcd2k->midi_out_urb) {
-		dev_err(&bcd2k->dev->dev, PREFIX "usb_alloc_urb failed\n");
-		return -ENOMEM;
-	}
-
-	usb_fill_int_urb(bcd2k->midi_in_urb, bcd2k->dev,
-				usb_rcvintpipe(bcd2k->dev, 0x81),
-				bcd2k->midi_in_buf, BUFSIZE,
-				bcd2000_input_complete, bcd2k, 1);
-
-	usb_fill_int_urb(bcd2k->midi_out_urb, bcd2k->dev,
-				usb_sndintpipe(bcd2k->dev, 0x1),
-				bcd2k->midi_out_buf, BUFSIZE,
-				bcd2000_output_complete, bcd2k, 1);
-
-	bcd2000_init_device(bcd2k);
-
-	return 0;
-}
+	mutex_lock(&devices_mutex);
 
-static void bcd2000_free_usb_related_resources(struct bcd2000 *bcd2k,
-						struct usb_interface *interface)
-{
-	/* usb_kill_urb not necessary, urb is aborted automatically */
+	/* make sure that userspace cannot create new requests */
+	snd_card_disconnect(bcd2k->card);
 
-	usb_free_urb(bcd2k->midi_out_urb);
-	usb_free_urb(bcd2k->midi_in_urb);
+	bcd2000_free_midi(bcd2k);
 
 	if (bcd2k->intf) {
 		usb_set_intfdata(bcd2k->intf, NULL);
 		bcd2k->intf = NULL;
 	}
+
+	clear_bit(bcd2k->card_index, devices_used);
+
+	snd_card_free_when_closed(bcd2k->card);
+
+	mutex_unlock(&devices_mutex);
 }
 
 static int bcd2000_probe(struct usb_interface *interface,
@@ -383,6 +95,7 @@ static int bcd2000_probe(struct usb_interface *interface,
 
 	err = snd_card_new(&interface->dev, index[card_index], id[card_index],
 			THIS_MODULE, sizeof(*bcd2k), &card);
+
 	if (err < 0) {
 		mutex_unlock(&devices_mutex);
 		return err;
@@ -397,10 +110,10 @@ static int bcd2000_probe(struct usb_interface *interface,
 	snd_card_set_dev(card, &interface->dev);
 
 	strncpy(card->driver, "snd-bcd2000", sizeof(card->driver));
-	strncpy(card->shortname, "BCD2000", sizeof(card->shortname));
+	strncpy(card->shortname, DEVICENAME, sizeof(card->shortname));
 	usb_make_path(bcd2k->dev, usb_path, sizeof(usb_path));
 	snprintf(bcd2k->card->longname, sizeof(bcd2k->card->longname),
-		    "Behringer BCD2000 at %s",
+			"Behringer " DEVICENAME " at %s",
 			usb_path);
 
 	err = bcd2000_init_midi(bcd2k);
@@ -419,31 +132,11 @@ static int bcd2000_probe(struct usb_interface *interface,
 
 probe_error:
 	dev_info(&bcd2k->dev->dev, PREFIX "error during probing");
-	bcd2000_free_usb_related_resources(bcd2k, interface);
-	snd_card_free(card);
-	mutex_unlock(&devices_mutex);
-	return err;
-}
-
-static void bcd2000_disconnect(struct usb_interface *interface)
-{
-	struct bcd2000 *bcd2k = usb_get_intfdata(interface);
-
-	if (!bcd2k)
-		return;
-
-	mutex_lock(&devices_mutex);
-
-	/* make sure that userspace cannot create new requests */
-	snd_card_disconnect(bcd2k->card);
-
-	bcd2000_free_usb_related_resources(bcd2k, interface);
-
-	clear_bit(bcd2k->card_index, devices_used);
-
-	snd_card_free_when_closed(bcd2k->card);
 
+	bcd2000_disconnect(interface);
 	mutex_unlock(&devices_mutex);
+
+	return err;
 }
 
 static struct usb_driver bcd2000_driver = {
diff --git a/sound/usb/bcd2000/bcd2000.h b/sound/usb/bcd2000/bcd2000.h
new file mode 100644
index 0000000..a0e27c9
--- /dev/null
+++ b/sound/usb/bcd2000/bcd2000.h
@@ -0,0 +1,25 @@
+#ifndef BCD2000_H
+#define BCD2000_H
+
+#include <linux/usb.h>
+#include <linux/usb/audio.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+
+#define DEVICENAME "BCD2000"
+#define PREFIX "snd-bcd2000: "
+
+#include "midi.h"
+
+struct bcd2000 {
+	struct usb_device *dev;
+	struct snd_card *card;
+	struct usb_interface *intf;
+	int card_index;
+
+	struct bcd2000_midi midi;
+};
+
+void bcd2000_dump_buffer(const char *prefix, const char *buf, int len);
+
+#endif
diff --git a/sound/usb/bcd2000/midi.c b/sound/usb/bcd2000/midi.c
new file mode 100644
index 0000000..3f34e95
--- /dev/null
+++ b/sound/usb/bcd2000/midi.c
@@ -0,0 +1,324 @@
+/*
+ * Behringer BCD2000 driver
+ *
+ *   Copyright (C) 2014 Mario Kicherer (dev@kicherer.org)
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include "bcd2000.h"
+#include "midi.h"
+
+/*
+ * For details regarding the usable MIDI commands, please see the official
+ * manual: http://www.behringer.com/EN/Products/BCD2000.aspx#softwareContent
+ */
+
+/*
+ * Some bytes of the init sequence are always the same, some only vary by a
+ * small amount and some values look random.
+ *
+ * After sending the init sequence, the device also returns data via the
+ * INTERRUPT IN endpoint which we simply ignore currently as its purpose is
+ * unknown.
+ */
+static unsigned char bcd2000_init_sequence[] = {
+	0x07, 0x00, 0x00, 0x00, /* always the same */
+	0x78, 0x48, 0x1c, 0x81, /* random, last byte is either 0x81 or 0xff */
+	0xc4, 0x00, 0x00, 0x00, /* always the same */
+
+	/* group A: */
+	0x5e,			/* always the same */
+	0x53,			/* observed 0x23, 0x43, 0x53, 0x83, 0xd3 */
+	0x4a,			/* looks random */
+	0xf7,			/* varies within a value of +- 4 */
+
+	0x18, 0xfa, 0x11, 0xff, /* Group B (repeats two times) */
+	0x6c, 0xf3, 0x90, 0xff, /* repeating values, last byte is always 0xff */
+	0x00, 0x00, 0x00, 0x00, /* always the same */
+	0x01, 0x00, 0x00, 0x00, /* always the same */
+
+	0x18, 0xfa, 0x11, 0xff, /* Group B again */
+	0x14, 0x00, 0x00, 0x00, /* always the same */
+	0x00, 0x00, 0x00, 0x00, /* always the same */
+	0xf2, 0x34, 0x4a, 0xf7, /* similar to group A */
+
+	0x18, 0xfa, 0x11, 0xff  /* Group B again */
+};
+
+static unsigned char device_cmd_prefix[] = MIDI_CMD_PREFIX_INIT;
+
+static int bcd2000_midi_input_open(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+static int bcd2000_midi_input_close(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+/* (de)register midi substream from client */
+static void bcd2000_midi_input_trigger(struct snd_rawmidi_substream *substream,
+						int up)
+{
+	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+
+	bcd2k->midi.receive_substream = up ? substream : NULL;
+}
+
+static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
+				const unsigned char *buf, unsigned int buf_len)
+{
+	unsigned int payload_length, tocopy;
+	struct snd_rawmidi_substream *receive_substream;
+
+	receive_substream = ACCESS_ONCE(bcd2k->midi.receive_substream);
+	if (!receive_substream)
+		return;
+
+	bcd2000_dump_buffer(PREFIX "received from device: ", buf, buf_len);
+
+	if (buf_len < 2)
+		return;
+
+	payload_length = buf[0];
+
+	/* ignore packets without payload */
+	if (payload_length == 0)
+		return;
+
+	tocopy = min(payload_length, buf_len-1);
+
+	bcd2000_dump_buffer(PREFIX "sending to userspace: ",
+					&buf[1], tocopy);
+
+	snd_rawmidi_receive(receive_substream,
+					&buf[1], tocopy);
+}
+
+static void bcd2000_midi_send(struct bcd2000 *bcd2k)
+{
+	int len, ret;
+	struct snd_rawmidi_substream *send_substream;
+
+	BUILD_BUG_ON(sizeof(device_cmd_prefix) >= MIDI_URB_BUFSIZE);
+
+	send_substream = ACCESS_ONCE(bcd2k->midi.send_substream);
+	if (!send_substream)
+		return;
+
+	/* copy command prefix bytes */
+	memcpy(bcd2k->midi.out_buffer, device_cmd_prefix,
+			sizeof(device_cmd_prefix));
+
+	/*
+	 * get MIDI packet and leave space for command prefix
+	 * and payload length
+	 */
+	len = snd_rawmidi_transmit(send_substream,
+				   bcd2k->midi.out_buffer + 3,
+				   MIDI_URB_BUFSIZE - 3);
+
+	if (len < 0)
+		dev_err(&bcd2k->dev->dev, "%s: snd_rawmidi_transmit error %d\n",
+				__func__, len);
+
+	if (len <= 0)
+		return;
+
+	/* set payload length */
+	bcd2k->midi.out_buffer[2] = len;
+	bcd2k->midi.out_urb->transfer_buffer_length = MIDI_URB_BUFSIZE;
+
+	bcd2000_dump_buffer(PREFIX "sending to device: ",
+						bcd2k->midi.out_buffer, len+3);
+
+	/* send packet to the BCD2000 */
+	ret = usb_submit_urb(bcd2k->midi.out_urb, GFP_ATOMIC);
+	if (ret < 0)
+		dev_err(&bcd2k->dev->dev, PREFIX
+			"%s (%p): usb_submit_urb() failed, ret=%d, len=%d\n",
+			__func__, send_substream, ret, len);
+	else
+		bcd2k->midi.out_active = 1;
+}
+
+static int bcd2000_midi_output_open(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+static int bcd2000_midi_output_close(struct snd_rawmidi_substream *substream)
+{
+	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+
+	if (bcd2k->midi.out_active) {
+		usb_kill_urb(bcd2k->midi.out_urb);
+		bcd2k->midi.out_active = 0;
+	}
+
+	return 0;
+}
+
+/* (de)register midi substream from client */
+static void bcd2000_midi_output_trigger(struct snd_rawmidi_substream *substream,
+						int up)
+{
+	struct bcd2000 *bcd2k = substream->rmidi->private_data;
+
+	if (up) {
+		bcd2k->midi.send_substream = substream;
+		/* check if there is data userspace wants to send */
+		if (!bcd2k->midi.out_active)
+			bcd2000_midi_send(bcd2k);
+	} else {
+		bcd2k->midi.send_substream = NULL;
+	}
+}
+
+static void bcd2000_output_complete(struct urb *urb)
+{
+	struct bcd2000 *bcd2k = urb->context;
+
+	bcd2k->midi.out_active = 0;
+
+	if (urb->status)
+		dev_warn(&urb->dev->dev,
+			PREFIX "output urb->status: %d\n", urb->status);
+
+	if (urb->status == -ESHUTDOWN)
+		return;
+
+	/* check if there is more data userspace wants to send */
+	bcd2000_midi_send(bcd2k);
+}
+
+static void bcd2000_input_complete(struct urb *urb)
+{
+	int ret;
+	struct bcd2000 *bcd2k = urb->context;
+
+	if (urb->status)
+		dev_warn(&urb->dev->dev,
+			PREFIX "input urb->status: %i\n", urb->status);
+
+	if (!bcd2k || urb->status == -ESHUTDOWN)
+		return;
+
+	if (urb->actual_length > 0)
+		bcd2000_midi_handle_input(bcd2k, urb->transfer_buffer,
+					urb->actual_length);
+
+	/* return URB to device */
+	ret = usb_submit_urb(bcd2k->midi.in_urb, GFP_ATOMIC);
+	if (ret < 0)
+		dev_err(&bcd2k->dev->dev, PREFIX
+			"%s: usb_submit_urb() failed, ret=%d\n",
+			__func__, ret);
+}
+
+static struct snd_rawmidi_ops bcd2000_midi_output = {
+	.open =    bcd2000_midi_output_open,
+	.close =   bcd2000_midi_output_close,
+	.trigger = bcd2000_midi_output_trigger,
+};
+
+static struct snd_rawmidi_ops bcd2000_midi_input = {
+	.open =    bcd2000_midi_input_open,
+	.close =   bcd2000_midi_input_close,
+	.trigger = bcd2000_midi_input_trigger,
+};
+
+int bcd2000_init_midi(struct bcd2000 *bcd2k)
+{
+	int ret;
+	struct snd_rawmidi *rmidi;
+	struct bcd2000_midi *midi;
+
+	ret = snd_rawmidi_new(bcd2k->card, bcd2k->card->shortname, 0,
+					1, /* output */
+					1, /* input */
+					&rmidi);
+
+	if (ret < 0)
+		return ret;
+
+	strlcpy(rmidi->name, bcd2k->card->shortname, sizeof(rmidi->name));
+
+	rmidi->info_flags = SNDRV_RAWMIDI_INFO_DUPLEX;
+	rmidi->private_data = bcd2k;
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+					&bcd2000_midi_output);
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+					&bcd2000_midi_input);
+
+	midi = &bcd2k->midi;
+	midi->rmidi = rmidi;
+
+	midi->in_urb = usb_alloc_urb(0, GFP_KERNEL);
+	midi->out_urb = usb_alloc_urb(0, GFP_KERNEL);
+
+	if (!midi->in_urb || !midi->out_urb) {
+		dev_err(&bcd2k->dev->dev, PREFIX "usb_alloc_urb failed\n");
+		return -ENOMEM;
+	}
+
+	usb_fill_int_urb(midi->in_urb, bcd2k->dev,
+				usb_rcvintpipe(bcd2k->dev, 0x81),
+				midi->in_buffer, MIDI_URB_BUFSIZE,
+				bcd2000_input_complete, bcd2k, 1);
+
+	usb_fill_int_urb(midi->out_urb, bcd2k->dev,
+				usb_sndintpipe(bcd2k->dev, 0x1),
+				midi->out_buffer, MIDI_URB_BUFSIZE,
+				bcd2000_output_complete, bcd2k, 1);
+
+	init_usb_anchor(&midi->anchor);
+	usb_anchor_urb(midi->out_urb, &midi->anchor);
+	usb_anchor_urb(midi->in_urb, &midi->anchor);
+
+	/* copy init sequence into buffer */
+	memcpy(midi->out_buffer, bcd2000_init_sequence, 52);
+	midi->out_urb->transfer_buffer_length = 52;
+
+	/* submit sequence */
+	ret = usb_submit_urb(midi->out_urb, GFP_KERNEL);
+	if (ret < 0)
+		dev_err(&bcd2k->dev->dev, PREFIX
+			"%s: usb_submit_urb() out failed, ret=%d: ",
+			__func__, ret);
+	else
+		midi->out_active = 1;
+
+	/* pass URB to device to enable button and controller events */
+	ret = usb_submit_urb(midi->in_urb, GFP_KERNEL);
+	if (ret < 0)
+		dev_err(&bcd2k->dev->dev, PREFIX
+			"%s: usb_submit_urb() in failed, ret=%d: ",
+			__func__, ret);
+
+	/* ensure initialization is finished */
+	usb_wait_anchor_empty_timeout(&midi->anchor, 1000);
+
+	return 0;
+}
+
+void bcd2000_free_midi(struct bcd2000 *bcd2k)
+{
+	/* usb_kill_urb not necessary, urb is aborted automatically */
+	usb_free_urb(bcd2k->midi.out_urb);
+	usb_free_urb(bcd2k->midi.in_urb);
+}
diff --git a/sound/usb/bcd2000/midi.h b/sound/usb/bcd2000/midi.h
new file mode 100644
index 0000000..a4d9fd8
--- /dev/null
+++ b/sound/usb/bcd2000/midi.h
@@ -0,0 +1,31 @@
+#ifndef MIDI_H
+#define MIDI_H
+
+#include <sound/rawmidi.h>
+
+#define MIDI_URB_BUFSIZE 64
+#define MIDI_CMD_PREFIX_INIT {0x03, 0x00}
+
+struct bcd2000;
+
+struct bcd2000_midi {
+	struct bcd2000 *bcd2k;
+
+	int out_active;
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_substream *receive_substream;
+	struct snd_rawmidi_substream *send_substream;
+
+	unsigned char in_buffer[MIDI_URB_BUFSIZE];
+	unsigned char out_buffer[MIDI_URB_BUFSIZE];
+
+	struct urb *out_urb;
+	struct urb *in_urb;
+
+	struct usb_anchor anchor;
+};
+
+int bcd2000_init_midi(struct bcd2000 *bcd2k);
+void bcd2000_free_midi(struct bcd2000 *bcd2k);
+
+#endif
-- 
2.0.5
