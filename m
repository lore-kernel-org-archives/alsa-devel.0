From: jordan johnston <triplesquarednine@gmail.com>
Subject: Re: Status of the Tascam US-122mkII???
Date: Sat, 19 Jun 2010 16:45:08 -0400
Message-ID: <AANLkTil_QpNxgpXEaisHx1Xh-DG7Mi9rCtKjtAmcW_KO@mail.gmail.com>
References: <AANLkTimaehZwC-e1pmbQl-pLNb7gVp2Rt5Ujz4BfduR_@mail.gmail.com>
	<20100619174259.GJ17833@buzzloop.caiaq.de>
	<AANLkTilfDBFqGH41TGF0H855CfCm8fOjGMW7lwH1tXi_@mail.gmail.com>
	<20100619180956.GL17833@buzzloop.caiaq.de>
	<AANLkTikfeTzrOttiyI9BqqD3zHI7NXY8ScyXoY8Ruq8N@mail.gmail.com>
	<20100619185753.GN17833@buzzloop.caiaq.de>
	<4C1D149B.7000802@physik.uni-hamburg.de>
	<AANLkTimJ17dGo6K3Gy8_tlhIezFFY0XDRyj53i8tj1pi@mail.gmail.com>
	<4C1D2662.3060106@physik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 68892103817
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 22:45:11 +0200 (CEST)
Received: by yxs7 with SMTP id 7so368001yxs.38
	for <alsa-devel@alsa-project.org>; Sat, 19 Jun 2010 13:45:08 -0700 (PDT)
In-Reply-To: <4C1D2662.3060106@physik.uni-hamburg.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Oops, sorry Tobias, i forgot to check it off. I did this time so
anyone can see. :)

So basically, many people have tried to get this working and
failed????  no one was able to get it working?

alright, i might setup a spare partition to give this another shot, as
i don't want to ruin my current setup that is needed every time
i got out and play music, or jam(like tonight!). My "Linux VST/live
input looper" must stay fully operational !
but i will probably take another shot at it. even though! - in the
end, i bet i am just going to purchase for FFADO "full-support".
i would buy HDSP, but it's a little pricey for my laptop.
I just thought that i would try to take advantage of the situation,
maybe help debug the driver, but if the implementation of the
us-122mkII is vastly different than what can you do??? It's too bad
that companies don't put more effort into supporting linux,
not that i need to tell you that!

