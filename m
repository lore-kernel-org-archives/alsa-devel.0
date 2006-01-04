From: Christoph Richter <prof.toph@gmail.com>
Subject: Better support for new USB Condenser Microphone: Samson C01U
Date: Wed, 4 Jan 2006 20:16:24 +0100
Message-ID: <d9db0b190601041116u52f65998t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I recently bought this microphone:
http://www.samsontech.com/products/productpage.cfm?prodID=3D1810&brandID=3D=
2
and have been quite pleased to see that it kind of works with alsa
(snd-usb-audio). I've only been puzzled by a few oddities: Although
the mic is mono, I get a stereo input with 2 controls, which did even
influence the sound on both channels separatly, but in a not-so-clear
way.

Since neither the windows, nor the OSX usb-audio driver are able to
fully control the device, especially the internal gain-control, Samson
has published a modified driver & tool to control such parameters. I
have investigated that tool with an usb-traffic sniffer (usbsnoop).

I did also do some experiments with the alsa driver to see, what the
controls really do and how the device might be designed internally. I
have found out about everything needed to make the device fully
supported, I just don't really know how to implement it, so I'm hoping
someone will guide and help me. Although I'd really like to, I'm not a
kernel hacker.

What I basically want to do is remap and rename the mixer-controls and
output-lines alsa exposes. Is that what  usbquirks.h and
usbmixer_maps.c are for?

Details about the device and my findings follow below:

----lsusb -v

