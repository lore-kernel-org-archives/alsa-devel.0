From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Tascam US-224 support: MIDI OK, Audio KO?
Date: Mon, 29 Mar 2004 22:41:08 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32817.192.168.1.5.1080596468.squirrel@www.rncbc.org>
References: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>
    <200403292129.04497.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403292129.04497.annabellesgarden@yahoo.de>
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

Hi Karsten, Martin,

Karsten wrote:
> I only have a us428 here, so I assume us224 behaves the same.
>
> could it be it is already running (started by hotpug scripts which were
> installed with alsa)?
> Did you try "ps -aux|grep us428control" ?
> 	aconnect -li gave you among others
> 	 client 129: 'US-428' [type=user]
> 	     0 'Controls        '
> this usually is due to us428controls activity.
>>

Yes us428control is indeed already running, spawned by the hotplug scripts
alright. How could I miss that? :)

OK. The first thing I tried then was killing it and restarting it by hand:

   us428control -v2 -D hw:1

By tweaking some knobs and faders it seems that its working. I have the
verbose feedback OK, or so I think. Below, you can find some data that
I've collected here. Please check if it's the same or similar that you
find for the US-428.


>>
>> The second one is about the LEDs on the control surface: besides the
>> USB light, isn't that supposed to light up anything else? Everything
>> else is dead dark. Touching the knobs, pushing the buttons or whatever
>> doesn't make any visible difference. Is that supposed to be normal?
>
> if us428control is running ok (AND fits the us224), INPUT MONITOR Led
> is functional.

Nope. INPUT MONITOR never gets lit, despite the verbose output of
us428control saying otherwise (see below).


> Also if INPUT MONITOR Led is ON, SELECT and MUTE Leds work.
>

Neither of those leds get ON, no matter how much I try to play with them.
Only darkness I see.


> us428 MASTER Slider behaves funny here:
> if it is set to MAXIMUM at Firmware BootUp, it tells us428control
> that it is ZEROed!
> To hear audio here I have to set MASTER Fader below MAX first.
> Later I can put it to MAX and it behaves as expected.
>

Tried several positions. Can't hear a thing. No output, only silence


> Hope the above helps. Mixer support isn't yet written, sorry.
>

Hmmm. Is it planned any time soon? Can I help in any way?


> To see if capturing works:
> can you record a file and it looks like expected in an audio editor?
>

YES. Capture works. I've tested with `arecord -D hw:1 take1.wav` and I can
hear my guitar. Obviously I had to feed the captured file into the onboard
soundcard to get to ear it.

After all, it's only playback that's missing. Oh, and no leds too.


> (UHCI worked more often than OHCI, but also UHCI can be tricky:
> on a via mobo one connector does it, but the other not !?!)
>

As I noted, I'm testing on two quite different machines, a desktop and a
laptop. The desktop one seems to be using UHCI (although ohci, uhci and
ehci modules are all loaded in). The laptop one is OHCI for sure and only.

AFAICT, the behaviour is quite the same on either system. No playback
sound, at least via PHONES output.


Now follows the data I collected while watching `us428control -v2 -D hw:1`
output. Hope it sheds some light.


-- Jog wheel:

poll returned 0x1
Last is 0
                                                            00
poll returned 0x1
Last is 1
                                                            01
poll returned 0x1
Last is 2
                                                            02
.                                                           .
.                                                           .
.                                                           .
poll returned 0x1
Last is 15
                                                            xx

-- [INPUT MONITOR] button:

poll returned 0x1
Last is 1
                              01 00 00 00 06 00 00 00 00 00 xx
Knob InputMonitor now 1 Light is 1
poll returned 0x1
Last is 2
                              00 00 00 00 06 00 00 00 00 00 xx
Knob InputMonitor now 0 Light is 1


-- [INPUT MONITOR] button (twice):

poll returned 0x1
Last is 4
                              01 00 00 00 06 00 00 00 00 00 xx
Knob InputMonitor now 1 Light is 0
poll returned 0x1
Last is 5
                              00 00 00 00 06 00 00 00 00 00 xx
Knob InputMonitor now 0 Light is 0