On Sat, Jun 19, 2010 at 4:19 PM, Tobias Hansen
<Tobias.Hansen@physik.uni-hamburg.de> wrote:
> jordan johnston wrote:
>>
>> sorry about that....no more re-posting...
>>
>
> Again, reply to all addressees of the mails, now you only replied to me.
>>
>> don't revert yet!!!
>>
>> The card IS half working, i can use midi no problem with jack...
>>
>> i think the driver DOES work..... i think the problem may be in
>> .asoundrc or some other alsa settings.
>>
>> right now i am using .asoundrc that i had picked up from here:
>>
>> # got from http://www.nabble.com/tascam-us122l-and-ccrma-td24036395.html
>> # thanks to Karsten
>>
>> # The usb_stream plugin configuration
>>
>> pcm.!usb_stream {
>> =A0 =A0 =A0 =A0@args [ CARD ]
>> =A0 =A0 =A0 =A0@args.CARD {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type string
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default "0"
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0type usb_stream
>>
>> =A0 =A0 =A0 =A0card $CARD
>> }
>>
>> ctl.!usb_stream {
>> =A0 =A0 =A0 =A0@args [ CARD ]
>> =A0 =A0 =A0 =A0@args.CARD {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type string
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default "0"
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0type hw
>>
>> =A0 =A0 =A0 =A0card $CARD
>> }
>>
>> i think the problem is that alsa/jack =A0don't know where to look for
>> both the inputs and outputs (as midi works great).
>> unfortunately, i have little to no experience with this, and am not
>> sure how to proceed.
>>
>> it turns out that this card DOES use echi_hcd (i didn't unbind
>> uchi_hcd this time).
>>
>> (dmesg)
>> usb 1-5: new high speed USB device using ehci_hcd and address 3
>> usb 1-5: config 1 interface 1 altsetting 1 bulk endpoint 0x83 has
>> invalid maxpacket 9
>> usb 1-5: New USB device found, idVendor=3D0644, idProduct=3D8021
>> usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
>> usb 1-5: Product: US-122 MKII
>> usb 1-5: Manufacturer: TASCAM
>> usb 1-5: SerialNumber: no serial number
>>
>> as you can see echi_hcd is being used and.....
>>
>> [ninez@ninez ~]$ ls /sys/bus/pci/drivers/ehci_hcd
>> 0000:00:1d.7 =A0bind =A0module =A0new_id =A0remove_id =A0uevent =A0unbind
>>
>> the card is found when you look for it!
>>
>> [ninez@ninez ~]$ cat /proc/asound/cards
>> =A00 [Intel =A0 =A0 =A0 =A0 =A0]: HDA-Intel - HDA Intel
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HDA Intel at 0xefffc000 irq 27
>> =A01 [US122L =A0 =A0 =A0 =A0 ]: USB US-122L - TASCAM US-122L
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TASCAM US-122L (644:8021 if 0=
 at 001/003)
>>
>> when i start Qjackctl up:
>>
>> jackdmp 1.9.5
>> Copyright 2001-2005 Paul Davis and others.
>> Copyright 2004-2009 Grame.
>> jackdmp comes with ABSOLUTELY NO WARRANTY
>> This is free software, and you are welcome to redistribute it
>> under certain conditions; see the file COPYING for details
>> JACK server starting in realtime mode with priority 89
>> audio_reservation_init
>> Acquire audio card Audio0
>> creating alsa driver ... hw:0|-|128|3|44100|0|0|nomon|swmeter|-|32bit
>> Using ALSA driver HDA-Intel running on card 0 - HDA Intel at
>> 0xefffc000 irq 27 =A0 =A0 =A0 =A0 =A0 =A0 *** =A0 using internal sound (=
bah!)
>> configuring for 44100Hz, period =3D 128 frames (2.9 ms), buffer =3D 3 pe=
riods
>> ALSA: final selected sample format for playback: 32bit integer
>> little-endian
>> ALSA: use 3 periods for playback
>> Using port names patch v0.1 (07.04.2010)
>> port created: Midi-Through:midi/playback_1
>> port created: Midi-Through:midi/capture_1
>> port created: TASCAM-US-122L:midi/playback_1
>> =A0 =A0 =A0 =A0*** =A0 =A0 =A0it uses the midi just fine (i tested it wi=
th Native
>> intruments, massive)
>> port created: TASCAM-US-122L:midi/capture_1
>> 15:46:49.327 ALSA connection change.
>> 15:46:50.351 Server configuration saved to "/home/ninez/.jackdrc".
>> 15:46:50.352 Statistics reset.
>> 15:46:50.367 Client activated.
>> 15:46:50.369 JACK connection change.
>> 15:46:50.374 JACK connection graph change.
>>
>> if i set it to hw:1 =A0jack can't start, nor does it matter if i am
>> duplex, playback(only) or capture(only)..
>> so i am convinced this driver can work, otherwise midi wouldn't work
>> at all. =A0 the problem is my configuration.
>> but i am not sure how to remedy this, any clues would help! (let's not
>> give up quite yet!)
>>
>> it's finding out how to tell it to use outputs and inputs properly.
>>
>> jordan
>>
>
> MIDI works because it is done by another driver.
>
> Follow these instructions to see if you can get the US122 MKII working li=
ke
> a US122L:
> http://www.premiumorange.com/la-page-web-of-phil/index.php?page=3DP030101=
#conseils_installation
>
> The interface is not hw:0 but usb_stream:1.
>
> Also the US122L works with both ehci-hcd and uhci-hcd, the US144 only wor=
ks
> with uhci-hcd.
>
> Good luck, others tried it before and it didn't work.
>
> Greetings, Tobias
>

thanks :)

jordan
