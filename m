From: Daniel Griscom <griscom@suitable.com>
Subject: Re: USB hardware that supports implicit feedback?
Date: Thu, 15 Nov 2012 16:32:19 -0500
Message-ID: <p06240809cccb09820207@[192.168.1.8]>
References: <p06240805cccafc72f23b@[192.168.1.36]>
 <alpine.LNX.2.00.1211152158440.2632@xoschi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway12.websitewelcome.com (gateway12.websitewelcome.com
 [67.18.22.86]) by alsa0.perex.cz (Postfix) with ESMTP id E029A265085
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 22:32:23 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway12.websitewelcome.com (Postfix) with ESMTP id 368C320B1D352
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 15:32:26 -0600 (CST)
In-Reply-To: <alpine.LNX.2.00.1211152158440.2632@xoschi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

At 10:02 PM +0100 11/15/12, Eldad Zack wrote:
>Hi Daniel,
>
>On Thu, 15 Nov 2012, Daniel Griscom wrote:
>>  I'm having trouble getting implicit feedback working with my custom
>>  capture/playback USB audio class device, even with the latest kernel. I
>>  presume it's a problem with my device's configuration, but can't figure out
>>  exactly what the problem is (after a whole lotta investigation).
>
>What exactly doesn't work?

The audio output stream (from the computer to my device) runs at a 
few frames per second higher or lower rate than that of the input 
stream (from my device to the computer). The actual difference seems 
to be stable on a specific machine, but varies greatly between 
machines (I've seen differences from +7fps to -2fps; I presume this 
is due to differences in CPU clock frequencies).

>The "lsusb -v" output from your device might help here.

It's long: posted at the end of this message.

>  > Is there any commercial USB hardware out there that supports implicit
>>  feedback? I assume the ALSA developers are testing against something, but I
>>  can't find anything appropriate.
>
>I'm not an ALSA dev, but I recently posted a series of patches for the
>M-Audio Fast Track C400, which uses the implicit feedback code that was
>already in the tree for other devices.

So, this device uses implicit feedback to tell ALSA to send output 
data at the same rate as its input data? Very cool; I've ordered one 
to test.

>Take a look at sound/usb/pcm.c, there are quite a few hints to how this
>is discovered currently.

We've been looking there already, but will dig deeper.


Grateful for any help you may have,
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
