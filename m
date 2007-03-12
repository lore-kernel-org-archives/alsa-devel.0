From: jlm devel <jlm_devel@laposte.net>
Subject: Re: hercules nuse pocket lt usb : kindof work but not
 really usable
Date: Mon, 12 Mar 2007 12:54:00 +0100
Message-ID: <45F53F58.1060205@laposte.net>
References: <45F03529.8010501@laposte.net> <45F116EB.7090702@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0574033445=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45F116EB.7090702@laposte.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============0574033445==
Content-Type: multipart/alternative;
	boundary="------------090708070005050003040906"

This is a multi-part message in MIME format.
--------------090708070005050003040906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

jlm devel a =E9crit :
> jl malet a =E9crit :
>  =20
>> hi
>> I've some problem with a muse pocket lt soundcard from hercules, it's =
an=20
>> usb card then it use snd-usb-audio, it works in the sense that I can=20
>> hear sound.... and it don't in the sense that my pcm volume control ha=
s=20
>> no effect, that the 2 lines volumes are able to control 2% of the volu=
me=20
>> about (I can set 0% 1% 2% (about) and then all the remaining is TOO=20
>> LOOD! or saturated)
>>
>> here is what lsusb gave me :
>>
>>
>> Bus 001 Device 003: ID 06f8:c000 Guillemot Corp.
>> Device Descriptor:
>>   bLength                18
>>   bDescriptorType         1
>>   bcdUSB               1.10
>>   bDeviceClass            0 (Defined at Interface level)
>>   bDeviceSubClass         0
>>   bDeviceProtocol         0
>>   bMaxPacketSize0        64
>>   idVendor           0x06f8 Guillemot Corp.
>>   idProduct          0xc000
>>   bcdDevice            1.00
>>   iManufacturer           0
>>   iProduct                1 USB Audio
>>   iSerial                 0
>>   bNumConfigurations      1
>>   Configuration Descriptor:
>>     bLength                 9
>>     bDescriptorType         2
>>     wTotalLength          337
>>     bNumInterfaces          4
>>     bConfigurationValue     1
>>     iConfiguration          0
>>     bmAttributes         0xa0
>>       (Bus Powered)
>>       Remote Wakeup
>>     MaxPower              500mA
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        0
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      1 Control Device
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       AudioControl Interface Descriptor:
>>         bLength                10
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (HEADER)
>>         bcdADC               1.00
>>         wTotalLength          147
>>         bInCollection           2
>>         baInterfaceNr( 0)       1
>>         baInterfaceNr( 1)       2
>>       AudioControl Interface Descriptor:
>>         bLength                12
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>>         bTerminalID             1
>>         wTerminalType      0x0101 USB Streaming
>>         bAssocTerminal          0
>>         bNrChannels             6
>>         wChannelConfig     0x003f
>>           Left Front (L)
>>           Right Front (R)
>>           Center Front (C)
>>           Low Freqency Enhancement (LFE)
>>           Left Surround (LS)
>>           Right Surround (RS)
>>         iChannelNames           0
>>         iTerminal               0
>>       AudioControl Interface Descriptor:
>>         bLength                12
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>>         bTerminalID             2
>>         wTerminalType      0x0201 Microphone
>>         bAssocTerminal          0
>>         bNrChannels             2
>>         wChannelConfig     0x0003
>>           Left Front (L)
>>           Right Front (R)
>>         iChannelNames           0
>>         iTerminal               0
>>       AudioControl Interface Descriptor:
>>         bLength                12
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>>         bTerminalID             3
>>         wTerminalType      0x0603 Line Connector
>>         bAssocTerminal          0
>>         bNrChannels             2
>>         wChannelConfig     0x0003
>>           Left Front (L)
>>           Right Front (R)
>>         iChannelNames           0
>>         iTerminal               0
>>       AudioControl Interface Descriptor:
>>         bLength                 9
>>         bDescriptorType        36
>>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>>         bTerminalID             6
>>         wTerminalType      0x0301 Speaker
>>         bAssocTerminal          0
>>         bSourceID               9
>>         iTerminal               0
>>       AudioControl Interface Descriptor:
>>         bLength                 9
>>         bDescriptorType        36
>>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>>         bTerminalID             7
>>         wTerminalType      0x0101 USB Streaming
>>         bAssocTerminal          0
>>         bSourceID               8
>>         iTerminal               0
>>       AudioControl Interface Descriptor:
>>         bLength                 8
>>         bDescriptorType        36
>>         bDescriptorSubtype      5 (SELECTOR_UNIT)
>>         bUnitID                 8
>>         bNrInPins               2
>>         baSource( 0)           10
>>         baSource( 1)           11
>>         iSelector               0
>>       AudioControl Interface Descriptor:
>>         bLength                14
>>         bDescriptorType        36
>>         bDescriptorSubtype      6 (FEATURE_UNIT)
>>         bUnitID                 9
>>         bSourceID              15
>>         bControlSize            1
>>         bmaControls( 0)      0x03
>>           Mute
>>           Volume
>>         bmaControls( 1)      0x00
>>         bmaControls( 2)      0x00
>>         bmaControls( 3)      0x00
>>         bmaControls( 4)      0x00
>>         bmaControls( 5)      0x00
>>         bmaControls( 6)      0x00
>>         iFeature                0
>>       AudioControl Interface Descriptor:
>>         bLength                10
>>         bDescriptorType        36
>>         bDescriptorSubtype      6 (FEATURE_UNIT)
>>         bUnitID                10
>>         bSourceID               2
>>         bControlSize            1
>>         bmaControls( 0)      0x43
>>           Mute
>>           Volume
>>           Automatic Gain
>>         bmaControls( 1)      0x00
>>         bmaControls( 2)      0x00
>>         iFeature                0
>>       AudioControl Interface Descriptor:
>>         bLength                10
>>         bDescriptorType        36
>>         bDescriptorSubtype      6 (FEATURE_UNIT)
>>         bUnitID                11
>>         bSourceID               3
>>         bControlSize            1
>>         bmaControls( 0)      0x01
>>           Mute
>>         bmaControls( 1)      0x02
>>           Volume
>>         bmaControls( 2)      0x02
>>           Volume
>>         iFeature                0
>>       AudioControl Interface Descriptor:
>>         bLength                10
>>         bDescriptorType        36
>>         bDescriptorSubtype      6 (FEATURE_UNIT)
>>         bUnitID                13
>>         bSourceID               2
>>         bControlSize            1
>>         bmaControls( 0)      0x03
>>           Mute
>>           Volume
>>         bmaControls( 1)      0x00
>>         bmaControls( 2)      0x00
>>         iFeature                0
>>       AudioControl Interface Descriptor:
>>         bLength                10
>>         bDescriptorType        36
>>         bDescriptorSubtype      6 (FEATURE_UNIT)
>>         bUnitID                14
>>         bSourceID               3
>>         bControlSize            1
>>         bmaControls( 0)      0x01
>>           Mute
>>         bmaControls( 1)      0x02
>>           Volume
>>         bmaControls( 2)      0x02
>>           Volume
>>         iFeature                0
>>       AudioControl Interface Descriptor:
>>         bLength                21
>>         bDescriptorType        36
>>         bDescriptorSubtype      4 (MIXER_UNIT)
>>         bUnitID                15
>>         bNrInPins               3
>>         baSourceID( 0)          1
>>         baSourceID( 1)         13
>>         baSourceID( 2)         14
>>         bNrChannels             6
>>         wChannelConfig     0x003f
>>           Left Front (L)
>>           Right Front (R)
>>           Center Front (C)
>>           Low Freqency Enhancement (LFE)
>>           Left Surround (LS)
>>           Right Surround (RS)
>>         iChannelNames           0
>>         bmControls         0x00
>>         bmControls         0x00
>>         bmControls         0x00
>>         iMixer                  0
>>         junk at descriptor end: 00 00 00 00 00
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       1
>>       bNumEndpoints           1
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       AudioStreaming Interface Descriptor:
>>         bLength                 7
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (AS_GENERAL)
>>         bTerminalLink           1
>>         bDelay                  3 frames
>>         wFormatTag              1 PCM
>>       AudioStreaming Interface Descriptor:
>>         bLength                11
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (FORMAT_TYPE)
>>         bFormatType             1 (FORMAT_TYPE_I)
>>         bNrChannels             2
>>         bSubframeSize           2
>>         bBitResolution         16
>>         bSamFreqType            1 Discrete
>>         tSamFreq[ 0]        48000
>>       Endpoint Descriptor:
>>         bLength                 9
>>         bDescriptorType         5
>>         bEndpointAddress     0x01  EP 1 OUT
>>         bmAttributes            9
>>           Transfer Type            Isochronous
>>           Synch Type               Adaptive
>>           Usage Type               Data
>>         wMaxPacketSize     0x00c8  1x 200 bytes
>>         bInterval               1
>>         bRefresh                0
>>         bSynchAddress           0
>>         AudioControl Endpoint Descriptor:
>>           bLength                 7
>>           bDescriptorType        37
>>           bDescriptorSubtype      1 (EP_GENERAL)
>>           bmAttributes         0x00
>>           bLockDelayUnits         1 Milliseconds
>>           wLockDelay              4 Milliseconds
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       2
>>       bNumEndpoints           1
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       AudioStreaming Interface Descriptor:
>>         bLength                 7
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (AS_GENERAL)
>>         bTerminalLink           1
>>         bDelay                  1 frames
>>         wFormatTag              1 PCM
>>       AudioStreaming Interface Descriptor:
>>         bLength                11
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (FORMAT_TYPE)
>>         bFormatType             1 (FORMAT_TYPE_I)
>>         bNrChannels             6
>>         bSubframeSize           2
>>         bBitResolution         16
>>         bSamFreqType            1 Discrete
>>         tSamFreq[ 0]        48000
>>       Endpoint Descriptor:
>>         bLength                 9
>>         bDescriptorType         5
>>         bEndpointAddress     0x01  EP 1 OUT
>>         bmAttributes            9
>>           Transfer Type            Isochronous
>>           Synch Type               Adaptive
>>           Usage Type               Data
>>         wMaxPacketSize     0x0258  1x 600 bytes
>>         bInterval               1
>>         bRefresh                0
>>         bSynchAddress           0
>>         AudioControl Endpoint Descriptor:
>>           bLength                 7
>>           bDescriptorType        37
>>           bDescriptorSubtype      1 (EP_GENERAL)
>>           bmAttributes         0x00
>>           bLockDelayUnits         1 Milliseconds
>>           wLockDelay              2 Milliseconds
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        2
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        2
>>       bAlternateSetting       1
>>       bNumEndpoints           1
>>       bInterfaceClass         1 Audio
>>       bInterfaceSubClass      2 Streaming
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       AudioStreaming Interface Descriptor:
>>         bLength                 7
>>         bDescriptorType        36
>>         bDescriptorSubtype      1 (AS_GENERAL)
>>         bTerminalLink           7
>>         bDelay                  1 frames
>>         wFormatTag              1 PCM
>>       AudioStreaming Interface Descriptor:
>>         bLength                11
>>         bDescriptorType        36
>>         bDescriptorSubtype      2 (FORMAT_TYPE)
>>         bFormatType             1 (FORMAT_TYPE_I)
>>         bNrChannels             2
>>         bSubframeSize           2
>>         bBitResolution         16
>>         bSamFreqType            1 Discrete
>>         tSamFreq[ 0]        48000
>>       Endpoint Descriptor:
>>         bLength                 9
>>         bDescriptorType         5
>>         bEndpointAddress     0x82  EP 2 IN
>>         bmAttributes            5
>>           Transfer Type            Isochronous
>>           Synch Type               Asynchronous
>>           Usage Type               Data
>>         wMaxPacketSize     0x00c8  1x 200 bytes
>>         bInterval               1
>>         bRefresh                0
>>         bSynchAddress           0
>>         AudioControl Endpoint Descriptor:
>>           bLength                 7
>>           bDescriptorType        37
>>           bDescriptorSubtype      1 (EP_GENERAL)
>>           bmAttributes         0x00
>>           bLockDelayUnits         0 Undefined
>>           wLockDelay              0 Undefined
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        3
>>       bAlternateSetting       0
>>       bNumEndpoints           1
>>       bInterfaceClass         3 Human Interface Devices
>>       bInterfaceSubClass      0 No Subclass
>>       bInterfaceProtocol      0 None
>>       iInterface              0
>>         HID Device Descriptor:
>>           bLength                 9
>>           bDescriptorType        33
>>           bcdHID               1.00
>>           bCountryCode            0 Not supported
>>           bNumDescriptors         1
>>           bDescriptorType        34 Report
>>           wDescriptorLength      48
>>          Report Descriptors:
>>            ** UNAVAILABLE **
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x83  EP 3 IN
>>         bmAttributes            3
>>           Transfer Type            Interrupt
>>           Synch Type               None
>>           Usage Type               Data
>>         wMaxPacketSize     0x0003  1x 3 bytes
>>         bInterval              32
>> Device Status:     0x0000
>>   (Bus Powered)
>>
>>
>> can someone help me?
>> thanks
>>
>> ----------------------------------------------------------------------=
---
>> Take Surveys. Earn Cash. Influence the Future of IT
>> Join SourceForge.net's Techsay panel and you'll get the chance to shar=
e your
>> opinions on IT & business topics through brief surveys-and earn cash
>> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>  =20
>>    =20
> nobody working on usb devices?
>
> -----------------------------------------------------------------------=
--
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share=
 your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>  =20
