From: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
Subject: Re: Status of the Tascam US-122mkII???
Date: Sat, 19 Jun 2010 22:19:46 +0200
Message-ID: <4C1D2662.3060106@physik.uni-hamburg.de>
References: <AANLkTimaehZwC-e1pmbQl-pLNb7gVp2Rt5Ujz4BfduR_@mail.gmail.com>	<20100619174259.GJ17833@buzzloop.caiaq.de>	<AANLkTilfDBFqGH41TGF0H855CfCm8fOjGMW7lwH1tXi_@mail.gmail.com>	<20100619180956.GL17833@buzzloop.caiaq.de>	<AANLkTikfeTzrOttiyI9BqqD3zHI7NXY8ScyXoY8Ruq8N@mail.gmail.com>	<20100619185753.GN17833@buzzloop.caiaq.de>	<4C1D149B.7000802@physik.uni-hamburg.de>
	<AANLkTimJ17dGo6K3Gy8_tlhIezFFY0XDRyj53i8tj1pi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.physnet.uni-hamburg.de (MAIL.PHYSnet.uni-hamburg.de
	[134.100.106.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A1E2103817
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 22:19:52 +0200 (CEST)
In-Reply-To: <AANLkTimJ17dGo6K3Gy8_tlhIezFFY0XDRyj53i8tj1pi@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jordan johnston <triplesquarednine@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

jordan johnston wrote:
> sorry about that....no more re-posting...
>   
Again, reply to all addressees of the mails, now you only replied to me.
> don't revert yet!!!
>
> The card IS half working, i can use midi no problem with jack...
>
> i think the driver DOES work..... i think the problem may be in
> .asoundrc or some other alsa settings.
>
> right now i am using .asoundrc that i had picked up from here:
>
> # got from http://www.nabble.com/tascam-us122l-and-ccrma-td24036395.html
> # thanks to Karsten
>
> # The usb_stream plugin configuration
>
> pcm.!usb_stream {
>         @args [ CARD ]
>         @args.CARD {
>                 type string
>                 default "0"
>         }
>
>         type usb_stream
>
>         card $CARD
> }
>
> ctl.!usb_stream {
>         @args [ CARD ]
>         @args.CARD {
>                 type string
>                 default "0"
>         }
>
>         type hw
>
>         card $CARD
> }
>
> i think the problem is that alsa/jack  don't know where to look for
> both the inputs and outputs (as midi works great).
> unfortunately, i have little to no experience with this, and am not
> sure how to proceed.
>
> it turns out that this card DOES use echi_hcd (i didn't unbind
> uchi_hcd this time).
>
> (dmesg)
> usb 1-5: new high speed USB device using ehci_hcd and address 3
> usb 1-5: config 1 interface 1 altsetting 1 bulk endpoint 0x83 has
> invalid maxpacket 9
> usb 1-5: New USB device found, idVendor=0644, idProduct=8021
> usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-5: Product: US-122 MKII
> usb 1-5: Manufacturer: TASCAM
> usb 1-5: SerialNumber: no serial number
>
> as you can see echi_hcd is being used and.....
>
> [ninez@ninez ~]$ ls /sys/bus/pci/drivers/ehci_hcd
> 0000:00:1d.7  bind  module  new_id  remove_id  uevent  unbind
>
> the card is found when you look for it!
>
> [ninez@ninez ~]$ cat /proc/asound/cards
>  0 [Intel          ]: HDA-Intel - HDA Intel
>                       HDA Intel at 0xefffc000 irq 27
>  1 [US122L         ]: USB US-122L - TASCAM US-122L
>                       TASCAM US-122L (644:8021 if 0 at 001/003)
>
> when i start Qjackctl up:
>
> jackdmp 1.9.5
> Copyright 2001-2005 Paul Davis and others.
> Copyright 2004-2009 Grame.
> jackdmp comes with ABSOLUTELY NO WARRANTY
> This is free software, and you are welcome to redistribute it
> under certain conditions; see the file COPYING for details
> JACK server starting in realtime mode with priority 89
> audio_reservation_init
> Acquire audio card Audio0
> creating alsa driver ... hw:0|-|128|3|44100|0|0|nomon|swmeter|-|32bit
> Using ALSA driver HDA-Intel running on card 0 - HDA Intel at
> 0xefffc000 irq 27             ***   using internal sound (bah!)
> configuring for 44100Hz, period = 128 frames (2.9 ms), buffer = 3 periods
> ALSA: final selected sample format for playback: 32bit integer little-endian
> ALSA: use 3 periods for playback
> Using port names patch v0.1 (07.04.2010)
> port created: Midi-Through:midi/playback_1
> port created: Midi-Through:midi/capture_1
> port created: TASCAM-US-122L:midi/playback_1
>         ***      it uses the midi just fine (i tested it with Native
> intruments, massive)
> port created: TASCAM-US-122L:midi/capture_1
> 15:46:49.327 ALSA connection change.
> 15:46:50.351 Server configuration saved to "/home/ninez/.jackdrc".
> 15:46:50.352 Statistics reset.
> 15:46:50.367 Client activated.
> 15:46:50.369 JACK connection change.
> 15:46:50.374 JACK connection graph change.
>
> if i set it to hw:1  jack can't start, nor does it matter if i am
> duplex, playback(only) or capture(only)..
> so i am convinced this driver can work, otherwise midi wouldn't work
> at all.   the problem is my configuration.
> but i am not sure how to remedy this, any clues would help! (let's not
> give up quite yet!)
>
> it's finding out how to tell it to use outputs and inputs properly.
>
> jordan
>   
MIDI works because it is done by another driver.

Follow these instructions to see if you can get the US122 MKII working 
like a US122L:
http://www.premiumorange.com/la-page-web-of-phil/index.php?page=P030101#conseils_installation

The interface is not hw:0 but usb_stream:1.

Also the US122L works with both ehci-hcd and uhci-hcd, the US144 only 
works with uhci-hcd.

Good luck, others tried it before and it didn't work.

Greetings, Tobias
