From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/6] linux/usb/audio.h: split header
Date: Thu, 11 Mar 2010 21:13:20 +0100
Message-ID: <1268338405-8944-2-git-send-email-daniel@caiaq.de>
References: <1268338405-8944-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7812D103800
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 21:14:10 +0100 (CET)
In-Reply-To: <1268338405-8944-1-git-send-email-daniel@caiaq.de>
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

- Split the audio.h file in two to clearly denote the differences
  between the standards.
- Add many more defines to audio-v2.h. Most of them are not currently
  used.
- Replaced a magic value with a proper define

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 include/linux/usb/audio-v2.h |  319 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/audio.h    |   50 +------
 sound/usb/card.c             |    3 +-
 sound/usb/endpoint.c         |    1 +
 sound/usb/format.c           |    1 +
 sound/usb/pcm.c              |    5 +-
 6 files changed, 333 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/usb/audio-v2.h

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
new file mode 100644
index 0000000..3b8560d
--- /dev/null
+++ b/include/linux/usb/audio-v2.h
@@ -0,0 +1,319 @@
+/*
+ * Copyright (c) 2010 Daniel Mack <daniel@caiaq.de>
+ *
+ * This software is distributed under the terms of the GNU General Public
+ * License ("GPL") version 2, as published by the Free Software Foundation.
+ *
+ * This file holds USB constants and structures defined
+ * by the USB Device Class Definition for Audio Devices in version 2.0.
+ * Comments below reference relevant sections of the documents contained
+ * in http://www.usb.org/developers/devclass_docs/Audio2.0_final.zip
+ */
+
+#ifndef __LINUX_USB_AUDIO_V2_H
+#define __LINUX_USB_AUDIO_V2_H
+
+#include <linux/types.h>
+
+/* v1.0 and v2.0 of this standard have many things in common. For the rest
+ * of the definitions, please refer to audio.h */
+
+/* 4.7.2.1 Clock Source Descriptor */
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
+/* 4.7.2.2 Clock Source Descriptor */
+
+struct uac_clock_selector_descriptor {
+	__u8 bLength;
+	__u8 bDescriptorType;
+	__u8 bDescriptorSubtype;
+	__u8 bClockID;
+	__u8 bNrInPins;
+	__u8 bmControls;
+	__u8 baCSourceID[];
+} __attribute__((packed));
+
+/* 4.9.2 Class-Specific AS Interface Descriptor */
+
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
+
+/* A.7 Audio Function Category Codes */
+#define UAC2_FUNCTION_SUBCLASS_UNDEFINED	0x00
+#define UAC2_FUNCTION_DESKTOP_SPEAKER		0x01
+#define UAC2_FUNCTION_HOME_THEATER		0x02
+#define UAC2_FUNCTION_MICROPHONE		0x03
+#define UAC2_FUNCTION_HEADSET			0x04
+#define UAC2_FUNCTION_TELEPHONE			0x05
+#define UAC2_FUNCTION_CONVERTER			0x06
+#define UAC2_FUNCTION_SOUND_RECORDER		0x07
+#define UAC2_FUNCTION_IO_BOX			0x08
+#define UAC2_FUNCTION_MUSICAL_INSTRUMENT	0x09
+#define UAC2_FUNCTION_PRO_AUDIO			0x0a
+#define UAC2_FUNCTION_AUDIO_VIDEO		0x0b
+#define UAC2_FUNCTION_CONTROL_PANEL		0x0c
+#define UAC2_FUNCTION_OTHER			0xff
+
+/* A.9 Audio Class-Specific AC Interface Descriptor Subtypes */
+/* see audio.h for the rest, which is identical to v1 */
+#define UAC2_EFFECT_UNIT			0x07
+#define UAC2_PROCESSING_UNIT_V2		0x08
+#define UAC2_EXTENSION_UNIT_V2		0x09
+#define UAC2_CLOCK_SOURCE		0x0a
+#define UAC2_CLOCK_SELECTOR		0x0b
+#define UAC2_CLOCK_MULTIPLIER		0x0c
+#define UAC2_SAMPLE_RATE_CONVERTER	0x0d
+
+/* A.10 Audio Class-Specific AS Interface Descriptor Subtypes */
+/* see audio.h for the rest, which is identical to v1 */
+#define UAC2_ENCODER			0x03
+#define UAC2_DECODER			0x04
+
+/* A.11 Effect Unit Effect Types */
+#define UAC2_EFFECT_UNDEFINED		0x00
+#define UAC2_EFFECT_PARAM_EQ		0x01
+#define UAC2_EFFECT_REVERB		0x02
+#define UAC2_EFFECT_MOD_DELAY		0x03
+#define UAC2_EFFECT_DYN_RANGE_COMP	0x04
+
+/* A.12 Processing Unit Process Types */
+#define UAC2_PROCESS_UNDEFINED		0x00
+#define UAC2_PROCESS_UP_DOWNMIX		0x01
+#define UAC2_PROCESS_DOLBY_PROLOCIC	0x02
+#define UAC2_PROCESS_STEREO_EXTENDER	0x03
+
+/* A.14 Audio Class-Specific Request Codes */
+#define UAC2_CS_CUR			0x01
+#define UAC2_CS_RANGE			0x02
+
+/* A.15 Encoder Type Codes */
+#define UAC2_ENCODER_UNDEFINED		0x00
+#define UAC2_ENCODER_OTHER		0x01
+#define UAC2_ENCODER_MPEG		0x02
+#define UAC2_ENCODER_AC3		0x03
+#define UAC2_ENCODER_WMA		0x04
+#define UAC2_ENCODER_DTS		0x05
+
+/* A.16 Decoder Type Codes */
+#define UAC2_DECODER_UNDEFINED		0x00
+#define UAC2_DECODER_OTHER		0x01
+#define UAC2_DECODER_MPEG		0x02
+#define UAC2_DECODER_AC3		0x03
+#define UAC2_DECODER_WMA		0x04
+#define UAC2_DECODER_DTS		0x05
+
+/* A.17.1 Clock Source Control Selectors */
+#define UAC2_CS_UNDEFINED		0x00
+#define UAC2_CS_CONTROL_SAM_FREQ	0x01
+#define UAC2_CS_CONTROL_CLOCK_VALID	0x02
+
+/* A.17.2 Clock Selector Control Selectors */
+#define UAC2_CX_UNDEFINED		0x00
+#define UAC2_CX_CLOCK_SELECTOR		0x01
+
+/* A.17.3 Clock Multiplier Control Selectors */
+#define UAC2_CM_UNDEFINED		0x00
+#define UAC2_CM_NUMERATOR		0x01
+#define UAC2_CM_DENOMINTATOR		0x02
+
+/* A.17.4 Terminal Control Selectors */
+#define UAC2_TE_UNDEFINED		0x00
+#define UAC2_TE_COPY_PROTECT		0x01
+#define UAC2_TE_CONNECTOR		0x02
+#define UAC2_TE_OVERLOAD		0x03
+#define UAC2_TE_CLUSTER			0x04
+#define UAC2_TE_UNDERFLOW		0x05
+#define UAC2_TE_OVERFLOW		0x06
+#define UAC2_TE_LATENCY			0x07
+
+/* A.17.5 Mixer Control Selectors */
+#define UAC2_MU_UNDEFINED		0x00
+#define UAC2_MU_MIXER			0x01
+#define UAC2_MU_CLUSTER			0x02
+#define UAC2_MU_UNDERFLOW		0x03
+#define UAC2_MU_OVERFLOW		0x04
+#define UAC2_MU_LATENCY			0x05
+
+/* A.17.6 Selector Control Selectors */
+#define UAC2_SU_UNDEFINED		0x00
+#define UAC2_SU_SELECTOR		0x01
+#define UAC2_SU_LATENCY			0x02
+
+/* A.17.7 Feature Unit Control Selectors */
+/* see audio.h for the rest, which is identical to v1 */
+#define UAC2_FU_INPUT_GAIN		0x0b
+#define UAC2_FU_INPUT_GAIN_PAD		0x0c
+#define UAC2_FU_PHASE_INVERTER		0x0d
+#define UAC2_FU_UNDERFLOW		0x0e
+#define UAC2_FU_OVERFLOW		0x0f
+#define UAC2_FU_LATENCY			0x10
+
+/* A.17.8.1 Parametric Equalizer Section Effect Unit Control Selectors */
+#define UAC2_PE_UNDEFINED		0x00
+#define UAC2_PE_ENABLE			0x01
+#define UAC2_PE_CENTERFREQ		0x02
+#define UAC2_PE_QFACTOR			0x03
+#define UAC2_PE_GAIN			0x04
+#define UAC2_PE_UNDERFLOW		0x05
+#define UAC2_PE_OVERFLOW		0x06
+#define UAC2_PE_LATENCY			0x07
+
+/* A.17.8.2 Reverberation Effect Unit Control Selectors */
+#define UAC2_RV_UNDEFINED		0x00
+#define UAC2_RV_ENABLE			0x01
+#define UAC2_RV_TYPE			0x02
+#define UAC2_RV_LEVEL			0x03
+#define UAC2_RV_TIME			0x04
+#define UAC2_RV_FEEDBACK		0x05
+#define UAC2_RV_PREDELAY		0x06
+#define UAC2_RV_DENSITY			0x07
+#define UAC2_RV_HIFREQ_ROLLOFF		0x08
+#define UAC2_RV_UNDERFLOW		0x09
+#define UAC2_RV_OVERFLOW		0x0a
+#define UAC2_RV_LATENCY			0x0b
+
+/* A.17.8.3 Modulation Delay Effect Control Selectors */
+#define UAC2_MD_UNDEFINED		0x00
+#define UAC2_MD_ENABLE			0x01
+#define UAC2_MD_BALANCE			0x02
+#define UAC2_MD_RATE			0x03
+#define UAC2_MD_DEPTH			0x04
+#define UAC2_MD_TIME			0x05
+#define UAC2_MD_FEEDBACK		0x06
+#define UAC2_MD_UNDERFLOW		0x07
+#define UAC2_MD_OVERFLOW		0x08
+#define UAC2_MD_LATENCY			0x09
+
+/* A.17.8.4 Dynamic Range Compressor Effect Unit Control Selectors */
+#define UAC2_DR_UNDEFINED		0x00
+#define UAC2_DR_ENABLE			0x01
+#define UAC2_DR_COMPRESSION_RATE	0x02
+#define UAC2_DR_MAXAMPL			0x03
+#define UAC2_DR_THRESHOLD		0x04
+#define UAC2_DR_ATTACK_TIME		0x05
+#define UAC2_DR_RELEASE_TIME		0x06
+#define UAC2_DR_UNDEFLOW		0x07
+#define UAC2_DR_OVERFLOW		0x08
+#define UAC2_DR_LATENCY			0x09
+
+/* A.17.9.1 Up/Down-mix Processing Unit Control Selectors */
+#define UAC2_UD_UNDEFINED		0x00
+#define UAC2_UD_ENABLE			0x01
+#define UAC2_UD_MODE_SELECT		0x02
+#define UAC2_UD_CLUSTER			0x03
+#define UAC2_UD_UNDERFLOW		0x04
+#define UAC2_UD_OVERFLOW		0x05
+#define UAC2_UD_LATENCY			0x06
+
+/* A.17.9.2 Dolby Prologic[tm] Processing Unit Control Selectors */
+#define UAC2_DP_UNDEFINED		0x00
+#define UAC2_DP_ENABLE			0x01
+#define UAC2_DP_MODE_SELECT		0x02
+#define UAC2_DP_CLUSTER			0x03
+#define UAC2_DP_UNDERFFLOW		0x04
+#define UAC2_DP_OVERFLOW		0x05
+#define UAC2_DP_LATENCY			0x06
+
+/* A.17.9.3 Stereo Expander Processing Unit Control Selectors */
+#define UAC2_ST_EXT_UNDEFINED		0x00
+#define UAC2_ST_EXT_ENABLE		0x01
+#define UAC2_ST_EXT_WIDTH		0x02
+#define UAC2_ST_EXT_UNDEFLOW		0x03
+#define UAC2_ST_EXT_OVERFLOW		0x04
+#define UAC2_ST_EXT_LATENCY		0x05
+
+/* A.17.10 Extension Unit Control Selectors */
+#define UAC2_XU_UNDEFINED		0x00
+#define UAC2_XU_ENABLE			0x01
+#define UAC2_XU_CLUSTER			0x02
+#define UAC2_XU_UNDERFLOW		0x03
+#define UAC2_XU_OVERFLOW		0x04
+#define UAC2_XU_LATENCY			0x05
+
+/* A.17.11 AudioStreaming Interface Control Selectors */
+#define UAC2_AS_UNDEFINED		0x00
+#define UAC2_AS_ACT_ALT_SETTING		0x01
+#define UAC2_AS_VAL_ALT_SETTINGS	0x02
+#define UAC2_AS_AUDIO_DATA_FORMAT	0x03
+
+/* A.17.12 Encoder Control Selectors */
+#define UAC2_EN_UNDEFINED		0x00
+#define UAC2_EN_BIT_RATE		0x01
+#define UAC2_EN_QUALITY			0x02
+#define UAC2_EN_VBR			0x03
+#define UAC2_EN_TYPE			0x04
+#define UAC2_EN_UNDERFLOW		0x05
+#define UAC2_EN_OVERFLOW		0x06
+#define UAC2_EN_ENCODER_ERROR		0x07
+#define UAC2_EN_PARAM1			0x08
+#define UAC2_EN_PARAM2			0x09
+#define UAC2_EN_PARAM3			0x0a
+#define UAC2_EN_PARAM4			0x0b
+#define UAC2_EN_PARAM5			0x0c
+#define UAC2_EN_PARAM6			0x0d
+#define UAC2_EN_PARAM7			0x0e
+#define UAC2_EN_PARAM8			0x0f
+
+/* A.17.13.1 MPEG Decoder Control Selectors */
+#define UAC2_MPEG_UNDEFINED		0x00
+#define UAC2_MPEG_DUAL_CHANNEL		0x01
+#define UAC2_MPEG_SECOND_STEREO		0x02
+#define UAC2_MPEG_MULTILINGUAL		0x03
+#define UAC2_MPEG_DYN_RANGE		0x04
+#define UAC2_MPEG_SCALING		0x05
+#define UAC2_MPEG_HILO_SCALING		0x06
+#define UAC2_MPEG_UNDERFLOW		0x07
+#define UAC2_MPEG_OVERFLOW		0x08
+#define UAC2_MPEG_DECODER_ERROR		0x09
+
+/* A17.13.2 AC3 Decoder Control Selectors */
+#define UAC2_AC3_UNDEFINED		0x00
+#define UAC2_AC3_MODE			0x01
+#define UAC2_AC3_DYN_RANGE		0x02
+#define UAC2_AC3_SCALING		0x03
+#define UAC2_AC3_HILO_SCALING		0x04
+#define UAC2_AC3_UNDERFLOW		0x05
+#define UAC2_AC3_OVERFLOW		0x06
+#define UAC2_AC3_DECODER_ERROR		0x07
+
+/* A17.13.3 WMA Decoder Control Selectors */
+#define UAC2_WMA_UNDEFINED		0x00
+#define UAC2_WMA_UNDERFLOW		0x01
+#define UAC2_WMA_OVERFLOW		0x02
+#define UAC2_WMA_DECODER_ERROR		0x03
+
+/* A17.13.4 DTS Decoder Control Selectors */
+#define UAC2_DTS_UNDEFINED		0x00
+#define UAC2_DTS_UNDERFLOW		0x01
+#define UAC2_DTS_OVERFLOW		0x02
+#define UAC2_DTS_DECODER_ERROR		0x03
+
+/* A17.14 Endpoint Control Selectors */
+#define UAC2_EP_CS_UNDEFINED		0x00
+#define UAC2_EP_CS_PITCH		0x01
+#define UAC2_EP_CS_DATA_OVERRUN		0x02
+#define UAC2_EP_CS_DATA_UNDERRUN	0x03
+
+#endif /* __LINUX_USB_AUDIO_V2_H */
+
diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 4d3e450..cdad728 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -13,6 +13,9 @@
  * Comments below reference relevant sections of that document:
  *
  * http://www.usb.org/developers/devclass_docs/audio10.pdf
