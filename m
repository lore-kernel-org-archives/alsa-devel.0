From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCM hw mixing with volume
Date: Tue, 09 Mar 2004 09:26:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403091426.i29EQv9o016723@dhin.linuxaudiosystems.com>
References: <1078781348.18057.85.camel@renegade>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 08 Mar 2004 22:29:08 +0100."
             <1078781348.18057.85.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>And by that time, games will be even more demanding than before, and
>still want to use those cycles for itself rather than software sound
>processing, so just sitting idle waiting for the ultimate
>infinite-megahertz cpu, that can do everything in no time, gains nobody
>anything... at least our business won't.

but don't you also want to be able to sell as many copies as possible
to as many satisfied customers as possible? if so, you have to pay
attention to whatever standards can be found for the domain at
hand. in this case, the AC97 codec spec (and its recent successor
whose name i forget) is about the most relevant thing i can think
of. AFAIK, AC97 etc. say nothing about the kinds of gain control and
mix routing that exist for multiple PCM streams. ergo, there is no
standard way to do this that will work across a significant fraction
of the installed and/or potential user base.

so, either ALSA can come up with such a thing, which might be
interesting but the manpower available to work on it is very limited,
or parties that have a vested interest in it can use an existing API
(SDL springs to mind, though i've never looked at it) or develop a new
one that provides a standard mechanism for doing wat you want.

i mean, even at the most basic level, the audio interface that is
built into my laptop motherboard (some intel nonsense) cannot do any
sample rate other than 48kHz! this is a high end laptop (HP Pavilion
zd7000, 3GHz processor, 1440x900 display, etc) ... think of the cycles
that will be spent *resampling* your audio independently of the mixing
step. this type of BS seems to be growing more and more common. if i
was in your position (specifically, if i have to assume that my user
base spent a (comparatively) lot of money on a graphics card, maybe
even paid for a 5.1 speaker setup, but are still using the
factory-provided audio interface, i would assume the absolute worst
capabilities for that interface that i could: single sample rate,
single PCM stream, no mixer.

and btw, i wasn't suggesting that you just "sit there waiting". my
point was that the time you might spend working on this could be spent
working on something else, and by the time you're done, CPU speed
increases will have done this particular task for you.

--p



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
