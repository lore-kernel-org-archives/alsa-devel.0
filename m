From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/4] ALSA: usbaudio: introduce new types for
	audio class v2
Date: Mon, 22 Feb 2010 17:28:55 +0100
Message-ID: <1266856137-26252-3-git-send-email-daniel@caiaq.de>
References: <1266856137-26252-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D1BFC103880
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 17:29:52 +0100 (CET)
In-Reply-To: <1266856137-26252-1-git-send-email-daniel@caiaq.de>
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
 sound/usb/usbaudio.h |  114 +++++++++++++++++++++++++++++++++++++++++++++-----
 sound/usb/usbmixer.c |   14 +++---
 2 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index c466ccc..d08f347 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -30,14 +30,26 @@
 #define USB_SUBCLASS_MIDI_STREAMING	0x03
 #define USB_SUBCLASS_VENDOR_SPEC	0xff
 
+#define USB_AC_VERSION_1		0x00
+#define USB_AC_VERSION_2		0x20
+
 #define HEADER				0x01
 #define INPUT_TERMINAL			0x02
 #define OUTPUT_TERMINAL			0x03
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
@@ -60,7 +72,7 @@
 #define EP_CS_ATTR_PITCH_CONTROL	0x02
 #define EP_CS_ATTR_FILL_MAX		0x80
 
-/* Audio Class specific Request Codes */
+/* Audio Class specific Request Codes (v1) */
 
 #define SET_CUR    0x01
 #define GET_CUR    0x81
@@ -74,6 +86,10 @@
 #define GET_MEM    0x85
 #define GET_STAT   0xff
 
+/* Audio Class specific Request Codes (v2) */
+#define CS_CUR     0x01
+#define CS_RANGE   0x02
+
 /* Terminal Control Selectors */
 
 #define COPY_PROTECT_CONTROL       0x01
@@ -87,6 +103,9 @@
 #define USB_FORMAT_TYPE_I	0x01
 #define USB_FORMAT_TYPE_II	0x02
 #define USB_FORMAT_TYPE_III	0x03
+#define USB_EXT_FORMAT_TYPE_I	0x81
+#define USB_EXT_FORMAT_TYPE_II	0x82
+#define USB_EXT_FORMAT_TYPE_III	0x83
 
 /* type I */
 #define USB_AUDIO_FORMAT_PCM	0x01
@@ -131,6 +150,47 @@ struct usb_ac_intf_header_v1 {
 } __attribute__((packed));
 
 /*
+ * class specific AS interface descriptors
+ */
+
+struct usb_as_interface_v1 {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bTerminalLink;
+	__u8 bDelay;
+	__u16 wFormatTag;
+} __attribute__((packed));
+
+struct usb_as_interface_v2 {
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
+/*
+ * class specific clock source descriptor (v2)
+ */
+
+struct usb_clock_source_descriptor {
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
+/*
  * class specific format type descriptors
  */
 
@@ -146,6 +206,18 @@ struct usb_format_type_i {
 	__u8 samplerates[0];
 } __attribute__((packed));
 
+struct usb_format_type_i_ext {
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
 struct usb_format_type_ii {
 	__u8 bLength;
 	__u8 bDescriptorType;
@@ -157,17 +229,15 @@ struct usb_format_type_ii {
 	__u8 samplerates[0];
 } __attribute__((packed));
 
-/*
- * class specific AS interface descriptors
- */
-
-struct usb_as_interface_v1 {
+struct usb_format_type_ii_ext {
 	__u8 bLength;
 	__u8 bDescriptorType;
 	__u8 bDescriptorSubtype;
-	__u8 bTerminalLink;
-	__u8 bDelay;
-	__u16 wFormatTag;
+	__u8 bFormatType;
+	__u16 wMaxBitRate;
+	__u16 wSamplesPerFrame;
+	__u8 bHeaderLength;
+	__u8 bSideBandProtocol;
 } __attribute__((packed));
 
 /*
@@ -184,6 +254,15 @@ struct usb_feature_unit_descriptor {
 	__u8 controls[0]; /* variable length */
 } __attribute__((packed));
 
+struct usb_feature_unit_descriptor_v2 {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bUnitID;
+	__u8 bSourceID;
+	__u32 bmaControls[0];
+} __attribute__((packed));
+
 /*
  * class specific terminal types
  */
@@ -199,6 +278,19 @@ struct usb_output_terminal_v1 {
 	__u8 iTerminal;
 } __attribute__((packed));
 
+struct usb_output_terminal_v2 {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bTerminalID;
+	__u16 wTerminalType;
+	__u8 bAssocTerminal;
+	__u8 bSourceID;
+	__u8 bCSourceID;
+	__u16 bmControls;
+	__u8 iTerminal;
+} __attribute__((packed));
+
 /*
  */
 
diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 93d3339..2bfc446 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -280,7 +280,7 @@ static void *find_audio_control_unit(struct mixer_build *state, unsigned char un
 
 	while ((p = snd_usb_find_desc(state->buffer, state->buflen, p,
 				      USB_DT_CS_INTERFACE)) != NULL) {
-		if (p[0] >= 4 && p[2] >= INPUT_TERMINAL && p[2] <= EXTENSION_UNIT && p[3] == unit)
+		if (p[0] >= 4 && p[2] >= INPUT_TERMINAL && p[2] <= EXTENSION_UNIT_V1 && p[3] == unit)
 			return p;
 	}
 	return NULL;
@@ -601,9 +601,9 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
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
@@ -667,8 +667,8 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
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
@@ -1741,9 +1741,9 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
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