can someone help me or redirect me to someplace where to get help?
thanks
JLM

--------------090708070005050003040906
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
jlm devel a &eacute;crit&nbsp;:
<blockquote cite="mid:45F116EB.7090702@laposte.net" type="cite">
  <pre wrap="">jl malet a &eacute;crit :
  </pre>
  <blockquote type="cite">
    <pre wrap="">hi
I've some problem with a muse pocket lt soundcard from hercules, it's an 
usb card then it use snd-usb-audio, it works in the sense that I can 
hear sound.... and it don't in the sense that my pcm volume control has 
no effect, that the 2 lines volumes are able to control 2% of the volume 
about (I can set 0% 1% 2% (about) and then all the remaining is TOO 
LOOD! or saturated)

here is what lsusb gave me :


Bus 001 Device 003: ID 06f8:c000 Guillemot Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x06f8 Guillemot Corp.
  idProduct          0xc000
  bcdDevice            1.00
  iManufacturer           0
  iProduct                1 USB Audio
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          337
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
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
        wTotalLength          147
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
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 8
        bNrInPins               2
        baSource( 0)           10
        baSource( 1)           11
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
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
        bmaControls( 3)      0x00
        bmaControls( 4)      0x00
        bmaControls( 5)      0x00
        bmaControls( 6)      0x00
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
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
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
        bmaControls( 1)      0x02
          Volume
        bmaControls( 2)      0x02
          Volume
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
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
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
        bmaControls( 1)      0x02
          Volume
        bmaControls( 2)      0x02
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
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  3 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
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
          Usage Type               Data
        wMaxPacketSize     0x00c8  1x 200 bytes
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
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
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
          Usage Type               Data
        wMaxPacketSize     0x0258  1x 600 bytes
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
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           7
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
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
          Usage Type               Data
        wMaxPacketSize     0x00c8  1x 200 bytes
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
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      48
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0003  1x 3 bytes
        bInterval              32
Device Status:     0x0000
  (Bus Powered)


can someone help me?
thanks

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT &amp; business topics through brief surveys-and earn cash
<a class="moz-txt-link-freetext" href="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a>
_______________________________________________
Alsa-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</a>
  
    </pre>
  </blockquote>
  <pre wrap=""><!---->nobody working on usb devices?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT &amp; business topics through brief surveys-and earn cash
<a class="moz-txt-link-freetext" href="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a>
_______________________________________________
Alsa-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</a>
  </pre>
</blockquote>
can someone help me or redirect me to someplace where to get help?<br>
thanks<br>
JLM<br>
</body>
</html>

--------------090708070005050003040906--


--===============0574033445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0574033445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0574033445==--
