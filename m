From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0000923]: Add Terratec Aureon 5.1 USB MKII to the list of supported cards
Date: Sat, 19 Feb 2005 06:41:37 +0100
Message-ID: <15a511866531bbbf9b2ebe52f34cbc17@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DA78623C
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2005 06:41:37 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=923> 
======================================================================
Reported By:                sebastian_ml
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   923
Category:                   soundcard matrix
Reproducibility:            N/A
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-19-2005 06:41 CET
Last Modified:              02-19-2005 06:41 CET
======================================================================
Summary:                    Add Terratec Aureon 5.1 USB MKII to the list of
supported cards
Description: 
Hello!

I bought such a card and it works. It follows the USB audio standard.

lsusb -v

Bus 003 Device 002: ID 0ccd:0028 TerraTec Electronic GmbH 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0ccd TerraTec Electronic GmbH
  idProduct          0x0028 
  bcdDevice            1.00
  iManufacturer           0 
  iProduct                1 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          369
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength          179
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             6
        wChannelConfig     0x003f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0603 Line Connector
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0605 SPDIF interface
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0605 SPDIF interface
        bAssocTerminal          0
        bSourceID               1
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               9
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             7
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               8
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 8
        bNrInPins               3
        baSource( 0)           10
        baSource( 1)           11
        baSource( 2)           12
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 9
        bSourceID              15
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
        bControlSize            1
        bmaControls( 0)      0x43
          Mute
          Volume
          Automatic Gain
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                11
        bSourceID               3
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x02
          Volume
        bmaControls( 0)      0x02
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                12
        bSourceID               4
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                13
        bSourceID               2
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                14
        bSourceID               3
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x02
          Volume
        bmaControls( 0)      0x02
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                21
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                15
        bNrInPins               3
        baSourceID( 0)          1
        baSourceID( 1)         13
        baSourceID( 2)         14
        bNrChannels             6
        wChannelConfig     0x003f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        bmControls         0x00
        bmControls         0x00
        bmControls         0x00
        iMixer                  0 
        junk at descriptor end: 00 00 00 00 00
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  3 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        200
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         1 Milliseconds
          wLockDelay              4 Milliseconds
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             6
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        600
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         1 Milliseconds
          wLockDelay              2 Milliseconds
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           7
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        200
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      48
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          3
        bInterval              32
  Language IDs: (length=4)
     0409 English(US)

lsmod
Module                  Size  Used by
snd_pcm_oss            47584  1
snd_mixer_oss          17216  1 snd_pcm_oss
snd_seq_oss            33920  0
snd_seq_midi_event      6144  1 snd_seq_oss
snd_seq                49872  4 snd_seq_oss,snd_seq_midi_event
snd_usb_audio          63360  2
snd_pcm                82504  2 snd_pcm_oss,snd_usb_audio
snd_timer              21316  2 snd_seq,snd_pcm
snd_page_alloc          7556  1 snd_pcm
snd_usb_lib            11072  1 snd_usb_audio
snd_rawmidi            20256  1 snd_usb_lib
snd_seq_device          7116  3 snd_seq_oss,snd_seq,snd_rawmidi
snd                    47524  12
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_usb_audio,snd_pcm,snd_timer,snd_usb_lib,snd_rawmidi,snd_seq_device


cat /proc/asound/modules
0 snd_usb_audio

cat /proc/asound/devices
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
  1:       : sequencer
 33:       : timer

The device is already listed at
http://www.qbik.ch/usb/devices/showdev.php?id=3102

Thanks! 

Keep up the good work!

Sebastian
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-05 06:41 sebastian_ml   New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
