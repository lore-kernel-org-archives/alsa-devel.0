From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: PCM questions
Date: Thu, 04 Mar 2004 18:49:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078422542.1866.899.camel@renegade>
References: <1078416129.1865.868.camel@renegade>
	 <Pine.LNX.4.58.0403041720490.2204@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403041720490.2204@pnote.perex-int.cz>
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

tor, 04.03.2004 kl. 17.33 skrev Jaroslav Kysela:
> The silence is filled at snd_pcm_start(). This mode is special one for
> our direct plugins. I don't think that other code need to use this mode.

Well, perhaps you don't think so, but the code we're trying to use here
does work much like any "direct plugins"... mixes several dynamic
streams, probably much like the dmix plugin does.

> > mmap buffer with sounds, then run snd_pcm_start. Right now when I do
> > that, the beginning of the sound effect that triggers snd_pcm_start is
> > silent (but more gets streamed into the mmap buffer later on, and that
> > is heard). With ALSA's oddball mmap scheme it's not like I could just
> > easily do the silence processing myself, so it would be nice if ALSA's
> > would do the right thing.
> 
> You can do everything like in OSS. It seems that you don't understand 
> API concepts. Forget to ALSA silence extensions and do it yourself
> if you wish (simply put stream into no-xrun mode and use rewind and 
> forward functions to move the actual write pointer).

Are you saying that the design of the API is very different from what is
considered the appropriate way to do things, so that using the API in
awkward ways are endorsed, while using all the API features in
straightforward ways, the way it is apparently designed, is discouraged?

Well, concerns of having to resort to messy application-side code to
reimplement ALSA API features aside, there's also the issue of whether
to rewind to before the playing position, or rather to forward to one
buffer size after the playing position, to insert the silence, since for
the ALSA API, there's a difference. But perhaps forward makes most
sense. I guess I can do that.

> > And is there a way to query what the current application frame position
> > is, without tracking it myself? Have to do a lot of rewinds (and
> > forwards) here to add more sound effects to the mmap buffer and such,
> > and being able to sanity-check the offsets would probably be nice.
> 
> These pointers are hidden, so you need to track the actual position in 
> application (which is not too difficult). Note that most of application
> does not ugly things with the DMA buffer, so they don't require to know
> the hardware pointers directly.

Okay.

> > And for sound cards capable of hardware mixing, is there a way to have
> > two PCMs that share a buffer, but can be still be started and stopped
> > independently? For example, if I've loaded an explosion sound into a PCM
> > buffer, how can I start a lot of explosion sounds, without wasting a lot
> > of RAM? Perhaps there's also a way to specify that this sound should be
> > loaded into the sound card's onboard memory, instead of streamed from
> > system RAM?
> 
> It is wavetable synthesizer API not PCM API. This part of ALSA is still 
> in the development phase.

But when that gets fully developed, would I have to use the rawmidi API
to do this then?




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
