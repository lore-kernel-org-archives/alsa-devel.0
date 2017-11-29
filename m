From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 1/6] ALSA: usb: ADC3: Add initial BADD spec
	support
Date: Wed, 29 Nov 2017 10:55:27 +0000
Message-ID: <20171129105532.15420-2-jorge.sanjuan@codethink.co.uk>
References: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E02F26787F
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:55:35 +0100 (CET)
In-Reply-To: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
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
Cc: linux-kernel@lists.codethink.co.uk, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

The Basic Audio Device 3 (BADD) spec requires the host to
have "inferred" descriptors when a BADD profile ID is specified.
This descriptor generator creates a buffer with known descriptors
for each profile that can be then read to create the alsa audio
device(s). The UAC3 compliant devices should have one configuration
that is BADD compliant.

The USB request from host are bypassed and these buffers are read
instead.

This patch series covers (for now) the following topologies:

 - HEADPHONE.
 - HEADSET.

For more information refer to the spec at:

 http://www.usb.org/developers/docs/devclass_docs/

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/Makefile   |   3 +-
 sound/usb/badd.c     | 495 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/badd.h     |  30 ++++
 sound/usb/card.c     |   3 +
 sound/usb/stream.c   | 158 ++++++++++------
 sound/usb/usbaudio.h |   1 +
 6 files changed, 632 insertions(+), 58 deletions(-)
 create mode 100644 sound/usb/badd.c
 create mode 100644 sound/usb/badd.h

diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 42cb33b94f6a..b4b54947a276 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -2,7 +2,8 @@
 # Makefile for ALSA
 #
 
-snd-usb-audio-objs := 	card.o \
+snd-usb-audio-objs := 	badd.o \
+			card.o \
 			clock.o \
 			endpoint.o \
 			format.o \
