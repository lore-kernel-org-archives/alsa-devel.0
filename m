From: Grant Diffey <gdiffey@gmail.com>
Subject: Small Regression in midi for M-Audio Fast Track Ultra.
Date: Sat, 16 Apr 2011 12:29:06 +1000
Message-ID: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 05B3E1037F3
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Apr 2011 04:29:06 +0200 (CEST)
Received: by eyg5 with SMTP id 5so962531eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 19:29:06 -0700 (PDT)
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

In 2.6.33/34 when support originally was put in alsa mainline the MIDI ports
were functional today they're not for me and I get the following in the
kernel log when using this card. (Audio all works acceptably.)

[ 1846.736062] usb 2-1: new high speed USB device using ehci_hcd and address
4
[ 1846.869790] usb 2-1: config 1 interface 3 altsetting 0 bulk endpoint 0x7
has invalid maxpacket 8
[ 1846.869802] usb 2-1: config 1 interface 3 altsetting 0 bulk endpoint 0x87
has invalid maxpacket 8
[ 1846.870897] usb 2-1: New USB device found, idVendor=0763, idProduct=2080
[ 1846.870905] usb 2-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[ 1846.870912] usb 2-1: Product: Fast Track Ultra
[ 1846.870917] usb 2-1: Manufacturer: M-Audio

This issue may be unrelated to the data below but it's included in case it's
useful.

The midi port is interface 3 and has a comment in quirk-table.h like this

                        /* interface 3 (MIDI) is standard compliant */
                        {
                               .ifnum = -1
                        }

Which is as I understand it a noop to the quirk stuff so that it just get's
processed normally. Which could also be completely wrong.

I've verified in lsusb -v of the midi interface (3) of the card is below
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 MIDI Streaming
      bInterfaceProtocol      0
      iInterface              5
      MIDIStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           63
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
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
      Warning: Descriptor too short
        bJackType               1 Embedded
        bJackID                 3
        bNrInputPins            1
        baSourceID( 0)          2
        BaSourcePin( 0)         1
        iJack                   8
      MIDIStreaming Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
      Warning: Descriptor too short
        bJackType               2 External
        bJackID                 4
        bNrInputPins            1
        baSourceID( 0)          1
        BaSourcePin( 0)         1
        iJack                  97
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               8
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       3
