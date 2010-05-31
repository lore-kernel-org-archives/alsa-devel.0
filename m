From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 5/9] ALSA: usb-audio: parse clock topology of
	UAC2 devices
Date: Mon, 31 May 2010 13:35:40 +0200
Message-ID: <1275305744-6590-5-git-send-email-daniel@caiaq.de>
References: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B5481038AE
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:36:08 +0200 (CEST)
In-Reply-To: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Audio devices which comply to the UAC2 standard can export complex clock
topologies in its descriptors and set up links between them.

The entities that are defined are

 - clock sources, which define the end-leafs.
 - clock selectors, which act as switch to select one out of many
   possible clocks sources.
 - clock multipliers, which have an input clock source, and act as clock
   source again. They can be used to derive one clock from another.

All sample rate changes, clock validity queries and the like must go to
clock source elements, while clock selectors and multipliers can be used
as terminal clock source.

The following patch adds a parser for these elements and functions to
iterate over the tree and find the leaf nodes (clock sources).

The samplerate set functions were moved to the new clock.c file.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/Makefile   |    3 +-
 sound/usb/card.c     |   18 +---
 sound/usb/card.h     |    1 +
 sound/usb/clock.c    |  310 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/clock.h    |   12 ++
 sound/usb/endpoint.c |   57 +++++++++-
 sound/usb/format.c   |   16 ++-
 sound/usb/pcm.c      |   98 +----------------
 sound/usb/usbaudio.h |    5 +-
 9 files changed, 395 insertions(+), 125 deletions(-)
 create mode 100644 sound/usb/clock.c
 create mode 100644 sound/usb/clock.h

diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index e7ac7f4..1e362bf 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -11,7 +11,8 @@ snd-usb-audio-objs := 	card.o \
 			endpoint.o \
 			urb.o \
 			pcm.o \
-			helper.o
+			helper.o \
+			clock.o
 
 snd-usbmidi-lib-objs := midi.o
 
diff --git a/sound/usb/card.c b/sound/usb/card.c
index da1346b..7a8ac1d 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -236,7 +236,6 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 	}
 
 	case UAC_VERSION_2: {
-		struct uac_clock_source_descriptor *cs;
 		struct usb_interface_assoc_descriptor *assoc =
 			usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
 
@@ -245,21 +244,6 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 			return -EINVAL;
 		}
 
-		/* FIXME: for now, we expect there is at least one clock source
-		 * descriptor and we always take the first one.
-		 * We should properly support devices with multiple clock sources,
-		 * clock selectors and sample rate conversion units. */
-
-		cs = snd_usb_find_csint_desc(host_iface->extra, host_iface->extralen,
-						NULL, UAC2_CLOCK_SOURCE);
-
-		if (!cs) {
-			snd_printk(KERN_ERR "CLOCK_SOURCE descriptor not found\n");
-			return -EINVAL;
-		}
-
-		chip->clock_id = cs->bClockID;
-
 		for (i = 0; i < assoc->bInterfaceCount; i++) {
 			int intf = assoc->bFirstInterface + i;
 
@@ -481,6 +465,8 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 			goto __error;
 	}
 
