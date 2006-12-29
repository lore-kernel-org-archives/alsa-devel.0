From: Frank van de Pol <fvdpol@coil.demon.nl>
Subject: Re: Adding support for BCD2000 USB Device?
Date: Fri, 29 Dec 2006 22:21:20 +0100
Message-ID: <20061229212119.GA14182@obelix.int.coil.demon.nl>
References: <20061217213617.GA6283@obelix.int.coil.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061217213617.GA6283@obelix.int.coil.demon.nl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: frank@fpaudio.com
List-Id: alsa-devel@alsa-project.org


Hi folks,

I've started an attempt to get the MIDI support working by adding an entry
to the usbquirks.h. 

Good news is that I receive events every time I push or release a button,
move a fader or turn a knob on the device. 

Bad news is that the packets send over the USB bus do not seem to be in
standard MIDI format, so I guess I need to add some custom handler for the
events emitted by the device. All in all this looks pretty hopefull to me.

I didn't (yet) bother about the audio support, to me the control surface is
most important.


Appologies for the long posting, I've tried to include sufficient info to
give a clear understanding of what has been done. Any hints or tips are
welcome (especially on the USB protocol handling, since that is all new to
me).



Test scenario: 
	- Power on the device 
	- press and release the Cue botton of the left deck (2x)
	- press and release the Play botton of the left deck (2x)


1/ Results on Windows (Driver v.1.1.1.0)

Midi events:
	
90 12 7F  (Note On  F#0) <-- Press of Cue button of left deck	
90 12 00  (Note Off F#0) <-- Release of Cue button of left deck
90 12 7F  (Note On  F#0) <-- Press of Cue button of left deck	
90 12 00  (Note Off F#0) <-- Release of Cue button of left deck
90 13 7F  (Note On  G0)	 <-- Press of Play button of left deck
90 13 00  (Note Off G0)	 <-- Release of Play button of left deck
90 13 7F  (Note On  G0)	 <-- Press of Play button of left deck
90 13 00  (Note Off G0)	 <-- Release of Play button of left deck


....so far nothing really interesting, clean and consistent data ;-)



2/ Results on ALSA (HG Version, with DUMP_PACKETS enabled)

after Power-On of the device:

# more /proc/asound/cards
 0 [I82801CAICH3   ]: ICH - Intel 82801CA-ICH3
                      Intel 82801CA-ICH3 with AD1881A at irq 11
 1 [BCD2000        ]: USB-Audio - BCD2000
                      Behringer BCD2000 at usb-0000:00:1d.1-1, full speed

# more /proc/asound/card1/midi0
BCD2000

Output 0
  Tx bytes     : 0
Input 0
  Rx bytes     : 0


So the device registers itself :-)


# aseqdump  -p 20:0
Waiting for data. Press Ctrl+C to end.
Source_ Event_________________ Ch _Data__
 20:0   Continue                                 <---- Press of Cue
 20:0   Note off                3 124 189
 20:0   Note off                3  18 127
 20:0   Continue
 20:0   Note off                3 124 189

 20:0   Continue                                 <---- Release of Cue
 20:0   Note off                3 124 189
 20:0   Continue
 20:0   Note off                3 124 189
 20:0   Continue
 20:0   Note off                3 124 189

 20:0   Continue                                 <---- Press of Cue
 20:0   Note off                3 124 189
 20:0   Note off                3  18 127
 20:0   Continue
 20:0   Note off                3 124 189

 20:0   Continue                                 <---- Release of Cue
 20:0   Note off                3 124 189
 20:0   Note off                3  18   0
 20:0   Continue
 20:0   Note off                3 124 189


 20:0   Continue                                 <---- Press of Play
 20:0   Note off                3 124 189
 20:0   Continue
 20:0   Note off                3 124 189
 20:0   Continue
 20:0   Note off                3 124 189

 20:0   Continue                                 <----  Release of Play
 20:0   Note off                3 124 189
 20:0   Note off                3  19   0
 20:0   Continue
 20:0   Note off                3 124 189

 20:0   Continue                                 <---- Press of Play
 20:0   Note off                3 124 189
 20:0   Note off                3  19 127
 20:0   Continue
 20:0   Note off                3 124 189

 20:0   Continue                                 <---- Release of Play
 20:0   Note off                3 124 189
 20:0   Note off                3  19   0
 20:0   Continue
 20:0   Note off                3 124 189


Events ARE received, but the content looks like garbage and does not seem
to correlate with the clean MIDI data seen using the Windows drivers. The
timestamp however does match. 

The dump of USB packets received gives a better understanding on what is
going on. My first observation is that the amount of data seems to be
relatively large compared to the event to be sent....


These packets are captured at the same time as the sequencer events shown
above. I just show them grouped to make it "easier" to read:

Press of Cue:
received packet: [ 01 90 ba 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 00
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 02 12 7f 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 01
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]

Release of Cue:
received packet: [ 01 90 7f 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 02
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 01 12 7f 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 03
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 01 00 7f 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 04
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
 
Press of Cue:
received packet: [ 01 90 7f 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 05
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 02 12 7f 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 06
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]

Release of Cue:
received packet: [ 01 90 7f 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 07
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 02 12 00 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 08
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]


Press of Play:
received packet: [ 01 90 00 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 09
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 01 13 00 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 0a
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 01 7f 00 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 0b
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]

Release of Play:
received packet: [ 01 90 00 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 0c
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 02 13 00 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 0d
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]

Press of Play:
received packet: [ 01 90 00 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 0e
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 02 13 7f 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 0f
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]

Release of Play:
received packet: [ 01 90 7f 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 10
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]
received packet: [ 02 13 00 26 da e6 0d 43 00 a3 0f de b5 8a 55 06 ff ff 11
00 00 79 01 03 53 d6 07 84 61 74 e2 a1 3a 2c 1d 74 6d 1d dd c8 91 a7 57 0d
04 fb 7c bd 2f ec 17 d2 75 b9 08 15 c2 78 85 80 ]



Observations:

- Huge amount of data sent for a single event!
- Mostly 2 packets for an event, but sometimes three???
- The 19th byte (last one on 1st line of the dump) seems to be some kind of
  packet sequence number, incrementing every packet.
- No packets logged unless I touch any of the controls on the BCD2000.
- The device also has an audio interface... but that should not(?) interface
  with these dumps since the audio is using another end point and iso
  transfers.


Staring at the packets captured did not yet give me a good clue how the
actual event is mapped, perhaps this will change in the future :-) 

Hopefully the fine folks at Behringer will send me sufficient data (as they
did before on schematics for the MB8000 meterbridge and sysex and protocol
info for the DDX3212 mixer).


Best regards,
Frank.



For those curious about the hack to usbquirks.h:
(inlined, so will probably be mangled by the mailer)
  
diff -r 1ede4dc9b6ea usb/usbquirks.h
--- a/usb/usbquirks.h   Sun Dec 10 00:00:38 2006 +0000
+++ b/usb/usbquirks.h   Fri Dec 29 18:03:00 2006 +0100
@@ -1604,6 +1604,28 @@ YAMAHA_DEVICE(0x7010, "UB99"),
        }
 },

