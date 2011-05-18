From: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Subject: Re: GR-55 Driver
Date: Wed, 18 May 2011 08:34:53 -0700
Message-ID: <1305732893.3209.5.camel@TrinaryDragon>
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
	by alsa0.perex.cz (Postfix) with ESMTP id C54A0103850
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 17:34:57 +0200 (CEST)
Received: by iwc10 with SMTP id 10so1606824iwc.38
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2011 08:34:56 -0700 (PDT)
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

Does this type of data (USBlyzer Report) help to write drivers?
http://vetshelpcenter.com/media/GR-55-USB-Anlyzer.html


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