+ *
+ * Types and defines in this file are either specific to version 1.0 of
+ * this standard or common for newer versions.
  */
 
 #ifndef __LINUX_USB_AUDIO_H
@@ -20,14 +23,15 @@
 
 #include <linux/types.h>
 
+/* bInterfaceProtocol values to denote the version of the standard used */
+#define UAC_VERSION_1			0x00
+#define UAC_VERSION_2			0x20
+
 /* A.2 Audio Interface Subclass Codes */
 #define USB_SUBCLASS_AUDIOCONTROL	0x01
 #define USB_SUBCLASS_AUDIOSTREAMING	0x02
 #define USB_SUBCLASS_MIDISTREAMING	0x03
 
-#define UAC_VERSION_1			0x00
-#define UAC_VERSION_2			0x20
-
 /* A.5 Audio Class-Specific AC Interface Descriptor Subtypes */
 #define UAC_HEADER			0x01
 #define UAC_INPUT_TERMINAL		0x02
@@ -38,15 +42,6 @@
 #define UAC_PROCESSING_UNIT_V1		0x07
 #define UAC_EXTENSION_UNIT_V1		0x08
 
-/* UAC v2.0 types */
-#define UAC_EFFECT_UNIT			0x07
-#define UAC_PROCESSING_UNIT_V2		0x08
-#define UAC_EXTENSION_UNIT_V2		0x09
-#define UAC_CLOCK_SOURCE		0x0a
-#define UAC_CLOCK_SELECTOR		0x0b
-#define UAC_CLOCK_MULTIPLIER		0x0c
-#define UAC_SAMPLE_RATE_CONVERTER	0x0d
-
 /* A.6 Audio Class-Specific AS Interface Descriptor Subtypes */
 #define UAC_AS_GENERAL			0x01
 #define UAC_FORMAT_TYPE			0x02