Bus 002 Device 002: ID 17a0:0001
Device Descriptor:
  bLength 18
  bDescriptorType 1
  bcdUSB 1.10
  bDeviceClass 0 (Defined at Interface level)
  bDeviceSubClass 0
  bDeviceProtocol 0
  bMaxPacketSize0 8
  idVendor 0x17a0
  idProduct 0x0001
  bcdDevice 0.01
  iManufacturer 1 Samson Technologies
  iProduct 2 Samson C01U
  iSerial 0
  bNumConfigurations 1
  Configuration Descriptor:
    bLength 9
    bDescriptorType 2
    wTotalLength 177
    bNumInterfaces 2
    bConfigurationValue 1
    iConfiguration 0
    bmAttributes 0x80
    MaxPower 90mA
    Interface Descriptor:
      bLength 9
      bDescriptorType 4
      bInterfaceNumber 0
      bAlternateSetting 0
      bNumEndpoints 0
      bInterfaceClass 1 Audio
      bInterfaceSubClass 1 Control Device
      bInterfaceProtocol 0
      iInterface 0
      AudioControl Interface Descriptor:
        bLength 9
        bDescriptorType 36
        bDescriptorSubtype 1 (HEADER)
        bcdADC 1.00
        wTotalLength 40
        bInCollection 1
        baInterfaceNr( 0) 1
      AudioControl Interface Descriptor:
        bLength 12
        bDescriptorType 36
        bDescriptorSubtype 2 (INPUT_TERMINAL)
        bTerminalID 1
        wTerminalType 0x0201 Microphone
        bAssocTerminal 2
        bNrChannels 2
        wChannelConfig 0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames 0
        iTerminal 0
      AudioControl Interface Descriptor:
        bLength 9
        bDescriptorType 36
        bDescriptorSubtype 3 (OUTPUT_TERMINAL)
        bTerminalID 2
        wTerminalType 0x0101 USB Streaming
        bAssocTerminal 1
        bSourceID 3
        iTerminal 0
      AudioControl Interface Descriptor:
        bLength 10
        bDescriptorType 36
        bDescriptorSubtype 6 (FEATURE_UNIT)
        bUnitID 3
        bSourceID 1
        bControlSize 1
        bmaControls( 0) 0x01
          Mute
        bmaControls( 1) 0x02
          Volume
        bmaControls( 2) 0x02
          Volume
        iFeature 0
    Interface Descriptor:
      bLength 9
      bDescriptorType 4
      bInterfaceNumber 1
      bAlternateSetting 0
      bNumEndpoints 0
      bInterfaceClass 1 Audio
      bInterfaceSubClass 2 Streaming
      bInterfaceProtocol 0
      iInterface 0
    Interface Descriptor:
      bLength 9
      bDescriptorType 4
      bInterfaceNumber 1
      bAlternateSetting 1
      bNumEndpoints 1
      bInterfaceClass 1 Audio
      bInterfaceSubClass 2 Streaming
      bInterfaceProtocol 0
      iInterface 0
      AudioStreaming Interface Descriptor:
        bLength 7
        bDescriptorType 36
        bDescriptorSubtype 1 (AS_GENERAL)
        bTerminalLink 2
        bDelay 1 frames
        wFormatTag 1 PCM
      AudioStreaming Interface Descriptor:
        bLength 23
        bDescriptorType 36
        bDescriptorSubtype 2 (FORMAT_TYPE)
        bFormatType 1 (FORMAT_TYPE_I)
        bNrChannels 1
        bSubframeSize 2
        bBitResolution 16
        bSamFreqType 5 Discrete
        tSamFreq[ 0] 8000
        tSamFreq[ 1] 11025
        tSamFreq[ 2] 22050
        tSamFreq[ 3] 44100
        tSamFreq[ 4] 48000
      Endpoint Descriptor:
        bLength 9
        bDescriptorType 5
        bEndpointAddress 0x81 EP 1 IN
        bmAttributes 5
          Transfer Type Isochronous
          Synch Type Asynchronous
          Usage Type Data
        wMaxPacketSize 0x0064 1x 100 bytes
        bInterval 1
        bRefresh 0
        bSynchAddress 0
        AudioControl Endpoint Descriptor:
          bLength 7
          bDescriptorType 37
          bDescriptorSubtype 1 (EP_GENERAL)
          bmAttributes 0x01
            Sampling Frequency
          bLockDelayUnits 0 Undefined
          wLockDelay 0 Undefined
    Interface Descriptor:
      bLength 9
      bDescriptorType 4
      bInterfaceNumber 1
      bAlternateSetting 2
      bNumEndpoints 1
      bInterfaceClass 1 Audio
      bInterfaceSubClass 2 Streaming
      bInterfaceProtocol 0
      iInterface 0
      AudioStreaming Interface Descriptor:
        bLength 7
        bDescriptorType 36
        bDescriptorSubtype 1 (AS_GENERAL)
        bTerminalLink 2
        bDelay 1 frames
        wFormatTag 1 PCM
      AudioStreaming Interface Descriptor:
        bLength 23
        bDescriptorType 36
        bDescriptorSubtype 2 (FORMAT_TYPE)
        bFormatType 1 (FORMAT_TYPE_I)
        bNrChannels 2
        bSubframeSize 2
        bBitResolution 16
        bSamFreqType 5 Discrete
        tSamFreq[ 0] 8000
        tSamFreq[ 1] 11025
        tSamFreq[ 2] 22050
        tSamFreq[ 3] 44100
        tSamFreq[ 4] 48000
      Endpoint Descriptor:
        bLength 9
        bDescriptorType 5
        bEndpointAddress 0x81 EP 1 IN
        bmAttributes 5
          Transfer Type Isochronous
          Synch Type Asynchronous
          Usage Type Data
        wMaxPacketSize 0x00c8 1x 200 bytes
        bInterval 1
        bRefresh 0
        bSynchAddress 0
        AudioControl Endpoint Descriptor:
          bLength 7
          bDescriptorType 37
          bDescriptorSubtype 1 (EP_GENERAL)
          bmAttributes 0x01
            Sampling Frequency
          bLockDelayUnits 0 Undefined
          wLockDelay 0 Undefined


----registered as:

