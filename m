From: Ross Miller <miller@penguinstation.net>
Subject: Re: AudioTrak Optoplay...
Date: Tue, 3 Jun 2003 08:48:43 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306030848.43580.miller@penguinstation.net>
References: <Pine.HPX.4.33n.0306030852380.24147-100000@studcom.urz.uni-halle.de>
Reply-To: miller@penguinstation.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0306030852380.24147-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 03 June 2003 01:03, Clemmens Ladisch wrote:
> > CHANNELS: 1
> > ...
>
> Are you sure that the Optoplay supports _one_-channel output?
>
That's a good question - I'll try a stereo WAV later this evening after I=
 get=20
off work.

> Please post the contents of /proc/asound/cardX/stream0 and the output o=
f
> "lsusb -v".
>
/proc/asound/OptoPlay/stream0:

Ego Systems Inc. AUDIOTRAK OptoPlay at usb-00:07.2-1 : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 32000, 44100, 48000, 64000, 88200, 96000
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 32000, 44100, 48000, 64000, 88200, 96000


lsusb -v:

Bus 001 Device 001: ID 0000:0000 =20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x0000=20
  idProduct          0x0000=20
  bcdDevice            0.00
  iManufacturer           0=20
  iProduct                2 USB UHCI Root Hub
  iSerial                 1 1400
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=3D4)
     0000 (null)((null))

Bus 001 Device 002: ID 0a92:0053 EGO SYStems, Inc.=20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x0a92 EGO SYStems, Inc.
  idProduct          0x0053=20
  bcdDevice            1.00
  iManufacturer           1 Ego Systems Inc.
  iProduct                2 AUDIOTRAK OptoPlay
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          201
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0=20
      iInterface              0=20
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           40
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
        iChannelNames           0=20
        iTerminal               0=20
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               1
        bControlSize            1
        bmaControls( 0)      0x00
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 0)      0x03
          Mute
          Volume
        iFeature                0=20
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            6 Discrete
        tSamFreq[ 0]        32000
        tSamFreq[ 1]        44100
        tSamFreq[ 2]        48000
        tSamFreq[ 3]        64000
        tSamFreq[ 4]        88200
        tSamFreq[ 5]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        384
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
      bInterfaceProtocol      0=20
      iInterface              0=20
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            6 Discrete
        tSamFreq[ 0]        32000
        tSamFreq[ 1]        44100
        tSamFreq[ 2]        48000
        tSamFreq[ 3]        64000
        tSamFreq[ 4]        88200
        tSamFreq[ 5]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        576
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
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0=20
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      42
=09  Report Descriptor: (length is 42)
            Item(Global): Usage Page, data=3D [ 0xa0 0xff ] 65440
                            (null)
            Item(Local ): Usage, data=3D [ 0x01 ] 1
                            (null)
            Item(Main  ): Collection, data=3D [ 0x01 ] 1
                            Application
            Item(Local ): Usage, data=3D [ 0x01 ] 1
                            (null)
            Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Logical Maximum, data=3D [ 0xff 0x00 ] 255
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x08 ] 8
            Item(Main  ): Input, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile=
=20
Bitfield
            Item(Local ): Usage, data=3D [ 0x02 ] 2
                            (null)
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x08 ] 8
            Item(Main  ): Output, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile=
=20
Bitfield
            Item(Local ): Usage, data=3D [ 0x03 ] 3
                            (null)
            Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
            Item(Global): Logical Maximum, data=3D [ 0xff 0x00 ] 255
            Item(Global): Report Size, data=3D [ 0x08 ] 8
            Item(Global): Report Count, data=3D [ 0x08 ] 8
            Item(Main  ): Feature, data=3D [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile=
=20
Bitfield
            Item(Main  ): End Collection, data=3Dnone
  Language IDs: (length=3D4)
     0409 English(US)



BTW: Is there any documentation available that explains what all these
fields mean?
-Ross



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
