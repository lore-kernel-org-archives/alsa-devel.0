From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 4/4] ALSA: line6: Remove `usb_' prefix from structs
Date: Fri,  6 Feb 2015 08:51:12 -0600
Message-ID: <1423234272-7348-5-git-send-email-chris@rorvick.com>
References: <1423234272-7348-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423234272-7348-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

It is just noise that makes lines longer.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/capture.c  |  2 +-
 sound/usb/line6/driver.c   | 42 +++++++++++++++++++-------------------
 sound/usb/line6/driver.h   | 22 ++++++++++----------
 sound/usb/line6/midi.c     | 24 ++++++++++------------
 sound/usb/line6/midi.h     |  6 +++---
 sound/usb/line6/pcm.c      |  5 ++---
 sound/usb/line6/pcm.h      |  4 ++--
 sound/usb/line6/playback.c |  2 +-
 sound/usb/line6/pod.c      | 50 ++++++++++++++++++++++------------------------
 sound/usb/line6/podhd.c    |  5 ++---
 sound/usb/line6/toneport.c | 45 ++++++++++++++++++++---------------------
 sound/usb/line6/variax.c   | 39 ++++++++++++++++++------------------
 12 files changed, 118 insertions(+), 128 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index f518fbb..fb23336 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -244,7 +244,7 @@ struct snd_pcm_ops snd_line6_capture_ops = {
 
 int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 {
-	struct usb_line6 *line6 = line6pcm->line6;
+	struct line6 *line6 = line6pcm->line6;
 	int i;
 
 	/* create audio URBs and fill in constant values: */
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 626b0c3..f10cb63 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -46,7 +46,7 @@ static const char line6_request_version[] = {
 	 Class for asynchronous messages.
 */
 struct message {
-	struct usb_line6 *line6;
+	struct line6 *line6;
 	const char *buffer;
 	int size;
 	int done;
@@ -62,7 +62,7 @@ static int line6_send_raw_message_async_part(struct message *msg,
 /*
 	Start to listen on endpoint.
 */
-static int line6_start_listen(struct usb_line6 *line6)
+static int line6_start_listen(struct line6 *line6)
 {
 	int err;
 
@@ -78,7 +78,7 @@ static int line6_start_listen(struct usb_line6 *line6)
 /*
 	Stop listening on endpoint.
 */
-static void line6_stop_listen(struct usb_line6 *line6)
+static void line6_stop_listen(struct line6 *line6)
 {
 	usb_kill_urb(line6->urb_listen);
 }
@@ -86,7 +86,7 @@ static void line6_stop_listen(struct usb_line6 *line6)
 /*
 	Send raw message in pieces of wMaxPacketSize bytes.
 */
-static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
+static int line6_send_raw_message(struct line6 *line6, const char *buffer,
 				  int size)
 {
 	int i, done = 0;
@@ -136,7 +136,7 @@ static int line6_send_raw_message_async_part(struct message *msg,
 					     struct urb *urb)
 {
 	int retval;
-	struct usb_line6 *line6 = msg->line6;
+	struct line6 *line6 = msg->line6;
 	int done = msg->done;
 	int bytes = min(msg->size - done, line6->max_packet_size);
 
@@ -173,7 +173,7 @@ EXPORT_SYMBOL_GPL(line6_start_timer);
 /*
 	Asynchronously send raw message.
 */
-int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
+int line6_send_raw_message_async(struct line6 *line6, const char *buffer,
 				 int size)
 {
 	struct message *msg;
@@ -206,7 +206,7 @@ EXPORT_SYMBOL_GPL(line6_send_raw_message_async);
 /*
 	Send asynchronous device version request.
 */
-int line6_version_request_async(struct usb_line6 *line6)
+int line6_version_request_async(struct line6 *line6)
 {
 	char *buffer;
 	int retval;
@@ -226,7 +226,7 @@ EXPORT_SYMBOL_GPL(line6_version_request_async);
 /*
 	Send sysex message in pieces of wMaxPacketSize bytes.
 */
-int line6_send_sysex_message(struct usb_line6 *line6, const char *buffer,
+int line6_send_sysex_message(struct line6 *line6, const char *buffer,
 			     int size)
 {
 	return line6_send_raw_message(line6, buffer,
@@ -240,7 +240,7 @@ EXPORT_SYMBOL_GPL(line6_send_sysex_message);
 	@param code sysex message code
 	@param size number of bytes between code and sysex end
 */
-char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1, int code2,
+char *line6_alloc_sysex_buffer(struct line6 *line6, int code1, int code2,
 			       int size)
 {
 	char *buffer = kmalloc(size + SYSEX_EXTRA_SIZE, GFP_ATOMIC);
@@ -262,7 +262,7 @@ EXPORT_SYMBOL_GPL(line6_alloc_sysex_buffer);
 */
 static void line6_data_received(struct urb *urb)
 {
-	struct usb_line6 *line6 = (struct usb_line6 *)urb->context;
+	struct line6 *line6 = (struct line6 *) urb->context;
 	struct midi_buffer *mb = &line6->line6midi->midibuf_in;
 	int done;
 
@@ -299,7 +299,7 @@ static void line6_data_received(struct urb *urb)
 /*
 	Read data from device.
 */
-int line6_read_data(struct usb_line6 *line6, int address, void *data,
+int line6_read_data(struct line6 *line6, int address, void *data,
 		    size_t datalen)
 {
 	struct usb_device *usbdev = line6->usbdev;
@@ -357,7 +357,7 @@ EXPORT_SYMBOL_GPL(line6_read_data);
 /*
 	Write data to device.
 */
-int line6_write_data(struct usb_line6 *line6, int address, void *data,
+int line6_write_data(struct line6 *line6, int address, void *data,
 		     size_t datalen)
 {
 	struct usb_device *usbdev = line6->usbdev;
@@ -403,7 +403,7 @@ EXPORT_SYMBOL_GPL(line6_write_data);
 	Read Line 6 device serial number.
 	(POD, TonePort, GuitarPort)
 */
-int line6_read_serial_number(struct usb_line6 *line6, int *serial_number)
+int line6_read_serial_number(struct line6 *line6, int *serial_number)
 {
 	return line6_read_data(line6, 0x80d0, serial_number,
 			       sizeof(*serial_number));
@@ -415,7 +415,7 @@ EXPORT_SYMBOL_GPL(line6_read_serial_number);
 */
 static void line6_destruct(struct snd_card *card)
 {
-	struct usb_line6 *line6 = card->private_data;
+	struct line6 *line6 = card->private_data;
 	struct usb_device *usbdev = line6->usbdev;
 
 	/* free buffer memory first: */
@@ -430,7 +430,7 @@ static void line6_destruct(struct snd_card *card)
 }
 
 /* get data from endpoint descriptor (see usb_maxpacket): */
-static void line6_get_interval(struct usb_line6 *line6)
+static void line6_get_interval(struct line6 *line6)
 {
 	struct usb_device *usbdev = line6->usbdev;
 	struct usb_host_endpoint *ep;
@@ -449,7 +449,7 @@ static void line6_get_interval(struct usb_line6 *line6)
 	}
 }
 
-static int line6_init_cap_control(struct usb_line6 *line6)
+static int line6_init_cap_control(struct line6 *line6)
 {
 	int ret;
 
@@ -482,12 +482,12 @@ int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
 		const char *driver_name,
 		const struct line6_properties *properties,
-		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id),
+		int (*private_init)(struct line6 *, const struct usb_device_id *id),
 		size_t data_size)
 {
 	struct usb_device *usbdev = interface_to_usbdev(interface);
 	struct snd_card *card;
-	struct usb_line6 *line6;
+	struct line6 *line6;
 	int interface_number;
 	int ret;
 
@@ -569,7 +569,7 @@ EXPORT_SYMBOL_GPL(line6_probe);
 */
 void line6_disconnect(struct usb_interface *interface)
 {
-	struct usb_line6 *line6 = usb_get_intfdata(interface);
+	struct line6 *line6 = usb_get_intfdata(interface);
 	struct usb_device *usbdev = interface_to_usbdev(interface);
 
 	if (!line6)
@@ -604,7 +604,7 @@ EXPORT_SYMBOL_GPL(line6_disconnect);
 */
 int line6_suspend(struct usb_interface *interface, pm_message_t message)
 {
-	struct usb_line6 *line6 = usb_get_intfdata(interface);
+	struct line6 *line6 = usb_get_intfdata(interface);
 	struct snd_line6_pcm *line6pcm = line6->line6pcm;
 
 	snd_power_change_state(line6->card, SNDRV_CTL_POWER_D3hot);
@@ -626,7 +626,7 @@ EXPORT_SYMBOL_GPL(line6_suspend);
 */
 int line6_resume(struct usb_interface *interface)
 {
-	struct usb_line6 *line6 = usb_get_intfdata(interface);
+	struct line6 *line6 = usb_get_intfdata(interface);
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL)
 		line6_start_listen(line6);
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 92a662a..13cd223 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -102,7 +102,7 @@ enum {
 	 Common data shared by all Line 6 devices.
 	 Corresponds to a pair of USB endpoints.
 */
-struct usb_line6 {
+struct line6 {
 	/* USB device */
 	struct usb_device *usbdev;
 
@@ -141,34 +141,34 @@ struct usb_line6 {
 	/* Length of message to be processed */
 	int message_length;
 
-	void (*process_message)(struct usb_line6 *);
-	void (*disconnect)(struct usb_line6 *line6);
+	void (*process_message)(struct line6 *);
+	void (*disconnect)(struct line6 *line6);
 };
 
-extern char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1,
+extern char *line6_alloc_sysex_buffer(struct line6 *line6, int code1,
 				      int code2, int size);
-extern int line6_read_data(struct usb_line6 *line6, int address, void *data,
+extern int line6_read_data(struct line6 *line6, int address, void *data,
 			   size_t datalen);
-extern int line6_read_serial_number(struct usb_line6 *line6,
+extern int line6_read_serial_number(struct line6 *line6,
 				    int *serial_number);
-extern int line6_send_raw_message_async(struct usb_line6 *line6,
+extern int line6_send_raw_message_async(struct line6 *line6,
 					const char *buffer, int size);
-extern int line6_send_sysex_message(struct usb_line6 *line6,
+extern int line6_send_sysex_message(struct line6 *line6,
 				    const char *buffer, int size);
 extern ssize_t line6_set_raw(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count);
 extern void line6_start_timer(struct timer_list *timer, unsigned long msecs,
 			      void (*function)(unsigned long),
 			      unsigned long data);
-extern int line6_version_request_async(struct usb_line6 *line6);
-extern int line6_write_data(struct usb_line6 *line6, int address, void *data,
+extern int line6_version_request_async(struct line6 *line6);
+extern int line6_write_data(struct line6 *line6, int address, void *data,
 			    size_t datalen);
 
 int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
 		const char *driver_name,
 		const struct line6_properties *properties,
-		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id),
+		int (*private_init)(struct line6 *, const struct usb_device_id *id),
 		size_t data_size);
 
 void line6_disconnect(struct usb_interface *interface);
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index cebea9b..0ad2e19 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -21,13 +21,13 @@
 #define line6_rawmidi_substream_midi(substream) \
 	((struct snd_line6_midi *)((substream)->rmidi->private_data))
 
-static int send_midi_async(struct usb_line6 *line6, unsigned char *data,
+static int send_midi_async(struct line6 *line6, unsigned char *data,
 			   int length);
 
 /*
 	Pass data received via USB to MIDI.
 */
-void line6_midi_receive(struct usb_line6 *line6, unsigned char *data,
+void line6_midi_receive(struct line6 *line6, unsigned char *data,
 			int length)
 {
 	if (line6->line6midi->substream_receive)
@@ -40,8 +40,7 @@ void line6_midi_receive(struct usb_line6 *line6, unsigned char *data,
 */
 static void line6_midi_transmit(struct snd_rawmidi_substream *substream)
 {
-	struct usb_line6 *line6 =
-	    line6_rawmidi_substream_midi(substream)->line6;
+	struct line6 *line6 = line6_rawmidi_substream_midi(substream)->line6;
 	struct snd_line6_midi *line6midi = line6->line6midi;
 	struct midi_buffer *mb = &line6midi->midibuf_out;
 	unsigned char chunk[LINE6_FALLBACK_MAXPACKETSIZE];
@@ -77,7 +76,7 @@ static void midi_sent(struct urb *urb)
 	unsigned long flags;
 	int status;
 	int num;
-	struct usb_line6 *line6 = (struct usb_line6 *)urb->context;
+	struct line6 *line6 = (struct line6 *) urb->context;
 
 	status = urb->status;
 	kfree(urb->transfer_buffer);
@@ -105,7 +104,7 @@ static void midi_sent(struct urb *urb)
 	Assumes that line6->line6midi->lock is held
 	(i.e., this function is serialized).
 */
-static int send_midi_async(struct usb_line6 *line6, unsigned char *data,
+static int send_midi_async(struct line6 *line6, unsigned char *data,
 			   int length)
 {
 	struct urb *urb;
@@ -156,8 +155,7 @@ static void line6_midi_output_trigger(struct snd_rawmidi_substream *substream,
 				      int up)
 {
 	unsigned long flags;
-	struct usb_line6 *line6 =
-	    line6_rawmidi_substream_midi(substream)->line6;
+	struct line6 *line6 = line6_rawmidi_substream_midi(substream)->line6;
 
 	line6->line6midi->substream_transmit = substream;
 	spin_lock_irqsave(&line6->line6midi->lock, flags);
@@ -170,8 +168,7 @@ static void line6_midi_output_trigger(struct snd_rawmidi_substream *substream,
 
 static void line6_midi_output_drain(struct snd_rawmidi_substream *substream)
 {
-	struct usb_line6 *line6 =
-	    line6_rawmidi_substream_midi(substream)->line6;
+	struct line6 *line6 = line6_rawmidi_substream_midi(substream)->line6;
 	struct snd_line6_midi *midi = line6->line6midi;
 
 	wait_event_interruptible(midi->send_wait,
@@ -191,8 +188,7 @@ static int line6_midi_input_close(struct snd_rawmidi_substream *substream)
 static void line6_midi_input_trigger(struct snd_rawmidi_substream *substream,
 				     int up)
 {
-	struct usb_line6 *line6 =
-	    line6_rawmidi_substream_midi(substream)->line6;
+	struct line6 *line6 = line6_rawmidi_substream_midi(substream)->line6;
 
 	if (up)
 		line6->line6midi->substream_receive = substream;
@@ -214,7 +210,7 @@ static struct snd_rawmidi_ops line6_midi_input_ops = {
 };
 
 /* Create a MIDI device */
-static int snd_line6_new_midi(struct usb_line6 *line6,
+static int snd_line6_new_midi(struct line6 *line6,
 			      struct snd_rawmidi **rmidi_ret)
 {
 	struct snd_rawmidi *rmidi;
@@ -252,7 +248,7 @@ static void snd_line6_midi_free(struct snd_rawmidi *rmidi)
 /*
 	Initialize the Line 6 MIDI subsystem.
 */
-int line6_init_midi(struct usb_line6 *line6)
+int line6_init_midi(struct line6 *line6)
 {
 	int err;
 	struct snd_rawmidi *rmidi;
diff --git a/sound/usb/line6/midi.h b/sound/usb/line6/midi.h
index cf82d69..2ca22b9 100644
--- a/sound/usb/line6/midi.h
+++ b/sound/usb/line6/midi.h
@@ -20,7 +20,7 @@
 
 struct snd_line6_midi {
 	/* Pointer back to the Line 6 driver data structure */
-	struct usb_line6 *line6;
+	struct line6 *line6;
 
 	/* MIDI substream for receiving (or NULL if not active) */
 	struct snd_rawmidi_substream *substream_receive;
@@ -44,8 +44,8 @@ struct snd_line6_midi {
 	struct midi_buffer midibuf_out;
 };
 
-extern int line6_init_midi(struct usb_line6 *line6);
-extern void line6_midi_receive(struct usb_line6 *line6, unsigned char *data,
+extern int line6_init_midi(struct line6 *line6);
+extern void line6_midi_receive(struct line6 *line6, unsigned char *data,
 			       int length);
 
 #endif
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 8461d6b..cd248f4 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -460,7 +460,7 @@ static void line6_cleanup_pcm(struct snd_pcm *pcm)
 }
 
 /* create a PCM device */
-static int snd_line6_new_pcm(struct usb_line6 *line6, struct snd_pcm **pcm_ret)
+static int snd_line6_new_pcm(struct line6 *line6, struct snd_pcm **pcm_ret)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -500,8 +500,7 @@ void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm)
 	Create and register the PCM device and mixer entries.
 	Create URBs for playback and capture.
 */
-int line6_init_pcm(struct usb_line6 *line6,
-		   struct line6_pcm_properties *properties)
+int line6_init_pcm(struct line6 *line6, struct line6_pcm_properties *properties)
 {
 	int i, err;
 	unsigned ep_read = line6->properties->ep_audio_r;
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 508410a..d2d1acb 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -139,7 +139,7 @@ struct line6_pcm_stream {
 
 struct snd_line6_pcm {
 	/* Pointer back to the Line 6 driver data structure */
-	struct usb_line6 *line6;
+	struct line6 *line6;
 
 	/* Properties. */
 	struct line6_pcm_properties *properties;
@@ -182,7 +182,7 @@ struct snd_line6_pcm {
 	unsigned long flags;
 };
 
-extern int line6_init_pcm(struct usb_line6 *line6,
+extern int line6_init_pcm(struct line6 *line6,
 			  struct line6_pcm_properties *properties);
 extern int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd);
 extern int snd_line6_prepare(struct snd_pcm_substream *substream);
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 05dee69..72debac 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -398,7 +398,7 @@ struct snd_pcm_ops snd_line6_playback_ops = {
 
 int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 {
-	struct usb_line6 *line6 = line6pcm->line6;
+	struct line6 *line6 = line6pcm->line6;
 	int i;
 
 	/* create audio URBs and fill in constant values: */
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 4c3d8cb..d109a72 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -56,9 +56,9 @@ enum {
 	LINE6_PODXTPRO,
 };
 
-struct usb_line6_pod {
+struct line6_pod {
 	/* Generic Line 6 USB data */
-	struct usb_line6 line6;
+	struct line6 line6;
 
 	/* Instrument monitor level */
 	int monitor_level;
@@ -176,9 +176,9 @@ static const char pod_version_header[] = {
 
 /* forward declarations: */
 static void pod_startup2(unsigned long data);
-static void pod_startup3(struct usb_line6_pod *pod);
+static void pod_startup3(struct line6_pod *pod);
 
-static char *pod_alloc_sysex_buffer(struct usb_line6_pod *pod, int code,
+static char *pod_alloc_sysex_buffer(struct line6_pod *pod, int code,
 				    int size)
 {
 	return line6_alloc_sysex_buffer(&pod->line6, POD_SYSEX_CODE, code,
@@ -188,9 +188,9 @@ static char *pod_alloc_sysex_buffer(struct usb_line6_pod *pod, int code,
 /*
 	Process a completely received message.
 */
-static void line6_pod_process_message(struct usb_line6 *line6)
+static void line6_pod_process_message(struct line6 *line6)
 {
-	struct usb_line6_pod *pod = (struct usb_line6_pod *) line6;
+	struct line6_pod *pod = (struct line6_pod *) line6;
 	const unsigned char *buf = pod->line6.buffer_message;
 
 	if (memcmp(buf, pod_version_header, sizeof(pod_version_header)) == 0) {
@@ -219,8 +219,7 @@ static void line6_pod_process_message(struct usb_line6 *line6)
 /*
 	Send system parameter (from integer).
 */
-static int pod_set_system_param_int(struct usb_line6_pod *pod, int value,
-				    int code)
+static int pod_set_system_param_int(struct line6_pod *pod, int value, int code)
 {
 	char *sysex;
 	static const int size = 5;
@@ -245,7 +244,7 @@ static ssize_t serial_number_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct usb_interface *interface = to_usb_interface(dev);
-	struct usb_line6_pod *pod = usb_get_intfdata(interface);
+	struct line6_pod *pod = usb_get_intfdata(interface);
 
 	return sprintf(buf, "%d\n", pod->serial_number);
 }
@@ -257,7 +256,7 @@ static ssize_t firmware_version_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	struct usb_interface *interface = to_usb_interface(dev);
-	struct usb_line6_pod *pod = usb_get_intfdata(interface);
+	struct line6_pod *pod = usb_get_intfdata(interface);
 
 	return sprintf(buf, "%d.%02d\n", pod->firmware_version / 100,
 		       pod->firmware_version % 100);
@@ -270,7 +269,7 @@ static ssize_t device_id_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct usb_interface *interface = to_usb_interface(dev);
-	struct usb_line6_pod *pod = usb_get_intfdata(interface);
+	struct line6_pod *pod = usb_get_intfdata(interface);
 
 	return sprintf(buf, "%d\n", pod->device_id);
 }
@@ -282,7 +281,7 @@ static ssize_t device_id_show(struct device *dev,
 	context). After the last one has finished, the device is ready to use.
 */
 
-static void pod_startup1(struct usb_line6_pod *pod)
+static void pod_startup1(struct line6_pod *pod)
 {
 	CHECK_STARTUP_PROGRESS(pod->startup_progress, POD_STARTUP_INIT);
 
@@ -293,8 +292,8 @@ static void pod_startup1(struct usb_line6_pod *pod)
 
 static void pod_startup2(unsigned long data)
 {
-	struct usb_line6_pod *pod = (struct usb_line6_pod *)data;
-	struct usb_line6 *line6 = &pod->line6;
+	struct line6_pod *pod = (struct line6_pod *) data;
+	struct line6 *line6 = &pod->line6;
 
 	CHECK_STARTUP_PROGRESS(pod->startup_progress, POD_STARTUP_VERSIONREQ);
 
@@ -302,7 +301,7 @@ static void pod_startup2(unsigned long data)
 	line6_version_request_async(line6);
 }
 
-static void pod_startup3(struct usb_line6_pod *pod)
+static void pod_startup3(struct line6_pod *pod)
 {
 	CHECK_STARTUP_PROGRESS(pod->startup_progress, POD_STARTUP_WORKQUEUE);
 
@@ -312,9 +311,9 @@ static void pod_startup3(struct usb_line6_pod *pod)
 
 static void pod_startup4(struct work_struct *work)
 {
-	struct usb_line6_pod *pod =
-	    container_of(work, struct usb_line6_pod, startup_work);
-	struct usb_line6 *line6 = &pod->line6;
+	struct line6_pod *pod = container_of(work, struct line6_pod,
+					     startup_work);
+	struct line6 *line6 = &pod->line6;
 
 	CHECK_STARTUP_PROGRESS(pod->startup_progress, POD_STARTUP_SETUP);
 
@@ -346,7 +345,7 @@ static int snd_pod_control_monitor_get(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
-	struct usb_line6_pod *pod = (struct usb_line6_pod *)line6pcm->line6;
+	struct line6_pod *pod = (struct line6_pod *) line6pcm->line6;
 
 	ucontrol->value.integer.value[0] = pod->monitor_level;
 	return 0;
@@ -357,7 +356,7 @@ static int snd_pod_control_monitor_put(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
-	struct usb_line6_pod *pod = (struct usb_line6_pod *)line6pcm->line6;
+	struct line6_pod *pod = (struct line6_pod *) line6pcm->line6;
 
 	if (ucontrol->value.integer.value[0] == pod->monitor_level)
 		return 0;
@@ -382,9 +381,9 @@ static struct snd_kcontrol_new pod_control_monitor = {
 /*
 	POD device disconnected.
 */
-static void line6_pod_disconnect(struct usb_line6 *line6)
+static void line6_pod_disconnect(struct line6 *line6)
 {
-	struct usb_line6_pod *pod = (struct usb_line6_pod *)line6;
+	struct line6_pod *pod = (struct line6_pod *) line6;
 	struct device *dev = line6->ifcdev;
 
 	/* remove sysfs entries: */
@@ -418,11 +417,10 @@ static int pod_create_files2(struct device *dev)
 /*
 	 Try to init POD device.
 */
-static int pod_init(struct usb_line6 *line6,
-		    const struct usb_device_id *id)
+static int pod_init(struct line6 *line6, const struct usb_device_id *id)
 {
 	int err;
-	struct usb_line6_pod *pod = (struct usb_line6_pod *) line6;
+	struct line6_pod *pod = (struct line6_pod *) line6;
 
 	line6->process_message = line6_pod_process_message;
 	line6->disconnect = line6_pod_disconnect;
@@ -576,7 +574,7 @@ static int pod_probe(struct usb_interface *interface,
 {
 	return line6_probe(interface, id, "Line 6 POD",
 			   &pod_properties_table[id->driver_info],
-			   pod_init, sizeof(struct usb_line6_pod));
+			   pod_init, sizeof(struct line6_pod));
 }
 
 static struct usb_driver pod_driver = {
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index f0a761b..d4399e7 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -79,8 +79,7 @@ static struct line6_pcm_properties podhd_pcm_properties = {
 /*
 	Try to init POD HD device.
 */
-static int podhd_init(struct usb_line6 *line6,
-		      const struct usb_device_id *id)
+static int podhd_init(struct line6 *line6, const struct usb_device_id *id)
 {
 	int err;
 
@@ -171,7 +170,7 @@ static int podhd_probe(struct usb_interface *interface,
 {
 	return line6_probe(interface, id, "Line 6 PODHD",
 			   &podhd_properties_table[id->driver_info],
-			   podhd_init, sizeof(struct usb_line6));
+			   podhd_init, sizeof(struct line6));
 }
 
 static struct usb_driver podhd_driver = {
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 53c0fbd..b5fe92f 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -32,18 +32,18 @@ enum line6_device_type {
 	LINE6_TONEPORT_UX2,
 };
 
-struct usb_line6_toneport;
+struct line6_toneport;
 
 struct toneport_led {
 	struct led_classdev dev;
 	char name[64];
-	struct usb_line6_toneport *toneport;
+	struct line6_toneport *toneport;
 	bool registered;
 };
 
-struct usb_line6_toneport {
+struct line6_toneport {
 	/* Generic Line 6 USB data */
-	struct usb_line6 line6;
+	struct line6 line6;
 
 	/* Source selector */
 	int source;
@@ -214,8 +214,8 @@ static int snd_toneport_source_get(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
-	struct usb_line6_toneport *toneport =
-	    (struct usb_line6_toneport *)line6pcm->line6;
+	struct line6_toneport *toneport =
+		(struct line6_toneport *) line6pcm->line6;
 	ucontrol->value.enumerated.item[0] = toneport->source;
 	return 0;
 }
@@ -225,8 +225,8 @@ static int snd_toneport_source_put(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
-	struct usb_line6_toneport *toneport =
-	    (struct usb_line6_toneport *)line6pcm->line6;
+	struct line6_toneport *toneport =
+		(struct line6_toneport *) line6pcm->line6;
 	unsigned int source;
 
 	source = ucontrol->value.enumerated.item[0];
@@ -243,8 +243,8 @@ static int snd_toneport_source_put(struct snd_kcontrol *kcontrol,
 
 static void toneport_start_pcm(unsigned long arg)
 {
-	struct usb_line6_toneport *toneport = (struct usb_line6_toneport *)arg;
-	struct usb_line6 *line6 = &toneport->line6;
+	struct line6_toneport *toneport = (struct line6_toneport *) arg;
+	struct line6 *line6 = &toneport->line6;
 
 	line6_pcm_acquire(line6->line6pcm, LINE6_STREAM_MONITOR);
 }
@@ -278,7 +278,7 @@ static struct snd_kcontrol_new toneport_control_source = {
 	(void cmd_0x02(byte red, byte green)
 */
 
-static bool toneport_has_led(struct usb_line6_toneport *toneport)
+static bool toneport_has_led(struct line6_toneport *toneport)
 {
 	switch (toneport->type) {
 	case LINE6_GUITARPORT:
@@ -294,7 +294,7 @@ static bool toneport_has_led(struct usb_line6_toneport *toneport)
 static const char * const led_colors[2] = { "red", "green" };
 static const int led_init_vals[2] = { 0x00, 0x26 };
 
-static void toneport_update_led(struct usb_line6_toneport *toneport)
+static void toneport_update_led(struct line6_toneport *toneport)
 {
 	toneport_send_cmd(toneport->line6.usbdev,
 			  (toneport->leds[0].dev.brightness << 8) | 0x0002,
@@ -309,7 +309,7 @@ static void toneport_led_brightness_set(struct led_classdev *led_cdev,
 	toneport_update_led(leds->toneport);
 }
 
-static int toneport_init_leds(struct usb_line6_toneport *toneport)
+static int toneport_init_leds(struct line6_toneport *toneport)
 {
 	struct device *dev = &toneport->line6.usbdev->dev;
 	int i, err;
@@ -334,7 +334,7 @@ static int toneport_init_leds(struct usb_line6_toneport *toneport)
 	return 0;
 }
 
-static void toneport_remove_leds(struct usb_line6_toneport *toneport)
+static void toneport_remove_leds(struct line6_toneport *toneport)
 {
 	struct toneport_led *led;
 	int i;
@@ -348,7 +348,7 @@ static void toneport_remove_leds(struct usb_line6_toneport *toneport)
 	}
 }
 
-static bool toneport_has_source_select(struct usb_line6_toneport *toneport)
+static bool toneport_has_source_select(struct line6_toneport *toneport)
 {
 	switch (toneport->type) {
 	case LINE6_TONEPORT_UX1:
@@ -365,10 +365,10 @@ static bool toneport_has_source_select(struct usb_line6_toneport *toneport)
 /*
 	Setup Toneport device.
 */
-static void toneport_setup(struct usb_line6_toneport *toneport)
+static void toneport_setup(struct line6_toneport *toneport)
 {
 	int ticks;
-	struct usb_line6 *line6 = &toneport->line6;
+	struct line6 *line6 = &toneport->line6;
 	struct usb_device *usbdev = line6->usbdev;
 
 	/* sync time on device with host: */
@@ -393,10 +393,9 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 /*
 	Toneport device disconnected.
 */
-static void line6_toneport_disconnect(struct usb_line6 *line6)
+static void line6_toneport_disconnect(struct line6 *line6)
 {
-	struct usb_line6_toneport *toneport =
-		(struct usb_line6_toneport *)line6;
+	struct line6_toneport *toneport = (struct line6_toneport *) line6;
 
 	del_timer_sync(&toneport->timer);
 
@@ -408,11 +407,11 @@ static void line6_toneport_disconnect(struct usb_line6 *line6)
 /*
 	 Try to init Toneport device.
 */
-static int toneport_init(struct usb_line6 *line6,
+static int toneport_init(struct line6 *line6,
 			 const struct usb_device_id *id)
 {
 	int err;
-	struct usb_line6_toneport *toneport =  (struct usb_line6_toneport *) line6;
+	struct line6_toneport *toneport =  (struct line6_toneport *) line6;
 
 	toneport->type = id->driver_info;
 	setup_timer(&toneport->timer, toneport_start_pcm,
@@ -559,7 +558,7 @@ static int toneport_probe(struct usb_interface *interface,
 {
 	return line6_probe(interface, id, "Line 6 TonePort",
 			   &toneport_properties_table[id->driver_info],
-			   toneport_init, sizeof(struct usb_line6_toneport));
+			   toneport_init, sizeof(struct line6_toneport));
 }
 
 static struct usb_driver toneport_driver = {
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 6f35c96..fc7438a 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -40,9 +40,9 @@ enum {
 	LINE6_VARIAX
 };
 
-struct usb_line6_variax {
+struct line6_variax {
 	/* Generic Line 6 USB data */
-	struct usb_line6 line6;
+	struct line6 line6;
 
 	/* Buffer for activation code */
 	unsigned char *buffer_activate;
@@ -86,7 +86,7 @@ static void variax_startup2(unsigned long data);
 static void variax_startup4(unsigned long data);
 static void variax_startup5(unsigned long data);
 
-static void variax_activate_async(struct usb_line6_variax *variax, int a)
+static void variax_activate_async(struct line6_variax *variax, int a)
 {
 	variax->buffer_activate[VARIAX_OFFSET_ACTIVATE] = a;
 	line6_send_raw_message_async(&variax->line6, variax->buffer_activate,
@@ -100,7 +100,7 @@ static void variax_activate_async(struct usb_line6_variax *variax, int a)
 	context). After the last one has finished, the device is ready to use.
 */
 
-static void variax_startup1(struct usb_line6_variax *variax)
+static void variax_startup1(struct line6_variax *variax)
 {
 	CHECK_STARTUP_PROGRESS(variax->startup_progress, VARIAX_STARTUP_INIT);
 
@@ -111,8 +111,8 @@ static void variax_startup1(struct usb_line6_variax *variax)
 
 static void variax_startup2(unsigned long data)
 {
-	struct usb_line6_variax *variax = (struct usb_line6_variax *)data;
-	struct usb_line6 *line6 = &variax->line6;
+	struct line6_variax *variax = (struct line6_variax *) data;
+	struct line6 *line6 = &variax->line6;
 
 	/* schedule another startup procedure until startup is complete: */
 	if (variax->startup_progress >= VARIAX_STARTUP_LAST)
@@ -126,7 +126,7 @@ static void variax_startup2(unsigned long data)
 	line6_version_request_async(line6);
 }
 
-static void variax_startup3(struct usb_line6_variax *variax)
+static void variax_startup3(struct line6_variax *variax)
 {
 	CHECK_STARTUP_PROGRESS(variax->startup_progress, VARIAX_STARTUP_WAIT);
 
@@ -137,7 +137,7 @@ static void variax_startup3(struct usb_line6_variax *variax)
 
 static void variax_startup4(unsigned long data)
 {
-	struct usb_line6_variax *variax = (struct usb_line6_variax *)data;
+	struct line6_variax *variax = (struct line6_variax *) data;
 
 	CHECK_STARTUP_PROGRESS(variax->startup_progress,
 			       VARIAX_STARTUP_ACTIVATE);
@@ -150,7 +150,7 @@ static void variax_startup4(unsigned long data)
 
 static void variax_startup5(unsigned long data)
 {
-	struct usb_line6_variax *variax = (struct usb_line6_variax *)data;
+	struct line6_variax *variax = (struct line6_variax *) data;
 
 	CHECK_STARTUP_PROGRESS(variax->startup_progress,
 			       VARIAX_STARTUP_WORKQUEUE);
@@ -161,8 +161,8 @@ static void variax_startup5(unsigned long data)
 
 static void variax_startup6(struct work_struct *work)
 {
-	struct usb_line6_variax *variax =
-	    container_of(work, struct usb_line6_variax, startup_work);
+	struct line6_variax *variax = container_of(work, struct line6_variax,
+						   startup_work);
 
 	CHECK_STARTUP_PROGRESS(variax->startup_progress, VARIAX_STARTUP_SETUP);
 
@@ -173,9 +173,9 @@ static void variax_startup6(struct work_struct *work)
 /*
 	Process a completely received message.
 */
-static void line6_variax_process_message(struct usb_line6 *line6)
+static void line6_variax_process_message(struct line6 *line6)
 {
-	struct usb_line6_variax *variax = (struct usb_line6_variax *) line6;
+	struct line6_variax *variax = (struct line6_variax *) line6;
 	const unsigned char *buf = variax->line6.buffer_message;
 
 	switch (buf[0]) {
@@ -190,7 +190,7 @@ static void line6_variax_process_message(struct usb_line6 *line6)
 		} else if (memcmp(buf + 1, variax_init_done + 1,
 				  sizeof(variax_init_done) - 1) == 0) {
 			/* notify of complete initialization: */
-			variax_startup4((unsigned long)variax);
+			variax_startup4((unsigned long) variax);
 		}
 		break;
 	}
@@ -199,9 +199,9 @@ static void line6_variax_process_message(struct usb_line6 *line6)
 /*
 	Variax destructor.
 */
-static void line6_variax_disconnect(struct usb_line6 *line6)
+static void line6_variax_disconnect(struct line6 *line6)
 {
-	struct usb_line6_variax *variax = (struct usb_line6_variax *)line6;
+	struct line6_variax *variax = (struct line6_variax *) line6;
 
 	del_timer(&variax->startup_timer1);
 	del_timer(&variax->startup_timer2);
@@ -213,10 +213,9 @@ static void line6_variax_disconnect(struct usb_line6 *line6)
 /*
 	 Try to init workbench device.
 */
-static int variax_init(struct usb_line6 *line6,
-		       const struct usb_device_id *id)
+static int variax_init(struct line6 *line6, const struct usb_device_id *id)
 {
-	struct usb_line6_variax *variax = (struct usb_line6_variax *) line6;
+	struct line6_variax *variax = (struct line6_variax *) line6;
 	int err;
 
 	line6->process_message = line6_variax_process_message;
@@ -285,7 +284,7 @@ static int variax_probe(struct usb_interface *interface,
 {
 	return line6_probe(interface, id, "Line 6 Variax",
 			   &variax_properties_table[id->driver_info],
-			   variax_init, sizeof(struct usb_line6_variax));
+			   variax_init, sizeof(struct line6_variax));
 }
 
 static struct usb_driver variax_driver = {
-- 
2.1.0
