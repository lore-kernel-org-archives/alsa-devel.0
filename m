From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 5/5] ALSA: usbaudio: consolidate header files
Date: Mon, 22 Feb 2010 23:49:13 +0100
Message-ID: <1266878953-9184-6-git-send-email-daniel@caiaq.de>
References: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D56F2446D
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 23:49:57 +0100 (CET)
In-Reply-To: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Use the definitions from linux/usb/audio.h all over the ALSA USB audio
driver and add some missing definitions there as well.

Use the endpoint attribute macros from linux/usb/ch9 and remove the own
things from sound/usb/usbaudio.h.

Now things are also nicely prefixed which makes understanding the code
easier.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 include/linux/usb/audio.h |   31 ++++++++++-
 sound/usb/usbaudio.c      |  125 +++++++++++++++++++++++----------------------
 sound/usb/usbaudio.h      |  100 ------------------------------------
 sound/usb/usbmidi.c       |   10 ++--
 sound/usb/usbmixer.c      |   62 +++++++++++-----------
 sound/usb/usbquirks.h     |   32 ++++++------
 6 files changed, 145 insertions(+), 215 deletions(-)

diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index fb1a97b..6bb2936 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -35,8 +35,17 @@
 #define UAC_MIXER_UNIT			0x04
 #define UAC_SELECTOR_UNIT		0x05
 #define UAC_FEATURE_UNIT		0x06
-#define UAC_PROCESSING_UNIT		0x07
-#define UAC_EXTENSION_UNIT		0x08
+#define UAC_PROCESSING_UNIT_V1		0x07
+#define UAC_EXTENSION_UNIT_V1		0x08
+
+/* UAC v2.0 types */
+#define UAC_EFFECT_UNIT			0x07
+#define UAC_PROCESSING_UNIT_V2		0x08
+#define UAC_EXTENSION_UNIT_V2		0x09
+#define UAC_CLOCK_SOURCE		0x0a
+#define UAC_CLOCK_SELECTOR		0x0b
+#define UAC_CLOCK_MULTIPLIER		0x0c
+#define UAC_SAMPLE_RATE_CONVERTER	0x0d
 
 /* A.6 Audio Class-Specific AS Interface Descriptor Subtypes */
 #define UAC_AS_GENERAL			0x01
@@ -69,6 +78,10 @@
 
 #define UAC_GET_STAT			0xff
 
+/* Audio class v2.0 handles all the parameter calls differently */
+#define UAC2_CS_CUR			0x01
+#define UAC2_CS_RANGE			0x02
+
 /* MIDI - A.1 MS Class-Specific Interface Descriptor Subtypes */
 #define UAC_MS_HEADER			0x01
 #define UAC_MIDI_IN_JACK		0x02
