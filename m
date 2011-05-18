From: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Subject: Re: GR-55 Driver
Date: Tue, 17 May 2011 22:24:10 -0700
Message-ID: <1305696250.3049.13.camel@TrinaryDragon>
References: <1305224448.5083.37.camel@TrinaryDragon>
	<BANLkTimvr7TkmTiCeeNOeOH66++sHnCfbg@mail.gmail.com>
	<1305233604.8214.2.camel@TrinaryDragon>
	<BANLkTikGVDWxShJOsfspETPVwKDqcJtNOg@mail.gmail.com>
	<1305253856.5076.65.camel@TrinaryDragon>
	<BANLkTi=jj7cjxgmOpH+EHnUMuazqLOEsZA@mail.gmail.com>
	<1305441562.2850.7.camel@TrinaryDragon>
	<BANLkTik-m+BmV0+vQyVfPPDSmCgXspCuAg@mail.gmail.com>
	<1305501208.7165.13.camel@TrinaryDragon>
	<BANLkTimD7pPS6ErrWA6rVKzjV1KoOj-yWw@mail.gmail.com>
	<1305581583.2594.40.camel@TrinaryDragon>
	<BANLkTik_oWtWLN+6Y_j7RznUzvztrzZybA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C14371037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 07:24:14 +0200 (CEST)
Received: by iwc10 with SMTP id 10so1181316iwc.38
	for <alsa-devel@alsa-project.org>; Tue, 17 May 2011 22:24:13 -0700 (PDT)
In-Reply-To: <BANLkTik_oWtWLN+6Y_j7RznUzvztrzZybA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Answers to questions:

> Are you sure hw:1,0 refers to your GR-55? Check the entries in
/proc/asound/cards again, please.

cat /proc/asound/cards
0 [U0x46d0x821    ]: USB-Audio - USB Device 0x46d:0x821
                      USB Device 0x46d:0x821 at usb-0000:00:12.2-1.1,
high speed
1 [GR55           ]: USB-Audio - GR-55
                      Roland GR-55 at usb-0000:00:12.2-4, high speed
2 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xf7ff4000 irq 16
3 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xfbcfc000 irq 19

Note that the position depends on if I start with the device on and
connected; as you see above, if I turn it on after startup; it becomes
number 3; but for all testing I always startup with it on.
***
> Can you try this with a 44100/16bit file?

# aplay -D plughw:GR55,0,0 test-441100-mono-16.wav
Playing WAVE 'test-441100-mono-16.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Mono

This did work, I can hear it in the GR-55 Headphone; but only once; it
locks up the GR-55 after completing, and I had to disconnect the power,
the on/off switch did not work; nor did the midi interface to the
instrument. 

This may have been working all the time; since it only worked once, I
might have missed it; also both wav files worked (48 and 44 khz).

Sound Preference Matrix
Input   -- Output
GR-55   -- GR-55
***
> So you DO in fact get audio from the device then with some tool? 

Only in Windoze (Vista x64 and Windows 7).
***
> For Windows, Midi-OX is a good tool to test with...

I did test Midi-OX in Windows, it worked fine.
I also was able to capture MIDI in Pro Guitar 6.
***
I tried http://gna.org/projects/gmidimonitor/ and KMidimon with no help
***
# amidi -l

Dir Device    Name

[Nothing]
Not sure what to use for X amidi --port hw:X,0 --dump

amidi --port hw:GR55,0 --dump
ALSA lib rawmidi_hw.c:233:(snd_rawmidi_hw_open) open /dev/snd/midiC1D0
failed: Device or resource busy
cannot open port "hw:GR55,0": Device or resource busy

amidi --port hw:1,0 --dump
ALSA lib rawmidi_hw.c:233:(snd_rawmidi_hw_open) open /dev/snd/midiC1D0
failed: Device or resource busy
cannot open port "hw:1,0": Device or resource busy

amidi --port hw:0,0 --dump
ALSA lib rawmidi_hw.c:233:(snd_rawmidi_hw_open) open /dev/snd/midiC0D0
failed: No such file or directory
cannot open port "hw:0,0": No such file or directory

***
I updated my troubleshooting file
http://vetshelpcenter.com/media/troubleshooting-gr-55.txt
It has a lot of information in it.
***
I was thinking about writing a tool to help troubleshoot MIDI and Audio
ALSA Driver issues with QT4 using Drumstick, do you think this would
help?

Do you know of any tools written with it?
http://qt-apps.org/content/show.php/Drumstick?content=121300 

I can reverse engineer this using Snoopy Pro
http://sourceforge.net/projects/usbsnoop/
Would that help?

What next?

Thanks
Jeff


-----Original Message-----
From: Daniel Mack <zonque@gmail.com>
To: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] GR-55 Driver
Date: Tue, 17 May 2011 12:11:14 +0200

On Mon, May 16, 2011 at 11:33 PM, Jeffrey Scott Flesher Gmail
<jeffrey.scott.flesher@gmail.com> wrote:
> # alsamixer -D hw:GR55
> This sound device does not have any controls.
> ***
> # amixer -D hw:GR55 controls
> [Nothing]

That's possible.

> ***
> # cat /proc/asound/GR55/stream0
> Roland GR-55 at usb-0000:00:12.2-4, high speed : USB Audio
>
> Playback:
>   Status: Stop
>   Interface 0
>     Altset 1
>     Format: S32_LE
>     Channels: 2
>     Endpoint: 5 OUT (ASYNC)
>     Rates: 44100
>     Data packet interval: 125 us
>
> Capture:
>   Status: Stop
>   Interface 1
>     Altset 1
>     Format: S32_LE
>     Channels: 2
>     Endpoint: 4 IN (ASYNC)
>     Rates: 44100
>     Data packet interval: 125 us
> ***
> # cat /proc/asound/GR55/midi0
> GR-55

Looks ok.

> ***
> # aplay -D plughw:GR55,0,0 /usr/share/sounds/alsa/Front_Center.wav
> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
> [No sound]

Can you try this with a 44100/16bit file?

> I am facing two problems, I am unfamiliar with this piece of equipment and as a result, I'm unsure how to test it.
>
> Testing Audio function:
> I tested it with Audacity in Windozes and it works;  in Linux I set it up the same way: GR-55 USB Audio (hw:1,0) as recording device; no sound.

Are you sure hw:1,0 refers to your GR-55? Check the entries in
/proc/asound/cards again, please.

> Using Logitech Webcam software I can record the guitar output; Using Cheese, I do not get Audio.

So you DO in fact get audio from the device then with some tool?

> Testing MIDI function:
> I'm going to call tech support on this one; I have not found a Windows app that seems to work with the MIDI;

For Windows, Midi-OX is a good tool to test with: http://www.midiox.com/

> so I can not expect to test this in Linux yet; I would like to be able to convert notes into sheet music; I tried TuxGuitar, but must admit I don't know how to get it to work with MIDI input, or if it even does.

For Linux, use amidi. "amidi -l" will list all available MIDI ports.
For example to dump all incoming messages, use "amidi --port hw:X,0
--dump". And to send messages, use "--send-hex" and make sure you send
valid MIDI messages, otherwise the other side won't do anything.

> I'm going to keep on this till I get it 100%; I have patience; lets hope you do too.

Well, I believe the quirks patch is correct, and there's only software
configuration issues left.


Daniel