diff --git a/sound/usb/badd.c b/sound/usb/badd.c
new file mode 100644
index 000000000000..aff6e431e5c0
--- /dev/null
+++ b/sound/usb/badd.c
@@ -0,0 +1,495 @@
+/*
+ *   USB: Audio Class 3: support for BASIC AUDIO DEVICE v.3
+ *
+ *   Author: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
+ *   Copyright (C) 2017 Codethink Ltd.
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
+ */
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/usb/audio.h>
+#include <linux/usb/audio-v3.h>
+
+#include <sound/asound.h>
+
+#include "badd.h"
+
+#define BADD_HEADPHONE		UAC3_FUNCTION_SUBCLASS_HEADPHONE
+#define BADD_SPEAKER		UAC3_FUNCTION_SUBCLASS_SPEAKER
+#define BADD_MICROPHONE		UAC3_FUNCTION_SUBCLASS_MICROPHONE
+#define BADD_HEADSET		UAC3_FUNCTION_SUBCLASS_HEADSET
+#define BADD_HEADSET_ADAPTER	UAC3_FUNCTION_SUBCLASS_HEADSET_ADAPTER
+#define BADD_SPEAKERPHONE	UAC3_FUNCTION_SUBCLASS_SPEAKERPHONE
+
+/* wMaxPacketSize field values from Std. AS Data Endpoint */
+#define BADD_M_16_SYNC		0x0060
+#define BADD_M_16_ASYNC		0x0062
+#define BADD_M_24_SYNC		0x0090
+#define BADD_M_24_ASYNC		0x0093
+#define BADD_S_16_SYNC		0x00C0
+#define BADD_S_16_ASYNC		0x00C4
+#define BADD_S_24_SYNC		0x0120
+#define BADD_S_24_ASYNC		0x0126
+
+struct uac3_ac_header_descriptor inf_ac_desc = {
+	.bLength = sizeof inf_ac_desc,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+
+	/* bCategory -> Profile dependent */
+	/* wTotalLength -> Profile dependent */
+	.bDescriptorSubtype = UAC_MS_HEADER,
+	.bmControls = 0x01,
+};
+
+struct uac3_input_terminal_descriptor inf_in_term_id1 = {
+	.bLength = sizeof inf_in_term_id1,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC_INPUT_TERMINAL,
+
+	.bTerminalID = 0x01, /* ID1 */
+	.wTerminalType = cpu_to_le16(UAC_TERMINAL_STREAMING),
+	.bAssocTerminal = 0,
+
+	.bCSourceID = 0x09, /* Clock Source ID9 */
+
+	.bmControls = 0,
+	/*.wClusterDescrID  -> Implementation dependent */
+	.wExTerminalDescrID = 0,
+	.wConnectorsDescrID = 0,
+};
+
+struct uac3_input_terminal_descriptor inf_in_term_id4 = {
+	.bLength = sizeof inf_in_term_id4,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC_INPUT_TERMINAL,
+
+	.bTerminalID = 0x04, /* ID4 */
+	/* wTerminalType -> Profile dependent */
+	/* bAssocTerminal -> Profile dependent */
+
+	.bCSourceID = 0x09, /* Clock Source ID9 */
+
+	/* bmControls -> Profile dependent */
+	/* wClusterDescrID  -> Implementation dependent */
+	.wExTerminalDescrID = 0,
+	/* wConnectorsDescrID -> Profile dependent */
+};
+
+struct uac3_output_terminal_descriptor inf_out_term_id3 = {
+	.bLength = sizeof inf_out_term_id3,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC_OUTPUT_TERMINAL,
+
+	.bTerminalID = 0x03, /* ID3 */
+
+	/* wTerminalType -> Profile dependent */
+	/* bAssocTerminal -> Profile dependent */
+
+	.bSourceID = 0x02, /* Connected to Feature Unit ID2 */
+	.bCSourceID = 0x09, /* Clock Source ID9 */
+
+	/* bmControls -> Profile dependent */
+	.wExTerminalDescrID = 0,
+	/* wConnectorsDescrID -> Profile dependent */
+};
+
+struct uac3_output_terminal_descriptor inf_out_term_id6 = {
+	.bLength = sizeof inf_out_term_id6,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC_OUTPUT_TERMINAL,
+
+	.bTerminalID = 0x06, /* ID6 */
+
+	.wTerminalType = cpu_to_le16(UAC_TERMINAL_STREAMING),
+	.bAssocTerminal = 0,
+
+	.bSourceID = 0x05, /* Connected to Feature Unit ID5 */
+	.bCSourceID = 0x09, /* Clock Source ID9 */
+
+	.bmControls = 0,
+	.wExTerminalDescrID = 0,
+	.wConnectorsDescrID = 0,
+};
+
+struct uac3_feature_unit_descriptor inf_feat_unit_id2 = {
+	.bLength = 0x0F, /* 0x13 if stereo */
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC3_FEATURE_UNIT,
+
+	.bUnitID = 0x02,
+	/* bSourceID -> Profile dependent */
+	.bmaControls[0] = 0x03, /* Mute */
+	.bmaControls[1] = 0x0C, /* Chn1 Vol */
+	/* If stereo */
+	//.bmaControls[2] = 0x0C, /* Chn2 Vol */
+};
+
+struct uac3_feature_unit_descriptor inf_feat_unit_id5 = {
+	.bLength = 0x0F, /* 0x13 if stereo */
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC3_FEATURE_UNIT,
+
+	.bUnitID = 0x05,
+	.bSourceID = 0x04,
+	.bmaControls[0] = 0x03, /* Mute */
+	.bmaControls[1] = 0x0C, /* Chn1 Vol */
+	/* If stereo */
+	//.bmaControls[2] = 0x0C, /* Chn2 Vol */
+};
+
+struct uac3_feature_unit_descriptor inf_feat_unit_id7 = {
+	.bLength = 0x0F,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC3_FEATURE_UNIT,
+
+	.bUnitID = 0x07,
+	.bSourceID = 0x04,
+	.bmaControls[0] = 0x03, /* Mute */
+	.bmaControls[1] = 0x0C, /* Chn1 Vol */
+};
+
+struct uac3_clock_source_descriptor inf_clk_src = {
+	.bLength = sizeof inf_clk_src,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC3_CLOCK_SOURCE,
+
+	.bClockID = 0x09,
+	/* bmAttributes -> Implementation dependent */
+
+	.bmControls = 0x01, /* 48 KHz fixed */
+	.bReferenceTerminal = 0,
+};
+
+struct uac3_power_domain_descriptor inf_pwdom_id10 = {
+	.bLength = 0x0D,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC3_POWER_DOMAIN,
+
+	.bPowerDomainID = 0x0A,
+	.waRecoveryTime1 = 0x0258,
+	.waRecoveryTime2 = 0x1770,
+
+	.bNrEntities = 0x02,
+	.baEntityID[0] = 0x01, /* Input Terminal ID1 */
+	.baEntityID[1] = 0x03, /* Output Terminal ID3 */
+};
+
+struct uac3_power_domain_descriptor inf_pwdom_id11 = {
+	.bLength = 0x0D,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC3_POWER_DOMAIN,
+
+	.bPowerDomainID = 0x0B,
+	.waRecoveryTime1 = 0x0258,
+	.waRecoveryTime2 = 0x1770,
+
+	.bNrEntities = 0x02,
+	.baEntityID[0] = 0x04, /* Input Terminal ID4 */
+	.baEntityID[1] = 0x06, /* Output Terminal ID6 */
+};
+
+struct uac3_as_header_descriptor inf_as_desc = {
+	.bLength = sizeof inf_as_desc,
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC_AS_GENERAL,
+
+	/* bTerminalLink -> Implementation dependent */
+
+	.bmControls = 0,
+	/* wClusterDescrID -> Implementation dependent */
+	.bmFormats = 0x01, /* PCM */
+	/* bSubslotSize -> Implementation dependent */
+	/* bBitResolution -> Implementation dependent */
+
+	.bmAuxProtocols = 0,
+	.bControlSize = 0,
+};
+
+struct uac3_iso_endpoint_descriptor inf_iso_ep_desc = {
+	.bLength = sizeof inf_iso_ep_desc,
+	.bDescriptorType = USB_DT_CS_ENDPOINT,
+	.bDescriptorSubtype = UAC_EP_GENERAL,
+
+	.bmControls = 0,
+	.bLockDelayUnits = 0,
+	.wLockDelay = 0,
+};
+
+/**
+ * badd_gen_cluster_desc - This is to bypass the GET_HIGH_CAPABILITY
+ * UAC3 requests for getting cluster descriptors and, instead, generate
+ * the cluster on the host side as per BADD specification.
+ */
+void * badd_gen_cluster_desc(unsigned int m_s)
+{
+	struct uac3_cluster_header_descriptor cluster;
+	struct uac3_cluster_information_segment_descriptor segment;
+	struct uac3_cluster_end_segment_descriptor end;
+	void *buffer;
+	int pos = 0;
+	int length;
+
+	end.wLength = 0x03;
+	end.bSegmentType = UAC3_END_SEGMENT;
+
+	if (m_s == 0x01) { /* Mono */
+		length = 0x10;
+		buffer = kzalloc(length, GFP_KERNEL);
+		if (!buffer)
+			return NULL;
+
+		/* Header */
+		cluster.wLength = length;
+		cluster.bDescriptorType = UAC3_CS_CLUSTER;
+		cluster.bDescriptorSubtype = 0;
+		cluster.wDescriptorID = 0x01;
+		cluster.bNrChannels = 1;
+		memcpy(buffer + pos, &cluster, sizeof(cluster));
+		pos += sizeof(cluster);
+
+		/* Info Segment Mono */
+		segment.wLength = sizeof segment;
+		segment.bSegmentType = UAC3_CHANNEL_INFORMATION;
+		segment.bChPurpose = 0;
+		segment.bChRelationship = 0x01; /* Mono */
+		segment.bChGroupID = 0;
+		memcpy(buffer + pos, &segment, sizeof(segment));
+		pos += sizeof(segment);
+
+		/* End segment */
+		memcpy(buffer + pos, &end, sizeof(end));
+		pos += sizeof(end);
+	}
+	else { /* Stereo */
+		length = 0x19;
+		buffer = kzalloc(length, GFP_KERNEL);
+		if (!buffer)
+			return NULL;
+
+		/* Header */
+		cluster.wLength = length;
+		cluster.bDescriptorType = UAC3_CS_CLUSTER;
+		cluster.bDescriptorSubtype = 0;
+		cluster.wDescriptorID = 0x02;
+		cluster.bNrChannels = 2;
+		memcpy(buffer + pos, &cluster, sizeof(cluster));
+		pos += sizeof(cluster);
+
+		/* Info Segment Left channel */
+		segment.wLength = sizeof segment;
+		segment.bSegmentType = UAC3_CHANNEL_INFORMATION;
+		segment.bChPurpose = 0;
+		segment.bChRelationship = 0x02; /* Left */
+		segment.bChGroupID = 0;
+		memcpy(buffer + pos, &segment, sizeof(segment));
+		pos += sizeof(segment);
+
+		/* End segment */
+		memcpy(buffer + pos, &end, sizeof(end));
+		pos += sizeof(end);
+
+		/* Info Segment Right channel */
+		segment.bChRelationship = 0x03; /* Right */
+		memcpy(buffer + pos, &segment, sizeof(segment));
+		pos += sizeof(segment);
+
+		/* End segment */
+		memcpy(buffer + pos, &end, sizeof(end));
+		pos += sizeof(end);
+	}
+
+	return buffer;
+};
+
+/**
+ * badd_gen_csint_desc - generates a buffer with the inferred
+ * descriptors that are predefined in the BADD specfication.
+ *
+ * This limits the amount of talking the USB device and the host
+ * need to do.
+ *
+ * @buffer: buffer containing all the inferred descriptors.
+ * @profile: BADD profile describing audio capabilities of the device.
+ * @m_s: cluster_id-> 0x1 (mono). 0x2 (stereo).
+ *
+ * return the length of the buffer with the inferred descriptors or negative
+ * value in the case of an error.
+ */
+int badd_gen_csint_desc(void **buffer, int profile, unsigned int m_s)
+{
+	void *pr_descs = NULL;
+	int pos = 0;
+	int bufflen = 0;
+	int ret = 0;
+
+	switch (profile) {
+	case BADD_HEADPHONE:
+		inf_ac_desc.bCategory = 0x0D;
+		inf_ac_desc.wTotalLength = 0x005D;
+		bufflen = inf_ac_desc.wTotalLength;
+
+		pr_descs = kzalloc(bufflen, GFP_KERNEL);
+		if (!pr_descs)
+			return -ENOMEM;
+
+		memcpy(pr_descs + pos, &inf_ac_desc, inf_ac_desc.bLength);
+		pos += inf_ac_desc.bLength;
+
+		inf_in_term_id1.wClusterDescrID = 0x02;
+		memcpy(pr_descs + pos, &inf_in_term_id1, inf_in_term_id1.bLength);
+		pos += inf_in_term_id1.bLength;
+
+		inf_out_term_id3.wTerminalType = 0x0302;
+		inf_out_term_id3.bAssocTerminal = 0;
+		inf_out_term_id3.bmControls = 0;
+		inf_out_term_id3.wConnectorsDescrID = 0;
+		memcpy(pr_descs + pos, &inf_out_term_id3, inf_out_term_id3.bLength);
+		pos += inf_out_term_id3.bLength;
+
+		inf_feat_unit_id2.bLength = 0x13;
+		inf_feat_unit_id2.bSourceID = 0x01;
+		inf_feat_unit_id2.bmaControls[2] = 0x0C;
+		memcpy(pr_descs + pos, &inf_feat_unit_id2, inf_feat_unit_id2.bLength);
+		pos += inf_feat_unit_id2.bLength;
+
+		memcpy(pr_descs + pos, &inf_clk_src, inf_clk_src.bLength);
+		pos += inf_clk_src.bLength;
+
+		memcpy(pr_descs + pos, &inf_pwdom_id10, inf_pwdom_id10.bLength);
+		pos += inf_pwdom_id10.bLength;
+
+		break;
+	case BADD_HEADSET:
+		inf_ac_desc.bCategory = 0x04;
+		if (m_s == 0x1) { /* Mono */
+			inf_ac_desc.wTotalLength = 0x00BB;
+			inf_in_term_id1.wClusterDescrID = 0x01;
+		} else { /* Stereo */
+			inf_ac_desc.wTotalLength = 0x00BF;
+			inf_in_term_id1.wClusterDescrID = 0x02;
+		}
+
+		bufflen = inf_ac_desc.wTotalLength;
+
+		pr_descs = kzalloc(bufflen, GFP_KERNEL);
+		if (!pr_descs)
+			return -ENOMEM;
+
+		memcpy(pr_descs + pos, &inf_ac_desc, inf_ac_desc.bLength);
+		pos += inf_ac_desc.bLength;
+
+		memcpy(pr_descs + pos, &inf_in_term_id1, inf_in_term_id1.bLength);
+		pos += inf_in_term_id1.bLength;
+
+		inf_in_term_id4.wTerminalType = 0x0402;
+		inf_in_term_id4.bAssocTerminal = 0x03;
+		inf_in_term_id4.bmControls = 0;
+		inf_in_term_id4.wClusterDescrID = 0x01;
+		memcpy(pr_descs + pos, &inf_in_term_id4, inf_in_term_id4.bLength);
+		pos += inf_in_term_id4.bLength;
+
+		inf_out_term_id3.wTerminalType = 0x0402;
+		inf_out_term_id3.bAssocTerminal = 0x04;
+		inf_out_term_id3.bmControls = 0;
+		inf_out_term_id3.wConnectorsDescrID = 0;
+		memcpy(pr_descs + pos, &inf_out_term_id3, inf_out_term_id3.bLength);
+		pos += inf_out_term_id3.bLength;
+
+		memcpy(pr_descs + pos, &inf_out_term_id6, inf_out_term_id6.bLength);
+		pos += inf_out_term_id6.bLength;
+
+		/* TODO: Add mising Mixer UNIT */
+
+		inf_feat_unit_id2.bLength = 0x13;
+		inf_feat_unit_id2.bmaControls[2] = 0x0C;
+		inf_feat_unit_id2.bSourceID = 0x08;
+		memcpy(pr_descs + pos, &inf_feat_unit_id2, inf_feat_unit_id2.bLength);
+		pos += inf_feat_unit_id2.bLength;
+
+		memcpy(pr_descs + pos, &inf_feat_unit_id5, inf_feat_unit_id5.bLength);
+		pos += inf_feat_unit_id5.bLength;
+
+		memcpy(pr_descs + pos, &inf_feat_unit_id7, inf_feat_unit_id7.bLength);
+		pos += inf_feat_unit_id7.bLength;
+
+		memcpy(pr_descs + pos, &inf_clk_src, inf_clk_src.bLength);
+		pos += inf_clk_src.bLength;
+
+		memcpy(pr_descs + pos, &inf_pwdom_id10, inf_pwdom_id10.bLength);
+		pos += inf_pwdom_id10.bLength;
+
+		memcpy(pr_descs + pos, &inf_pwdom_id11, inf_pwdom_id11.bLength);
+		pos += inf_pwdom_id11.bLength;
+
+		break;
+	case BADD_MICROPHONE:
+	case BADD_HEADSET_ADAPTER:
+	default:
+		return -ENOSYS;
+	}
+
+	*buffer = pr_descs;
+	ret = bufflen;
+	return ret;
+}
+
+void * badd_get_as_iface(int stream_dir, int badd_cfg)
+{
+	struct uac3_as_header_descriptor *badd_as = &inf_as_desc;
+
+	if (stream_dir == SNDRV_PCM_STREAM_CAPTURE)
+		badd_as->bTerminalLink = 0x06; /* IN */
+	else
+		badd_as->bTerminalLink = 0x01; /* OUT */
+
+	switch (badd_cfg) {
+	case BADD_M_16_SYNC:
+	case BADD_M_16_ASYNC:
+		badd_as->wClusterDescrID = 0x01;
+		badd_as->bSubslotSize = 0x02;
+		badd_as->bBitResolution = 0x10;
+		break;
+	case BADD_M_24_SYNC:
+	case BADD_M_24_ASYNC:
+		badd_as->wClusterDescrID = 0x01;
+		badd_as->bSubslotSize = 0x03;
+		badd_as->bBitResolution = 0x18;
+		break;
+	case BADD_S_16_SYNC:
+	case BADD_S_16_ASYNC:
+		badd_as->wClusterDescrID = 0x02;
+		badd_as->bSubslotSize = 0x02;
+		badd_as->bBitResolution = 0x10;
+		break;
+	case BADD_S_24_SYNC:
+	case BADD_S_24_ASYNC:
+		badd_as->wClusterDescrID = 0x02;
+		badd_as->bSubslotSize = 0x03;
+		badd_as->bBitResolution = 0x18;
+		break;
+	default:
+		return NULL;
+	}
+
+	return badd_as;
+}
+
+void * badd_get_ep_dec(void)
+{
+	return &inf_iso_ep_desc;
+}
+
+
diff --git a/sound/usb/badd.h b/sound/usb/badd.h
new file mode 100644
index 000000000000..de3d990bfbb8
--- /dev/null
+++ b/sound/usb/badd.h
@@ -0,0 +1,30 @@
+/*
+ *   USB: Audio Class 3: support for BASIC AUDIO DEVICE v.3
+ *
+ *   Author: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
+ *   Copyright (C) 2017 Codethink Ltd.
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
+ */
+#ifndef __USBAUDIO_BADD_H
+#define __USBAUDIO_BADD_H
+
+int badd_gen_csint_desc(void **buffer, int profile, unsigned int m_s);
+void * badd_gen_cluster_desc(unsigned int m_s);
+void * badd_get_as_iface(int stream_dir, int badd_cfg);
+void * badd_get_ep_dec(void);
+
+#endif /* __USBAUDIO_BADD_H */
+
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 24cfb4bc5ed6..fa3cabd1cadc 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -288,6 +288,9 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 			return -EINVAL;
 		}
 