+	chip->ctrl_intf = alts;
+
 	if (err > 0) {
 		/* create normal USB audio interfaces */
 		if (snd_usb_create_streams(chip, ifnum) < 0 ||
diff --git a/sound/usb/card.h b/sound/usb/card.h
index ed92420..1febf2f 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -25,6 +25,7 @@ struct audioformat {
 	unsigned int rate_min, rate_max;	/* min/max rates */
 	unsigned int nr_rates;		/* number of rate table entries */
 	unsigned int *rate_table;	/* rate table */
+	unsigned char clock;		/* associated clock */
 };
 
 struct snd_usb_substream;
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
new file mode 100644
index 0000000..94f2664
--- /dev/null
+++ b/sound/usb/clock.c
@@ -0,0 +1,310 @@
+/*
+ *   Clock domain and sample rate management functions
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
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/usb.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/usb/audio.h>
+#include <linux/usb/audio-v2.h>
+
+#include <sound/core.h>
+#include <sound/info.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+
+#include "usbaudio.h"
+#include "card.h"
+#include "midi.h"
+#include "mixer.h"
+#include "proc.h"
+#include "quirks.h"
+#include "endpoint.h"
+#include "helper.h"
+#include "debug.h"
+#include "pcm.h"
+#include "urb.h"
+#include "format.h"
+
+static struct uac_clock_source_descriptor *
+	snd_usb_find_clock_source(struct usb_host_interface *ctrl_iface,
+				  int clock_id)
+{
+	struct uac_clock_source_descriptor *cs = NULL;
+
+	while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
+					     ctrl_iface->extralen,
+					     cs, UAC2_CLOCK_SOURCE))) {
+		if (cs->bClockID == clock_id)
+			return cs;
+	}
+
+	return NULL;
+}
+
+static struct uac_clock_selector_descriptor *
+	snd_usb_find_clock_selector(struct usb_host_interface *ctrl_iface,
+				    int clock_id)
+{
+	struct uac_clock_selector_descriptor *cs = NULL;
+
+	while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
+					     ctrl_iface->extralen,
+					     cs, UAC2_CLOCK_SELECTOR))) {
+		if (cs->bClockID == clock_id)
+			return cs;
+	}
+
+	return NULL;
+}
+
+static struct uac_clock_multiplier_descriptor *
+	snd_usb_find_clock_multiplier(struct usb_host_interface *ctrl_iface,
+				      int clock_id)
+{
+	struct uac_clock_multiplier_descriptor *cs = NULL;
+
+	while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
+					     ctrl_iface->extralen,
+					     cs, UAC2_CLOCK_MULTIPLIER))) {
+		if (cs->bClockID == clock_id)
+			return cs;
+	}
+
+	return NULL;
+}
+
+static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_id)
+{
+	unsigned char buf;
+	int ret;
+
+	ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
+			      UAC2_CS_CUR,
+			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+			      UAC2_CX_CLOCK_SELECTOR << 8, selector_id << 8,
+			      &buf, sizeof(buf), 1000);
+
+	if (ret < 0)
+		return ret;
+
+	return buf;
+}
+
+static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int source_id)
+{
+	int err;
+	unsigned char data;
+	struct usb_device *dev = chip->dev;
+
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
+			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
+			      UAC2_CS_CONTROL_CLOCK_VALID << 8, source_id << 8,
+			      &data, sizeof(data), 1000);
+
+	if (err < 0) {
+		snd_printk(KERN_WARNING "%s(): cannot get clock validity for id %d\n",
+			   __func__, source_id);
+		return err;
+	}
+
+	return !!data;
+}
+
+/* Try to find the clock source ID of a given clock entity */
+
+static int __uac_clock_find_source(struct snd_usb_audio *chip,
+				   struct usb_host_interface *host_iface,
+				   int entity_id, unsigned long *visited)
+{
+	struct uac_clock_source_descriptor *source;
+	struct uac_clock_selector_descriptor *selector;
+	struct uac_clock_multiplier_descriptor *multiplier;
+
+	entity_id &= 0xff;
+
+	if (test_and_set_bit(entity_id, visited)) {
+		snd_printk(KERN_WARNING
+			"%s(): recursive clock topology detected, id %d.\n",
+			__func__, entity_id);
+		return -EINVAL;
+	}
+
+	/* first, see if the ID we're looking for is a clock source already */
+	source = snd_usb_find_clock_source(host_iface, entity_id);
+	if (source)
+		return source->bClockID;
+
+	selector = snd_usb_find_clock_selector(host_iface, entity_id);
+	if (selector) {
+		int ret;
+
+		/* the entity ID we are looking for is a selector.
+		 * find out what it currently selects */
+		ret = uac_clock_selector_get_val(chip, selector->bClockID);
+		if (ret < 0)
+			return ret;
+
+		if (ret >= selector->bNrInPins) {
+			printk(KERN_ERR
+				"%s(): selector reported illegal value, id %d, ret %d\n",
+				__func__, selector->bClockID, ret);
+			return -EINVAL;
+		}
+
+		return __uac_clock_find_source(chip, host_iface,
+					       selector->baCSourceID[ret],
+					       visited);
+	}
+
+	/* FIXME: multipliers only act as pass-thru element for now */
+	multiplier = snd_usb_find_clock_multiplier(host_iface, entity_id);
+	if (multiplier)
+		return __uac_clock_find_source(chip, host_iface,
+					       multiplier->bCSourceID, visited);
+
+	return -EINVAL;
+}
+
+int snd_usb_clock_find_source(struct snd_usb_audio *chip,
+			      struct usb_host_interface *host_iface,
+			      int entity_id)
+{
+	DECLARE_BITMAP(visited, 256);
+	memset(visited, 0, sizeof(visited));
+	return __uac_clock_find_source(chip, host_iface, entity_id, visited);
+}
+
+static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
+			      struct usb_host_interface *alts,
+			      struct audioformat *fmt, int rate)
+{
+	struct usb_device *dev = chip->dev;
+	unsigned int ep;
+	unsigned char data[3];
+	int err, crate;
+
+	ep = get_endpoint(alts, 0)->bEndpointAddress;
+
+	/* if endpoint doesn't have sampling rate control, bail out */
+	if (!(fmt->attributes & UAC_EP_CS_ATTR_SAMPLE_RATE)) {
+		snd_printk(KERN_WARNING "%d:%d:%d: endpoint lacks sample rate attribute bit, cannot set.\n",
+				   dev->devnum, iface, fmt->altsetting);
+		return 0;
+	}
+
+	data[0] = rate;
+	data[1] = rate >> 8;
+	data[2] = rate >> 16;
+	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
+				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d to ep %#x\n",
+			   dev->devnum, iface, fmt->altsetting, rate, ep);
+		return err;
+	}
+
+	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
+				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
+				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq at ep %#x\n",
+			   dev->devnum, iface, fmt->altsetting, ep);
+		return 0; /* some devices don't support reading */
+	}
+
+	crate = data[0] | (data[1] << 8) | (data[2] << 16);
+	if (crate != rate) {
+		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
+		// runtime->rate = crate;
+	}
+
+	return 0;
+}
+
+static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
+			      struct usb_host_interface *alts,
+			      struct audioformat *fmt, int rate)
+{
+	struct usb_device *dev = chip->dev;
+	unsigned char data[4];
+	int err, crate;
+	int clock = snd_usb_clock_find_source(chip, chip->ctrl_intf, fmt->clock);
+
+	if (clock < 0)
+		return clock;
+
+	if (!uac_clock_source_is_valid(chip, clock)) {
+		snd_printk(KERN_ERR "%d:%d:%d: clock source %d is not valid, cannot use\n",
+			   dev->devnum, iface, fmt->altsetting, clock);
+		return -ENXIO;
+	}
+
+	data[0] = rate;
+	data[1] = rate >> 8;
+	data[2] = rate >> 16;
+	data[3] = rate >> 24;
+	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
+				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
+				   UAC2_CS_CONTROL_SAM_FREQ << 8, clock << 8,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2)\n",
+			   dev->devnum, iface, fmt->altsetting, rate);
+		return err;
+	}
+
+	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
+				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
+				   UAC2_CS_CONTROL_SAM_FREQ << 8, clock << 8,
+				   data, sizeof(data), 1000)) < 0) {
+		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
+			   dev->devnum, iface, fmt->altsetting);
+		return err;
+	}
+
+	crate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
+	if (crate != rate)
+		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
+
+	return 0;
+}
+
+int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
+			     struct usb_host_interface *alts,
+			     struct audioformat *fmt, int rate)
+{
+	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
+
+	switch (altsd->bInterfaceProtocol) {
+	case UAC_VERSION_1:
+		return set_sample_rate_v1(chip, iface, alts, fmt, rate);
+
+	case UAC_VERSION_2:
+		return set_sample_rate_v2(chip, iface, alts, fmt, rate);
+	}
+
+	return -EINVAL;
+}
+
diff --git a/sound/usb/clock.h b/sound/usb/clock.h
new file mode 100644
index 0000000..beb2536
--- /dev/null
+++ b/sound/usb/clock.h
@@ -0,0 +1,12 @@
+#ifndef __USBAUDIO_CLOCK_H
+#define __USBAUDIO_CLOCK_H
+
+int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
+			     struct usb_host_interface *alts,
+			     struct audioformat *fmt, int rate);
+
+int snd_usb_clock_find_source(struct snd_usb_audio *chip,
+			      struct usb_host_interface *host_iface,
+			      int entity_id);
+
+#endif /* __USBAUDIO_CLOCK_H */
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 28ee1ce..9593b91 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -190,6 +190,38 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 	return attributes;
 }
 