@@ -78,10 +73,6 @@
 
 #define UAC_GET_STAT			0xff
 
-/* Audio class v2.0 handles all the parameter calls differently */
-#define UAC2_CS_CUR			0x01
-#define UAC2_CS_RANGE			0x02
-
 /* MIDI - A.1 MS Class-Specific Interface Descriptor Subtypes */
 #define UAC_MS_HEADER			0x01
 #define UAC_MIDI_IN_JACK		0x02
@@ -200,19 +191,6 @@ struct uac_as_header_descriptor_v1 {
 	__le16 wFormatTag;		/* The Audio Data Format */
 } __attribute__ ((packed));
 
-struct uac_as_header_descriptor_v2 {
-	__u8 bLength;
-	__u8 bDescriptorType;
-	__u8 bDescriptorSubtype;
-	__u8 bTerminalLink;
-	__u8 bmControls;
-	__u8 bFormatType;
-	__u32 bmFormats;
-	__u8 bNrChannels;
-	__u32 bmChannelConfig;
-	__u8 iChannelNames;
-} __attribute__((packed));
-
 #define UAC_DT_AS_HEADER_SIZE		7
 
 /* Formats - A.1.1 Audio Data Format Type I Codes */
@@ -277,7 +255,6 @@ struct uac_format_type_i_ext_descriptor {
 	__u8 bSideBandProtocol;
 } __attribute__((packed));
 
