From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Lost dB volumes on USB headset between 2.6.38 and
 3.0
Date: Tue, 16 Aug 2011 15:41:46 +0200
Message-ID: <4E4A739A.6020906@canonical.com>
References: <4E410361.7010808@canonical.com> <4E410E7D.8050903@ladisch.de>
	<4E4117C9.2090100@colin.guthr.ie> <s5hwremdagh.wl%tiwai@suse.de>
	<4E4A6338.6020309@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090700080309030606010800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id CADF924414
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 15:41:49 +0200 (CEST)
In-Reply-To: <4E4A6338.6020309@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090700080309030606010800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/16/2011 02:31 PM, Colin Guthrie wrote:
> 'Twas brillig, and Takashi Iwai at 09/08/11 13:40 did gyre and gimble:
>> At Tue, 09 Aug 2011 13:19:37 +0200,
>> Colin Guthrie wrote:
>>>
>>> 'Twas brillig, and Clemens Ladisch at 09/08/11 12:39 did gyre and gimble:
>>>> David Henningsson wrote:
>>>>> Hmm, I and Colin Guthrie have found a regression between kernels 2.6.38
>>>>> and 3.0.
>>>>>
>>>>> When running "amixer -D hw:handset" for this device under 2.6.38, the
>>>>> attached file is returned. Under 3.0, the dB information is missing.
>>>>> This can't be intentional, can it?
>>>>
>>>> There are patches that might have introduced bugs, but these two patches
>>>> do remove dB information intentionally:
>>>>
>>>> ALSA: usb-audio - Don't expose broken dB ranges:
>>>> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=59bb7f0eebe6
>>>> ALSA: usb-audio - Add volume range check and warn if it too big:
>>>> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=80acefff3bc7
>>>>
>>>> Are there any messages in the system log when loading the driver?
>>>> What are the controls' dB ranges (see "amixer contents")?
>>>
>>> Interesting thanks fpr the hints.
>>>
>>> I get this when plugging in the device David mentioned previously.
>>>
>>>
>>> usb 3-1: USB disconnect, device number 2
>>> usbcore: deregistering interface driver snd-usb-audio
>>> usb 2-1: new full speed USB device number 7 using uhci_hcd
>>> usb 2-1: New USB device found, idVendor=1885, idProduct=0501
>>> usb 2-1: New USB device strings: Mfr=2, Product=1, SerialNumber=0
>>> usb 2-1: Product: BT Agile handset
>>> usb 2-1: Manufacturer: Ascalade
>>> input: Ascalade BT Agile handset as
>>> /devices/pci0000:00/0000:00:1d.1/usb2/2-1/2-1:1.3/input/input14
>>> generic-usb 0003:1885:0501.0006: input,hidraw0: USB HID v1.00 Device
>>> [Ascalade BT Agile handset] on usb-0000:00:1d.1-1/input3
>>> 13:0: cannot get min/max values for control 2 (id 13)
>>> 14:0: cannot get min/max values for control 2 (id 14)
>>> 9:0: cannot get min/max values for control 2 (id 9)
>>> 10:0: cannot get min/max values for control 2 (id 10)
>>> 11:0: cannot get min/max values for control 2 (id 11)
>>> 9:0: cannot get min/max values for control 2 (id 9)
>>> 14:0: cannot get min/max values for control 2 (id 14)
>>> 11:0: cannot get min/max values for control 2 (id 11)
>>> 13:0: cannot get min/max values for control 2 (id 13)
>>> 10:0: cannot get min/max values for control 2 (id 10)
>>> 9:0: cannot get min/max values for control 2 (id 9)
>>
>> So the problem is that the driver can't extract the dB values.
>> If the problem is seen only at the beginning of driver initialization,
>> the patch below may work.
>>
>> Also, could you give "lsusb -v" output, too?
>
> Sure here it is. I actually have two USB cards plugged in here, both of
> which have now lost their dB info. The one above is here and the new one
> is the Yamaha one.

Never saw that attachment (did you forget to attach it?) but here's a 
third one which lacks dB volumes in 3.0 (but had in 2.6.38).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090700080309030606010800
Content-Type: text/plain;
 name="lsusb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lsusb.txt"

Bus 003 Device 002: ID 046d:0a0c Logitech, Inc. Clear Chat Comfort USB Headset
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0x0a0c Clear Chat Comfort USB Headset
  bcdDevice           10.13
  iManufacturer           1 Logitech
  iProduct                2 Logitech USB Headset
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          299
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          3 G8 v3.0.0.0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
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
        wTotalLength          100
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID              13
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            12
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 9
        bNrInPins               2
        baSourceID( 0)         12
        baSourceID( 1)          6
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 1
        bSourceID               9
        bControlSize            1
        bmaControls( 0)      0x01
          Mute Control
        bmaControls( 1)      0x02
          Volume Control
        bmaControls( 2)      0x02
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            14
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               1
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID              13
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 8
        bNrInPins               1
        baSource( 0)            2
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            10
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               8
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
        bTerminalLink          12
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            0 Continuous
        tLowerSamFreq        8000
        tUpperSamFreq       48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
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
        bTerminalLink          12
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            0 Continuous
        tLowerSamFreq        8000
        tUpperSamFreq       48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x0060  1x 96 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
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
        bTerminalLink          10
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            0 Continuous
        tLowerSamFreq        8000
        tUpperSamFreq       48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x0060  1x 96 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
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
          wDescriptorLength      57
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
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               8
Device Status:     0x0000
  (Bus Powered)


--------------090700080309030606010800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090700080309030606010800--