-- [NULL] button:

poll returned 0x1
Last is 6
                           80 00 00 00 00 06 00 00 00 00 00 xx
Knob 79 now 1
poll returned 0x1
Last is 7
                           00 00 00 00 00 06 00 00 00 00 00 xx
Knob 79 now 0


-- [<< LOCATE] button:

poll returned 0x1
Last is 9
                              08 00 00 00 06 00 00 00 00 00 xx
Knob 83 now 1
poll returned 0x1
Last is 10
                              00 00 00 00 06 00 00 00 00 00 xx
Knob 83 now 0


-- [LOCATE >>] button:

poll returned 0x1
Last is 1
                              10 00 00 00 06 00 00 00 00 00 xx
Knob 84 now 1
poll returned 0x1
Last is 2
                              00 00 00 00 06 00 00 00 00 00 xx
Knob 84 now 0


-- [SET] button:

poll returned 0x1
Last is 3
                              20 00 00 00 06 00 00 00 00 00 xx
Knob 85 now 1
poll returned 0x1
Last is 4
                              00 00 00 00 06 00 00 00 00 00 xx
Knob 85 now 0


-- [< BANK] button:

poll returned 0x1
Last is 7
                              02 00 00 00 06 00 00 00 00 00 xx
Knob 81 now 1
poll returned 0x1
Last is 8
                              00 00 00 00 06 00 00 00 00 00 xx
Knob 81 now 0


-- [BANK >] button:

poll returned 0x1
Last is 9
                              04 00 00 00 06 00 00 00 00 00 xx
Knob 82 now 1
poll returned 0x1
Last is 10
                              00 00 00 00 06 00 00 00 00 00 xx
Knob 82 now 0


-- [REW] button:

poll returned 0x1
Last is 11
                           10 00 00 00 00 06 00 00 00 00 00 xx
Knob 76 now 1
poll returned 0x1
Last is 12
                           00 00 00 00 00 06 00 00 00 00 00 xx
Knob 76 now 0


-- [F FWD] button:

poll returned 0x1
Last is 13
                           08 00 00 00 00 06 00 00 00 00 00 xx
Knob 75 now 1
poll returned 0x1
Last is 14
                           00 00 00 00 00 06 00 00 00 00 00 xx
Knob 75 now 0


-- [STOP] button:

poll returned 0x1
Last is 15
                           04 00 00 00 00 06 00 00 00 00 00 xx
Knob 74 now 1
poll returned 0x1
Last is 0
                           00 00 00 00 00 06 00 00 00 00 00 xx
Knob 74 now 0


-- [PLAY] button:

poll returned 0x1
Last is 1
                           02 00 00 00 00 06 00 00 00 00 00 xx
Knob 73 now 1
poll returned 0x1
Last is 2
                           00 00 00 00 00 06 00 00 00 00 00 xx
Knob 73 now 0


-- [RECORD] button:

poll returned 0x1
Last is 3
                           01 00 00 00 00 06 00 00 00 00 00 xx
Knob 72 now 1
poll returned 0x1
Last is 4
                           00 00 00 00 00 06 00 00 00 00 00 xx
Knob 72 now 0


-- Channel controls:

poll returned 0x1
Last is 1
f1 f2 f3 f4 fm 00 00 00 00 00 00 00 ss mm 06 00 00 00 00 00 xx

where:

f1..4 - each one of the 4 channel faders
fm - master fader
mm - [MUTE] button   (bitflag 00=1,..08=4)
ss - [SELECT] button (bitflag 00=1,..08=4)


-- [SOLO] button:

poll returned 0x1
Last is 2
                           20 00 00 00 00 06 00 00 00 00 00 xx
Knob 77 now 1
poll returned 0x1
Last is 3
                           00 00 00 00 00 06 00 00 00 00 00 xx
Knob 77 now 0


-- [REC] button:

poll returned 0x1
Last is 4
                           40 00 00 00 00 06 00 00 00 00 00 xx
Knob 78 now 1
poll returned 0x1
Last is 5
                           00 00 00 00 00 06 00 00 00 00 00 xx
Knob 78 now 0


--
OK. That's all for today,


Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