+static struct uac2_input_terminal_descriptor *
+	snd_usb_find_input_terminal_descriptor(struct usb_host_interface *ctrl_iface,
+					       int terminal_id)
+{
+	struct uac2_input_terminal_descriptor *term = NULL;
+
+	while ((term = snd_usb_find_csint_desc(ctrl_iface->extra,
+					       ctrl_iface->extralen,
+					       term, UAC_INPUT_TERMINAL))) {
+		if (term->bTerminalID == terminal_id)
+			return term;
+	}
+
+	return NULL;
+}
+
+static struct uac2_output_terminal_descriptor *
+	snd_usb_find_output_terminal_descriptor(struct usb_host_interface *ctrl_iface,
+						int terminal_id)
+{
+	struct uac2_output_terminal_descriptor *term = NULL;
+
+	while ((term = snd_usb_find_csint_desc(ctrl_iface->extra,
+					       ctrl_iface->extralen,
+					       term, UAC_OUTPUT_TERMINAL))) {
+		if (term->bTerminalID == terminal_id)
+			return term;
+	}
+
+	return NULL;
+}
+
 int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 {
 	struct usb_device *dev;
@@ -199,7 +231,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 	int i, altno, err, stream;
 	int format = 0, num_channels = 0;
 	struct audioformat *fp = NULL;
-	int num, protocol;
+	int num, protocol, clock = 0;
 	struct uac_format_type_i_continuous_descriptor *fmt;
 
 	dev = chip->dev;
@@ -263,6 +295,8 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		}
 
 		case UAC_VERSION_2: {
+			struct uac2_input_terminal_descriptor *input_term;
+			struct uac2_output_terminal_descriptor *output_term;
 			struct uac_as_header_descriptor_v2 *as =
 				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
 
@@ -281,7 +315,25 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 			num_channels = as->bNrChannels;
 			format = le32_to_cpu(as->bmFormats);
 
-			break;
+			/* lookup the terminal associated to this interface
+			 * to extract the clock */
+			input_term = snd_usb_find_input_terminal_descriptor(chip->ctrl_intf,
+									    as->bTerminalLink);
+			if (input_term) {
+				clock = input_term->bCSourceID;
+				break;
+			}
+
+			output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
+									      as->bTerminalLink);
+			if (output_term) {
+				clock = output_term->bCSourceID;
+				break;
+			}
+
+			snd_printk(KERN_ERR "%d:%u:%d : bogus bTerminalLink %d\n",
+				   dev->devnum, iface_no, altno, as->bTerminalLink);
+			continue;
 		}
 
 		default:
