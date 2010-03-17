From: Felix Homann <fexpop@web.de>
Subject: Re: How to create an Alsa mixer for a USB device w/o
 mixer descriptor?
Date: Wed, 17 Mar 2010 12:47:46 +0100
Message-ID: <4BA0C162.5090606@web.de>
References: <4BA094B9.8010907@web.de>
	<20100317112804.GB30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060503030600080700040101"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id B519A10381A
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 12:47:47 +0100 (CET)
In-Reply-To: <20100317112804.GB30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060503030600080700040101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Mack schrieb:
> Does that mean it doesn't export _any_ descriptors for that? Or just not
> output terminal?
>
>   

As far as I can tell, there really is no descriptor for a mixer device 
or similar. Please, see the attached output of lsusb -v. (The device is 
mostly working with QUIRK_AUDIO_STANDARD_INTERFACE quirks. )

Although I posted it before, you might take a look at my findings in the 
attached  reverse-engineering-...txt file. I didn't know anything about 
Audio Class devices when I gathered that information, and digged only a 
bit deeper by now. For me, it seems that the device is actually operated 
like an ordinary USB mixer (v1).

> Check out the latest USB audio sources from the ALSA git - they have
> been undergoing a major refactoring lately.
>   

I already have. Many thanks for your refactoring. Before that, I didn't 
have the slightest idea of what's going on. It's much, much cleaner now!!!

> Thinking about what you're trying to achieve, I think at least one way
> to go is to implement a new function ('handle_audio_mixer_unit_quirks'
> for example) in sound/usb/mixer_quirks.c and call it from
> snd_usb_create_mixer(). The function would need to return a static fake
> descriptor, hard-coded in mixer_quirks.c. Now that the driver works with
> structs for descriptors, that shouldn't be hard to do.
>   

OK, I'll try to work my way through the sources. Although it's probably 
not too hard for someone familiar with Alsa and USB devices, it might 
take some time for me ;-)
> One thing to pay attention to is that this fake descriptor must not have
> any references to other entities or descriptors of the device unless you
> take care for them, too. In particular, you would need to add a hook to
> snd_usb_copy_string_descriptor() if you want to give your controls a
> name.
>
>   

Thank you very much  for your comments!


Kind regards,

Felix

--------------060503030600080700040101
Content-Type: text/plain;
 name="lsusb-ftu8r-1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsusb-ftu8r-1.txt"


Bus 001 Device 003: ID 0763:2081 Midiman M-Audio RunTime DFU
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x0763 Midiman
  idProduct          0x2081 M-Audio RunTime DFU
  bcdDevice            1.51
  iManufacturer           1 M-Audio
  iProduct                2 Fast Track Ultra 8R
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          340
    bNumInterfaces          5
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         5
      bFunctionClass        255 Vendor Specific Class
      bFunctionSubClass       1 
      bFunctionProtocol       0 
      iFunction               2 Fast Track Ultra 8R
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1 
      bInterfaceProtocol      0 
      iInterface              2 Fast Track Ultra 8R
      ** UNRECOGNIZED:  0b 24 01 00 01 34 00 03 01 02 03
      ** UNRECOGNIZED:  0c 24 02 01 03 06 00 08 03 00 00 00
      ** UNRECOGNIZED:  09 24 03 02 01 01 00 01 00
      ** UNRECOGNIZED:  0c 24 02 03 01 01 00 08 03 00 00 00
      ** UNRECOGNIZED:  09 24 03 04 03 06 00 03 00
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
      ** UNRECOGNIZED:  07 24 01 03 01 01 00
      ** UNRECOGNIZED:  14 24 02 01 08 03 18 04 44 ac 00 80 bb 00 88 58 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0003  1x 3 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
      ** UNRECOGNIZED:  07 24 01 02 01 01 00
      ** UNRECOGNIZED:  14 24 02 01 08 03 18 04 44 ac 00 80 bb 00 88 58 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      2 
      bInterfaceProtocol      0 
      iInterface              0 
      ** UNRECOGNIZED:  07 24 01 02 01 01 00
      ** UNRECOGNIZED:  14 24 02 01 08 03 18 04 44 ac 00 80 bb 00 88 58 01 00 77 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0138  1x 312 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 MIDI Streaming
      bInterfaceProtocol      0 
      iInterface              4 Fast Track Ultra 8R
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
        iJack                   0 
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
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0 
      iInterface              5 M-Audio DFU
      Device Firmware Upgrade Interface Descriptor:
        bLength                             9
        bDescriptorType                    33
        bmAttributes                        1
          Will Not Detach
          Manifestation Intolerant
          Upload Unsupported
          Download Supported
        wDetachTimeout                   2000 milliseconds
        wTransferSize                    1024 bytes
        bcdDFUVersion                   10.01
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