+/* Behringer devices */
+{
+       /*
+        * Preliminary support for the B-Control Deejay BCD2000.
+        *
+        * the device is a control surface with 4 in/out soundcard. initial focus
+        * is on the control surface functionality.
+        */
+       USB_DEVICE_VENDOR_SPEC(0x1397,0x00bd),
+       .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk)
{
+               .vendor_name = "Behringer",
+               .product_name = "BCD2000",
+               .ifnum = 0,
+               .type = /* QUIRK_MIDI_STANDARD_INTERFACE, */ /*-- does not work 'MIDIStreaming interface descriptor not found */
+                          QUIRK_MIDI_FIXED_ENDPOINT,      /*-- receives data if a switch/knob is touched, but data is no valid MIDI stream */
+               .data = & (const struct snd_usb_midi_endpoint_info) {
+                       .out_cables = 0x0001,
+                       .in_cables  = 0x0001
+               }
+       }
+},
+
 {
        /*
         * Some USB MIDI devices don't have an audio control interface,




On Sun, Dec 17, 2006 at 10:36:17PM +0100, Frank van de Pol wrote:
> 
> I've bought a new dj'ing control surface, Behringer BCD2000, which currently
> does not seem to be supported using the Alsa-driver (current hg snapshot).
> 
> The device is basically an USB soundcard (4 in, 4 out) and most likely a
> MIDI interface connected to the device's knobs, buttons and leds. 
> I noticed that bInterfaceClass is set to 255 instead of 1 as I would expect
> for an audio class device. Perhaps some quirck is needed to get this device
> recognised?
> 
> 
> If someone could give me some hints where to look for and where to start at
> hacking this device alive in linux that would be wonderfull.
> 
> 
> Website showing the device:
> http://www.behringer.com/BCD2000/index.cfm?lang=ENG
> 
> 
> output of lsusb -v (section for the BCD2000):
> 
> 
> Bus 002 Device 008: ID 1397:00bd
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x1397
>   idProduct          0x00bd
>   bcdDevice            0.00
>   iManufacturer           1 Behringer
>   iProduct                2 BCD2000
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           46
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           4
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0180  1x 384 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0180  1x 384 bytes
>         bInterval               1
> 
> 
> 
> 
> -- 
> +---- --- -- -  -   -    -
> | Frank van de Pol                  -o)    A-L-S-A
> | frank@fpaudio.com                 /\\  Sounds good!
> | http://www.alsa-project.org      _\_v
> | http://www.gentoo.org                  Gentoo Linux   
> | Linux - Why use Windows if we have doors available?
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
+---- --- -- -  -   -    -
| Frank van de Pol                  -o)    A-L-S-A
| frank@fpaudio.com                 /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| http://www.gentoo.org                  Gentoo Linux   
| Linux - Why use Windows if we have doors available?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