+		if (assoc->bFunctionSubClass > UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0)
+			chip->badd_profile = assoc->bFunctionSubClass;
+
 		for (i = 0; i < assoc->bInterfaceCount; i++) {
 			int intf = assoc->bFirstInterface + i;
 
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 631b6cfe865a..8b3565d4ca24 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -37,6 +37,7 @@
 #include "format.h"
 #include "clock.h"
 #include "stream.h"
+#include "badd.h"
 
 /*
  * free a substream
@@ -485,7 +486,11 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
 	int attributes = 0;
 
-	csep = snd_usb_find_desc(alts->endpoint[0].extra, alts->endpoint[0].extralen, NULL, USB_DT_CS_ENDPOINT);
+	if (protocol == UAC_VERSION_3 &&
+			chip->badd_profile > UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0)
+		csep = badd_get_ep_dec();
+	else
+		csep = snd_usb_find_desc(alts->endpoint[0].extra, alts->endpoint[0].extralen, NULL, USB_DT_CS_ENDPOINT);
 
 	/* Creamware Noah has this descriptor after the 2nd endpoint */
 	if (!csep && altsd->bNumEndpoints >= 2)
@@ -568,6 +573,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 	int i, altno, err, stream;
 	u64 format = 0;
 	unsigned int num_channels = 0;
+	unsigned int ep_packsize;
 	struct audioformat *fp = NULL;
 	int num, protocol, clock = 0;
 	struct uac_format_type_i_continuous_descriptor *fmt;
@@ -609,6 +615,8 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 			SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 		altno = altsd->bAlternateSetting;
 
+		ep_packsize =  le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+
 		if (snd_usb_apply_interface_quirk(chip, iface_no, altno))
 			continue;
 
@@ -715,11 +723,33 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 			struct uac3_as_header_descriptor *as;
 			struct uac3_cluster_header_descriptor *cluster;
 			struct uac3_hc_descriptor_header hc_header;
+			struct usb_host_interface *badd_ctrl_intf;
+			void *badd_extra;
+			int badd_extralen;
 			u16 cluster_id, wLength;
 
-			as = snd_usb_find_csint_desc(alts->extra,
-							alts->extralen,
-							NULL, UAC_AS_GENERAL);
+			badd_ctrl_intf = kzalloc(sizeof(*badd_ctrl_intf), GFP_KERNEL);
+			memcpy(badd_ctrl_intf, chip->ctrl_intf, sizeof(*badd_ctrl_intf));
+
+			if (chip->badd_profile > UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0) {
+
+				as = badd_get_as_iface(stream, ep_packsize);
+
+				err = badd_gen_csint_desc(&badd_extra, chip->badd_profile, as->wClusterDescrID);
+				if (err <= 0 || !badd_extra) {
+					dev_err(&dev->dev,
+						"%u:%d : Cannot set BADD profile 0x%x. err=%d. badd_extra %p\n",
+						iface_no, altno, chip->badd_profile, err, badd_extra);
+					return err;
+				}
+
+				badd_extralen = err;
+				badd_ctrl_intf->extra = badd_extra;
+				badd_ctrl_intf->extralen = badd_extralen;
+			} else
+				as = snd_usb_find_csint_desc(alts->extra,
+								alts->extralen,
+								NULL, UAC_AS_GENERAL);
 
 			if (!as) {
 				dev_err(&dev->dev,
@@ -743,53 +773,64 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 				continue;
 			}
 
-			/*
-			 * Get number of channels and channel map through
-			 * High Capability Cluster Descriptor
-			 *
-			 * First step: get High Capability header and
-			 * read size of Cluster Descriptor
-			 */
-			err = snd_usb_ctl_msg(chip->dev,
-					usb_rcvctrlpipe(chip->dev, 0),
-					UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
-					USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-					cluster_id,
-					snd_usb_ctrl_intf(chip),
-					&hc_header, sizeof(hc_header));
-			if (err < 0)
-				return err;
-			else if (err != sizeof(hc_header)) {
-				dev_err(&dev->dev,
-					"%u:%d : can't get High Capability descriptor\n",
-					iface_no, altno);
-				return -EIO;
-			}
-
-			/*
-			 * Second step: allocate needed amount of memory
-			 * and request Cluster Descriptor
-			 */
-			wLength = le16_to_cpu(hc_header.wLength);
-			cluster = kzalloc(wLength, GFP_KERNEL);
-			if (!cluster)
-				return -ENOMEM;
-			err = snd_usb_ctl_msg(chip->dev,
-					usb_rcvctrlpipe(chip->dev, 0),
-					UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
-					USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-					cluster_id,
-					snd_usb_ctrl_intf(chip),
-					cluster, wLength);
-			if (err < 0) {
-				kfree(cluster);
-				return err;
-			} else if (err != wLength) {
-				dev_err(&dev->dev,
-					"%u:%d : can't get Cluster Descriptor\n",
-					iface_no, altno);
-				kfree(cluster);
-				return -EIO;
+			if (chip->badd_profile > UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0) {
+
+				cluster = badd_gen_cluster_desc(cluster_id);
+				if (!cluster) {
+					dev_err(&dev->dev, 
+						"%u:%d : can't get Cluster Descriptor\n",
+						iface_no, altno);
+					return -ENOMEM;
+				}
+			} else {
+				/*
+				 * Get number of channels and channel map through
+				 * High Capability Cluster Descriptor
+				 *
+				 * First step: get High Capability header and
+				 * read size of Cluster Descriptor
+				 */
+				err = snd_usb_ctl_msg(chip->dev,
+						usb_rcvctrlpipe(chip->dev, 0),
+						UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
+						USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+						cluster_id,
+						snd_usb_ctrl_intf(chip),
+						&hc_header, sizeof(hc_header));
+				if (err < 0)
+					return err;
+				else if (err != sizeof(hc_header)) {
+					dev_err(&dev->dev,
+						"%u:%d : can't get High Capability descriptor\n",
+						iface_no, altno);
+					return -EIO;
+				}
+
+				/*
+				 * Second step: allocate needed amount of memory
+				 * and request Cluster Descriptor
+				 */
+				wLength = le16_to_cpu(hc_header.wLength);
+				cluster = kzalloc(wLength, GFP_KERNEL);
+				if (!cluster)
+					return -ENOMEM;
+				err = snd_usb_ctl_msg(chip->dev,
+						usb_rcvctrlpipe(chip->dev, 0),
+						UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
+						USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+						cluster_id,
+						snd_usb_ctrl_intf(chip),
+						cluster, wLength);
+				if (err < 0) {
+					kfree(cluster);
+					return err;
+				} else if (err != wLength) {
+					dev_err(&dev->dev,
+						"%u:%d : can't get Cluster Descriptor\n",
+						iface_no, altno);
+					kfree(cluster);
+					return -EIO;
+				}
 			}
 
 			num_channels = cluster->bNrChannels;
@@ -802,7 +843,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 			/* lookup the terminal associated to this interface
 			 * to extract the clock */
 			input_term = snd_usb_find_input_terminal_descriptor(
-							chip->ctrl_intf,
+							badd_ctrl_intf,
 							as->bTerminalLink);
 
 			if (input_term) {
@@ -810,7 +851,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 				break;
 			}
 
-			output_term = snd_usb_find_output_terminal_descriptor(chip->ctrl_intf,
+			output_term = snd_usb_find_output_terminal_descriptor(badd_ctrl_intf,
 									      as->bTerminalLink);
 			if (output_term) {
 				clock = output_term->bCSourceID;
@@ -874,7 +915,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
 		fp->datainterval = snd_usb_parse_datainterval(chip, alts);
 		fp->protocol = protocol;
-		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+		fp->maxpacksize = ep_packsize;
 		fp->channels = num_channels;
 		if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
 			fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
@@ -926,9 +967,12 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		} else {
 			struct uac3_as_header_descriptor *as;
 
-			as = snd_usb_find_csint_desc(alts->extra,
-						     alts->extralen,
-						     NULL, UAC_AS_GENERAL);
+			if (chip->badd_profile > UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0)
+				as = badd_get_as_iface(stream, ep_packsize);
+			else
+				as = snd_usb_find_csint_desc(alts->extra,
+								alts->extralen,
+								NULL, UAC_AS_GENERAL);
 
 			if (snd_usb_parse_audio_format_v3(chip, fp, as,
 								stream) < 0) {
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 4d5c89a7ba2b..276f5f93ad40 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -61,6 +61,7 @@ struct snd_usb_audio {
 	bool autoclock;			/* from the 'autoclock' module param */
 
 	struct usb_host_interface *ctrl_intf;	/* the audio control interface */
+	unsigned int badd_profile;	/* BADD profile from bFunctionSubClass */
 };
 
 #define usb_audio_err(chip, fmt, args...) \
-- 
2.11.0