@@ -133,6 +146,10 @@ struct uac_input_terminal_descriptor {
 #define UAC_INPUT_TERMINAL_MICROPHONE_ARRAY		0x205
 #define UAC_INPUT_TERMINAL_PROC_MICROPHONE_ARRAY	0x206
 
+/* Terminals - control selectors */
+
+#define UAC_TERMINAL_CS_COPY_PROTECT_CONTROL		0x01
+
 /* 4.3.2.2 Output Terminal Descriptor */
 struct uac_output_terminal_descriptor_v1 {
 	__u8  bLength;			/* in bytes: 9 */
@@ -263,6 +280,9 @@ struct uac_format_type_i_ext_descriptor {
 
 /* Formats - Audio Data Format Type I Codes */
 
+#define UAC_FORMAT_TYPE_II_MPEG	0x1001
+#define UAC_FORMAT_TYPE_II_AC3	0x1002
+
 struct uac_format_type_ii_discrete_descriptor {
 	__u8 bLength;
 	__u8 bDescriptorType;
@@ -285,6 +305,13 @@ struct uac_format_type_ii_ext_descriptor {
 	__u8 bSideBandProtocol;
 } __attribute__((packed));
 
+/* type III */
+#define UAC_FORMAT_TYPE_III_IEC1937_AC3	0x2001
+#define UAC_FORMAT_TYPE_III_IEC1937_MPEG1_LAYER1	0x2002
+#define UAC_FORMAT_TYPE_III_IEC1937_MPEG2_NOEXT	0x2003
+#define UAC_FORMAT_TYPE_III_IEC1937_MPEG2_EXT	0x2004
+#define UAC_FORMAT_TYPE_III_IEC1937_MPEG2_LAYER1_LS	0x2005
+#define UAC_FORMAT_TYPE_III_IEC1937_MPEG2_LAYER23_LS	0x2006
 
 /* Formats - A.2 Format Type Codes */
 #define UAC_FORMAT_TYPE_UNDEFINED	0x0
diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 34dc687..7bbc333 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -47,6 +47,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/usb/audio.h>
+#include <linux/usb/ch9.h>
 
 #include <sound/core.h>
 #include <sound/info.h>
@@ -598,7 +599,7 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 		if (subs->transfer_done >= runtime->period_size) {
 			subs->transfer_done -= runtime->period_size;
 			period_elapsed = 1;
-			if (subs->fmt_type == USB_FORMAT_TYPE_II) {
+			if (subs->fmt_type == UAC_FORMAT_TYPE_II) {
 				if (subs->transfer_done > 0) {
 					/* FIXME: fill-max mode is not
 					 * supported yet */
@@ -1106,7 +1107,7 @@ static int init_substream_urbs(struct snd_usb_substream *subs, unsigned int peri
 		u->packets = (i + 1) * total_packs / subs->nurbs
 			- i * total_packs / subs->nurbs;
 		u->buffer_size = maxsize * u->packets;
-		if (subs->fmt_type == USB_FORMAT_TYPE_II)
+		if (subs->fmt_type == UAC_FORMAT_TYPE_II)
 			u->packets++; /* for transfer delimiter */
 		u->urb = usb_alloc_urb(u->packets, GFP_KERNEL);
 		if (!u->urb)
@@ -1182,7 +1183,7 @@ static struct audioformat *find_format(struct snd_usb_substream *subs, unsigned
 			if (i >= fp->nr_rates)
 				continue;
 		}
-		attr = fp->ep_attr & EP_ATTR_MASK;
+		attr = fp->ep_attr & USB_ENDPOINT_SYNCTYPE;
 		if (! found) {
 			found = fp;
 			cur_attr = attr;
@@ -1194,14 +1195,14 @@ static struct audioformat *find_format(struct snd_usb_substream *subs, unsigned
 		 * M-audio audiophile USB.
 		 */
 		if (attr != cur_attr) {
-			if ((attr == EP_ATTR_ASYNC &&
+			if ((attr == USB_ENDPOINT_SYNC_ASYNC &&
 			     subs->direction == SNDRV_PCM_STREAM_PLAYBACK) ||
-			    (attr == EP_ATTR_ADAPTIVE &&
+			    (attr == USB_ENDPOINT_SYNC_ADAPTIVE &&
 			     subs->direction == SNDRV_PCM_STREAM_CAPTURE))
 				continue;
-			if ((cur_attr == EP_ATTR_ASYNC &&
+			if ((cur_attr == USB_ENDPOINT_SYNC_ASYNC &&
 			     subs->direction == SNDRV_PCM_STREAM_PLAYBACK) ||
-			    (cur_attr == EP_ATTR_ADAPTIVE &&
+			    (cur_attr == USB_ENDPOINT_SYNC_ADAPTIVE &&
 			     subs->direction == SNDRV_PCM_STREAM_CAPTURE)) {
 				found = fp;
 				cur_attr = attr;
@@ -1231,11 +1232,11 @@ static int init_usb_pitch(struct usb_device *dev, int iface,
 
 	ep = get_endpoint(alts, 0)->bEndpointAddress;
 	/* if endpoint has pitch control, enable it */
-	if (fmt->attributes & EP_CS_ATTR_PITCH_CONTROL) {
+	if (fmt->attributes & UAC_EP_CS_ATTR_PITCH_CONTROL) {
 		data[0] = 1;
-		if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR,
+		if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
 					   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
-					   PITCH_CONTROL << 8, ep, data, 1, 1000)) < 0) {
+					   UAC_EP_CS_ATTR_PITCH_CONTROL << 8, ep, data, 1, 1000)) < 0) {
 			snd_printk(KERN_ERR "%d:%d:%d: cannot set enable PITCH\n",
 				   dev->devnum, iface, ep);
 			return err;
@@ -1254,21 +1255,21 @@ static int init_usb_sample_rate(struct usb_device *dev, int iface,
 
 	ep = get_endpoint(alts, 0)->bEndpointAddress;
 	/* if endpoint has sampling rate control, set it */
-	if (fmt->attributes & EP_CS_ATTR_SAMPLE_RATE) {
+	if (fmt->attributes & UAC_EP_CS_ATTR_SAMPLE_RATE) {
 		int crate;
 		data[0] = rate;
 		data[1] = rate >> 8;
 		data[2] = rate >> 16;
-		if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR,
+		if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
 					   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
-					   SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000)) < 0) {
+					   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep, data, 3, 1000)) < 0) {
 			snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d to ep %#x\n",
 				   dev->devnum, iface, fmt->altsetting, rate, ep);
 			return err;
 		}
-		if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), GET_CUR,
+		if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
 					   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_IN,
-					   SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000)) < 0) {
+					   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep, data, 3, 1000)) < 0) {
 			snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq at ep %#x\n",
 				   dev->devnum, iface, fmt->altsetting, ep);
 			return 0; /* some devices don't support reading */
@@ -1386,9 +1387,9 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	 * descriptors which fool us.  if it has only one EP,
 	 * assume it as adaptive-out or sync-in.
 	 */
-	attr = fmt->ep_attr & EP_ATTR_MASK;
-	if (((is_playback && attr == EP_ATTR_ASYNC) ||
-	     (! is_playback && attr == EP_ATTR_ADAPTIVE)) &&
+	attr = fmt->ep_attr & USB_ENDPOINT_SYNCTYPE;
+	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
+	     (! is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
 	    altsd->bNumEndpoints >= 2) {
 		/* check sync-pipe endpoint */
 		/* ... and check descriptor size before accessing bSynchAddress
@@ -1428,7 +1429,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	}
 
 	/* always fill max packet size */
-	if (fmt->attributes & EP_CS_ATTR_FILL_MAX)
+	if (fmt->attributes & UAC_EP_CS_ATTR_FILL_MAX)
 		subs->fill_max = 1;
 
 	if ((err = init_usb_pitch(dev, subs->interface, alts, fmt)) < 0)
@@ -1886,7 +1887,7 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 			runtime->hw.channels_min = fp->channels;
 		if (runtime->hw.channels_max < fp->channels)
 			runtime->hw.channels_max = fp->channels;
-		if (fp->fmt_type == USB_FORMAT_TYPE_II && fp->frame_size > 0) {
+		if (fp->fmt_type == UAC_FORMAT_TYPE_II && fp->frame_size > 0) {
 			/* FIXME: there might be more than one audio formats... */
 			runtime->hw.period_bytes_min = runtime->hw.period_bytes_max =
 				fp->frame_size;
@@ -2120,7 +2121,7 @@ static struct usb_device_id usb_audio_ids [] = {
 #include "usbquirks.h"
     { .match_flags = (USB_DEVICE_ID_MATCH_INT_CLASS | USB_DEVICE_ID_MATCH_INT_SUBCLASS),
       .bInterfaceClass = USB_CLASS_AUDIO,
-      .bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL },
+      .bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL },
     { }						/* Terminating entry */
 };
 
@@ -2159,7 +2160,7 @@ static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct s
 		snd_iprintf(buffer, "    Endpoint: %d %s (%s)\n",
 			    fp->endpoint & USB_ENDPOINT_NUMBER_MASK,
 			    fp->endpoint & USB_DIR_IN ? "IN" : "OUT",
-			    sync_types[(fp->ep_attr & EP_ATTR_MASK) >> 2]);
+			    sync_types[(fp->ep_attr & USB_ENDPOINT_SYNCTYPE) >> 2]);
 		if (fp->rates & SNDRV_PCM_RATE_CONTINUOUS) {
 			snd_iprintf(buffer, "    Rates: %d - %d (continuous)\n",
 				    fp->rate_min, fp->rate_max);
@@ -2471,11 +2472,11 @@ static int parse_audio_format_i_type(struct snd_usb_audio *chip,
 	pcm_format = -1;
 
 	switch (format) {
-	case 0: /* some devices don't define this correctly... */
+	case UAC_FORMAT_TYPE_I_UNDEFINED: /* some devices don't define this correctly... */
 		snd_printdd(KERN_INFO "%d:%u:%d : format type 0 is detected, processed as PCM\n",
 			    chip->dev->devnum, fp->iface, fp->altsetting);
 		/* fall-through */
-	case USB_AUDIO_FORMAT_PCM:
+	case UAC_FORMAT_TYPE_I_PCM:
 		if (sample_width > sample_bytes * 8) {
 			snd_printk(KERN_INFO "%d:%u:%d : sample bitwidth %d in over sample bytes %d\n",
 				   chip->dev->devnum, fp->iface, fp->altsetting,
@@ -2509,7 +2510,7 @@ static int parse_audio_format_i_type(struct snd_usb_audio *chip,
 			break;
 		}
 		break;
-	case USB_AUDIO_FORMAT_PCM8:
+	case UAC_FORMAT_TYPE_I_PCM8:
 		pcm_format = SNDRV_PCM_FORMAT_U8;
 
 		/* Dallas DS4201 workaround: it advertises U8 format, but really
@@ -2517,13 +2518,13 @@ static int parse_audio_format_i_type(struct snd_usb_audio *chip,
 		if (chip->usb_id == USB_ID(0x04fa, 0x4201))
 			pcm_format = SNDRV_PCM_FORMAT_S8;
 		break;
-	case USB_AUDIO_FORMAT_IEEE_FLOAT:
+	case UAC_FORMAT_TYPE_I_IEEE_FLOAT:
 		pcm_format = SNDRV_PCM_FORMAT_FLOAT_LE;
 		break;
-	case USB_AUDIO_FORMAT_ALAW:
+	case UAC_FORMAT_TYPE_I_ALAW:
 		pcm_format = SNDRV_PCM_FORMAT_A_LAW;
 		break;
-	case USB_AUDIO_FORMAT_MU_LAW:
+	case UAC_FORMAT_TYPE_I_MULAW:
 		pcm_format = SNDRV_PCM_FORMAT_MU_LAW;
 		break;
 	default:
@@ -2551,7 +2552,7 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 	int nr_rates = fmt[offset];
 
 	if (fmt[0] < offset + 1 + 3 * (nr_rates ? nr_rates : 2)) {
-		snd_printk(KERN_ERR "%d:%u:%d : invalid FORMAT_TYPE desc\n",
+		snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_FORMAT_TYPE desc\n",
 				   chip->dev->devnum, fp->iface, fp->altsetting);
 		return -1;
 	}
@@ -2614,7 +2615,7 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 	int i, nr_rates, data_size, ret = 0;
 
 	/* get the number of sample rates first by only fetching 2 bytes */
-	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), CS_RANGE,
+	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			       USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			       0x0100, chip->clock_id << 8, tmp, sizeof(tmp), 1000);
 
@@ -2632,7 +2633,7 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 	}
 
 	/* now get the full information */
-	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), CS_RANGE,
+	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			       USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			       0x0100, chip->clock_id << 8, data, data_size, 1000);
 
@@ -2682,7 +2683,7 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 	int protocol = altsd->bInterfaceProtocol;
 	int pcm_format, ret;
 
-	if (fmt->bFormatType == USB_FORMAT_TYPE_III) {
+	if (fmt->bFormatType == UAC_FORMAT_TYPE_III) {
 		/* FIXME: the format type is really IECxxx
 		 *        but we give normal PCM format to get the existing
 		 *        apps working...
@@ -2745,12 +2746,12 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip,
 	int protocol = altsd->bInterfaceProtocol;
 
 	switch (format) {
-	case USB_AUDIO_FORMAT_AC3:
+	case UAC_FORMAT_TYPE_II_AC3:
 		/* FIXME: there is no AC3 format defined yet */
 		// fp->format = SNDRV_PCM_FORMAT_AC3;
 		fp->format = SNDRV_PCM_FORMAT_U8; /* temporarily hack to receive byte streams */
 		break;
-	case USB_AUDIO_FORMAT_MPEG:
+	case UAC_FORMAT_TYPE_II_MPEG:
 		fp->format = SNDRV_PCM_FORMAT_MPEG;
 		break;
 	default:
@@ -2793,11 +2794,11 @@ static int parse_audio_format(struct snd_usb_audio *chip, struct audioformat *fp
 	int err;
 
 	switch (fmt[3]) {
-	case USB_FORMAT_TYPE_I:
-	case USB_FORMAT_TYPE_III:
+	case UAC_FORMAT_TYPE_I:
+	case UAC_FORMAT_TYPE_III:
 		err = parse_audio_format_i(chip, fp, format, fmt, iface);
 		break;
-	case USB_FORMAT_TYPE_II:
+	case UAC_FORMAT_TYPE_II:
 		err = parse_audio_format_ii(chip, fp, format, fmt, iface);
 		break;
 	default:
@@ -2816,7 +2817,7 @@ static int parse_audio_format(struct snd_usb_audio *chip, struct audioformat *fp
 	if (chip->usb_id == USB_ID(0x041e, 0x3000) ||
 	    chip->usb_id == USB_ID(0x041e, 0x3020) ||
 	    chip->usb_id == USB_ID(0x041e, 0x3061)) {
-		if (fmt[3] == USB_FORMAT_TYPE_I &&
+		if (fmt[3] == UAC_FORMAT_TYPE_I &&
 		    fp->rates != SNDRV_PCM_RATE_48000 &&
 		    fp->rates != SNDRV_PCM_RATE_96000)
 			return -1;
@@ -2871,7 +2872,7 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		/* skip invalid one */
 		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
 		     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
-		    (altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING &&
+		    (altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIOSTREAMING &&
 		     altsd->bInterfaceSubClass != USB_SUBCLASS_VENDOR_SPEC) ||
 		    altsd->bNumEndpoints < 1 ||
 		    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) == 0)
@@ -2895,16 +2896,16 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		switch (protocol) {
 		case UAC_VERSION_1: {
 			struct uac_as_header_descriptor_v1 *as =
-				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, AS_GENERAL);
+				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
 
 			if (!as) {
-				snd_printk(KERN_ERR "%d:%u:%d : AS_GENERAL descriptor not found\n",
+				snd_printk(KERN_ERR "%d:%u:%d : UAC_AS_GENERAL descriptor not found\n",
 					   dev->devnum, iface_no, altno);
 				continue;
 			}
 
 			if (as->bLength < sizeof(*as)) {
-				snd_printk(KERN_ERR "%d:%u:%d : invalid AS_GENERAL desc\n",
+				snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_AS_GENERAL desc\n",
 					   dev->devnum, iface_no, altno);
 				continue;
 			}
@@ -2915,16 +2916,16 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 
 		case UAC_VERSION_2: {
 			struct uac_as_header_descriptor_v2 *as =
-				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, AS_GENERAL);
+				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
 
 			if (!as) {
-				snd_printk(KERN_ERR "%d:%u:%d : AS_GENERAL descriptor not found\n",
+				snd_printk(KERN_ERR "%d:%u:%d : UAC_AS_GENERAL descriptor not found\n",
 					   dev->devnum, iface_no, altno);
 				continue;
 			}
 
 			if (as->bLength < sizeof(*as)) {
-				snd_printk(KERN_ERR "%d:%u:%d : invalid AS_GENERAL desc\n",
+				snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_AS_GENERAL desc\n",
 					   dev->devnum, iface_no, altno);
 				continue;
 			}
@@ -2942,15 +2943,15 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		}
 
 		/* get format type */
-		fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, FORMAT_TYPE);
+		fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_FORMAT_TYPE);
 		if (!fmt) {
-			snd_printk(KERN_ERR "%d:%u:%d : no FORMAT_TYPE desc\n",
+			snd_printk(KERN_ERR "%d:%u:%d : no UAC_FORMAT_TYPE desc\n",
 				   dev->devnum, iface_no, altno);
 			continue;
 		}
 		if (((protocol == UAC_VERSION_1) && (fmt[0] < 8)) ||
 		    ((protocol == UAC_VERSION_2) && (fmt[0] != 6))) {
-			snd_printk(KERN_ERR "%d:%u:%d : invalid FORMAT_TYPE desc\n",
+			snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_FORMAT_TYPE desc\n",
 				   dev->devnum, iface_no, altno);
 			continue;
 		}
@@ -2972,7 +2973,7 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		/* Creamware Noah has this descriptor after the 2nd endpoint */
 		if (!csep && altsd->bNumEndpoints >= 2)
 			csep = snd_usb_find_desc(alts->endpoint[1].extra, alts->endpoint[1].extralen, NULL, USB_DT_CS_ENDPOINT);
-		if (!csep || csep[0] < 7 || csep[2] != EP_GENERAL) {
+		if (!csep || csep[0] < 7 || csep[2] != UAC_EP_GENERAL) {
 			snd_printk(KERN_WARNING "%d:%u:%d : no or invalid"
 				   " class specific endpoint descriptor\n",
 				   dev->devnum, iface_no, altno);
@@ -3006,12 +3007,12 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 			/* Optoplay sets the sample rate attribute although
 			 * it seems not supporting it in fact.
 			 */
-			fp->attributes &= ~EP_CS_ATTR_SAMPLE_RATE;
+			fp->attributes &= ~UAC_EP_CS_ATTR_SAMPLE_RATE;
 			break;
 		case USB_ID(0x041e, 0x3020): /* Creative SB Audigy 2 NX */
 		case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
 			/* doesn't set the sample rate attribute, but supports it */
-			fp->attributes |= EP_CS_ATTR_SAMPLE_RATE;
+			fp->attributes |= UAC_EP_CS_ATTR_SAMPLE_RATE;
 			break;
 		case USB_ID(0x047f, 0x0ca1): /* plantronics headset */
 		case USB_ID(0x077d, 0x07af): /* Griffin iMic (note that there is
@@ -3020,11 +3021,11 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		 * plantronics headset and Griffin iMic have set adaptive-in
 		 * although it's really not...
 		 */
-			fp->ep_attr &= ~EP_ATTR_MASK;
+			fp->ep_attr &= ~USB_ENDPOINT_SYNCTYPE;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-				fp->ep_attr |= EP_ATTR_ADAPTIVE;
+				fp->ep_attr |= USB_ENDPOINT_SYNC_ADAPTIVE;
 			else
-				fp->ep_attr |= EP_ATTR_SYNC;
+				fp->ep_attr |= USB_ENDPOINT_SYNC_SYNC;
 			break;
 		}
 
@@ -3094,7 +3095,7 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 	altsd = get_iface_desc(alts);
 	if ((altsd->bInterfaceClass == USB_CLASS_AUDIO ||
 	     altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) &&
-	    altsd->bInterfaceSubClass == USB_SUBCLASS_MIDI_STREAMING) {
+	    altsd->bInterfaceSubClass == USB_SUBCLASS_MIDISTREAMING) {
 		int err = snd_usbmidi_create(chip->card, iface,
 					     &chip->midi_list, NULL);
 		if (err < 0) {
@@ -3109,7 +3110,7 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 
 	if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
 	     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
-	    altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING) {
+	    altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIOSTREAMING) {
 		snd_printdd(KERN_ERR "%d:%u:%d: skipping non-supported interface %d\n",
 					dev->devnum, ctrlif, interface, altsd->bInterfaceClass);
 		/* skip non-supported classes */
@@ -3145,12 +3146,12 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 	host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
 	control_header = snd_usb_find_csint_desc(host_iface->extra,
 						 host_iface->extralen,
-						 NULL, HEADER);
+						 NULL, UAC_HEADER);
 	altsd = get_iface_desc(host_iface);
 	protocol = altsd->bInterfaceProtocol;
 
 	if (!control_header) {
-		snd_printk(KERN_ERR "cannot find HEADER\n");
+		snd_printk(KERN_ERR "cannot find UAC_HEADER\n");
 		return -EINVAL;
 	}
 
@@ -3164,7 +3165,7 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 		}
 
 		if (h1->bLength < sizeof(*h1) + h1->bInCollection) {
-			snd_printk(KERN_ERR "invalid HEADER (v1)\n");
+			snd_printk(KERN_ERR "invalid UAC_HEADER (v1)\n");
 			return -EINVAL;
 		}
 
@@ -3190,7 +3191,7 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 		 * clock selectors and sample rate conversion units. */
 
 		cs = snd_usb_find_csint_desc(host_iface->extra, host_iface->extralen,
-						NULL, CLOCK_SOURCE);
+						NULL, UAC_CLOCK_SOURCE);
 
 		if (!cs) {
 			snd_printk(KERN_ERR "CLOCK_SOURCE descriptor not found\n");
@@ -3302,7 +3303,7 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,
 	static const struct audioformat ua_format = {
 		.format = SNDRV_PCM_FORMAT_S24_3LE,
 		.channels = 2,
-		.fmt_type = USB_FORMAT_TYPE_I,
+		.fmt_type = UAC_FORMAT_TYPE_I,
 		.altsetting = 1,
 		.altset_idx = 1,
 		.rates = SNDRV_PCM_RATE_CONTINUOUS,
@@ -3394,7 +3395,7 @@ static int create_ua1000_quirk(struct snd_usb_audio *chip,
 {
 	static const struct audioformat ua1000_format = {
 		.format = SNDRV_PCM_FORMAT_S32_LE,
-		.fmt_type = USB_FORMAT_TYPE_I,
+		.fmt_type = UAC_FORMAT_TYPE_I,
 		.altsetting = 1,
 		.altset_idx = 1,
 		.attributes = 0,
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 26daf68..6b016d4 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -21,106 +21,6 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-
-/*
- */
-
-#define USB_SUBCLASS_AUDIO_CONTROL	0x01
-#define USB_SUBCLASS_AUDIO_STREAMING	0x02
-#define USB_SUBCLASS_MIDI_STREAMING	0x03
-#define USB_SUBCLASS_VENDOR_SPEC	0xff
-
-#define HEADER				0x01
-#define INPUT_TERMINAL			0x02
-#define OUTPUT_TERMINAL			0x03
-#define MIXER_UNIT			0x04
-#define SELECTOR_UNIT			0x05
-#define FEATURE_UNIT			0x06
-#define PROCESSING_UNIT_V1		0x07
-#define EXTENSION_UNIT_V1		0x08
-
-/* audio class v2 */
-#define EFFECT_UNIT			0x07
-#define PROCESSING_UNIT_V2		0x08
-#define EXTENSION_UNIT_V2		0x09
-#define CLOCK_SOURCE			0x0a
-#define CLOCK_SELECTOR			0x0b
-#define CLOCK_MULTIPLIER		0x0c
-#define SAMPLE_RATE_CONVERTER		0x0d
-
-#define AS_GENERAL			0x01
-#define FORMAT_TYPE			0x02
-#define FORMAT_SPECIFIC			0x03
-
-#define EP_GENERAL			0x01
-
-#define MS_GENERAL			0x01
-#define MIDI_IN_JACK			0x02
-#define MIDI_OUT_JACK			0x03
-
-/* endpoint attributes */
-#define EP_ATTR_MASK			0x0c
-#define EP_ATTR_ASYNC			0x04
-#define EP_ATTR_ADAPTIVE		0x08
-#define EP_ATTR_SYNC			0x0c
-
-/* cs endpoint attributes */
-#define EP_CS_ATTR_SAMPLE_RATE		0x01
-#define EP_CS_ATTR_PITCH_CONTROL	0x02
-#define EP_CS_ATTR_FILL_MAX		0x80
-
-/* Audio Class specific Request Codes (v1) */
-
-#define SET_CUR    0x01
-#define GET_CUR    0x81
-#define SET_MIN    0x02
-#define GET_MIN    0x82
-#define SET_MAX    0x03
-#define GET_MAX    0x83
-#define SET_RES    0x04
-#define GET_RES    0x84
-#define SET_MEM    0x05
-#define GET_MEM    0x85
-#define GET_STAT   0xff
-
-/* Audio Class specific Request Codes (v2) */
-#define CS_CUR     0x01
-#define CS_RANGE   0x02
-
-/* Terminal Control Selectors */
-
-#define COPY_PROTECT_CONTROL       0x01
-
-/* Endpoint Control Selectors */
-
-#define SAMPLING_FREQ_CONTROL      0x01
-#define PITCH_CONTROL              0x02
-
-/* Format Types */
-#define USB_FORMAT_TYPE_I	0x01
-#define USB_FORMAT_TYPE_II	0x02
-#define USB_FORMAT_TYPE_III	0x03
-
-/* type I */
-#define USB_AUDIO_FORMAT_PCM	0x01
-#define USB_AUDIO_FORMAT_PCM8	0x02
-#define USB_AUDIO_FORMAT_IEEE_FLOAT	0x03
-#define USB_AUDIO_FORMAT_ALAW	0x04
-#define USB_AUDIO_FORMAT_MU_LAW	0x05
-
-/* type II */
-#define USB_AUDIO_FORMAT_MPEG	0x1001
-#define USB_AUDIO_FORMAT_AC3	0x1002
-
-/* type III */
-#define USB_AUDIO_FORMAT_IEC1937_AC3	0x2001
-#define USB_AUDIO_FORMAT_IEC1937_MPEG1_LAYER1	0x2002
-#define USB_AUDIO_FORMAT_IEC1937_MPEG2_NOEXT	0x2003
-#define USB_AUDIO_FORMAT_IEC1937_MPEG2_EXT	0x2004
-#define USB_AUDIO_FORMAT_IEC1937_MPEG2_LAYER1_LS	0x2005
-#define USB_AUDIO_FORMAT_IEC1937_MPEG2_LAYER23_LS	0x2006
-
-
 /* maximum number of endpoints per interface */
 #define MIDI_MAX_ENDPOINTS 2
 
diff --git a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
index 6e89b83..15e8e4b 100644
--- a/sound/usb/usbmidi.c
+++ b/sound/usb/usbmidi.c
@@ -46,6 +46,8 @@
 #include <linux/timer.h>
 #include <linux/usb.h>
 #include <linux/wait.h>
+#include <linux/usb/audio.h>
+
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/rawmidi.h>
@@ -1522,7 +1524,7 @@ static int snd_usbmidi_get_ms_info(struct snd_usb_midi* umidi,
 	if (hostif->extralen >= 7 &&
 	    ms_header->bLength >= 7 &&
 	    ms_header->bDescriptorType == USB_DT_CS_INTERFACE &&
-	    ms_header->bDescriptorSubtype == HEADER)
+	    ms_header->bDescriptorSubtype == UAC_HEADER)
 		snd_printdd(KERN_INFO "MIDIStreaming version %02x.%02x\n",
 			    ms_header->bcdMSC[1], ms_header->bcdMSC[0]);
 	else
@@ -1538,7 +1540,7 @@ static int snd_usbmidi_get_ms_info(struct snd_usb_midi* umidi,
 		if (hostep->extralen < 4 ||
 		    ms_ep->bLength < 4 ||
 		    ms_ep->bDescriptorType != USB_DT_CS_ENDPOINT ||
-		    ms_ep->bDescriptorSubtype != MS_GENERAL)
+		    ms_ep->bDescriptorSubtype != UAC_MS_GENERAL)
 			continue;
 		if (usb_endpoint_dir_out(ep)) {
 			if (endpoints[epidx].out_ep) {
@@ -1750,9 +1752,9 @@ static int snd_usbmidi_detect_yamaha(struct snd_usb_midi* umidi,
 	     cs_desc < hostif->extra + hostif->extralen && cs_desc[0] >= 2;
 	     cs_desc += cs_desc[0]) {
 		if (cs_desc[1] == USB_DT_CS_INTERFACE) {
-			if (cs_desc[2] == MIDI_IN_JACK)
+			if (cs_desc[2] == UAC_MIDI_IN_JACK)
 				endpoint->in_cables = (endpoint->in_cables << 1) | 1;
-			else if (cs_desc[2] == MIDI_OUT_JACK)
+			else if (cs_desc[2] == UAC_MIDI_OUT_JACK)
 				endpoint->out_cables = (endpoint->out_cables << 1) | 1;
 		}
 	}
diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 525caec..1b167fb 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -282,7 +282,7 @@ static void *find_audio_control_unit(struct mixer_build *state, unsigned char un
 
 	while ((p = snd_usb_find_desc(state->buffer, state->buflen, p,
 				      USB_DT_CS_INTERFACE)) != NULL) {
-		if (p[0] >= 4 && p[2] >= INPUT_TERMINAL && p[2] <= EXTENSION_UNIT_V1 && p[3] == unit)
+		if (p[0] >= 4 && p[2] >= UAC_INPUT_TERMINAL && p[2] <= UAC_EXTENSION_UNIT_V1 && p[3] == unit)
 			return p;
 	}
 	return NULL;
@@ -403,14 +403,14 @@ static int get_ctl_value(struct usb_mixer_elem_info *cval, int request, int vali
 
 static int get_cur_ctl_value(struct usb_mixer_elem_info *cval, int validx, int *value)
 {
-	return get_ctl_value(cval, GET_CUR, validx, value);
+	return get_ctl_value(cval, UAC_GET_CUR, validx, value);
 }
 
 /* channel = 0: master, 1 = first channel */
 static inline int get_cur_mix_raw(struct usb_mixer_elem_info *cval,
 				  int channel, int *value)
 {
-	return get_ctl_value(cval, GET_CUR, (cval->control << 8) | channel, value);
+	return get_ctl_value(cval, UAC_GET_CUR, (cval->control << 8) | channel, value);
 }
 
 static int get_cur_mix_value(struct usb_mixer_elem_info *cval,
@@ -464,14 +464,14 @@ static int set_ctl_value(struct usb_mixer_elem_info *cval, int request, int vali
 
 static int set_cur_ctl_value(struct usb_mixer_elem_info *cval, int validx, int value)
 {
-	return set_ctl_value(cval, SET_CUR, validx, value);
+	return set_ctl_value(cval, UAC_SET_CUR, validx, value);
 }
 
 static int set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
 			     int index, int value)
 {
 	int err;
-	err = set_ctl_value(cval, SET_CUR, (cval->control << 8) | channel,
+	err = set_ctl_value(cval, UAC_SET_CUR, (cval->control << 8) | channel,
 			    value);
 	if (err < 0)
 		return err;
@@ -601,13 +601,13 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
 		if (term_only)
 			return 0;
 		switch (iterm->type >> 16) {
-		case SELECTOR_UNIT:
+		case UAC_SELECTOR_UNIT:
 			strcpy(name, "Selector"); return 8;
-		case PROCESSING_UNIT_V1:
+		case UAC_PROCESSING_UNIT_V1:
 			strcpy(name, "Process Unit"); return 12;
-		case EXTENSION_UNIT_V1:
+		case UAC_EXTENSION_UNIT_V1:
 			strcpy(name, "Ext Unit"); return 8;
-		case MIXER_UNIT:
+		case UAC_MIXER_UNIT:
 			strcpy(name, "Mixer"); return 5;
 		default:
 			return sprintf(name, "Unit %d", iterm->id);
@@ -646,22 +646,22 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 	while ((p1 = find_audio_control_unit(state, id)) != NULL) {
 		term->id = id;
 		switch (p1[2]) {
-		case INPUT_TERMINAL:
+		case UAC_INPUT_TERMINAL:
 			term->type = combine_word(p1 + 4);
 			term->channels = p1[7];
 			term->chconfig = combine_word(p1 + 8);
 			term->name = p1[11];
 			return 0;
-		case FEATURE_UNIT:
+		case UAC_FEATURE_UNIT:
 			id = p1[4];
 			break; /* continue to parse */
-		case MIXER_UNIT:
+		case UAC_MIXER_UNIT:
 			term->type = p1[2] << 16; /* virtual type */
 			term->channels = p1[5 + p1[4]];
 			term->chconfig = combine_word(p1 + 6 + p1[4]);
 			term->name = p1[p1[0] - 1];
 			return 0;
-		case SELECTOR_UNIT:
+		case UAC_SELECTOR_UNIT:
 			/* call recursively to retrieve the channel info */
 			if (check_input_term(state, p1[5], term) < 0)
 				return -ENODEV;
@@ -669,8 +669,8 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 			term->id = id;
 			term->name = p1[9 + p1[0] - 1];
 			return 0;
-		case PROCESSING_UNIT_V1:
-		case EXTENSION_UNIT_V1:
+		case UAC_PROCESSING_UNIT_V1:
+		case UAC_EXTENSION_UNIT_V1:
 			if (p1[6] == 1) {
 				id = p1[7];
 				break; /* continue to parse */
@@ -748,23 +748,23 @@ static int get_min_max(struct usb_mixer_elem_info *cval, int default_min)
 					break;
 				}
 		}
-		if (get_ctl_value(cval, GET_MAX, (cval->control << 8) | minchn, &cval->max) < 0 ||
-		    get_ctl_value(cval, GET_MIN, (cval->control << 8) | minchn, &cval->min) < 0) {
+		if (get_ctl_value(cval, UAC_GET_MAX, (cval->control << 8) | minchn, &cval->max) < 0 ||
+		    get_ctl_value(cval, UAC_GET_MIN, (cval->control << 8) | minchn, &cval->min) < 0) {
 			snd_printd(KERN_ERR "%d:%d: cannot get min/max values for control %d (id %d)\n",
 				   cval->id, cval->mixer->ctrlif, cval->control, cval->id);
 			return -EINVAL;
 		}
-		if (get_ctl_value(cval, GET_RES, (cval->control << 8) | minchn, &cval->res) < 0) {
+		if (get_ctl_value(cval, UAC_GET_RES, (cval->control << 8) | minchn, &cval->res) < 0) {
 			cval->res = 1;
 		} else {
 			int last_valid_res = cval->res;
 
 			while (cval->res > 1) {
-				if (set_ctl_value(cval, SET_RES, (cval->control << 8) | minchn, cval->res / 2) < 0)
+				if (set_ctl_value(cval, UAC_SET_RES, (cval->control << 8) | minchn, cval->res / 2) < 0)
 					break;
 				cval->res /= 2;
 			}
-			if (get_ctl_value(cval, GET_RES, (cval->control << 8) | minchn, &cval->res) < 0)
+			if (get_ctl_value(cval, UAC_GET_RES, (cval->control << 8) | minchn, &cval->res) < 0)
 				cval->res = last_valid_res;
 		}
 		if (cval->res == 0)
@@ -1093,7 +1093,7 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 	struct uac_feature_unit_descriptor *ftr = _ftr;
 
 	if (ftr->bLength < 7 || ! (csize = ftr->bControlSize) || ftr->bLength < 7 + csize) {
-		snd_printk(KERN_ERR "usbaudio: unit %u: invalid FEATURE_UNIT descriptor\n", unitid);
+		snd_printk(KERN_ERR "usbaudio: unit %u: invalid UAC_FEATURE_UNIT descriptor\n", unitid);
 		return -EINVAL;
 	}
 
@@ -1735,17 +1735,17 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 	}
 
 	switch (p1[2]) {
-	case INPUT_TERMINAL:
+	case UAC_INPUT_TERMINAL:
 		return 0; /* NOP */
-	case MIXER_UNIT:
+	case UAC_MIXER_UNIT:
 		return parse_audio_mixer_unit(state, unitid, p1);
-	case SELECTOR_UNIT:
+	case UAC_SELECTOR_UNIT:
 		return parse_audio_selector_unit(state, unitid, p1);
-	case FEATURE_UNIT:
+	case UAC_FEATURE_UNIT:
 		return parse_audio_feature_unit(state, unitid, p1);
-	case PROCESSING_UNIT_V1:
+	case UAC_PROCESSING_UNIT_V1:
 		return parse_audio_processing_unit(state, unitid, p1);
-	case EXTENSION_UNIT_V1:
+	case UAC_EXTENSION_UNIT_V1:
 		return parse_audio_extension_unit(state, unitid, p1);
 	default:
 		snd_printk(KERN_ERR "usbaudio: unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
@@ -1775,7 +1775,7 @@ static int snd_usb_mixer_dev_free(struct snd_device *device)
 /*
  * create mixer controls
  *
- * walk through all OUTPUT_TERMINAL descriptors to search for mixers
+ * walk through all UAC_OUTPUT_TERMINAL descriptors to search for mixers
  */
 static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 {
@@ -1802,7 +1802,7 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 		}
 	}
 
-	while ((desc = snd_usb_find_csint_desc(hostif->extra, hostif->extralen, desc, OUTPUT_TERMINAL)) != NULL) {
+	while ((desc = snd_usb_find_csint_desc(hostif->extra, hostif->extralen, desc, UAC_OUTPUT_TERMINAL)) != NULL) {
 		if (desc->bLength < 9)
 			continue; /* invalid descriptor? */
 		set_bit(desc->bTerminalID, state.unitbitmap);  /* mark terminal ID as visited */
@@ -2002,7 +2002,7 @@ static int snd_usb_soundblaster_remote_init(struct usb_mixer_interface *mixer)
 	}
 	mixer->rc_setup_packet->bRequestType =
 		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE;
-	mixer->rc_setup_packet->bRequest = GET_MEM;
+	mixer->rc_setup_packet->bRequest = UAC_GET_MEM;
 	mixer->rc_setup_packet->wValue = cpu_to_le16(0);
 	mixer->rc_setup_packet->wIndex = cpu_to_le16(0);
 	mixer->rc_setup_packet->wLength = cpu_to_le16(len);
@@ -2125,7 +2125,7 @@ static void snd_audigy2nx_proc_read(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "%s: ", jacks[i].name);
 		err = snd_usb_ctl_msg(mixer->chip->dev,
 				      usb_rcvctrlpipe(mixer->chip->dev, 0),
-				      GET_MEM, USB_DIR_IN | USB_TYPE_CLASS |
+				      UAC_GET_MEM, USB_DIR_IN | USB_TYPE_CLASS |
 				      USB_RECIP_INTERFACE, 0,
 				      jacks[i].unitid << 8, buf, 3, 100);
 		if (err == 3 && (buf[0] == 3 || buf[0] == 6))
diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index 65bbd22..c51b1c8 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -91,7 +91,7 @@
 	.idVendor = 0x046d,
 	.idProduct = 0x0850,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 },
 {
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
@@ -100,7 +100,7 @@
 	.idVendor = 0x046d,
 	.idProduct = 0x08ae,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 },
 {
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
@@ -109,7 +109,7 @@
 	.idVendor = 0x046d,
 	.idProduct = 0x08c6,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 },
 {
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
@@ -118,7 +118,7 @@
 	.idVendor = 0x046d,
 	.idProduct = 0x08f0,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 },
 {
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
@@ -127,7 +127,7 @@
 	.idVendor = 0x046d,
 	.idProduct = 0x08f5,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 },
 {
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
@@ -136,7 +136,7 @@
 	.idVendor = 0x046d,
 	.idProduct = 0x08f6,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 },
 {
 	USB_DEVICE(0x046d, 0x0990),
@@ -301,7 +301,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.iface = 1,
 					.altsetting = 1,
 					.altset_idx = 1,
-					.attributes = EP_CS_ATTR_FILL_MAX,
+					.attributes = UAC_EP_CS_ATTR_FILL_MAX,
 					.endpoint = 0x81,
 					.ep_attr = 0x05,
 					.rates = SNDRV_PCM_RATE_CONTINUOUS,
@@ -2081,7 +2081,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hauppauge",
 		.product_name = "HVR-950Q",
@@ -2095,7 +2095,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hauppauge",
 		.product_name = "HVR-950Q",
@@ -2109,7 +2109,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hauppauge",
 		.product_name = "HVR-950Q",
@@ -2123,7 +2123,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hauppauge",
 		.product_name = "HVR-950Q",
@@ -2137,7 +2137,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hauppauge",
 		.product_name = "HVR-950Q",
@@ -2151,7 +2151,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hauppauge",
 		.product_name = "HVR-950Q",
@@ -2165,7 +2165,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hauppauge",
 		.product_name = "HVR-950Q",
@@ -2179,7 +2179,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hauppauge",
 		.product_name = "HVR-850",
@@ -2196,7 +2196,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	.match_flags = USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_MIDI_STREAMING,
+	.bInterfaceSubClass = USB_SUBCLASS_MIDISTREAMING,
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_STANDARD_INTERFACE
-- 
1.6.6.2
