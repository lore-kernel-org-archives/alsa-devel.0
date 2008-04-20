From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: My issues with the ALSA API
Date: Sun, 20 Apr 2008 03:31:32 +0200
Message-ID: <20080420013132.GA22690@tango.0pointer.de>
References: <20080409221512.GA4466@tango.0pointer.de>
	<Pine.LNX.4.61.0804100951180.13990@tm8103.perex-int.cz>
	<20080410152038.GD5852@tango.0pointer.de>
	<s5h7iez48fz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id EB1F12434E
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Apr 2008 03:31:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7iez48fz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 15.04.08 14:19, Takashi Iwai (tiwai@suse.de) wrote:

> > As far as I understood there are a few soundcards around where
> > the playback sample index is only known each time the hw changes to
> > the next fragment. It would be good to know about this, to tweak the
> > time interpolation in timer-based scheduling.
> 
> We may add some hints to the PCM information, but I think maybe this
> isn't only the question about granualrity.  For example, on some
> hardwares, the query of the current position costs much due to the
> hardware design.

What is "much" if I may ask?

> > > Documentantion - if you ask specific questions, we try to update 
> > > documentantion for other developers.. unfortunately, saying that whole 
> > > documentantion is bad is not productive
> > 
> > Sorry. I'll make sure I'll ask for clarifications more clearly on
> > alsa-devel from now on.
> > 
> > Here's my first batch of questions:
> > 
> > I am not sure I get what the "transfer align" is about.
> 
> Just ignore, this is obsoleted in the latest version :)

Please remove from the docs, then!

Also the part in the "Managing parameters" chapter in the PCM
introduction text.

> > It is not clear how snd_pcm_update_avail() and snd_pcm_hwsync()
> > actually play together, why they exist at all, and how exactly the
> > optimization they are apparently useful for should  be used.
> 
> The detailed description is found in PCM documentation.

Uh, and that's the part I don't get. I did read it, and didn't get
it. What exactly does _hwsync() do that _update_avail() doesnt?

> > It would be good to have an explanation what a "card", what an "id",
> > what a "name", what a "device" and what a "subdevice" actually refers
> > to, with examples.
> 
> The card (index) is the index number of the sound card instance.
> Each card has an id string and name string(s).
> One card instance may have several belonging components.  And each
> component has (usually) a device index.  Some components (e.g. PCM or
> rawmidi) can have multiple subdevices (or substreams).  Each subdevice
> has a subdevice index.

The question remains: what exactly is is a "device" and what is a
"subdevice"? Examples?

For a while I thought that for those sound cards wich can output to
SPDIF and analog at the same time we have two different device
indexes, but a single card index. However, for my HDA card that is
listed in /proc/asound/pcm as "04-00 ALC882 Analog" and "04-01 ALC882
Digital", aplay -L suggests to use "ec958:CARD=Intel,DEV=0" for spdif
and "front:CARD=Intel,DEV=0" for analog -- both times with DEV=0!
Since then I have no idea what devices, subdevices and stuff should
actually be.

So again, what exactly qualifies subdevices? Do they share a single
crystal? Are they usually combined for multi-channel output? What's
the story?

> > regarding hw params: What exactly is "double buffering",
> > "sample-resolution mmap", "block transfer", "batch", "sync_start" ,
> > "fifo_size", "subformat", "export buffer", "min align";
> 
> Most of them can be ignored, at least for PA :)  I'd love to get rid
> of most of them in future, too.

Really? "block transfer" sounds to me like something that would be
interesting for mmap playback for cases where i randomly seek around
in my mmap buffer, with frame granularity. Which is exactly what I do
all the time in PA.

> > why there is a
> > need for a seperate can_pause() and can_resume()?
> 
> can_pause() means the ability to pause/restart the stream.
> 
> can_resume() means the ability to resume the suspended/hibernated
> stream by the driver natively.

Uh. This has very confusing naming.

> > regarding sw params: What exactly is a "boundary"? Difference between
> > tstamp modes?
> 
> The boundary defines the limit PCM position (frames) can reach.  When
> the PCM position reaches to the boundary size, then it backs to 0 at
> next.  The boundary size is aligned to the buffer size, and it's not
> LONG_MAX (although close to it).

But what is this interesting for? I mean, I cannot read the raw
hardware pointer index anyway from ALSA, so why should I care?

Or is it all for the case where I create a *major* buffer underrun
with disabled stop_threshold and the value of _update_avail() keeps
increasing but eventually wraps around?

> > how do silence_size and silence_threshold relate?
> 
> The PCM driver core has a feature to clear the samples automatically
> at each period elapse call.  The silence_size and silence_threshold
> defines this behavior.

But in which way? Please elaborate!

> > What is snd_pcm_xrun_t useful for? (I think it is obsolete, should
> > also be removed from docs, then)
> 
> Right.  Maybe should be classified to the section "obsoleted
> functions".  A part of the problem is that the reference document is
> generated via doxygen, and it seems a bit confusing to arrange the
> sections in a single file.

You can use stuff like \cond in doxygen to hide certain parts of the
API pretty easily. 

> > Why is snd_pcm_scope included in the normal PCM docs?
> 
> I guess it was thought it'd be pretty useful.

Maybe the plugin is useful. But why is it part of the API docs?

Thanks,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
