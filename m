From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: another ALSA question
Date: Mon, 28 May 2007 17:55:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0705281738360.7894@tm8103.perex-int.cz>
References: <20070413191258.GA15076@suse.de>
	<b130c85e0704140922v7a7b15acj3f36a8c2537dd0ca@mail.gmail.com>
	<Pine.LNX.4.61.0704141913320.7963@tm8103.perex-int.cz>
	<46211955.60701@gmail.com>
	<Pine.LNX.4.61.0704142019590.7963@tm8103.perex-int.cz>
	<465AC260.3060601@gmail.com>
	<Pine.LNX.4.61.0705281356090.7894@tm8103.perex-int.cz>
	<465AE6A8.4040906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3247724720
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 17:55:48 +0200 (CEST)
In-Reply-To: <465AE6A8.4040906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


I'm CCing alsa-devel because this discussion might be interesting for 
other developers, too.

On Mon, 28 May 2007, Maarten Lankhorst wrote:

> Jaroslav Kysela schreef:
> > On Mon, 28 May 2007, Maarten Lankhorst wrote:
> >   
> >> After playing around a little more with alsa I tried to do manipulation
> >> of pointer using the instructions, I wrote some simple code either does
> >> rewind or forward to get to the right point, taking in respect the
> >> amount of delay and where to go.
> >>
> >> However it doesn't seem to work: Looking at the source code it seems
> >> rewinding isn't implemented, using the #if 0'd code there gives problems
> >> when doing snd_pcm_forward later: It then ends up at the pointer where
> >> the sound is currently being played at.
> >>     
> >
> > Not all alsa-lib plugins are capable or have implemented this fine 
> > position control (check error value).
> >   
> For a plugin like dmix, I would expect it to be implemented, especially
> since most cards sold are integrated cards that don't have multiple
> sound buffers.

Go ahead and send us patches. We're doing open source :-) Anyway any 
rewind operation mens "undo" - it will eat extra CPU ticks for nothing.

> >> As workaround I used the following in my own code:
> >> typeof(snd_pcm_forward) snd_pcm_mmap_appl_forward;
> >> #define snd_pcm_forward snd_pcm_mmap_appl_forward
> >>
> >> typeof(snd_pcm_rewind) snd_pcm_mmap_appl_backward;
> >> #define snd_pcm_rewind snd_pcm_mmap_appl_backward
> >>
> >> This works, but I wonder if there is a cleaner way to do it.
> >>     
> >
> > It won't work with all plugins and mentioned functions are not part of 
> > public API.
> >   
> As I work in wine on it's DirectSound implementation, I can tell it
> relies heavily on the fact that it can lock a buffer at an arbitrary
> position, and that it works with absolute pointers, rather then
> relative. So if snd_pcm_rewind/snd_pcm_forward don't work as expected,
> an alsa driver for it would become nearly useless, I don't expect it to
> always work, but I would expect it to work for a common plugin like dmix
> at least.
> >> Also, I noticed some audio glitches when using this in combination with
> >> alsa-lib's resampling, is that because of the way it is done or is
> >> something else wrong?
> >>     
> >
> > You should not use mentioned functions.
> >
> > You can try to use the direct hardware access (hw:CARD_NAME) devices 
> > (you'll lose all stream conversions from the ALSA side) or use an 
> > intermediate buffer for fine position control and configure ALSA to use 
> > smallest ring buffer as possible (to minimalize latency).
> >
> > 						Jarosla
> I wish that would work, directsound expects to have access to a fixed
> size buffer, and if I go for direct hardware access, I lose the ability
> to work properly with most cheap cards on the market, since people want
> to be able to listen to music on background while gaming. For now it
> seems I have to use the internal calls in case of dmix, or modify
> already committed data, which is what winealsa's current driver does. I
> don't know what is the least of those 2 evils, or if there is a third
> option. I'm open for advice.

I'm afraid, that you're trying to exactly copy DirectSound API. Playing 
with the buffer position in this way is always dangerous, because it's 
really hard to predict the final result in the multitasking environment.

Think about these proposals:

1) what sample (ring buffer) rewritting is supposed to do - maybe you can 
   change only not yet commited samples with satisfactory results
2) use a small ALSA ring buffer and use own "big" ring buffer for changes 
   before you commit samples to ALSA's ring buffer - you'll increase a bit 
   sample flow latency, but you can do anything you want (you just add 
   extra buffering to avoid rewind / forward for ALSA API)
3) fix (or better implement) dmix plugin rewind function

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
