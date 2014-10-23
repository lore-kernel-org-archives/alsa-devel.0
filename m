From: Tristan Chambers <tristan.chambers@gmail.com>
Subject: Re: Echo Audio Echo 2 USB Interface
Date: Wed, 22 Oct 2014 23:16:53 -0400
Message-ID: <CABuEqK5qDMVUk_U8AezcmruzND8ajFFjFWRJseyzsd22gj=N5w@mail.gmail.com>
References: <CABuEqK7VqOxFg8dBTwXoiKEqP-ZZPSZxwH5bapAP0uugio9qbg@mail.gmail.com>
 <543BE5A0.1090009@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C27F26530C
 for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2014 05:17:16 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id tr6so196461ieb.0
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 20:17:15 -0700 (PDT)
In-Reply-To: <543BE5A0.1090009@zonque.org>
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

Silly me, I tried it in a USB 2 port and now I'm getting much better
results. I guess there are problems with this device on a USB 3 port
in Linux - or maybe in general? There are still several problems
though. Now I can get it to record and play with arecord and aplay,
and I can run Jack and Ardour or Audacity with jack selected and do
multitrack recording no problem! HOWEVER, the playback device still
doesn't show up in my Gnome/Pulse manager. Also when I open Audacity
(no jack) the device shows up on the list of ALSA devices but when I
select the device for input or output the device emits several audible
clicks, and when I try to record or play the program either crashes or
goes very very slow and can only play or capture a fraction of a
second worth of data.

Regarding your suggestions, I see very little reported in dmesg. I'm
unaware of separate logs for PulseAudio. Anyone else have any ideas?
It would be convenient, but not critical to get it working like any
other sound device.

Anybody have any ideas for better debugging of the issue? I'd say the
current state is livable but maybe not something I'd say 'works for
anyone.'

------ dmesg -------

[  137.058345] usb 3-1: new high-speed USB device number 2 using xhci_hcd
[  137.222869] usb 3-1: New USB device found, idVendor=040f, idProduct=0010
[  137.222873] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  137.222875] usb 3-1: Product: Echo 2 Audio
[  137.222877] usb 3-1: Manufacturer: ECHO Digital Audio
[  137.222878] usb 3-1: SerialNumber: 0000
[  139.452978] usbcore: registered new interface driver snd-usb-audio
[  140.110495] retire_capture_urb: 3 callbacks suppressed


------ lsusb -v ------

tristan@ilya:/var/log$ lsusb -v

