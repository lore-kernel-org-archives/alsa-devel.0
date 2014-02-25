From: Dana Goyette <DanaGoyette@gmail.com>
Subject: Re: External sound card issue
Date: Mon, 24 Feb 2014 23:16:50 -0800
Message-ID: <lehg0l$gu1$1@ger.gmane.org>
References: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>	<52DD1A66.9050909@ladisch.de>	<CAN8cciYR_9Le-tX-CLBjfnYQ1+CuexKzxpxberVkkV6jR_c50A@mail.gmail.com>	<1390398693.24097.YahooMailNeo@web162304.mail.bf1.yahoo.com>	<52E54D7B.3040408@ladisch.de>	<1390765545.16173.YahooMailNeo@web162301.mail.bf1.yahoo.com>
 <s5ha9ehkdk5.wl%tiwai@suse.de>
 <1390824843.46971.YahooMailNeo@web162301.mail.bf1.yahoo.com>
 <52E65597.6040602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CA6C26558E
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 08:40:08 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WICcW-0007NL-Jf
 for alsa-devel@alsa-project.org; Tue, 25 Feb 2014 08:40:04 +0100
Received: from 173-228-54-224.dsl.dynamic.sonic.net ([173.228.54.224])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 08:40:04 +0100
Received: from DanaGoyette by 173-228-54-224.dsl.dynamic.sonic.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 08:40:04 +0100
In-Reply-To: <52E65597.6040602@ladisch.de>
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

On 01/27/2014 04:48 AM, Clemens Ladisch wrote:
> Ionica Bizau wrote:
>> When I run the first command:
>>
>> $ rmmod snd-usb-audio
>> rmmod: ERROR: Module snd_usb_audio is in use
>
> Exit all programs (such as PulseAudio) that might be using the device.
>
> Alternatively, add the line
>
>    options snd-usb-audio ignore_ctl_error=1
>
> to some .conf file in /etc/modprobe.d/, and reboot.
>
>
> Regards,
> Clemens
>

I have the successor to that card ("Xonar U7 Echelon Ed."), with similar 
issues.

Bus 004 Device 009: ID 1043:85c1 iCreate Technologies Corp.

Incidentally, the capture selector switch seems horribly broken even in 
Windows!  In my attempts to get line-in and mic-in working, I've gotten 
the audio driver (or perhaps the device?) wedged several times.

Side note: alsa-info.sh did not catch the following non-prefixed message:
[ 1612.517217] cannot get ctl value: req = 0x81, wValue = 0x0, wIndex = 
0x1400, type = 3

The device works relatively well with ignore_ctl_err=1 set.

lsusb -vvvv for that device:

Bus 004 Device 009: ID 1043:85c1 iCreate Technologies Corp.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass          239 Miscellaneous Device
   bDeviceSubClass         2 ?
   bDeviceProtocol         1 Interface Association
   bMaxPacketSize0        64
   idVendor           0x1043 iCreate Technologies Corp.
   idProduct          0x85c1
   bcdDevice            1.10
   iManufacturer           1 ASUS
   iProduct                2 Xonar U7 Echelon Ed.
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
       bFunctionSubClass       0 No Subclass
       bFunctionProtocol       0 None
       iFunction               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        4
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
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
   bDeviceSubClass         2 ?
   bDeviceProtocol         1 Interface Association
   bMaxPacketSize0        64
   bNumConfigurations      1
Device Status:     0x0000
   (Bus Powered)
