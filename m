From: Mark J Roberts <mjr@znex.org>
Subject: Re: Patch to fix LIN_OUT1 on Audigy2 cards (+ others)
Date: Fri, 21 Mar 2003 03:11:08 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030321091108.GA1324@znex>
References: <200303120648.HAA27496@www1.pobox.sk> <200303122216.33901.adq_dvb@lidskialf.net> <20030318051812.GA1810@znex> <200303182213.12650.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200303182213.12650.adq_dvb@lidskialf.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: p z oooo <pzad@pobox.sk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Andrew de Quincey:
> Cool, I'll add that to my list
> BTW, attached is my current state of analysis of the mixer devices.. not 
> complete yet (been very busy recently).
> 
> If you can be bothered, can you confim what I've got so far?

I've obviously had little success being bothered so far... I guess
I'll post what I can right now.

> * Tone
> 
>   Switch to enable tone controls
>   Umuted: enabled
>   Muted: disabled
> 
> * Bass
> 
>   Controls output Bass.
> 
> * Treble
> 
>   Controls output Treble.

These work here too.

> ? Surround

IIRC, with "aplay -D rear out.dat", this will control its volume.

> * Wave
> 
>   Master control volume of PCM data (and ONLY PCM data).
>   Volume controls work.

Controls my line1 and spdif out. BTW, do you know how I can output
to the rca spdif out ("Optical IEC958"), _without_ outputting to
anything else? I want to run my iiwusynth output through an effects
processor but I can't figure out how to do it properly without
feedback.

mjr$ aplay -D iec958 out.dat
ALSA lib pcm_hw.c:1078:(snd_pcm_hw_open) open /dev/snd/pcmC1D3p failed: No such device

is one thing i tried without success.

Unrelated: it's interesting that my audigy1's line1 output was quite
a bit louder than the audigy2's, though it had a worse noise floor
even when turned down to a comparable level. Weirdly, the OSS driver
for it was softer, about comparable to my audigy2 right now.

> ? Wave Center
> ? Wave LFE
> ? Wave Surround

All working here.

> ? Music
> ? Music Capture
> * Line
> 
>   Controls input from LIN_IN on card.
> 
>   Mute/unmute works.
>   Volume controls work.
>   Needs to be selected as a capture input.
> 
> * Line2
> 
>   Controls input from "Line 2"/"Mic 2" on drive.
>   Volume controls work.
> 
> ? Line2 Capture
> * CD
> 
>   Controls input from CD_IN on card.
>   Mute does not work.
>   Volume does not work.
>   Needs to be selected as a capture input.
>   Volume is controlled by Capture+AC97.
> 
> ? Mic
> ? Mic Boost
> ? Mic Select
> ? Video
> ? Phone
> ? PC Speaker
> * Aux
> 
>   Controls input from AUX_IN on card.
>   Volume does not work.
>   Needs to be selected as a capture input.
>   Volume is controlled by Capture+AC97.
> 
> * Aux2
> 
>   Controls input from Aux In 2 on drive.
>   Volume controls work.
> 
> ? Aux2 Capture
> ? Mono Out

All untested, sorry.

> * Capture
> 
>   Provides master control for all capturing.
> 
>   Volume control works and affects all captures.
>   Select as a capture device to enable capture. Deselect to disable all capturing.

I've been able to capture from spdif without turning up this
slider... I'm not really sure about the specifics now.

> ? Mix
> ? Mix Mono
> ? AC97
> ? AC97 Capture
> * Audigy Analog/Digital Output Jack
> 
>   Controls switch between output on LIN_OUT1, LIN_OUT2, LIN_OUT3 and Digital-out-jack on card.
>   Needs the special creative speakers to take advantage of digital (Audigy/2 cannot encode AC3)
>   Can also passthrough pre-encoded AC3 (e.g. from a DVD)
> 
>   Unmuted: Analogue output
>   Muted:   Digital output through
> 
> * Audigy CD
> 
>   Controls input from CD_SPDIF connector.
> 
> ? Audigy CD Capture
> ? External Amplifier Power Down

All untested.

> ? Optical IEC958
> ? Optical IEC958 Capture

These are my audigy-drive rca spdif sliders.

> ? RCA SPDIF
> ? RCA SPDIF Capture

I don't know what these are supposed to do, given the above...

Oh, and MIDI input is still an unresolved issue. No interrupts, etc,
through the gameport and the drive. Output works on both. Maybe a
problem with snd_emu10k1_intr_enable()? Without datasheets I am
totally hopeless...


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
