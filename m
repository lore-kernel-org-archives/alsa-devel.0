From: "Kalvas, Taneli" <taneli.v.m.kalvas@jyu.fi>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Mon, 9 Mar 2015 19:22:33 +0000
Message-ID: <6A72E9C91650BD49A6D9B305755BC04C42D8067A@mbs1.ad.jyu.fi>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>,
 <54FD5D4C.3040204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from posti5.jyu.fi (posti5.jyu.fi [130.234.4.34])
 by alsa0.perex.cz (Postfix) with ESMTP id E1B632610A3
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 20:22:36 +0100 (CET)
In-Reply-To: <54FD5D4C.3040204@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> writing to the midi port with snd_rawmidi_write() seems to broken. The
>> function accepts any size of data block and claims to have sent
>> everything. In reality only a part of the message is sent.
>>
>> My hardware is Miditech Midiface 4x4, a USB midi interface:
>>  1 [MIDI4x4        ]: USB-Audio - MIDI4x4
>>                       MIDIPLUS MIDI4x4 at usb-0000:00:14.0-1, full speed
>
> snd_rawmidi_write() never accepts more data than it can handle (in
> blocking mode, it waits until the buffer is empty enough).  The
> snd-usb-audio driver waits until the device has accepted the data.
> 
> Are there any messages in the system log when this happens?

There is nothing in the logs.

> Please show the output of "lsusb -d 1acc:1a0b -v".

$ sudo lsusb -d 1acc:1a0b -v

Bus 003 Device 003: ID 1acc:1a0b  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        16
  idVendor           0x1acc 
  idProduct          0x1a0b 
  bcdDevice            1.01
  iManufacturer           1 MIDIPLUS
  iProduct                2 MIDI4x4
  iSerial                 3 MIDIPLUS-BC-1A0B-07DA0908-MIDI4x4
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          197
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
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
        wTotalLength          155
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 1
        iJack                   4 Midi Out 1
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 2
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 5
        iJack                   6 Midi Out 2
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 6
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                 9
        iJack                   8 Midi Out 3
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                10
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                13
        iJack                  10 Midi Out 4
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                14
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
        iJack                   5 Midi In 1
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
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                 7
        bNrInputPins            1
        baSourceID( 0)          6
        BaSourcePin( 0)         1
        iJack                   7 Midi In 2
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                 8
        bNrInputPins            1
        baSourceID( 0)          5
        BaSourcePin( 0)         1
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                11
        bNrInputPins            1
        baSourceID( 0)         10
        BaSourcePin( 0)         1
        iJack                   9 Midi In 3
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                12
        bNrInputPins            1
        baSourceID( 0)          9
        BaSourcePin( 0)         1
        iJack                   0 
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                15
        bNrInputPins            1
        baSourceID( 0)         14
        BaSourcePin( 0)         1
        iJack                  11 Midi In 4
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                16
        bNrInputPins            1
        baSourceID( 0)         13
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
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         4
          baAssocJackID( 0)       1
          baAssocJackID( 1)       5
          baAssocJackID( 2)       9
          baAssocJackID( 3)      13
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         4
          baAssocJackID( 0)       3
          baAssocJackID( 1)       7
          baAssocJackID( 2)      11
          baAssocJackID( 3)      15
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled

>> I have tested the system by connecting the output port to an input
>> port on the hardware and having another program output the received
>> bytes on stdout. My observations:
>> - As long as the buffer size is 276 bytes or less it gets sent ok
>> - Larger buffer sizes cause corruption and roughly 300 bytes of received.
> 
> This sounds as if the device has a buffer size of 256 bytes, but does
> not actually check if the buffer is full, and always accepts more data.
> 
> Does later data overwrite data that should have been sent earlier?

By looking at the receiving end bytes it looks exactly like that has happened.

>> Is there a way to connect two programs via a virtual RawMIDI port so
>> that I could test without using the hardware?
> 
> Load the snd-virmidi module, and connect two of its ports with aconnect.

I did this and by using the virtual ports the behaviour is more reasonable, but still not as expected. Everything works ok as long as the message length is less than or equal to the buffer size (4096). With message sizes larger than that the writing end still claims it has sent everything, as it should do because the port is opened in blocking mode. On the reading end I can see that some data is missing and xruns are reported.
