From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/5] ALSA: usbaudio: introduce new types for
	audio class v2
Date: Mon, 22 Feb 2010 23:49:10 +0100
Message-ID: <1266878953-9184-3-git-send-email-daniel@caiaq.de>
References: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D44124480
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 23:49:48 +0100 (CET)
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

This patch adds some definitions for audio class v2.

Unfortunately, the UNIT types PROCESSING_UNIT and EXTENSION_UNIT have
different numerical representations in both standards, so there is need
for a _V1 add-on now. usbmixer.c is changed accordingly.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 include/linux/usb/audio.h |   57 +++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/usbaudio.h      |   19 ++++++++++++--
 sound/usb/usbmixer.c      |   14 +++++-----
 3 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 44f82d8..fb1a97b 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -25,6 +25,9 @@
 #define USB_SUBCLASS_AUDIOSTREAMING	0x02
 #define USB_SUBCLASS_MIDISTREAMING	0x03
 
+#define UAC_VERSION_1			0x00
+#define UAC_VERSION_2			0x20
+
 /* A.5 Audio Class-Specific AC Interface Descriptor Subtypes */
 #define UAC_HEADER			0x01
 #define UAC_INPUT_TERMINAL		0x02
@@ -180,6 +183,19 @@ struct uac_as_header_descriptor_v1 {
 	__le16 wFormatTag;		/* The Audio Data Format */
 } __attribute__ ((packed));
 
+struct uac_as_header_descriptor_v2 {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bTerminalLink;
+	__u8 bmControls;
+	__u8 bFormatType;
+	__u32 bmFormats;
+	__u8 bNrChannels;
+	__u32 bmChannelConfig;
+	__u8 iChannelNames;
+} __attribute__((packed));
+
 #define UAC_DT_AS_HEADER_SIZE		7
 
 /* Formats - A.1.1 Audio Data Format Type I Codes */
@@ -232,6 +248,19 @@ struct uac_format_type_i_discrete_descriptor_##n {		\
 
 #define UAC_FORMAT_TYPE_I_DISCRETE_DESC_SIZE(n)	(8 + (n * 3))
 
