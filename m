From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/2] ALSA: sound/usb: add preliminary support
	for UAC2 interrupts
Date: Tue, 11 May 2010 18:13:50 +0200
Message-ID: <1273594430-9356-2-git-send-email-daniel@caiaq.de>
References: <1273594430-9356-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 48E81248E0
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 18:14:39 +0200 (CEST)
In-Reply-To: <1273594430-9356-1-git-send-email-daniel@caiaq.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

For both UAC1 and UAC2, interrupt endpoint messages are now parsed with
structs rather that with anonymous buffer array accesses.

For UAC2, only CUR interrupt notifications are supported for now.

snd_usb_mixer_status_complete() was renamed to
snd_usb_mixer_interrupt().

Fixed one indentation flaw on the way.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
---
 include/linux/usb/audio-v2.h |   12 +++++
 include/linux/usb/audio.h    |   15 ++++++
 sound/usb/mixer.c            |   98 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 112 insertions(+), 13 deletions(-)

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index 0952231..2389f93 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -105,6 +105,17 @@ struct uac_as_header_descriptor_v2 {
 	__u8 iChannelNames;
 } __attribute__((packed));
 
+/* 6.1 Interrupt Data Message */
+
+#define UAC2_INTERRUPT_DATA_MSG_VENDOR	(1 << 0)
+#define UAC2_INTERRUPT_DATA_MSG_EP	(1 << 1)
+
+struct uac2_interrupt_data_msg {
+	__u8 bInfo;
+	__u8 bAttribute;
+	__le16 wValue;
+	__le16 wIndex;
+} __attribute__((packed));
 
 /* A.7 Audio Function Category Codes */
 #define UAC2_FUNCTION_SUBCLASS_UNDEFINED	0x00
