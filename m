From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: My issues with the ALSA API
Date: Thu, 10 Apr 2008 17:20:38 +0200
Message-ID: <20080410152038.GD5852@tango.0pointer.de>
References: <20080409221512.GA4466@tango.0pointer.de>
	<Pine.LNX.4.61.0804100951180.13990@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 4824E24442
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 17:20:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0804100951180.13990@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10.04.08 10:16, Jaroslav Kysela (perex@perex.cz) wrote:

> Mixer
> =====
> 
> Please explain this question (why you need the dB <-> value conversion, 
> we assumed that application works in dB or integer range not both):
> 
> 'It is possible to query the dB range of a smixer element. And it is 
> possible to query and set the current dB level. However, it is not 
> possible to have a dB value converted to an integer level or vice versa, 
> without touching the actual setting. i.e. a question like "What is the 
> integer level 0 dB corresponds to?" can not be answered by ALSA. Which 
> happens to be a serious limitation.'

I can think of many reasons, they all have to do with the fact that
the dB scale is not integral, i.e. in contrast for the normal integer
scale you won't always get what you are asking for, because the
hardware only supports a value below or above what you asked for: a) a
volume control tool might want to show a slider that is linear to the
dB scale, but also shows which dB values are actually selectable from
it via small black lines on the side (or suchlike) b) PA doesn't make
use of positive dB values -- it limits itself to attenuation via the
mixer. However, right now there is no way to find out which actually
supported dB value is the nearest one to 0dB. c) Several different dB
values may refer to the same actual hw setting. It would be good if a
specific dB value actually maps to the same integer hw setting as some
other value, to surpress redundant "volume change" events.

And I am pretty sure people could think of more cases.

> PCM
> ===
> 
> Timestamps - since 1.0.16 monotonic clocks are usable

Hmm, not really, as I hope I made clear in my other posting.

> plughw: issue - since 1.0.16 you can pass SND_PCM_NO_AUTO flags to open 
> function to disable specific conversions

Awesome, thank you very much! This is exactly what I need. I updated
the page accordingly.

> buffer mananagement - I think we already discussed this - use sw_params or 
> PCM timer to be updated when buffer position changes (interrupt was
> processed), you can use poll() as well

I am doing this now. I'd still love to see an API for naked
interrupts, though.

> What do you mean with 'There is no API to query the granularity of 
> snd_pcm_delay()' ? Application should not know details about bottom 
> implementation.

As far as I understood there are a few soundcards around where
the playback sample index is only known each time the hw changes to
the next fragment. It would be good to know about this, to tweak the
time interpolation in timer-based scheduling.

> Documentantion - if you ask specific questions, we try to update 
> documentantion for other developers.. unfortunately, saying that whole 
> documentantion is bad is not productive

Sorry. I'll make sure I'll ask for clarifications more clearly on
alsa-devel from now on.

Here's my first batch of questions:

I am not sure I get what the "transfer align" is about.

It is not clear how snd_pcm_update_avail() and snd_pcm_hwsync()
actually play together, why they exist at all, and how exactly the
optimization they are apparently useful for should  be used.

It would be good to have an explanation what a "card", what an "id",
what a "name", what a "device" and what a "subdevice" actually refers
to, with examples.

regarding hw params: What exactly is "double buffering",
"sample-resolution mmap", "block transfer", "batch", "sync_start" ,
"fifo_size", "subformat", "export buffer", "min align"; why there is a
need for a seperate can_pause() and can_resume()? When and how should
all these options be used?

BTW: the doc for is_batch is copied 1:1 from the double_buffer text.

The docs speak of "blocked" and "non-blocked" open. It should be
"blocking", I believe.

regarding sw params: What exactly is a "boundary"? Difference between
tstamp modes? how do silence_size and silence_threshold relate?

What is snd_pcm_xrun_t useful for? (I think it is obsolete, should
also be removed from docs, then)

Why is snd_pcm_scope included in the normal PCM docs?

> stderr output - you can redirect all outputs via 
> snd_lib_error_set_handler().

Ah, awesome, didn't find that one. Thanks.

> My plans for near future are to implement a better PCM device enumeration 
> and try to simplify mixer and add the mixer <-> PCM relationship.

That would be great.

> Also, could you explain why current device enumeration is not useful to 
> hotplug? There is information which card will be used (CARD=).

It's an API that returns a static list. That's all. 

Thanks,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