+struct uac_format_type_i_ext_descriptor {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bSubslotSize;
+	__u8 bFormatType;
+	__u8 bBitResolution;
+	__u8 bHeaderLength;
+	__u8 bControlSize;
+	__u8 bSideBandProtocol;
+} __attribute__((packed));
+
+
 /* Formats - Audio Data Format Type I Codes */
 
 struct uac_format_type_ii_discrete_descriptor {
@@ -245,11 +274,26 @@ struct uac_format_type_ii_discrete_descriptor {
 	__u8 tSamFreq[][3];
 } __attribute__((packed));
 
+struct uac_format_type_ii_ext_descriptor {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bFormatType;
+	__u16 wMaxBitRate;
+	__u16 wSamplesPerFrame;
+	__u8 bHeaderLength;
+	__u8 bSideBandProtocol;
+} __attribute__((packed));
+
+
 /* Formats - A.2 Format Type Codes */
 #define UAC_FORMAT_TYPE_UNDEFINED	0x0
 #define UAC_FORMAT_TYPE_I		0x1
 #define UAC_FORMAT_TYPE_II		0x2
 #define UAC_FORMAT_TYPE_III		0x3
+#define UAC_EXT_FORMAT_TYPE_I		0x81
+#define UAC_EXT_FORMAT_TYPE_II		0x82
+#define UAC_EXT_FORMAT_TYPE_III		0x83
 
 struct uac_iso_endpoint_descriptor {
 	__u8  bLength;			/* in bytes: 7 */
@@ -265,6 +309,19 @@ struct uac_iso_endpoint_descriptor {
 #define UAC_EP_CS_ATTR_PITCH_CONTROL	0x02
 #define UAC_EP_CS_ATTR_FILL_MAX		0x80
 
+/* Audio class v2.0: CLOCK_SOURCE descriptor */
+
+struct uac_clock_source_descriptor {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bClockID;
+	__u8 bmAttributes;
+	__u8 bmControls;
+	__u8 bAssocTerminal;
+	__u8 iClockSource;
+} __attribute__((packed));
+
 /* A.10.2 Feature Unit Control Selectors */
 
 struct uac_feature_unit_descriptor {
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 9d8cea4..4f48293 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -36,8 +36,17 @@
 #define MIXER_UNIT			0x04
 #define SELECTOR_UNIT			0x05
 #define FEATURE_UNIT			0x06
-#define PROCESSING_UNIT			0x07
-#define EXTENSION_UNIT			0x08
+#define PROCESSING_UNIT_V1		0x07
+#define EXTENSION_UNIT_V1		0x08
+
+/* audio class v2 */
+#define EFFECT_UNIT			0x07
+#define PROCESSING_UNIT_V2		0x08
+#define EXTENSION_UNIT_V2		0x09
+#define CLOCK_SOURCE			0x0a
+#define CLOCK_SELECTOR			0x0b
+#define CLOCK_MULTIPLIER		0x0c
+#define SAMPLE_RATE_CONVERTER		0x0d
 
 #define AS_GENERAL			0x01
 #define FORMAT_TYPE			0x02
@@ -60,7 +69,7 @@
 #define EP_CS_ATTR_PITCH_CONTROL	0x02
 #define EP_CS_ATTR_FILL_MAX		0x80
 
-/* Audio Class specific Request Codes */
+/* Audio Class specific Request Codes (v1) */
 
 #define SET_CUR    0x01
 #define GET_CUR    0x81
@@ -74,6 +83,10 @@
 #define GET_MEM    0x85
 #define GET_STAT   0xff
 
+/* Audio Class specific Request Codes (v2) */
+#define CS_CUR     0x01
+#define CS_RANGE   0x02
+
 /* Terminal Control Selectors */
 
 #define COPY_PROTECT_CONTROL       0x01
diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 3631595..5c21400 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -282,7 +282,7 @@ static void *find_audio_control_unit(struct mixer_build *state, unsigned char un
 
 	while ((p = snd_usb_find_desc(state->buffer, state->buflen, p,
 				      USB_DT_CS_INTERFACE)) != NULL) {
-		if (p[0] >= 4 && p[2] >= INPUT_TERMINAL && p[2] <= EXTENSION_UNIT && p[3] == unit)
+		if (p[0] >= 4 && p[2] >= INPUT_TERMINAL && p[2] <= EXTENSION_UNIT_V1 && p[3] == unit)
 			return p;
 	}
 	return NULL;
@@ -603,9 +603,9 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
 		switch (iterm->type >> 16) {
 		case SELECTOR_UNIT:
 			strcpy(name, "Selector"); return 8;
-		case PROCESSING_UNIT:
+		case PROCESSING_UNIT_V1:
 			strcpy(name, "Process Unit"); return 12;
-		case EXTENSION_UNIT:
+		case EXTENSION_UNIT_V1:
 			strcpy(name, "Ext Unit"); return 8;
 		case MIXER_UNIT:
 			strcpy(name, "Mixer"); return 5;
@@ -669,8 +669,8 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 			term->id = id;
 			term->name = p1[9 + p1[0] - 1];
 			return 0;
-		case PROCESSING_UNIT:
-		case EXTENSION_UNIT:
+		case PROCESSING_UNIT_V1:
+		case EXTENSION_UNIT_V1:
 			if (p1[6] == 1) {
 				id = p1[7];
 				break; /* continue to parse */
@@ -1743,9 +1743,9 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 		return parse_audio_selector_unit(state, unitid, p1);
 	case FEATURE_UNIT:
 		return parse_audio_feature_unit(state, unitid, p1);
-	case PROCESSING_UNIT:
+	case PROCESSING_UNIT_V1:
 		return parse_audio_processing_unit(state, unitid, p1);
-	case EXTENSION_UNIT:
+	case EXTENSION_UNIT_V1:
 		return parse_audio_extension_unit(state, unitid, p1);
 	default:
 		snd_printk(KERN_ERR "usbaudio: unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
-- 
1.6.6.2