Bus 002 Device 004: ID 040f:0010 Echo Speech Corp.
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x040f Echo Speech Corp.
  idProduct          0x0010
  bcdDevice            0.38
  iManufacturer           1
  iProduct                2
  iSerial                 3
  bNumConfigurations      2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          311
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         3
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
      iInterface              2
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        bCategory               8
        wTotalLength          143
        bmControl            0x00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               41
        bmAttributes         0x03 Internal programmable Clock
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            9
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     11 (CLOCK_SELECTOR)
        bUnitID                40
        bNrInPins               1
        baCSourceID( 0)        41
        bmControls           0x03
          Clock Selector Control (read/write)
        iClockSelector          8
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels             4
        bmChannelConfig   0x00000000
        bmControls    0x0000
        iChannelNames          15
        iTerminal               6
      AudioControl Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
        bmaControls( 0)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 1)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 2)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 3)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 4)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            20
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              10
        bCSourceID             40
        bmControls         0x0000
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels             2
        bmChannelConfig   0x00000000
        bmControls    0x0000
        iChannelNames          33
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                11
        bSourceID               1
        bmaControls( 0)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 1)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 2)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            22
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID              11
        bCSourceID             40
        bmControls         0x0000
        iTerminal               7
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0006  1x 6 bytes
        bInterval               8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              4
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x00
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             4
        bmChannelConfig   0x00000000
        iChannelNames          15
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            4
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              8
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
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
      iInterface              5
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              5
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          22
        bmControls           0x00
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000000
        iChannelNames          33
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            4
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      1
      iInterface             12
      Device Firmware Upgrade Interface Descriptor:
        bLength                             9
        bDescriptorType                    33
        bmAttributes                        7
          Will Not Detach
          Manifestation Tolerant
          Upload Supported
          Download Supported
        wDetachTimeout                    250 milliseconds
        wTransferSize                      64 bytes
        bcdDFUVersion                   1.10
      Warning: Invalid descriptor
      Device Firmware Upgrade Interface Descriptor:
        bLength                            16
        bDescriptorType                    36
        bmAttributes                        9
          Will Detach
          Manifestation Intolerant
          Upload Unsupported
          Download Supported
        wDetachTimeout                    226 milliseconds
        wTransferSize                     256 bytes
        bcdDFUVersion                   1.02
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          311
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         3
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
      iInterface              2
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        bCategory               8
        wTotalLength          143
        bmControl            0x00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               41
        bmAttributes         0x03 Internal programmable Clock
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            9
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     11 (CLOCK_SELECTOR)
        bUnitID                40
        bNrInPins               1
        baCSourceID( 0)        41
        bmControls           0x03
          Clock Selector Control (read/write)
        iClockSelector          8
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels             4
        bmChannelConfig   0x00000000
        bmControls    0x0000
        iChannelNames          15
        iTerminal               6
      AudioControl Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
        bmaControls( 0)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 1)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 2)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 3)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 4)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            20
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              10
        bCSourceID             40
        bmControls         0x0000
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels             2
        bmChannelConfig   0x00000000
        bmControls    0x0000
        iChannelNames          33
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                11
        bSourceID               1
        bmaControls( 0)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 1)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 2)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            22
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID              11
        bCSourceID             40
        bmControls         0x0000
        iTerminal               7
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0006  1x 6 bytes
        bInterval               8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              4
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x00
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             4
        bmChannelConfig   0x00000000
        iChannelNames          15
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            4
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              8
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
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
      iInterface              5
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              5
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          22
        bmControls           0x00
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000000
        iChannelNames          33
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            4
        bBitResolution         24
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               1
        AudioControl Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bmControls           0x00
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      1
      iInterface             12
      Device Firmware Upgrade Interface Descriptor:
        bLength                             9
        bDescriptorType                    33
        bmAttributes                        7
          Will Not Detach
          Manifestation Tolerant
          Upload Supported
          Download Supported
        wDetachTimeout                    250 milliseconds
        wTransferSize                      64 bytes
        bcdDFUVersion                   1.10
      Warning: Invalid descriptor
      Device Firmware Upgrade Interface Descriptor:
        bLength                            16
        bDescriptorType                    36
        bmAttributes                        9
          Will Detach
          Manifestation Intolerant
          Upload Unsupported
          Download Supported
        wDetachTimeout                    226 milliseconds
        wTransferSize                     256 bytes
        bcdDFUVersion                   1.02



On Mon, Oct 13, 2014 at 10:45 AM, Daniel Mack <daniel@zonque.org> wrote:
> Hi,
>
> On 10/11/2014 07:32 PM, Tristan Chambers wrote:
>> I picked up an Echo Audio Echo 2 USB Interface. The product specs list
>> iPad support through camera connection kit, so I assume it is class
>> compliant. http://echoaudio.com/blogs/news/6454472-echo-digital-audio-introduces-the-echo-2-usb-audio-interface
>>
>> However, on most systems when I plug the device in, it shows up in my
>> sound settings panel under the Input tab, but not under the Output
>> tab.
>>
>> Recording works. I can successfully record with arecord -vv -fdat -D
>> "plughw:CARD=Audio,DEV=0" echo.wav. I also can increase the sample
>> rate by changing the flags. I verified that the sample rate actually
>> increases by recording a 50khz test tone into the input and examining
>> the wave form in an editor. It's there! So this is very promising.
>> (anyone know of a test to verify bit depth? I want to make sure it's
>> actually recording at 24bits.)
>>
>> Playback however, is nothing but trouble. Like I said, the output
>> device doesn't show up in the Output tab in my sound settings
>> (gnome/pulse). However, when I list devices and available PCMs with
>> aplay -l and aplay -L the device shows up on the lists. See specimens
>> #1, #2, and #3. When I try to play though I get about a 1/4 second of
>> audio and then nothing, and subsequent attempts to play sound output
>> nothing. The device then must be unplugged and plugged back in. I'm
>> playing with the command aplay -vv foo.wav
>> --device="plughw:CARD=Audio,DEV=0". See output screen on specimen #4.
>
> Any messages in dmesg when you try this? And does PulseAudio generate
> any logs that look suspicious? The output of 'lsusb -v' might also be
> helpful.
>
>
> Daniel
>
