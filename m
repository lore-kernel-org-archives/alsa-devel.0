From: Con Kolivas <kernel@kolivas.org>
Subject: Re: [alsa-devel] ALSA:usb audio Higher sample rates on usb audio no
 longer working.
Date: Sat, 5 Jan 2019 07:34:34 +1100
Message-ID: <CABqErrGas1rmgx7UeYBw2XJyHsXvmxxiwngRvwT0VcGsVVCzow@mail.gmail.com>
References: <CABqErrECNH+gRiZXM+z=igjAw895e7KLeV6H0EKvMkW0UsVvJw@mail.gmail.com>
 <s5hsgy96fiu.wl-tiwai@suse.de> <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
 <s5hd0pdey4e.wl-tiwai@suse.de> <5c7b2c6b-5dcc-7170-f6e1-bf6021bbb72a@linux.intel.com>
 <C672AA6DAAC36042A98BAD0B0B25BDA94CB021CE@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C672AA6DAAC36042A98BAD0B0B25BDA94CB021CE@BGSMSX104.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gopal, Saranya" <saranya.gopal@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Saranya.

On Sat, 5 Jan 2019 at 03:52, Gopal, Saranya <saranya.gopal@intel.com> wrote:

> And since I was not part of the initial mail thread, I might have missed some information.
> Could someone give me lsusb -v output for this USB audio device.

These outputs are with the UAC3 patch backed out:

dmesg:
[50384.859492] usb 2-1.8.4: new high-speed USB device number 26 using ehci-pci
[50384.974496] usb 2-1.8.4: New USB device found, idVendor=19fb,
idProduct=2040, bcdDevice= 2.00
[50384.974500] usb 2-1.8.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[50384.974501] usb 2-1.8.4: Product: Anti-Mode X4
[50384.974503] usb 2-1.8.4: Manufacturer: DSPeaker

lsusb -v:
Bus 002 Device 026: ID 19fb:2040
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x19fb
  idProduct          0x2040
  bcdDevice            2.00
  iManufacturer           1 DSPeaker
  iProduct                2 Anti-Mode X4
  iSerial                 0
  bNumConfigurations      2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          254
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       0
      bFunctionProtocol      32
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
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
        wTotalLength           60
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
        iClockSource            0
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     11 (CLOCK_SELECTOR)
        bUnitID                40
        bNrInPins               1
        baCSourceID( 0)        41
        bmControls           0x00
        iClockSelector          0
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels             2
        bmChannelConfig   0x00000000
        bmControls    0x0000
        iChannelNames           4 Analog 1
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 3
        bSourceID               1
        bmaControls( 0)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls( 1)      0x00000000
        bmaControls( 2)      0x00000000
        iFeature                0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32
      iInterface              0
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
        bmControls           0x00
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000000
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
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x010e  1x 270 bytes
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
        bmControls           0x00
        bFormatType             1
        bmFormats         0x00000001
          PCM
        bNrChannels             2
        bmChannelConfig   0x00000000
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
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x010e  1x 270 bytes
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
        bmControls           0x00
        bFormatType             1
        bmFormats         0x80000000
        bNrChannels             2
        bmChannelConfig   0x00000000
        iChannelNames           0
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bSubslotSize            4
        bBitResolution         32
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0190  1x 400 bytes
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
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          186
    bNumInterfaces          2
    bConfigurationValue     2
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
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
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           43
        bInCollection           1
        baInterfaceNr( 0)       1
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
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
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 3
        bSourceID               1
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 0)      0x00
          Mute Control
          Volume Control
        bmaControls( 1)      0x00
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
        bmaControls( 2)      0x00
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0305 Room Speaker
        bAssocTerminal          0
        bSourceID               3
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
      bNumEndpoints           2
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
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            3 Discrete
        tSamFreq[ 0]        44100
        tSamFreq[ 1]        48000
        tSamFreq[ 2]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0258  1x 600 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress         129
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              0 Decoded PCM samples
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0003  1x 3 bytes
        bInterval               4
        bRefresh                4
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
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
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            3 Discrete
        tSamFreq[ 0]        44100
        tSamFreq[ 1]        48000
        tSamFreq[ 2]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0258  1x 600 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress         129
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              0 Decoded PCM samples
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0003  1x 3 bytes
        bInterval               4
        bRefresh                4
        bSynchAddress           0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  bNumConfigurations      2
Device Status:     0x0000
  (Bus Powered)

>
> Thanks,
> Saranya

Regards,
Con