ALSA sound/usb/usbaudio.c:2626: 2:1:1: add audio endpoint 0x81
ALSA sound/usb/usbaudio.c:2626: 2:1:2: add audio endpoint 0x81
ALSA sound/usb/usbmixer.c:920: [3] FU [Mic Capture Switch] ch =3D 1, val =
=3D 0/1/1
ALSA sound/usb/usbmixer.c:393: cannot set ctl value: req =3D 0x4, wValue
=3D 0x201, wIndex =3D 0x300, type =3D 4, data =3D 0x80/0x0
ALSA sound/usb/usbmixer.c:920: [3] FU [Mic Capture Volume] ch =3D 2, val
=3D -7936/6144/256

----cat /proc/asound/card1/stream0

Samson Technologies Samson C01U at usb-0000:00:01.3-1, full : USB Audio

Capture:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 1
    Endpoint: 1 IN (ASYNC)
    Rates: 8000, 11025, 22050, 44100, 48000
  Interface 1
    Altset 2
    Format: S16_LE
    Channels: 2
    Endpoint: 1 IN (ASYNC)
    Rates: 8000, 11025, 22050, 44100, 48000

-----Samson's SoftPre-tool:

Samson has published a modified driver and the so called SoftPre-Applet.
The tool has 3 control elements: A knob for the low-cut-frequency, a
button for Phase-invert and a Gain-slider.
The usbsnoopy-session made it obvious, that only the Gain-setting is a
hardware-feature, since none of the other controls did produce any
traffic.

The usb traffic-log reveals that SoftPre uses both volume controls
(Left+Right) to set the desired gain value (-62dB - +48dB). The scale
is as follows:

wValue: 201, 202 (aka 'Mic Capture Volume Left/Right') gain
data: 80 00 80 00 =3D mute?
    80 00 E2 00 =3D -62dB
        ...
    80 00 FF 00
    E1 00 00 00
    ...
    FF 00 00 00
    00 00 00 00 =3D 0dB ?
    01 00 00 00
    ...
    17 00 00 00
    7f ff 00 00
    7f ff 01 00
        ...
    7f ff 18 00 =3D 48dB

Since the volume-controls register as
    [Mic Capture Volume] ch =3D 2, val =3D -7936/6144/256
ALSA reaches 0xE100 - 0x1800 on both controls anyway. The only thing I
don't get is if the 0x8000/0x7fff SoftPre sets the left control to do
have any effect.

>From experimenting with the normal vol-left/right controls, alsa
exposes, I have the fealing that each of them controls its own
Gain-stage, although the right one (0x202) does seem more like a
poti/damper, because you cannot get any signal to distort or clip with
it. I also noticed that the right and left channel are mutually
phase-inverted.

[Mic IN] ------->[0x202(Poti/Gain)]+------------------->[altset:2,Right-cha=
nnel]
                                                    |
                                                 =20
+--[0x201(GAIN)]---->[altset:2,Left-channel] =3D [altset:1(mono)]

Alsa selects which altset to use depending on what format you request.
E.g. if I start jackd with 1 input channel only, altset1 is selected
and I get the post_gain-signal as alsapcm:capture_1. If I request 2
input channels altset2 gets chosen and I get the post_gain-signal on
alsapcm:capture_1 and pre_gain-signal on alsapcm:capture_2.
The output of altset2/Left is identical to altset1.


So for Samson's C01U to be correctly handled by ALSA, 2 things have to be d=
one:
        1) either a) Give the 2 Volume-Controls descriptive names
(left -> gain; right -> volume)
               or b) Create 1 'virtual' control, that mimicks the
behaviour of Samson's SoftPre-Applet (described above)

        2) either a) make both (altset2-) 'stereo' streams available
seperatly with descriptive names (right -> pre-Gain; left ->
post-Gain)
               or b) make altset1 the only output, after all that's
what you paid for.

A small advantage of having the pre-Gain signal available is that the
signal might be cleaner having passed only 1 gain stage. Another nice
thing is that each output would have an associated control (implying
1a and 2a).
Nonetheless this device is just a simple microphone and I guess most
people would prefer to leave the setup as simple as possible, which is
1 control and 1 (mono) output.

How can either possibility be implemented into snd-usb-audio?

Thanks for your interest,

    Toph


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