@@ -338,6 +390,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 			fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
 					* (fp->maxpacksize & 0x7ff);
 		fp->attributes = parse_uac_endpoint_attributes(chip, alts, protocol, iface_no);
+		fp->clock = clock;
 
 		/* some quirks for attributes here */
 
diff --git a/sound/usb/format.c b/sound/usb/format.c
index fe29d61..5367cd1 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -29,6 +29,7 @@
 #include "quirks.h"
 #include "helper.h"
 #include "debug.h"
+#include "clock.h"
 
 /*
  * parse the audio format type I descriptor
@@ -215,15 +216,17 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 	struct usb_device *dev = chip->dev;
 	unsigned char tmp[2], *data;
 	int i, nr_rates, data_size, ret = 0;
+	int clock = snd_usb_clock_find_source(chip, chip->ctrl_intf, fp->clock);
 
 	/* get the number of sample rates first by only fetching 2 bytes */
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-			      UAC2_CS_CONTROL_SAM_FREQ << 8, chip->clock_id << 8,
+			      UAC2_CS_CONTROL_SAM_FREQ << 8, clock << 8,
 			      tmp, sizeof(tmp), 1000);
 
 	if (ret < 0) {
-		snd_printk(KERN_ERR "unable to retrieve number of sample rates\n");
+		snd_printk(KERN_ERR "%s(): unable to retrieve number of sample rates (clock %d)\n",
+				__func__, clock);
 		goto err;
 	}
 
