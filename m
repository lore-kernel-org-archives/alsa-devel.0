From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: PCM questions
Date: Fri, 05 Mar 2004 10:01:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040305100128.pochini@shiny.it>
References: <s5hishkl9s8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hishkl9s8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Ove Kaaven <ovek@transgaming.com>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


On 04-Mar-2004 Takashi Iwai wrote:

>> > > It is wavetable synthesizer API not PCM API. This part of ALSA is still
>> > > in the development phase.
>> >
>> > But when that gets fully developed, would I have to use the rawmidi API
>> > to do this then?
>>
>> I think that sequencer API is more appropriate, but as I said, we don't
>> have a clear design at this time. It's also possible that we will hide
>> these things in alsa-lib and the kernel API will be hardware specific
>> using the hwdep interface.
>
> i feel hwdep would be more appropriate.
>
> i guess he wants the sound engine, mixing of several streams and
> running efficiently (almost in background) for games, etc.
> it's less music-oriented, but would need just a sample load and
> loop playback function (with panning, volume effect if possible).
> at least, it wouldn't be too difficult to implement it for emu10k1
> (and maybe trident and ymfpci, too, if the sample size is small).

On the Amiga :) it was simple. You only need to tell the hw
to play a block of data at given sample rate, volume, etc.
But most of the cards can't do that. I think one good solution
is to run an "sfx mixer" in a separate thread. That mixer
must provide emulation code if the hardware lacks some of the
required features, at least the basic ones. Device dependent
stuff is not a good idea IMHO.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
