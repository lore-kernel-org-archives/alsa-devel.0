From: Daniel Griscom <griscom@suitable.com>
Subject: Missing exactly 3 of 8 audio packets?
Date: Wed, 21 Nov 2012 15:13:50 -0500
Message-ID: <p06240816ccd2e5cc9db7@[192.168.1.8]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway14.websitewelcome.com (gateway14.websitewelcome.com
 [67.18.82.11]) by alsa0.perex.cz (Postfix) with ESMTP id F367726171E
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 21:13:54 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway14.websitewelcome.com (Postfix) with ESMTP id E237B72F5F97C
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 14:13:52 -0600 (CST)
Received: from [75.144.159.89] (port=52464 helo=[192.168.1.8])
 by gator683.hostgator.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.80) (envelope-from <griscom@suitable.com>)
 id 1TbGgC-0001WK-Ux
 for alsa-devel@alsa-project.org; Wed, 21 Nov 2012 14:13:53 -0600
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On to the next problem we're having with our USB audio card. Recap: 
simple USB Audio Class embedded stereo audio card, running at 44.1kHz 
or 48kHz, using the 3.6.6 kernel and its associated ALSA modules to 
drive it, running on Jetway ND9D-2700, with an Atom D2700 and NM10 
chipset. Output of "sudo lsusb -v" for card is appended below.

Problem: we're experiencing strange hiccups in the delivery of audio 
from the motherboard to the card. At 48kHz, the motherboard should 
send a 6-frame packet to the card once per high-speed microframe 
(every 125us). This usually works, but sometimes there are two 
closely related failures:

1) Once in a while (every few seconds or minutes) a single packet 
will be missed

2) Once in a longer while (every few minutes or hours), the system 
will go into a continuing error condition where three of every eight 
packets are missed.

In both cases, "missed" means that ALSA consumes the output audio 
from my motherboard application, but never sends a packet to the 
audio card. No USB errors, no logged messages; it just disappears.


The second case has one very interesting symptom. The pattern of 
missed frames is amazingly rigid, and repeats the following pattern 
endlessly (each character is a 125us slot for a packet, "F" is a 
transmitted packet, "-" is a missing packet):

FFFF--F-

So, with eight microframes per millisecond where packets can be sent, 
the fifth, sixth and eighth packets are missed, and this repeats for 
at least a number of seconds. Very, very strange.

Using a Beagle 1200 I can see that there are no USB errors: the 
packet is just not sent. Audio continues unabated in the other 
direction. Timing always looks good, no other traffic on that USB 
port.


We've been chewing on this issue for a while. To me, it sounds like 
this could only happen in the ALSA code where the stream of audio is 
broken into individual USB packets. Unfortunately, I'm having a heck 
of a time navigating the ALSA source code, and frankly have gotten no 
traction at all.


Any thoughts on what this might be, or on what further tests we might do?


Thanks,
Dan



P.S. Here's the output of "sudo lsusb -v" for the device.


Bus 001 Device 005: ID 03eb:2311 Atmel Corp.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x03eb Atmel Corp.
   idProduct          0x2311
   bcdDevice           10.00
   iManufacturer           1 Suitable Systems
   iProduct                2 USB 24-bit Stereo AudioCard
   iSerial                 3 1.0.0.0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          266
     bNumInterfaces          4
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xc0
       Self Powered
     MaxPower                0mA
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
         wTotalLength          107
         bInCollection           2
         baInterfaceNr( 0)       2
         baInterfaceNr( 1)       1
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             1
         wTerminalType      0x0101 USB Streaming
         bAssocTerminal          0
         bNrChannels             1
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         iTerminal              17 AES/EBU
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID            14
         wTerminalType      0x0602 Digital Audio Interface
         bAssocTerminal          0
         bNrChannels             1
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         iTerminal              18 SPDIF
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                 2
         bSourceID               1
         bControlSize            1
         bmaControls( 0)      0x03
           Mute
           Volume
         bmaControls( 1)      0x00
         iFeature               10 Output
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
         bTerminalID             3
         wTerminalType      0x0301 Speaker
         bAssocTerminal          0
         bSourceID               2
         iTerminal               0
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             4
         wTerminalType      0x0201 Microphone
         bAssocTerminal          0
         bNrChannels             1
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         iTerminal               7 Analog
       AudioControl Interface Descriptor:
         bLength                16
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                 8
         bSourceID               4
         bControlSize            1
         bmaControls( 0)      0x00
         bmaControls( 1)      0x80
           Delay
         bmaControls( 2)      0x80
           Delay
         bmaControls( 3)      0x80
           Delay
         bmaControls( 4)      0x80
           Delay
         bmaControls( 5)      0x80
           Delay
         bmaControls( 6)      0x80
           Delay
         bmaControls( 7)      0x80
           Delay
         bmaControls( 8)      0x80
           Delay
         iFeature               12 ADC Regs
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      5 (SELECTOR_UNIT)
         bUnitID                 7
         bNrInPins               3
         baSource( 0)            8
         baSource( 1)            1
         baSource( 2)           14
         iSelector              11 Source Select
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                 5
         bSourceID               7
         bControlSize            1
         bmaControls( 0)      0x03
           Mute
           Volume
         bmaControls( 1)      0x00
         iFeature                9 Input
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
         bTerminalID             6
         wTerminalType      0x0101 USB Streaming
         bAssocTerminal          0
         bSourceID               5
         iTerminal               0
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
         bDelay                  1 frames
         wFormatTag              1 PCM
       AudioStreaming Interface Descriptor:
         bLength                17
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             2
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            3 Discrete
         tSamFreq[ 0]        32000
         tSamFreq[ 1]        44100
         tSamFreq[ 2]        48000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x05  EP 5 OUT
         bmAttributes            5
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Data
         wMaxPacketSize     0x0100  1x 256 bytes
         bInterval               1
         bRefresh                0
         bSynchAddress           2
         AudioControl Endpoint Descriptor:
           bLength                 7
           bDescriptorType        37
           bDescriptorSubtype      1 (EP_GENERAL)
           bmAttributes         0x01
             Sampling Frequency
           bLockDelayUnits         0 Undefined
           wLockDelay              0 Undefined
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
         bTerminalLink           6
         bDelay                  1 frames
         wFormatTag              1 PCM
       AudioStreaming Interface Descriptor:
         bLength                17
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             2
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            3 Discrete
         tSamFreq[ 0]        32000
         tSamFreq[ 1]        44100
         tSamFreq[ 2]        48000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes           37
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Implicit feedback Data
         wMaxPacketSize     0x0100  1x 256 bytes
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
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      0 No Subclass
       bInterfaceProtocol      1 Keyboard
       iInterface              0
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID              11.01
           bCountryCode            0 Not supported
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      39
          Report Descriptors:
            ** UNAVAILABLE **
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0008  1x 8 bytes
         bInterval               2
Device Qualifier (for other device speed):
   bLength                10
   bDescriptorType         6
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   bNumConfigurations      1
Device Status:     0x0001
   Self Powered

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