-
 /* Formats - Audio Data Format Type I Codes */
 
 #define UAC_FORMAT_TYPE_II_MPEG	0x1001
@@ -336,19 +313,6 @@ struct uac_iso_endpoint_descriptor {
 #define UAC_EP_CS_ATTR_PITCH_CONTROL	0x02
 #define UAC_EP_CS_ATTR_FILL_MAX		0x80
 
-/* Audio class v2.0: CLOCK_SOURCE descriptor */
-
-struct uac_clock_source_descriptor {
-	__u8 bLength;
-	__u8 bDescriptorType;
-	__u8 bDescriptorSubtype;
-	__u8 bClockID;
-	__u8 bmAttributes;
-	__u8 bmControls;
-	__u8 bAssocTerminal;
-	__u8 iClockSource;
-} __attribute__((packed));
-
 /* A.10.2 Feature Unit Control Selectors */
 
 struct uac_feature_unit_descriptor {
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 426aabc..78d12ff 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -45,6 +45,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/usb/audio.h>
+#include <linux/usb/audio-v2.h>
 
 #include <sound/core.h>
 #include <sound/info.h>
@@ -250,7 +251,7 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 		 * clock selectors and sample rate conversion units. */
 
 		cs = snd_usb_find_csint_desc(host_iface->extra, host_iface->extralen,
-						NULL, UAC_CLOCK_SOURCE);
+						NULL, UAC2_CLOCK_SOURCE);
 
 		if (!cs) {
 			snd_printk(KERN_ERR "CLOCK_SOURCE descriptor not found\n");
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 91850f8..b1309cd 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
+#include <linux/usb/audio-v2.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/usb/format.c b/sound/usb/format.c
index b613e0a..0e04efe 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
+#include <linux/usb/audio-v2.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e0f3f87..630e220 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
+#include <linux/usb/audio-v2.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -215,7 +216,7 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	data[3] = rate >> 24;
 	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
 				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
-				   0x0100, chip->clock_id << 8,
+				   UAC2_CS_CONTROL_SAM_FREQ << 8, chip->clock_id << 8,
 				   data, sizeof(data), 1000)) < 0) {
 		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2)\n",
 			   dev->devnum, iface, fmt->altsetting, rate);
@@ -223,7 +224,7 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	}
 	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-				   0x0100, chip->clock_id << 8,
+				   UAC2_CS_CONTROL_SAM_FREQ << 8, chip->clock_id << 8,
 				   data, sizeof(data), 1000)) < 0) {
 		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
 			   dev->devnum, iface, fmt->altsetting);
-- 
1.6.6.2
