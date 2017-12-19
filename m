From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v1 6/6] ALSA: usb: ADC3: Add initial BADD spec
	support
Date: Tue, 19 Dec 2017 09:14:11 +0000
Message-ID: <20171219091411.16267-7-jorge.sanjuan@codethink.co.uk>
References: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 36EA5267601
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 10:14:19 +0100 (CET)
In-Reply-To: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: linux-kernel@lists.codethink.co.uk, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, ci005-internal@lists.codethink.co.uk
List-Id: alsa-devel@alsa-project.org

The Basic Audio Device 3 (BADD) spec requires the host
to have "inferred" descriptors when a BADD profile ID
is specified. This descriptor generator creates a buffer
with known descriptors for each profile that can be then
read to create the alsa audio device(s). The UAC3
compliant devices should have one configuration that is
BADD compliant.

The inferred descriptors get fixed values defined in the spec
depending on the topology of the device. This patch series
covers (for now) the following topologies:

 - HEADPHONE.
 - MICROPHONE.
 - HEADSET.

For more information refer to the spec at:

http://www.usb.org/developers/docs/devclass_docs/

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/Makefile   |   3 +-
 sound/usb/badd.c     | 518 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/badd.h     |  14 ++
 sound/usb/card.c     |   7 +
 sound/usb/stream.c   | 148 +++++++++------
 sound/usb/usbaudio.h |   1 +
 6 files changed, 635 insertions(+), 56 deletions(-)
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
index 000000000000..5fe8252fcde1
--- /dev/null
+++ b/sound/usb/badd.c
@@ -0,0 +1,518 @@
+/*
+ *   USB: Audio Class 3: support for BASIC AUDIO DEVICE v.3
+ *
+ *   Author: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
+ *   Copyright (C) 2017 Codethink Ltd.
+ *
+ *   SPDX-License-Identifier: GPL-2.0
+ */
+
+
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
+#define BADD_MONO		0x01
+#define BADD_STEREO		0x02
+
+/* CS Control Interface fixed lengths */
+#define BADD_HP_LEN		0x005D
+#define BADD_MP_LEN_M		0x0059
+#define BADD_MP_LEN_S		0x005D
+#define BADD_HS_LEN_M		0x00BB
+#define BADD_HS_LEN_S		0x00BF
+
+/* Feature Unit fixed lengths */
+#define BADD_FU_LEN_M		0x0F
+#define BADD_FU_LEN_S		0x13
+
+/* Cluster Descriptor fixed lengths */
+#define BADD_CLUSTER_LEN_M	0x10
+#define BADD_CLUSTER_LEN_S	0x19
+#define BADD_CLUSTER_END_SEG	0x03
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
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC3_FEATURE_UNIT,
+
+	.bUnitID = 0x02,
+	/* bSourceID -> Profile dependent */
+	.bmaControls[0] = 0x03, /* Mute */
+	.bmaControls[1] = 0x0C, /* Chn1 Vol */
+	/* If stereo */
+	/* bmaControls[2] = 0x0C, Chn2 Vol */
+};
+
+struct uac3_feature_unit_descriptor inf_feat_unit_id5 = {
+	.bDescriptorType = USB_DT_CS_INTERFACE,
+	.bDescriptorSubtype = UAC3_FEATURE_UNIT,
+
+	.bUnitID = 0x05,
+	.bSourceID = 0x04,
+	.bmaControls[0] = 0x03, /* Mute */
+	.bmaControls[1] = 0x0C, /* Chn1 Vol */
+	/* If stereo */
+	/* bmaControls[2] = 0x0C, Chn2 Vol */
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
+void *badd_gen_cluster_desc(unsigned int m_s)
+{
+	struct uac3_cluster_header_descriptor cluster;
+	struct uac3_cluster_information_segment_descriptor segment;
+	struct uac3_cluster_end_segment_descriptor end;
+	void *buffer;
+	int pos = 0;
+	int length;
+
+	end.wLength = cpu_to_le16(BADD_CLUSTER_END_SEG);
+	end.bSegmentType = UAC3_END_SEGMENT;
+
+	if (m_s == BADD_MONO) {
+		length = BADD_CLUSTER_LEN_M;
+		buffer = kzalloc(length, GFP_KERNEL);
+		if (!buffer)
+			return NULL;
+
+		/* Header */
+		cluster.wLength = cpu_to_le16(length);
+		cluster.bDescriptorType = UAC3_CS_CLUSTER;
+		cluster.bDescriptorSubtype = 0;
+		cluster.wDescriptorID = cpu_to_le16(BADD_MONO);
+		cluster.bNrChannels = 1;
+		memcpy(buffer + pos, &cluster, sizeof(cluster));
+		pos += sizeof(cluster);
+
+		/* Info Segment Mono */
+		segment.wLength = cpu_to_le16(sizeof segment);
+		segment.bSegmentType = UAC3_CHANNEL_INFORMATION;
+		segment.bChPurpose = 0;
+		segment.bChRelationship = UAC3_CH_MONO;
+		segment.bChGroupID = 0;
+		memcpy(buffer + pos, &segment, sizeof(segment));
+		pos += sizeof(segment);
+
+		/* End segment */
+		memcpy(buffer + pos, &end, sizeof(end));
+		pos += sizeof(end);
+	} else {
+		length = BADD_CLUSTER_LEN_S;
+		buffer = kzalloc(length, GFP_KERNEL);
+		if (!buffer)
+			return NULL;
+
+		/* Header */
+		cluster.wLength = cpu_to_le16(length);
+		cluster.bDescriptorType = UAC3_CS_CLUSTER;
+		cluster.bDescriptorSubtype = 0;
+		cluster.wDescriptorID = cpu_to_le16(BADD_STEREO);
+		cluster.bNrChannels = 2;
+		memcpy(buffer + pos, &cluster, sizeof(cluster));
+		pos += sizeof(cluster);
+
+		/* Info Segment Left channel */
+		segment.wLength = cpu_to_le16(sizeof segment);
+		segment.bSegmentType = UAC3_CHANNEL_INFORMATION;
+		segment.bChPurpose = 0;
+		segment.bChRelationship = UAC3_CH_LEFT;
+		segment.bChGroupID = 0;
+		memcpy(buffer + pos, &segment, sizeof(segment));
+		pos += sizeof(segment);
+
+		/* End segment */
+		memcpy(buffer + pos, &end, sizeof(end));
+		pos += sizeof(end);
+
+		/* Info Segment Right channel */
+		segment.bChRelationship = UAC3_CH_RIGHT;
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
+int badd_gen_csint_desc(void **buffer, int profile, unsigned int m_s)
+{
+	void *pr_descs = NULL;
+	int pos = 0;
+	int bufflen = 0;
+	int ret = 0;
+
+	switch (profile) {
+	case BADD_HEADPHONE:
+		inf_ac_desc.bCategory = UAC3_FUNCTION_HEADPHONE;
+		bufflen = BADD_HP_LEN;
+		inf_ac_desc.wTotalLength = cpu_to_le16(bufflen);
+
+		pr_descs = kzalloc(bufflen, GFP_KERNEL);
+		if (!pr_descs)
+			return -ENOMEM;
+
+		memcpy(pr_descs + pos, &inf_ac_desc, inf_ac_desc.bLength);
+		pos += inf_ac_desc.bLength;
+
+		inf_in_term_id1.wClusterDescrID = cpu_to_le16(BADD_STEREO);
+		memcpy(pr_descs + pos, &inf_in_term_id1, inf_in_term_id1.bLength);
+		pos += inf_in_term_id1.bLength;
+
+		inf_out_term_id3.wTerminalType = cpu_to_le16(UAC_OUTPUT_TERMINAL_HEADPHONES);
+		inf_out_term_id3.bAssocTerminal = 0;
+		inf_out_term_id3.bmControls = 0;
+		inf_out_term_id3.wConnectorsDescrID = 0;
+		memcpy(pr_descs + pos, &inf_out_term_id3, inf_out_term_id3.bLength);
+		pos += inf_out_term_id3.bLength;
+
+		inf_feat_unit_id2.bLength = BADD_FU_LEN_S;
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
+	case BADD_MICROPHONE:
+		inf_ac_desc.bCategory = UAC3_FUNCTION_MICROPHONE;
+		if (m_s == BADD_MONO) {
+			bufflen = BADD_MP_LEN_M;
+			inf_in_term_id4.wClusterDescrID = cpu_to_le16(BADD_MONO);
+			inf_feat_unit_id5.bLength = BADD_FU_LEN_M;
+		} else {
+			bufflen = BADD_MP_LEN_S;
+			inf_in_term_id4.wClusterDescrID = cpu_to_le16(BADD_STEREO);
+			inf_feat_unit_id5.bLength = BADD_FU_LEN_S;
+			inf_feat_unit_id5.bmaControls[2] = 0x0C;
+		}
+
+		inf_ac_desc.wTotalLength = cpu_to_le16(bufflen);
+		pr_descs = kzalloc(bufflen, GFP_KERNEL);
+		if (!pr_descs)
+			return -ENOMEM;
+
+		inf_in_term_id4.wTerminalType = cpu_to_le16(UAC_INPUT_TERMINAL_MICROPHONE);
+		inf_in_term_id4.bAssocTerminal = 0;
+		inf_in_term_id4.bmControls = 0;
+		memcpy(pr_descs + pos, &inf_in_term_id4, inf_in_term_id4.bLength);
+		pos += inf_in_term_id4.bLength;
+
+		memcpy(pr_descs + pos, &inf_out_term_id6, inf_out_term_id6.bLength);
+		pos += inf_out_term_id6.bLength;
+
+		memcpy(pr_descs + pos, &inf_feat_unit_id5, inf_feat_unit_id5.bLength);
+		pos += inf_feat_unit_id5.bLength;
+
+		memcpy(pr_descs + pos, &inf_clk_src, inf_clk_src.bLength);
+		pos += inf_clk_src.bLength;
+
+		memcpy(pr_descs + pos, &inf_pwdom_id11, inf_pwdom_id11.bLength);
+		pos += inf_pwdom_id11.bLength;
+
+		break;
+	case BADD_HEADSET:
+		inf_ac_desc.bCategory = UAC3_FUNCTION_HEADSET;
+		if (m_s == BADD_MONO) {
+			bufflen = BADD_HS_LEN_M;
+			inf_in_term_id1.wClusterDescrID = cpu_to_le16(BADD_MONO);
+			inf_feat_unit_id2.bLength = BADD_FU_LEN_M;
+		} else {
+			bufflen = BADD_HS_LEN_S;
+			inf_in_term_id1.wClusterDescrID = cpu_to_le16(BADD_STEREO);
+			inf_feat_unit_id2.bLength = BADD_FU_LEN_S;
+			inf_feat_unit_id2.bmaControls[2] = 0x0C;
+		}
+
+		inf_ac_desc.wTotalLength = cpu_to_le16(bufflen);
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
+		inf_in_term_id4.wTerminalType = cpu_to_le16(UAC_BIDIR_TERMINAL_HEADSET);
+		inf_in_term_id4.bAssocTerminal = 0x03;
+		inf_in_term_id4.bmControls = 0;
+		inf_in_term_id4.wClusterDescrID = cpu_to_le16(BADD_MONO);
+		memcpy(pr_descs + pos, &inf_in_term_id4, inf_in_term_id4.bLength);
+		pos += inf_in_term_id4.bLength;
+
+		inf_out_term_id3.wTerminalType = cpu_to_le16(UAC_BIDIR_TERMINAL_HEADSET);
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
+void *badd_get_as_iface(int stream_dir, int badd_cfg)
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
+		badd_as->wClusterDescrID = cpu_to_le16(BADD_MONO);
+		badd_as->bSubslotSize = 0x02;
+		badd_as->bBitResolution = 0x10;
+		break;
+	case BADD_M_24_SYNC:
+	case BADD_M_24_ASYNC:
+		badd_as->wClusterDescrID = cpu_to_le16(BADD_MONO);
+		badd_as->bSubslotSize = 0x03;
+		badd_as->bBitResolution = 0x18;
+		break;
+	case BADD_S_16_SYNC:
+	case BADD_S_16_ASYNC:
+		badd_as->wClusterDescrID = cpu_to_le16(BADD_STEREO);
+		badd_as->bSubslotSize = 0x02;
+		badd_as->bBitResolution = 0x10;
+		break;
+	case BADD_S_24_SYNC:
+	case BADD_S_24_ASYNC:
+		badd_as->wClusterDescrID = cpu_to_le16(BADD_STEREO);
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
+void *badd_get_ep_dec(void)
+{
+	return &inf_iso_ep_desc;
+}
+
+
diff --git a/sound/usb/badd.h b/sound/usb/badd.h
new file mode 100644
index 000000000000..d27e7cf49751
--- /dev/null
+++ b/sound/usb/badd.h
@@ -0,0 +1,14 @@
+/*
+ *   USB: Audio Class 3: support for BASIC AUDIO DEVICE v.3
+ *   SPDX-License-Identifier: GPL-2.0
+ */
+#ifndef __USBAUDIO_BADD_H
+#define __USBAUDIO_BADD_H
+
+int badd_gen_csint_desc(void **buffer, int profile, unsigned int m_s);
+void *badd_gen_cluster_desc(unsigned int m_s);
+void *badd_get_as_iface(int stream_dir, int badd_cfg);
+void *badd_get_ep_dec(void);
+
+#endif /* __USBAUDIO_BADD_H */
+
diff --git a/sound/usb/card.c b/sound/usb/card.c
index f5f385b0a32e..82f7d5bd8abb 100644
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
 
@@ -319,6 +322,10 @@ static int snd_usb_audio_free(struct snd_usb_audio *chip)
 	mutex_destroy(&chip->mutex);
 	if (!atomic_read(&chip->shutdown))
 		dev_set_drvdata(&chip->dev->dev, NULL);
+
+	if (chip->badd_profile > UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0)
+		kfree(chip->ctrl_intf->extra);
+
 	kfree(chip);
 	return 0;
 }
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 152e8484be1b..48ba25512b0d 100644
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
+	    chip->badd_profile > UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0)
+		csep = badd_get_ep_dec();
+	else
+		csep = snd_usb_find_desc(alts->endpoint[0].extra, alts->endpoint[0].extralen, NULL, USB_DT_CS_ENDPOINT);
 
 	/* Creamware Noah has this descriptor after the 2nd endpoint */
 	if (!csep && altsd->bNumEndpoints >= 2)
@@ -581,6 +586,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 	int i, altno, err, stream;
 	u64 format = 0;
 	unsigned int num_channels = 0;
+	unsigned int ep_packsize;
 	struct audioformat *fp = NULL;
 	int num, protocol, clock = 0;
 	struct uac_format_type_i_continuous_descriptor *fmt;
@@ -622,6 +628,8 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 			SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 		altno = altsd->bAlternateSetting;
 
+		ep_packsize =  le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+
 		if (snd_usb_apply_interface_quirk(chip, iface_no, altno))
 			continue;
 
@@ -728,11 +736,27 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 			struct uac3_as_header_descriptor *as;
 			struct uac3_cluster_header_descriptor *cluster;
 			struct uac3_hc_descriptor_header hc_header;
+			void *badd_extra;
 			u16 cluster_id, wLength;
 
-			as = snd_usb_find_csint_desc(alts->extra,
-							alts->extralen,
-							NULL, UAC_AS_GENERAL);
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
+				chip->ctrl_intf->extra = badd_extra;
+				chip->ctrl_intf->extralen = err;
+			} else
+				as = snd_usb_find_csint_desc(alts->extra,
+								alts->extralen,
+								NULL, UAC_AS_GENERAL);
 
 			if (!as) {
 				dev_err(&dev->dev,
@@ -756,53 +780,64 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
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
@@ -887,7 +922,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
 		fp->datainterval = snd_usb_parse_datainterval(chip, alts);
 		fp->protocol = protocol;
-		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+		fp->maxpacksize = ep_packsize;
 		fp->channels = num_channels;
 		if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
 			fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
@@ -939,9 +974,12 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
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