--------------060503030600080700040101
Content-Type: text/plain;
 name="reverse-engineering-ftu8r-dsp-mixer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reverse-engineering-ftu8r-dsp-mixer.txt"

Hi,

as posted on the alsa-user list, I could get the Fast Track Ultra
8R (USB Id 0763:2881) partially working with Clemes Ladisch's patch for
the Fast Track Ultra (w/o 8R) [1] by just changing the USB Id.

What's not working is setting the sample rate (at least I don't know
how to set it up for 44100 Hz ). And there is no access to the DSP
mixer and effects section.

The nice thing on the DSP mixer is that it remembers it's settings and
operates even without a computer attached. In other words, once set
up, the device can operate as a simple stand alone mixer.

In order to help developing  a driver, I've gathered some information
on how the M-Audio Fast Track Ultra 8R interface is set up. I'm not
familiar with USB programming nor with audio devices or Alsa. But I hope, I can
give the relevant parts of the usbmon output nonetheless.

I've grepped the usbmon logs for "Co", the output below contains only the
lines with "Co" in them. Most of them carry a "Co:1:003:0" while some
of them have "Co:1:006:0". I guess that's because of my replugging the
device as at the time of this writing all output has the 006.


I hope somebody can take this information and put in in a
driver.

You can find further information on this device on
http://www.m-audio.com/products/en_us/FastTrackUltra8R.html.

Some parts of my description might make a little more sense looking at
a screenshot of the Windows settings dialog or the flow schematics,
both of which you can find in the manual, linked to on the site above.

See below my findings.

Kind regards,

Felix

[1] http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg25385.html


1. Settings on Win**
--------------------

There are 4 regions in the settings tab. (A nice overview on the
Control Panel can be found in the manual, which you can download at
www.m-audio.com.)


1.1 Effect Program
------------------

1.1.1 The Effect Program
------------------------

There are 8 effect programs to choose from a drop down menu: Room 1-3, Hall 1-2, Plate, Delay and Echo.

Choosing an effect programm yields these relevant parts of the usbmon
output:

	ffff8800a00d0d80 595057804 S Co:1:003:0 s 21 01 0100 0600 0002 2 = [VAL]
	ffff8800a00d0d80 595058325 C Co:1:003:0 0 2 >
	ffff8800a00d0d80 595079774 S Co:1:003:0 s 21 01 0200 0600 0001 1 = 40
	ffff8800a00d0d80 595080194 C Co:1:003:0 0 1 >
	ffff8800a00d0d80 595084732 S Co:1:003:0 s 21 01 0300 0600 0002 2 = 0040
	ffff8800a00d0d80 595085070 C Co:1:003:0 0 2 >
	ffff8800a00d0d80 595089766 S Co:1:003:0 s 21 01 0400 0600 0001 1 = 40
	ffff8800a00d0d80 595090192 C Co:1:003:0 0 1 >

where [VAL] is one of the following values:

      0000 for "Room 1"
      0100 for "Room 2"
      0200 for "Room 3"
      0300 for "Hall 1"
      0400 for "Hall 2"
      0500 for "Plate"
      0600 for "Delay"
      0700 for "Echo".

1.1.2 Duration
--------------

There's a control "Duration". Changing it yields these relevant parts of the usbmon
output:
	
	ffff8800608fed80 771218819 S Co:1:003:0 s 21 01 0300 0600 0002 2 = [VAL]
	ffff8800608fed80 771219174 C Co:1:003:0 0 2 >

where [VAL] seems to range from 0000 (control knob left) to 007f (control
knob right). 

1.1.3 Feedback
--------------

