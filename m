From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: PCM questions
Date: Thu, 04 Mar 2004 20:54:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078430057.30309.921.camel@renegade>
References: <1078416129.1865.868.camel@renegade>
	 <Pine.LNX.4.58.0403041720490.2204@pnote.perex-int.cz>
	 <1078422542.1866.899.camel@renegade>
	 <Pine.LNX.4.58.0403041932480.2204@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403041932480.2204@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

tor, 04.03.2004 kl. 19.43 skrev Jaroslav Kysela:
> Not really. I don't know, what you're trying to do. The silence extension
> can be used to silence played area automatically from the interrupt 
> contents. If you set "silence_threshold" and "silence_size" to 
> buffer_size, then the whole _unused_ portion of the ring buffer will be 
> filled with silence. Perhaps, that's the behaviour what you expect.

Well, I was afraid that mode would not work well when I rewinded to add
more sfx, I would risk getting any existing sfx in the buffer cleared.
Or wouldn't I?

> > Well, concerns of having to resort to messy application-side code to
> > reimplement ALSA API features aside, there's also the issue of whether
> > to rewind to before the playing position, or rather to forward to one
> > buffer size after the playing position, to insert the silence, since for
> > the ALSA API, there's a difference. But perhaps forward makes most
> > sense. I guess I can do that.
> 
> I don't understand.

Well, for example, if the buffer size is 16384 frames, the app frame
position is 24576, and the currently playing position is 20480 (so that
snd_pcm_delay returns 4096). Now I want to clear the last 4096 frames
that completed playing. Do I

1) call snd_pcm_rewind(8192), so that app frame position is 16384, which
is logically behind play position (and in a xrun condition)

or

2) call snd_pcm_forward(8192), so that app frame position is 32768,
which is logically after play position (and seeking past potentially
invalid data to get there)

In both cases, begin_mmap should return a pointer at the beginning of
the buffer and let me clear the desired area of it. But it might make a
difference to xrun recovery, auto-silence, and who knows what else...

But I'll just go for 2), it seems to be most straightforward to achieve
with the current abstraction in our code.

> > > It is wavetable synthesizer API not PCM API. This part of ALSA is still
> > > in the development phase.
> > 
> > But when that gets fully developed, would I have to use the rawmidi API
> > to do this then?
> 
> I think that sequencer API is more appropriate, but as I said, we don't 
> have a clear design at this time. It's also possible that we will hide 
> these things in alsa-lib and the kernel API will be hardware specific 
> using the hwdep interface.

Hmm.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