@@ -153,6 +164,7 @@ struct uac_as_header_descriptor_v2 {
 /* A.14 Audio Class-Specific Request Codes */
 #define UAC2_CS_CUR			0x01
 #define UAC2_CS_RANGE			0x02
+#define UAC2_CS_MEM			0x03
 
 /* A.15 Encoder Type Codes */
 #define UAC2_ENCODER_UNDEFINED		0x00
diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 9fae6bd..c0ef18d 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -488,6 +488,21 @@ struct uac_iso_endpoint_descriptor {
 #define UAC_FU_BASS_BOOST	(1 << (UAC_BASS_BOOST_CONTROL - 1))
 #define UAC_FU_LOUDNESS		(1 << (UAC_LOUDNESS_CONTROL - 1))
 
+/* status word format (3.7.1.1) */
+
+#define UAC1_STATUS_TYPE_ORIG_MASK		0x0f
+#define UAC1_STATUS_TYPE_ORIG_AUDIO_CONTROL_IF	0x0
+#define UAC1_STATUS_TYPE_ORIG_AUDIO_STREAM_IF	0x1
+#define UAC1_STATUS_TYPE_ORIG_AUDIO_STREAM_EP	0x2
+
+#define UAC1_STATUS_TYPE_IRQ_PENDING		(1 << 7)
+#define UAC1_STATUS_TYPE_MEM_CHANGED		(1 << 6)
+
+struct uac1_status_word {
+	__u8 bStatusType;
+	__u8 bOriginator;
+} __attribute__((packed));
+
 #ifdef __KERNEL__
 
 struct usb_audio_control {
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index fa0fb77..97dd176 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1443,8 +1443,8 @@ static struct procunit_info procunits[] = {
  * predefined data for extension units
  */
 static struct procunit_value_info clock_rate_xu_info[] = {
-       { USB_XU_CLOCK_RATE_SELECTOR, "Selector", USB_MIXER_U8, 0 },
-       { 0 }
+	{ USB_XU_CLOCK_RATE_SELECTOR, "Selector", USB_MIXER_U8, 0 },
+	{ 0 }
 };
 static struct procunit_value_info clock_source_xu_info[] = {
 	{ USB_XU_CLOCK_SOURCE_SELECTOR, "External", USB_MIXER_BOOLEAN },
@@ -1967,26 +1967,98 @@ static void snd_usb_mixer_proc_read(struct snd_info_entry *entry,
 	}
 }
 
-static void snd_usb_mixer_status_complete(struct urb *urb)
+static void snd_usb_mixer_interrupt_v2(struct usb_mixer_interface *mixer,
+				       int attribute, int value, int index)
+{
+	struct usb_mixer_elem_info *info;
+	__u8 unitid = (index >> 8) & 0xff;
+	__u8 control = (value >> 8) & 0xff;
+	__u8 channel = value & 0xff;
+
+	if (channel >= MAX_CHANNELS) {
+		snd_printk(KERN_DEBUG "%s(): bogus channel number %d\n",
+				__func__, channel);
+		return;
+	}
+
+	for (info = mixer->id_elems[unitid]; info; info = info->next_id_elem) {
+		if (info->control != control)
+			continue;
+
+		switch (attribute) {
+		case UAC2_CS_CUR:
+			/* invalidate cache, so the value is read from the device */
+			if (channel)
+				info->cached &= ~(1 << channel);
+			else /* master channel */
+				info->cached = 0;
+
+			snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+					info->elem_id);
+			break;
+
+		case UAC2_CS_RANGE:
+			/* TODO */
+			break;
+
+		case UAC2_CS_MEM:
+			/* TODO */
+			break;
+
+		default:
+			snd_printk(KERN_DEBUG "unknown attribute %d in interrupt\n",
+						attribute);
+			break;
+		} /* switch */
+	}
+}
+
+static void snd_usb_mixer_interrupt(struct urb *urb)
 {
 	struct usb_mixer_interface *mixer = urb->context;
+	int len = urb->actual_length;
+
+	if (urb->status != 0)
+		goto requeue;
 
-	if (urb->status == 0) {
-		u8 *buf = urb->transfer_buffer;
-		int i;
+	if (mixer->protocol == UAC_VERSION_1) {
+		struct uac1_status_word *status;
 
-		for (i = urb->actual_length; i >= 2; buf += 2, i -= 2) {
+		for (status = urb->transfer_buffer;
+		     len >= sizeof(*status);
+		     len -= sizeof(*status), status++) {
 			snd_printd(KERN_DEBUG "status interrupt: %02x %02x\n",
-				   buf[0], buf[1]);
+						status->bStatusType,
+						status->bOriginator);
+
 			/* ignore any notifications not from the control interface */
-			if ((buf[0] & 0x0f) != 0)
+			if ((status->bStatusType & UAC1_STATUS_TYPE_ORIG_MASK) !=
+				UAC1_STATUS_TYPE_ORIG_AUDIO_CONTROL_IF)
 				continue;
-			if (!(buf[0] & 0x40))
-				snd_usb_mixer_notify_id(mixer, buf[1]);
+
+			if (status->bStatusType & UAC1_STATUS_TYPE_MEM_CHANGED)
+				snd_usb_mixer_rc_memory_change(mixer, status->bOriginator);
 			else
-				snd_usb_mixer_rc_memory_change(mixer, buf[1]);
+				snd_usb_mixer_notify_id(mixer, status->bOriginator);
+		}
+	} else { /* UAC_VERSION_2 */
+		struct uac2_interrupt_data_msg *msg;
+
+		for (msg = urb->transfer_buffer;
+		     len >= sizeof(*msg);
+		     len -= sizeof(*msg), msg++) {
+			/* drop vendor specific and endpoint requests */
+			if ((msg->bInfo & UAC2_INTERRUPT_DATA_MSG_VENDOR) ||
+			    (msg->bInfo & UAC2_INTERRUPT_DATA_MSG_EP))
+				continue;
+
+			snd_usb_mixer_interrupt_v2(mixer, msg->bAttribute,
+						   le16_to_cpu(msg->wValue),
+						   le16_to_cpu(msg->wIndex));
 		}
 	}
+
+requeue:
 	if (urb->status != -ENOENT && urb->status != -ECONNRESET) {
 		urb->dev = mixer->chip->dev;
 		usb_submit_urb(urb, GFP_ATOMIC);
@@ -2023,7 +2095,7 @@ static int snd_usb_mixer_status_create(struct usb_mixer_interface *mixer)
 	usb_fill_int_urb(mixer->urb, mixer->chip->dev,
 			 usb_rcvintpipe(mixer->chip->dev, epnum),
 			 transfer_buffer, buffer_length,
-			 snd_usb_mixer_status_complete, mixer, ep->bInterval);
+			 snd_usb_mixer_interrupt, mixer, ep->bInterval);
 	usb_submit_urb(mixer->urb, GFP_KERNEL);
 	return 0;
 }
-- 
1.7.1