@@ -237,12 +240,13 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 
 	/* now get the full information */
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
-			       USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-			       UAC2_CS_CONTROL_SAM_FREQ << 8, chip->clock_id << 8,
-			       data, data_size, 1000);
+			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
+			      UAC2_CS_CONTROL_SAM_FREQ << 8, clock << 8,
+			      data, data_size, 1000);
 
 	if (ret < 0) {
-		snd_printk(KERN_ERR "unable to retrieve sample rate range\n");
+		snd_printk(KERN_ERR "%s(): unable to retrieve sample rate range (clock %d)\n",
+				__func__, clock);
 		ret = -EINVAL;
 		goto err_free;
 	}
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 056587d..4568298 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -31,6 +31,7 @@
 #include "urb.h"
 #include "helper.h"
 #include "pcm.h"
+#include "clock.h"
 
 /*
  * return the current pcm pointer.  just based on the hwptr_done value.
@@ -181,103 +182,6 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 	return -EINVAL;
 }
 
-static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
-			      struct usb_host_interface *alts,
-			      struct audioformat *fmt, int rate)
-{
-	struct usb_device *dev = chip->dev;
-	unsigned int ep;
-	unsigned char data[3];
-	int err, crate;
-
-	ep = get_endpoint(alts, 0)->bEndpointAddress;
-	/* if endpoint doesn't have sampling rate control, bail out */
-	if (!(fmt->attributes & UAC_EP_CS_ATTR_SAMPLE_RATE)) {
-		snd_printk(KERN_WARNING "%d:%d:%d: endpoint lacks sample rate attribute bit, cannot set.\n",
-				   dev->devnum, iface, fmt->altsetting);
-		return 0;
-	}
-
-	data[0] = rate;
-	data[1] = rate >> 8;
-	data[2] = rate >> 16;
-	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
-				   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
-				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
-				   data, sizeof(data), 1000)) < 0) {
-		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d to ep %#x\n",
-			   dev->devnum, iface, fmt->altsetting, rate, ep);
-		return err;
-	}
-	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
-				   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_IN,
-				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
-				   data, sizeof(data), 1000)) < 0) {
-		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq at ep %#x\n",
-			   dev->devnum, iface, fmt->altsetting, ep);
-		return 0; /* some devices don't support reading */
-	}
-	crate = data[0] | (data[1] << 8) | (data[2] << 16);
-	if (crate != rate) {
-		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
-		// runtime->rate = crate;
-	}
-
-	return 0;
-}
-
-static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
-			      struct usb_host_interface *alts,
-			      struct audioformat *fmt, int rate)
-{
-	struct usb_device *dev = chip->dev;
-	unsigned char data[4];
-	int err, crate;
-
-	data[0] = rate;
-	data[1] = rate >> 8;
-	data[2] = rate >> 16;
-	data[3] = rate >> 24;
-	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
-				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
-				   UAC2_CS_CONTROL_SAM_FREQ << 8, chip->clock_id << 8,
-				   data, sizeof(data), 1000)) < 0) {
-		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2)\n",
-			   dev->devnum, iface, fmt->altsetting, rate);
-		return err;
-	}
-	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
-				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-				   UAC2_CS_CONTROL_SAM_FREQ << 8, chip->clock_id << 8,
-				   data, sizeof(data), 1000)) < 0) {
-		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
-			   dev->devnum, iface, fmt->altsetting);
-		return err;
-	}
-	crate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
-	if (crate != rate)
-		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
-
-	return 0;
-}
-
-int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
-			     struct usb_host_interface *alts,
-			     struct audioformat *fmt, int rate)
-{
-	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
-
-	switch (altsd->bInterfaceProtocol) {
-	case UAC_VERSION_1:
-		return set_sample_rate_v1(chip, iface, alts, fmt, rate);
-
-	case UAC_VERSION_2:
-		return set_sample_rate_v2(chip, iface, alts, fmt, rate);
-	}
-
-	return -EINVAL;
-}
-
 /*
  * find a matching format and set up the interface
  */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 06ebf24..24d3319 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -40,9 +40,6 @@ struct snd_usb_audio {
 	int num_interfaces;
 	int num_suspended_intf;
 
-	/* for audio class v2 */
-	int clock_id;
-
 	struct list_head pcm_list;	/* list of pcm streams */
 	int pcm_devs;
 
@@ -53,6 +50,8 @@ struct snd_usb_audio {
 	int setup;			/* from the 'device_setup' module param */
 	int nrpacks;			/* from the 'nrpacks' module param */
 	int async_unlink;		/* from the 'async_unlink' module param */
+
+	struct usb_host_interface *ctrl_intf;	/* the audio control interface */
 };
 
 /*
-- 
1.7.1
