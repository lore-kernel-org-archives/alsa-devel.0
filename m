From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCM questions
Date: Thu, 4 Mar 2004 17:33:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403041720490.2204@pnote.perex-int.cz>
References: <1078416129.1865.868.camel@renegade>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078416129.1865.868.camel@renegade>
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

> Okay, whoever says ALSA is greater than OSS, I'm trying to act on your
> assertions, so here are a few questions.
> 
> I have the primary PCM configured with silence_threshold set to zero and
> silence_size set to MAXINT. This condition is documented as "The whole
> ring buffer is filled with silence at start. Later, only just processed
> area is filled with silence."
> 
> When is "start"? Is it snd_pcm_prepare, or snd_pcm_start? If it's the
> latter, it's not too useful, as I currently snd_pcm_prepare, fill the

The silence is filled at snd_pcm_start(). This mode is special one for
our direct plugins. I don't think that other code need to use this mode.

> mmap buffer with sounds, then run snd_pcm_start. Right now when I do
> that, the beginning of the sound effect that triggers snd_pcm_start is
> silent (but more gets streamed into the mmap buffer later on, and that
> is heard). With ALSA's oddball mmap scheme it's not like I could just
> easily do the silence processing myself, so it would be nice if ALSA's
> would do the right thing.

You can do everything like in OSS. It seems that you don't understand 
API concepts. Forget to ALSA silence extensions and do it yourself
if you wish (simply put stream into no-xrun mode and use rewind and 
forward functions to move the actual write pointer). This mode is same
as OSS offers.

> And is there a way to query what the current application frame position
> is, without tracking it myself? Have to do a lot of rewinds (and
> forwards) here to add more sound effects to the mmap buffer and such,
> and being able to sanity-check the offsets would probably be nice.

These pointers are hidden, so you need to track the actual position in 
application (which is not too difficult). Note that most of application
does not ugly things with the DMA buffer, so they don't require to know
the hardware pointers directly.

> And for sound cards capable of hardware mixing, is there a way to have
> two PCMs that share a buffer, but can be still be started and stopped
> independently? For example, if I've loaded an explosion sound into a PCM
> buffer, how can I start a lot of explosion sounds, without wasting a lot
> of RAM? Perhaps there's also a way to specify that this sound should be
> loaded into the sound card's onboard memory, instead of streamed from
> system RAM?

It is wavetable synthesizer API not PCM API. This part of ALSA is still 
in the development phase.

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
