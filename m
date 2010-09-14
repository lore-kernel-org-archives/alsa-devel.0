From: Krzysztof Foltman <wdev@foltman.com>
Subject: need help diagnosing USB MIDI latency problem with
	MPD16
Date: Wed, 15 Sep 2010 00:36:56 +0100
Message-ID: <4C900718.3010509@foltman.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000706000002020802030406"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpoproxy3-pub.bluehost.com (cpoproxy3-pub.bluehost.com
	[67.222.54.6]) by alsa0.perex.cz (Postfix) with SMTP id 29F0F10388B
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 01:37:00 +0200 (CEST)
Received: from [188.141.103.78] (helo=[192.168.1.12])
	by box517.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <wdev@foltman.com>) id 1Ovf3a-0007V4-Gc
	for alsa-devel@alsa-project.org; Tue, 14 Sep 2010 17:36:59 -0600
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000706000002020802030406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  Hello,

Some time ago, I wrote the Akai MPD16 protocol handlers (input/output) 
for the USB MIDI driver. Unfortunately, the kernel driver seems to 
suffer from a rather embarrassing input latency, it looks like the MIDI 
event timing granularity is >100ms (so the latency is variable, making 
the pad practically useless except if a rhythm is played with the rate 
matching the polling rate!). At the same time, a simple Python based 
contraption using libusb and bulkRead in a while loop, gets much better 
results. The same USB MIDI driver in the same kernel and PC doesn't have 
noticeable problems with class-compliant E-Mu Xboard25 connected to the 
same USB port.

Both devices use endpoints in bulk mode. I've attached the excerpts of 
lsusb -v output for both devices - the only differences are:

1) the Akai device isn't class compliant,
2) the E-mu device has one pair of inputs/outputs, the Akai has two 
(control/configuration and MIDI proper)
3) the maximum packet length is 32 for E-mu, 64 for Akai.

When I enabled logging in midi.c (#define DUMP_PACKETS), it looks like 
the device is returning data packets rather infrequently, as a single 
packet often contains multiple events (up to 3) when two pads are 
pressed in rapid succession. So, it looks like a problem outside of my 
snd_usbmidi_akai_input.

One thing that *does* help, though, is disabling the 'control' port by 
adding endpoints[0].in_cables = 0; in Akai quirk handling in 
snd_usbmidi_create - when input from the control port is not polled, the 
choppiness disappears completely. I'm guessing that the device itself 
(or something in between) has some problems having to handle the URBs 
for both endpoints, and that perhaps the IN/NAK exchange on a "control" 
endpoint causes the device's microcontroller (or something else?) to 
stall for a while. However, in that case, a proper solution (one that 
doesn't involve sacrificing the ability to use control port for 
configuration) would involve submitting URBs for the control input 
endpoint only when control port is open on ALSA side, and cancelling 
them when the port is closed. However, that sounds pretty invasive.

Any hints? The device in question is rather uncommon and hasn't been 
supported for a while, so refactoring the whole USB MIDI driver to 
accommodate it doesn't sound like a great idea - but still, the latency 
thing sucks pretty bad for a drumming-oriented device!

Thanks in advance,
Krzysztof


--------------000706000002020802030406
Content-Type: text/plain;
 name="xboard.usb"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xboard.usb"

Bus 005 Device 003: ID 041e:3f00 Creative Technology, Ltd 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x041e Creative Technology, Ltd
  idProduct          0x3f00 
  bcdDevice            0.47
  iManufacturer           1 E-MU Systems, Inc.
  iProduct                2 E-MU Xboard25
  iSerial                 3 E-MU-62-3F00-07D60505-90185-98
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          101
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower              250mA
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
        wTotalLength            9
        bInCollection           1
        baInterfaceNr( 0)       1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 MIDI Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      MIDIStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           37
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 1
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 2
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                 3
        bNrInputPins            1
        baSourceID( 0)          2
        BaSourcePin( 0)         1
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                 4
        bNrInputPins            1
        baSourceID( 0)          1
        BaSourcePin( 0)         1
        iJack                   0 
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       1
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       3
Device Status:     0x0000
  (Bus Powered)


--------------000706000002020802030406
Content-Type: text/plain;
 name="akai.usb"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="akai.usb"

Bus 005 Device 006: ID 09e8:0062 AKAI  Professional M.I. Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x09e8 AKAI  Professional M.I. Corp.
  idProduct          0x0062 
  bcdDevice            1.00
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           46
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          3 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           4
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol    255 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1


--------------000706000002020802030406
Content-Type: text/x-python;
 name="akai.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="akai.py"

import usb
import alsaseq

mpd16 = None

idVendor = 0x09e8
idProduct = 0x0062

for bus in usb.busses():
    for device in bus.devices:
        if device.idVendor == idVendor and device.idProduct == idProduct:
            mpd16 = device
            break

if mpd16 is None:
    raise ValueError, "No MPD16 found"

conf = mpd16.configurations[0]
iface = conf.interfaces[0][0]

midiept = None
for ept in iface.endpoints:
    if ept.address == 0x82:
        midiept = ept
        break
if midiept is None:
    raise ValueError, "MIDI endpoint not found"
    
dev = mpd16.open()
dev.setConfiguration(mpd16.configurations[0])
dev.claimInterface(0)
dev.setAltInterface(0)
#dev.reset()

#print "MPD16", dir(mpd16)
#print "Config", dir(conf)
#print "Iface", dir(iface)
#print dev.getString(2, 200)
#print midiept.maxPacketSize
alsaseq.client("MPD16", 0, 1, False)
while True:
    data = dev.bulkRead(midiept.address, midiept.maxPacketSize, 0)
    if len(data) == 2:
        continue
    pos = 0
    while pos < len(data):
        elen = data[pos] - 32
        edata = data[pos + 1 : pos + 1 + elen]
        channel = edata[0] & 0x0F
        if edata[0] >= 0x90 and edata[0] <= 0x9F:
            if edata[2] > 0:
                alsaseq.output( (alsaseq.SND_SEQ_EVENT_NOTEON, 1, 0, 253, (0, 0), (0, 0), (0, 0), (channel, edata[1], edata[2], 0, 0)))
            else:
                alsaseq.output( (alsaseq.SND_SEQ_EVENT_NOTEOFF, 1, 0, 253, (0, 0), (0, 0), (0, 0), (channel, edata[1], 0, 0, 0)))
        if edata[0] >= 0xA0 and edata[0] <= 0xAF:
            alsaseq.output( (alsaseq.SND_SEQ_EVENT_KEYPRESS, 1, 0, 253, (0, 0), (0, 0), (0, 0), (channel, edata[1], edata[2], 0, 0)))
        if edata[0] >= 0xB0 and edata[0] <= 0xBF:
            alsaseq.output( (alsaseq.SND_SEQ_EVENT_CONTROLLER, 1, 0, 253, (0, 0), (0, 0), (0, 0), (channel, 0, 0, 0, edata[1], edata[2])))
        pos += 1 + elen
dev.releaseInterface()

--------------000706000002020802030406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000706000002020802030406--
