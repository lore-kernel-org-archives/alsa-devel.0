From: mark@undertone.org
Subject: Re: testers for SB Extigy wanted
Date: Fri, 11 Oct 2002 10:35:19 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021011153518.GB32132@undertone.org>
References: <s5hlm55ciee.wl@alsa2.suse.de> <20021011141312.GA31835@undertone.org> <s5hbs61cazj.wl@alsa2.suse.de> <20021011143659.GA31907@undertone.org> <s5h8z15c8uq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+g7M9IMkV8truYOl"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8z15c8uq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2002 at 05:07:25PM +0200, Takashi Iwai wrote:
> > Here is everything syslog spits out at me when I start up alsa (the
> > cant locate module stuff is obviously nothing, along with one or two
> > other things, but I'll leave them in for completeness sake):
> > 
> > Oct 11 09:30:39 atrophy kernel: PCI: Found IRQ 10 for device 00:08.0
> > Oct 11 09:30:39 atrophy kernel: usb.c: registered new driver snd-usb-audio
> > Oct 11 09:30:40 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1662: 4:1:2 : unsupported format type 0
> 
> this should be harmless.  just ignored a bogus descriptor.
> to be sure, could you send the output of "lsusb -v" for this device?

This is fairly long, so I have it included as an attachment.

> so far, all looks good.
> 
> just try to start "alsamixer -c1" and unmute the switch and change the
> volume as you like.
> you can play via hw:1,0 pcm (you might need to use plughw:1,0
> instead), for example,
> 
> 	% aplay -Dplughw:1,0 foo.wav
> 
> and for capture
> 
> 	% arecord -Dplughw:1,0 -fcd bar.wav

I'd love to do this, but:

atrophy:/etc/modutils# amixer -c1
amixer: Mixer load error: hw:1
atrophy:/etc/modutils# alsamixer -c1

alsamixer: function snd_mixer_load failed: Invalid argument
atrophy:/etc/modutils# 

> and /dev/dsp1 is the OSS device for Extigy (available only if you load
> snd-pcm-oss module).

Hmm, when I load snd-mixer-oss and snd-pcm-oss, only /dev/dsp appears as a compatibility link to sound/dsp. Sound (which im guessing is the oss stuff in the dev tree) has:

mark@atrophy:/dev/sound$ ls -l
total 0
crw-rw----    1 root     audio     14,   4 Dec 31  1969 audio
crw-rw----    1 root     audio     14,  10 Dec 31  1969 dmfm
crw-rw----    1 root     audio     14,   9 Dec 31  1969 dmmidi
crw-rw----    1 root     audio     14,   3 Dec 31  1969 dsp
crw-rw----    1 root     audio     14,   2 Dec 31  1969 midi00
crw-rw----    1 root     audio     14,   0 Dec 31  1969 mixer
crw-rw----    1 root     audio     14,  18 Dec 31  1969 unknown

Which I guess makes sense since oss only supports one audio card and I
have two . . .

> if the above doesn't work (or even if it works), please send me the
> output of /proc/asound/card1/stream* files. 
> this contains the supported formats on the device.

There is only a stream0:

atrophy:/proc/asound/card1# more stream0 
Creative Technology Ltd. : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000
  Interface 2
    Altset 2
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 16000
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 24000
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 32000
  Interface 2
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 48000

> to the MIDI devices, you can access either via ALSA sequencer or via
> a rawmidi device file /dev/snd/midiC1D0 (or midiC1D1), which is
> equivalent with OSS midi device, /dev/midi01 (or amidi01).

The two devices popping up seem consistant with the hardware, it has a
midi in/out (no thru).

> but please note that here MIDI means not the MIDI wavetable playback.
> apparently Extigy has _no_ wavetable function at all.
> they are connectors to external MIDI devices.

Thats ok, wavetables suck. I'd rather hook up my own bank via midi, heh.

> and finally, if the above works properly, please check what mixer
> element corresponds to which role (as i asked in my original post).
> you can see the mixer topology and each mixer element in
> usbmixer_maps.c.

As shown above, amixer doesnt want to fire up. I hate to do it, but
here is a wishlist:

- have the volume knob on the front of the device work 
- be able to turn "cmss" on and off either via the controling client or on
  the hardware itself. (its a dsp that fakes surround sound fairly well).
- be able to control the output detection of the unit. apparently it
  can tell if you have 2, 4, or 5 speakers hooked up into it. the option
  can certainly be automatic (testable when i unplug the card and use it
  as a standalone), and I'm fairly certain it can be forced as well (as
  evidenced in windows). When I was able to use the hardware with the 
  current rc release of alsa, it forced 2 speaker selection.
- the remote ir stuff is cute but not really essential -- would be nice to 
  have hooks to attach triggers to or something.

