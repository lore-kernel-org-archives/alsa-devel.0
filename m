From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCM questions
Date: Thu, 4 Mar 2004 19:43:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403041932480.2204@pnote.perex-int.cz>
References: <1078416129.1865.868.camel@renegade>
 <Pine.LNX.4.58.0403041720490.2204@pnote.perex-int.cz> <1078422542.1866.899.camel@renegade>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078422542.1866.899.camel@renegade>
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

On Thu, 4 Mar 2004, Ove Kaaven wrote:

> tor, 04.03.2004 kl. 17.33 skrev Jaroslav Kysela:
> > The silence is filled at snd_pcm_start(). This mode is special one for
> > our direct plugins. I don't think that other code need to use this mode.
> 
> Well, perhaps you don't think so, but the code we're trying to use here
> does work much like any "direct plugins"... mixes several dynamic
> streams, probably much like the dmix plugin does.

Yes, but note that you can still enable the "auto silence" mechanism 
which does empty buffer at snd_pcm_start().

> > > mmap buffer with sounds, then run snd_pcm_start. Right now when I do
> > > that, the beginning of the sound effect that triggers snd_pcm_start is
> > > silent (but more gets streamed into the mmap buffer later on, and that
> > > is heard). With ALSA's oddball mmap scheme it's not like I could just
> > > easily do the silence processing myself, so it would be nice if ALSA's
> > > would do the right thing.
> > 
> > You can do everything like in OSS. It seems that you don't understand 
> > API concepts. Forget to ALSA silence extensions and do it yourself
> > if you wish (simply put stream into no-xrun mode and use rewind and 
> > forward functions to move the actual write pointer).
> 
> Are you saying that the design of the API is very different from what is
> considered the appropriate way to do things, so that using the API in
> awkward ways are endorsed, while using all the API features in
> straightforward ways, the way it is apparently designed, is discouraged?

Not really. I don't know, what you're trying to do. The silence extension
can be used to silence played area automatically from the interrupt 
contents. If you set "silence_threshold" and "silence_size" to 
buffer_size, then the whole _unused_ portion of the ring buffer will be 
filled with silence. Perhaps, that's the behaviour what you expect.

I wanted to note, that we can do everything like OSS API does.

> Well, concerns of having to resort to messy application-side code to
> reimplement ALSA API features aside, there's also the issue of whether
> to rewind to before the playing position, or rather to forward to one
> buffer size after the playing position, to insert the silence, since for
> the ALSA API, there's a difference. But perhaps forward makes most
> sense. I guess I can do that.

I don't understand.

> > It is wavetable synthesizer API not PCM API. This part of ALSA is still
> > in the development phase.
> 
> But when that gets fully developed, would I have to use the rawmidi API
> to do this then?

I think that sequencer API is more appropriate, but as I said, we don't 
have a clear design at this time. It's also possible that we will hide 
these things in alsa-lib and the kernel API will be hardware specific 
using the hwdep interface.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
