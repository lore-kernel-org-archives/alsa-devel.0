From: "Piotr G." <pejotr@wp.pl>
Subject: [PATCH 1/1] sound/usb: Add Asus Xonar U7 Mixer - input
	support
Date: Sun, 26 Jul 2015 10:00:12 +0200
Message-ID: <55B4938C.6080808@wp.pl>
References: <55B4929D.5030401@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070707040804000704060204"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
 by alsa0.perex.cz (Postfix) with ESMTP id AD9612606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2015 10:00:16 +0200 (CEST)
Received: from 095160246149.zabrze.vectranet.pl (HELO [192.168.1.253])
 (pejotr@[95.160.246.149]) (envelope-sender <pejotr@wp.pl>)
 by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-SHA encrypted SMTP
 for <alsa-devel@alsa-project.org>; 26 Jul 2015 10:00:14 +0200
In-Reply-To: <55B4929D.5030401@wp.pl>
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070707040804000704060204
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
This is my first patch to alsa-devel, and I'm not very skilled
programmer. From lsusb -vvv, I've draw Xonar U7 map with all IT OT FU CS
in mixer_map.c I don't know why the driver by default doesn't parse all
info correctly. With this patch you can see Line Switch and Mic Switch
in alsamixer. I can record my voice in Audacity with all supported bit
and sampling rates in Mono or Stereo
This is temporary solution. Please correct me if the patch is not
properly made.

   What doesn't work:
   - Cannot change Capture Volume for Line/Mic. No mixer control in
alsamixer
   - Switching between Line/Mic doesn't work (Mute doesn't work)
   - SPDIF not tested
   As what I wrote at beginning I'm not skilled programmer so any help is
   aprreciated