It's a really tall list, but its just so know where I'm comming from
and where I ultimately want to head with it. I'm more than happy to
help you take me as far you're willing =p

thanks,
-mark


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsusb-out.txt"


Bus 001 Device 004: ID 041e:3000 Creative Labs 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x041e Creative Labs
  idProduct          0x3000 
  bcdDevice            1.00
  iManufacturer           1 Creative Technology Ltd.
  iProduct                2 Sound Blaster Extigy
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength         1701
    bNumInterfaces          5
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
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength          410
        bInCollection           4
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
        baInterfaceNr( 2)       3
        baInterfaceNr( 3)       4
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
        bLength                21
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               1
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             3
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
        bTerminalID             4
        wTerminalType      0x0602 Digital Audio Interface
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
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 5
        bNrInPins               2
        baSource( 0)            3
        baSource( 1)            4
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                21
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID               5
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             7
        wTerminalType      0x0603 Line Connector
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
        bUnitID                 8
        bSourceID               7
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             9
        wTerminalType      0x0201 Microphone
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
        bUnitID                10
        bSourceID               9
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                11
        bNrInPins               3
        baSource( 0)            7
        baSource( 1)            9
        baSource( 2)           17
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                12
        bSourceID              11
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID              12
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                14
        bNrInPins               2
        baSourceID( 0)          8
        baSourceID( 1)          6
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
        junk at descriptor end: 00 00 00 00
      AudioControl Interface Descriptor:
        bLength                15
        bDescriptorType        36
        bDescriptorSubtype      7 (PROCESSING_UNIT)
        bUnitID                15
        wProcessType            3
        bNrPins                 1
        baSourceID( 0)         14
        bNrChannels             5
        wChannelConfig     0x0037
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        bControlSize            1
        bmControls( 0)       0x01
          Enable Processing
        iProcessing             0 
        Process-Specific    
      AudioControl Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                16
        bNrInPins               4
        baSourceID( 0)          2
        baSourceID( 1)          6
        baSourceID( 2)         15
        baSourceID( 3)         10
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
        junk at descriptor end: 00 00 00 00 00 00 00 00 00
      AudioControl Interface Descriptor:
        bLength                30
        bDescriptorType        36
        bDescriptorSubtype      7 (PROCESSING_UNIT)
        bUnitID                17
        wProcessType            1
        bNrPins                 1
        baSourceID( 0)         16
        bNrChannels             6
        wChannelConfig     0x003f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        bControlSize            1
        bmControls( 0)       0x03
          Enable Processing
        iProcessing             0 
        Process-Specific     07 03 00 03 00 0b 00 33 00 3b 00 37 00 3f 00
      AudioControl Interface Descriptor:
        bLength                21
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                18
        bSourceID              17
        bControlSize            2
        bmaControls( 0)      0x17
        bmaControls( 1)      0x00
          Mute
          Volume
          Bass
          Treble
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                15
        bDescriptorType        36
        bDescriptorSubtype      8 (EXTENSION_UNIT)
        bUnitID                27
        wExtensionCode          0
        bNrPins                 1
        baSourceID( 0)         18
        bNrChannels             6
        wChannelConfig         63
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        bControlSize            1
        bmControls( 0)       0x01
          Enable Processing
        iExtension              0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                28
        bSourceID              27
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            19
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              28
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            20
        wTerminalType      0x0302 Headphones
        bAssocTerminal          0
        bSourceID              18
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                15
        bDescriptorType        36
        bDescriptorSubtype      8 (EXTENSION_UNIT)
        bUnitID                21
        wExtensionCode          0
        bNrPins                 1
        baSourceID( 0)         27
        bNrChannels             6
        wChannelConfig         63
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        bControlSize            1
        bmControls( 0)       0x01
          Enable Processing
        iExtension              0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                22
        bSourceID              21
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                23
        bSourceID              22
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            24
        wTerminalType      0x0602 Digital Audio Interface
        bAssocTerminal          0
        bSourceID              23
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                25
        bSourceID              22
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            26
        wTerminalType      0x0602 Digital Audio Interface
        bAssocTerminal          0
        bSourceID              25
        iTerminal               0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              10
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
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
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
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        200
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
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
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             3
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        22050
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        102
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             5
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        22050
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        126
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             5
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        22050
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        198
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             6
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        22050
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        174
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       6
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             6
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        22050
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        246
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       7
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             3
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        190
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       8
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             5
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        236
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       9
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             5
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        374
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      10
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             6
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        328
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      11
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              0 TYPE_I_UNDEFINED
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             6
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        466
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
  descriptor length past end: 09 04 01 0c 02 01 02 00
  Language IDs: (length=4)
     0409 English(US)

--+g7M9IMkV8truYOl--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