There's a control "Feedback", which is only adjustable in the effect
programs "Delay" and "Echo". Changing it yields these relevant parts of the usbmon
output:

	ffff8800662a6600 3120473733 S Co:1:006:0 s 21 01 0400 0600 0001 1 = [VAL]
	ffff8800662a6600 3120474160 C Co:1:006:0 0 1 >

where [VAL] seems to range from 00 (control knob left) to 7f (control
knob right).



1.1.4 Volume
------------

There's a control "Volume". Changing it yields these relevant parts of the usbmon
output:

	ffff8800ac1ed900 2882138576 S Co:1:006:0 s 21 01 0200 0600 0001 1 = [VAL]
	ffff8800ac1ed900 2882138990 C Co:1:006:0 0 1 >


where [VAL] seems to range from 00 (control knob left) to 7f (control
knob right).


1.2 Sample rate
---------------

1.2.1 Sync Source
-----------------

There's a drop down menu for selecting the sync source. The choices
are "Internal" and "External" (<- SPDIF). 

When set to "External" there
are lots of "Zi" lines in the log like these:

    ffff88006638d000 3325892013 C Zi:1:006:1 0:1:904:0 8 0:0:168 0:312:144 0:624:120 0:936:144 0:1248:168 1152 = a7e4fff5 d7ff6fe3 ffb0e0ff a9e9ff65 dcff0000 00000000 cce4fffa d7ff8ee3
    ffff88004e611800 3325893010 C Zi:1:006:1 0:1:912:0 8 0:0:168
    0:312:144 0:624:120 0:936:168 0:1248:144 1176 = d7e5ff0a d9ff6ce4
    ff0be2ff 17eaff66 ddff0000 00000000 eee5ff32 d9ff59e4

Don't know if they are relevant.



1.2.1.1 From "Internal" to "External"
-------------------------------------

Here's what happens when switching the "Sync Source" from "Internal" to "External":

       ffff8800662a60c0 3325542111 S Co:1:006:0 s 01 0b 0000 0001 0000 0
       ffff8800662a60c0 3325543386 C Co:1:006:0 0 0
       ffff88009159e740 3325594872 S Co:1:006:0 s 01 0b 0000 0002 0000 0
       ffff88009159e740 3325596263 C Co:1:006:0 0 0
       ffff8800a00d0900 3325633405 S Co:1:006:0 s 01 0b 0001 0001 0000 0
       ffff8800a00d0900 3325633637 C Co:1:006:0 0 0
       ffff88009159e440 3325644251 S Co:1:006:0 s 01 0b 0002 0002 0000 0
       ffff88009159e440 3325644631 C Co:1:006:0 0 0
       ffff8800a00d0480 3326127863 S Co:1:006:0 s 22 01 0100 0001 0003 3 = 80bb00
       ffff8800a00d0480 3326128270 C Co:1:006:0 0 3 >
       ffff8800a00d0480 3326132492 S Co:1:006:0 s 22 01 0100 0081 0003 3 = 80bb00
       ffff8800a00d0480 3326132895 C Co:1:006:0 0 3 >

 1.2.1.2 From "External" to "Internal"
-------------------------------------

Here's what happens when switching the "Sync Source" from "External"
to "Internal":

   ffff8800a00d0480 3349133460 S Co:1:006:0 s 01 0b 0000 0001 0000 0
   ffff8800a00d0480 3349134696 C Co:1:006:0 0 0
   ffff88009159e740 3349186489 S Co:1:006:0 s 01 0b 0000 0002 0000 0
   ffff88009159e740 3349187696 C Co:1:006:0 0 0
   ffff88009159e440 3349239544 S Co:1:006:0 s 01 0b 0001 0001 0000 0
   ffff88009159e440 3349239823 C Co:1:006:0 0 0
   ffff8800a00d0900 3349255385 S Co:1:006:0 s 01 0b 0001 0002 0000 0
   ffff8800a00d0900 3349256567 C Co:1:006:0 0 0

1.2.2 Sample Rate
-----------------

When "Sync Source" is set to "Internal" you can choose a sample rate
44.1 kHz, 48 kHz, 88.2 kHz an 96 kHz.

     ffff88007a826a40 4164558574 S Co:1:003:0 s 22 01 0100 0001 0003 3 = 007701
     ffff88007a826a40 4164559977 C Co:1:003:0 0 3 >
     ffff88007a826a40 4164563251 S Co:1:003:0 s 22 01 0100 0081 0003 3 = 007701
     ffff88007a826a40 4164563597 C Co:1:003:0 0 3 >