proc-usbmixer -> cat /proc/asound/*/usbmix
usb.debug -> lsusb -vv (only Asus Xonar U7)

---
   sound/usb/mixer.c      | 23 +++++++++++++++++++++--
   sound/usb/mixer_maps.c | 48
++++++++++++++++++++++++++++++++++++++++++++++++
   2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 6b3acba..027d160 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -818,6 +818,25 @@ static struct usb_feature_control_info
audio_feature_info[] = {
   	{ "Phase Inverter Control",	USB_MIXER_BOOLEAN },
   };

+static struct usb_feature_control_info uac2_audio_feature_info[] = {
+	/* UAC2 specific */
+	{ "Mute Control",		USB_MIXER_INV_BOOLEAN },
+	{ "Volume Control",		USB_MIXER_S16 },
+	{ "Bass Control",		USB_MIXER_S8 },
+	{ "Mid Control",		USB_MIXER_S8 },
+	{ "Treble Control",		USB_MIXER_S8 },
+	{ "Graphic Equalizer Control",	USB_MIXER_S8 },
+	{ "Automatic Gain Control",	USB_MIXER_BOOLEAN },
+	{ "Delay Control",		USB_MIXER_S16 }, /* FIXME: U32 in UAC2 */
+	{ "Bass Boost Control",		USB_MIXER_BOOLEAN },
+	{ "Loudness Control",		USB_MIXER_BOOLEAN },
+	{ "Input Gain Control",		USB_MIXER_S16 },
+	{ "Input Gain Pad Control",	USB_MIXER_S16 },
+	{ "Phase Inverter Control",	USB_MIXER_BOOLEAN },
+	{ "Underflow Control",		USB_MIXER_BOOLEAN },
+	{ "Overflow Control",		USB_MIXER_BOOLEAN },
+};
+
   /* private_free callback */
   void snd_usb_mixer_elem_free(struct snd_kcontrol *kctl)
   {
@@ -1240,7 +1259,7 @@ static void build_feature_ctl(struct mixer_build
*state, void *raw_desc,
   	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
   	cval->control = control;
   	cval->cmask = ctl_mask;
-	cval->val_type = audio_feature_info[control-1].type;
+	cval->val_type = uac2_audio_feature_info[control-1].type;
   	if (ctl_mask == 0) {
   		cval->channels = 1;	/* master channel */
   		cval->master_readonly = readonly_mask;
@@ -1318,7 +1337,7 @@ static void build_feature_ctl(struct mixer_build
*state, void *raw_desc,
   		break;
   	default:
   		if (!len)
-			strlcpy(kctl->id.name, audio_feature_info[control-1].name,
+			strlcpy(kctl->id.name, uac2_audio_feature_info[control-1].name,
   				sizeof(kctl->id.name));
   		break;
   	}
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index e5000da..07f510e 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -341,6 +341,48 @@ static const struct usbmix_name_map
scms_usb3318_map[] = {
   	{ 0 }
   };

+/* ASUS Xonar U7 - USB CM6632A (ADC CS5361 // DAC Dolby CS4362A // DAC
Stereo CS4398 */
+/* Topology:
+
+USB_IN[1]------->FU[13]-----------CS[18]--->Spk_OUT[7]
+
+Dig_IN[2]------->FU[14]-----------CS[19]--->Dig_OUT[8]
+
+Mic_IN[4]------->FU[16]---+
+                          SU[20]--CS[22]--->USB_OUT[11]
+Line_IN[5]------>FU[17]---+
+
+*/
+
+static const struct usbmix_name_map xonar_u7_map[] = {
+	/* 1: IT PCM  Analog (USB Streaming) */
+	/* 2: IT PCM2 Digital (USB Streaming) */
+	/* 4: IT Microphone */
+	/* 5: IT Line IN */
+	/* 7: OT Speaker */
+	/* 8: OT SPDIF */
+	/* 11 OT Capture Playback (USB Streaming) */
+	{ 13, "Speaker Playback" },	/* 13 FU Speaker Out Mute/Volume */
+	{ 14, "IEC958 Playback" },	/* 14 FU SPDIF Out Mute/Volume */
+	{ 16, "Mic Capture" }, 		/* 16 FU Capture Mic-in Mute/Volume */
+	{ 17, "Line Capture" }, 	/* 17 FU Capture Line-in Mute/Volume */
+	/* 18 CS for 1 PCM (USB Streaming) Clock Source */
+	/* 19 CS for 2 SPDIF (USB Streaming) Clock Source */
+	{ 20, "Capture Source" }, 	/* 20 SU Capture Source Selector */
+	/* 22 CS Line-in and Mic-in Clock Source */
+	{ 0 }
+};
+
+static struct usbmix_selector_map xonar_u7_selectors[] = {
+{
+                .id = 20,
+                .count = 2,
+                .names = (const char*[]) {"Mic", "Line"}
+        },
+        { 0 } /* terminator */
+
+};
+
   /*
    * Control map entries
    */
@@ -451,6 +493,12 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
   		.id = USB_ID(0x25c4, 0x0003),
   		.map = scms_usb3318_map,
   	},
+	{
+		/* Asus Xonar U7 */
+		.id = USB_ID(0x1043, 0x857c),
+		.map = xonar_u7_map,
+		.selector_map = xonar_u7_selectors,
+	},
   	{ 0 } /* terminator */
   };

-- 
2.3.6


--------------070707040804000704060204
Content-Type: text/plain; charset=windows-1250;
 name="usb.debug"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="usb.debug"

Bus 004 Device 004: ID 1043:857c iCreate Technologies Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x1043 iCreate Technologies Corp.
  idProduct          0x857c 
  bcdDevice            1.10
  iManufacturer           1 ASUS
  iProduct                2 Xonar U7
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength         1010
    bNumInterfaces          5
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         4
      bFunctionClass          1 Audio
      bFunctionSubClass       0 
      bFunctionProtocol      32 
      iFunction               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol     32 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        bCategory              10
        wTotalLength          256
        bmControl            0x00
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID             18
        bNrChannels             0
        bmChannelConfig   0x00000000
        bmControls    0x0040
          Cluster Control (read-only)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID             19
        bNrChannels             0
        bmChannelConfig   0x00000000
        bmControls    0x0040
          Cluster Control (read-only)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bCSourceID             22
        bNrChannels             2
        bmChannelConfig   0x00000003
          Front Left (FL)
          Front Right (FR)
        bmControls    0x0044
          Connector Control (read-only)
          Cluster Control (read-only)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0603 Line Connector
        bAssocTerminal          0
        bCSourceID             22
        bNrChannels             2
        bmChannelConfig   0x00000003
          Front Left (FL)
          Front Right (FR)
        bmControls    0x0044
          Connector Control (read-only)
          Cluster Control (read-only)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             7
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              13
        bCSourceID             18
        bmControls         0xc004
          Connector Control (read-only)
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             8
        wTerminalType      0x0605 SPDIF interface
        bAssocTerminal          0
        bSourceID              14
        bCSourceID             19
        bmControls         0x0004
          Connector Control (read-only)
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            11
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID              20
        bCSourceID             22
        bmControls         0x0000
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                42
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                13
        bSourceID               1
        bmaControls( 0)      0x00000003
          Mute Control (read/write)
        bmaControls( 1)      0x00c0000c
          Volume Control (read/write)
          Input gain pad Control (read/write)
        bmaControls( 2)      0x00c0000c
          Volume Control (read/write)
          Input gain pad Control (read/write)
        bmaControls( 3)      0x0000000c
          Volume Control (read/write)
        bmaControls( 4)      0x0000000c
          Volume Control (read/write)
        bmaControls( 5)      0x0000000c
          Volume Control (read/write)
        bmaControls( 6)      0x0000000c
          Volume Control (read/write)
        bmaControls( 7)      0x0000000c
          Volume Control (read/write)
        bmaControls( 8)      0x0000000c
          Volume Control (read/write)
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                14
        bSourceID               2
        bmaControls( 0)      0x00000003
          Mute Control (read/write)
        bmaControls( 1)      0x00000000
        bmaControls( 2)      0x00000000
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                16
        bSourceID               4
        bmaControls( 0)      0x00000003
          Mute Control (read/write)
        bmaControls( 1)      0x00000000
        bmaControls( 2)      0x00000000
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                17
        bSourceID               5
        bmaControls( 0)      0x00000003
          Mute Control (read/write)
        bmaControls( 1)      0x00000000
        bmaControls( 2)      0x00000000
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               18
        bmAttributes         0x03 Internal programmable Clock 
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               19
        bmAttributes         0x03 Internal programmable Clock 
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               22
        bmAttributes         0x03 Internal programmable Clock 
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                20
        bNrInPins               2
        baSource( 0)           16
        baSource( 1)           17
        bmControls           0x03
          Selector Control (read/write)
        iSelector               0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8f  EP 15 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0006  1x 6 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              4 Speaker
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            2
        bBitResolution         16
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0068  1x 104 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            3
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x009c  1x 156 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             4
        bmChannelConfig   0x00000033
          Front Left (FL)
          Front Right (FR)
          Back Left (BL)
          Back Right (BR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            2
        bBitResolution         16
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x00d0  1x 208 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             4
        bmChannelConfig   0x00000033
          Front Left (FL)
          Front Right (FR)
          Back Left (BL)
          Back Right (BR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            3
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             6
        bmChannelConfig   0x0000003f
          Front Left (FL)
          Front Right (FR)
          Front Center (FC)
          Low Frequency Effects (LFE)
          Back Left (BL)
          Back Right (BR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            2
        bBitResolution         16
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       6
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             6
        bmChannelConfig   0x0000003f
          Front Left (FL)
          Front Right (FR)
          Front Center (FC)
          Low Frequency Effects (LFE)
          Back Left (BL)
          Back Right (BR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            3
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x01d4  1x 468 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       7
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             8
        bmChannelConfig   0x0000063f
          Front Left (FL)
          Front Right (FR)
          Front Center (FC)
          Low Frequency Effects (LFE)
          Back Left (BL)
          Back Right (BR)
          Side Left (SL)
          Side Right (SR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            2
        bBitResolution         16
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x01a0  1x 416 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       8
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             8
        bmChannelConfig   0x0000063f
          Front Left (FL)
          Front Right (FR)
          Front Center (FC)
          Low Frequency Effects (LFE)
          Back Left (BL)
          Back Right (BR)
          Side Left (SL)
          Side Right (SR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            3
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0270  1x 624 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              5 SPDIF Output
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            2
        bBitResolution         16
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0068  1x 104 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            3
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x009c  1x 156 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             3
        bmFormats         0x00001381
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             3 (FORMAT_TYPE_III)
        bSubslotSize            2
        bBitResolution         16
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0068  1x 104 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              9 Input
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          11
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            2
        bBitResolution         16
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x88  EP 8 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0068  1x 104 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          11
        bmControls           0x05
          Active Alternate Setting Control (read-only)
          Valid Alternate Setting Control (read-only)
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000003
          Front Left (FL)
          Front Right (FR)
        iChannelNames           0 
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            3
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x88  EP 8 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x009c  1x 156 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         4
      bInterfaceCount         1
      bFunctionClass          3 Human Interface Device
      bFunctionSubClass       0 
      bFunctionProtocol       0 
      iFunction               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      50
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               4
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)


--------------070707040804000704060204
Content-Type: text/plain; charset=windows-1250;
 name="proc-usbmixer"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="proc-usbmixer"

USB Mixer: usb_id=0x1043857c, ctrlif=0, ctlerr=0
Card: ASUS Xonar U7 at usb-0000:00:13.2-5, high speed
  Unit: 13
    Control: name="Speaker Playback", index=0
    Info: id=13, control=12, cmask=0x3, channels=2, type="S16"
    Volume: min=-3072, max=0, dBmin=-1200, dBmax=0
  Unit: 13
    Control: name="Speaker Playback Volume", index=0
    Info: id=13, control=2, cmask=0xff, channels=8, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0
  Unit: 13
    Control: name="Speaker Playback Switch", index=0
    Info: id=13, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 14
    Control: name="IEC958 Playback Switch", index=0
    Info: id=14, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 16
    Control: name="Mic Capture Switch", index=0
    Info: id=16, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 17
    Control: name="Line Capture Switch", index=0
    Info: id=17, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 20
    Control: name="Capture Source", index=0
    Info: id=20, control=1, cmask=0x0, channels=1, type="U8"
    Volume: min=1, max=2, dBmin=0, dBmax=0

--------------070707040804000704060204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070707040804000704060204--