where [Val] is one of the following values:

      44ac00 for 44.1 kHz
      80bb00 for 48 kHz
      885801 for 88.2 kHz
      007701 for 96 kHz

1.3 Other settings
------------------

The other settings do not seem to change anything on the device but are only
related to the driver or the GUI. (Well, maybe the "High Performance
Mode" button changes something on the device, when the driver is
loaded next time.)


2. The mixer (on Win**)
-----------------------

The Fast Track Ultra 8R features 4 monitor mixers. Monitor 1/2, 3/4,
5/6 and 7/8. They are mixing to the corresponding outputs 1-8. Each
mixer is represented by controls for "Analog In 1-8" and "Software
Return 1-8" and "Master Out 1/2".

For each of those 16 channels ("Analog In"s and "Software Return"s)
there is a level slider, a pan knob, a mute button and a solo button.

"Master Out" 1+2 are represented by a level slider.

For "Monitor 1/2" and "Monitor 3/4" in addition to the controls
mentioned above there's an "Effects Send" control knob for each
"Analog In" and "Software Return", a control knob "Effects Return" for
each of the "Master Out"s and a "Effects Bypass" button.


2.1 Effects Bypass
------------------

2.1.1 Monitor 1/2 Bypass
------------------------

Setting the Monitor 1/2 to bypass the effect yields this: 

	ffff8800ac1edcc0 734991273 S Co:1:006:0 s 21 01 0201 0700 0002 2 = 0080
	ffff8800ac1edcc0 734991583 C Co:1:006:0 0 2 >
	ffff8800ac1edcc0 734999254 S Co:1:006:0 s 21 01 0202 0700 0002 2 = 0080
	ffff8800ac1edcc0 734999581 C Co:1:006:0 0 2 >

Reenabling the effects on Monitor 1/2 yields this:
	   
	ffff8800662a63c0 1084925217 S Co:1:006:0 s 21 01 0201 0700 0002 2 = e7cd
	ffff8800662a63c0 1084925584 C Co:1:006:0 0 2 >
	ffff8800662a63c0 1084934745 S Co:1:006:0 s 21 01 0202 0700 0002 2 = e7cd
	ffff8800662a63c0 1084935078 C Co:1:006:0 0 2 >

2.1.2 Monitor 3/4 Bypass
------------------------

Setting the Monitor 3/4 to bypass the effect yields this:

	ffff8800ac1ed0c0 3024153559 S Co:1:006:0 s 21 01 0203 0700 0002 2 = 0080
	ffff8800ac1ed0c0 3024153901 C Co:1:006:0 0 2 >
	ffff8800ac1ed0c0 3024158859 S Co:1:006:0 s 21 01 0204 0700 0002 2 = 0080
	ffff8800ac1ed0c0 3024159277 C Co:1:006:0 0 2 >

Reenabling the effects on Monitor 3/4 yields this:

	   ffff8800662a6840 3034928368 S Co:1:006:0 s 21 01 0203 0700 0002 2 = e7cd
	   ffff8800662a6840 3034928788 C Co:1:006:0 0 2 >
	   ffff8800662a6840 3034936142 S Co:1:006:0 s 21 01 0204 0700 0002 2 = e7cd
	   ffff8800662a6840 3034936540 C Co:1:006:0 0 2 >


2.2 Levels
----------

Changing a level for a channel yields this:

	 ffff880093800e00 3649051254 S Co:1:003:0 s 21 01 [OutIn] 0500 0002 2 = [VAL]
	 ffff880093800e00 3649051527 C Co:1:003:0 0 2 >

where 
      [VAL] ranges from 0080 to ffff and

      [OutIn] is a number composed of the Out-channel (01-08) and In
      ranges from 01 to 10 (Hex, Software returns starting at 09).
       
Example: [OutIn] = 0209 for the Level of "Software Return 1" on Out 2.

2.2.1 Panning
-------------

Panning is done by changing the respective Levels for 2 channels. When
panning is in the middle position, the max value for each level seems
to be "fdfc". Example:

   ffff8800ac1edd80 1908059496 S Co:1:003:0 s 21 01 0402 0500 0002 2 = fdfc
   ffff8800ac1edd80 1908059852 C Co:1:003:0 0 2 >
   ffff8800ac1edd80 1908064495 S Co:1:003:0 s 21 01 0302 0500 0002 2 = fdfc
   ffff8800ac1edd80 1908064850 C Co:1:003:0 0 2 >

This sets the level of "Analog In 2"  in "Monitor 3/4" to the maximum
value while the panning control is in the middle position.

2.3 Solo and Mute
-----------------

Solo and Mute are operated by changing the respective levels to
minimum value. In other words: Not a seperate action from changing
levels.

2.4 Effects Send
----------------

Changing the Effects send value for a Channel


	ffff8800ac1ed840 958480452 S Co:1:[MON]:0 s 21 01 09[CH] 0500 0002 2 = [VAL]
	ffff8800ac1ed840 958480800 C Co:1:[MON]:0 0 2 >

where

	[VAL] ranges from e7cd (knob left, minimum) to daff (knob
	right, maximum),

	[MON] = 003 for Monitor 1/2 and 006 for Monitor 3/4 
and
	[CH] is the channel number (0-10, Hex, Software returns
	starting at 09)


2.5 Effects Return
------------------

2.5.1 Monitor 1/2
-----------------

Setting the "Effects Return 1" ('left') Value in Monitor 1/2 yields

	ffff8800608fe9c0 1220780329 S Co:1:003:0 s 21 01 0201 0700 0002 2 = [VAL]
	ffff8800608fe9c0 1220780648 C Co:1:003:0 0 2 >

with 
     [VAL] from e7cd to daff.

For "Effect Return 2" ('right') it's

        ffff880093800080 1281633920 S Co:1:003:0 s 21 01 0202 0700 0002 2 = [VAL]
        ffff880093800080 1281634358 C Co:1:003:0 0 2 >

2.5.2 Monitor 3/4
-----------------

Setting the "Effects Return 1" ('left') Value in Monitor 3/4 yields

	ffff8800ac1ed240 45150924 S Co:1:006:0 s 21 01 0203 0700 0002 2 = [VAL]
	ffff8800ac1ed240 45151245 C Co:1:006:0 0 2 >

with 
     [VAL] from e7cd to daff.

For "Effect Return 2" ('right') it's

    ffff8800a00d0480 31181802 S Co:1:006:0 s 21 01 0204 0700 0002 2 = [VAL]
    ffff8800a00d0480 31182181 C Co:1:006:0 0 2 >

2.6 Master Out
--------------

2.6.1 Monitor 1/2
-----------------

Changing the "Master Out 1" ('left') level in Monitor 1/2 gives this

	 ffff880093800440 1385027420 S Co:1:003:0 s 21 01 0109 0500 0002 2 = [VAL]
	 ffff880093800440 1385027770 C Co:1:003:0 0 2 >

changing the "Master Out 2" ('right') level in Monitor 1/2 gives this

	 ffff8800ac1ede40 1410769402 S Co:1:003:0 s 21 01 020a 0500 0002 2 = [VAL]
	 ffff8800ac1ede40 1410769744 C Co:1:003:0 0 2 >

with [VAL] ranging from e7cd to 0000 (loudest).



2.6.2 Monitor 3/4
-----------------

Changing the "Master Out 1" ('left') level in Monitor 3/4 gives this

	ffff8800662a6540 4152434840 S Co:1:006:0 s 21 01 030b 0500 0002 2 = [VAL]
	ffff8800662a6540 4152435226 C Co:1:006:0 0 2 >


changing the "Master Out 2" ('right') level in Monitor 3/4 gives this

	 ffff88008280ca40 14381909 S Co:1:006:0 s 21 01 040c 0500 0002 2 = [VAL]
	 ffff88008280ca40 14382274 C Co:1:006:0 0 2 >


with [VAL] ranging from e7cd to 0000 (loudest).



3. Startup
----------

I've attached a log file showing what happens when the device is
attached to Windows. Please note, that this is done under VirtualBox,
so there might be some noise at the beginning of the file.

I hope, there's some information in the log on how the Windows control
panel gathers the current mixer values from the device.

--------------060503030600080700040101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060503030600080700040101--
