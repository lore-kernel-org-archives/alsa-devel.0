From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: snd_pcm_delay, hw buffers and driver api (v2)
Date: Sat, 15 Aug 2009 01:02:37 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.0908142201380.3417@ecabase.localdomain>
References: <alpine.DEB.1.10.0908140023240.3417@ecabase.localdomain>
	<ad2655cb0908140338q21ed09d6xd750bff561805d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 018FC2446F
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Aug 2009 00:02:15 +0200 (CEST)
In-Reply-To: <ad2655cb0908140338q21ed09d6xd750bff561805d5a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, 14 Aug 2009, James Courtier-Dutton wrote:

> snd_pcm_delay() does not just support exposing a fixed latency. The
> value returned is dynamic.

yes, I'm aware of that, and I was in fact quoting the documentation in my 
original mail, which indeed states that (although there are two 
descriptions, written with slightly different wording in alsa-lib pcm.c).

> In the current ALSA implementation, the value returns a real time
> count of how many samples are already in the hardware buffer.
> So, if one makes a call to snd_pcm_delay(), waits for a period of a
> few samples, the new value returned in snd_pcm_delay() is going to be
> different, but only for sound cards that support this level of
> accuracy.
[...]
> So, I think the snd_pcm_delay() function is already doing what you 
> want. It was me who originally requested the snd_pcm_delay() function to be
> introduced into the API, for the purposes of audio/video sync in the
> media player xine.

Yes, acking that as well. It's just that we now start to have more drivers 
for HW, which include separate, fairly big, buffers of their own. I.e. 
something like the "URB buffering" of USB audio, but with potentially even 
larger buffers. My understanding is that so far these delays have not been 
exposed via ALSA and snd_pcm_delay(), although semantically these should 
be taken into consideration in the result of snd_pcm_delay() (as they 
directly affect e.g. a/v sync).

So if we have drivers that could expose this information, my question 
is how to do it with ALSA.

I've been looking at the ALSA code, and e.g. current implementation of 
snd_pcm_delay()->snd_pcm_hw_delay() in alsa-lib/src/pcm/pcm_hw.c, just 
returns the diff between 'hw_ptr' and 'appl_ptr'. The 
SNDRV_PCM_IOCTL_DELAY is called only for cases where the control structs 
cannot be mmap'ed, and the result is the same anyways. On the kernel side, 
drivers just implement the "pointer" method returning one value (-> 
hw_ptr). This tells the delay to last transfer from ringbuffer to/from HW, 
but not necessarily the full latency up until the codec.

Now one approach is full double-buffering, or virtualizeing the 'hw_ptr',
(this seems to be done in e.g. the cs46xx driver). This is certainly one
way to do it, but it seems somewhat messy, and based on earlier discussion 
(see the archive links in my original post to this thread), at least some 
of you share this view. A potential problem is for instance if application 
wants to do late mixing of samples and resubmit the samples 
[hw_ptr+X,hw_ptr+X+Y] in the ringbuffer. With the virtualized hw_ptr 
(usb-audio,cs46xx), this range might already been transfered to the HW, 
and thus application edits of that range will be discarded. You can warn 
applications about this by declaring SNDRV_PCM_INFO_BATCH/BLOCK_TRANSFER 
flags in the driver (as is done by usb-audio+cs46xx), but for apps, an 
accurate hw_ptr reflecting which parts of ringbuffer have been consumed, 
would be easier to handle.

Basicly transfering the bytes from the ALSA ringbuffer to a 
codec/dsp-memory, and actually playing those samples out a DAC or digital 
interface, are two different things, and ideally the application could 
track both of these pieces of information. Former is important for i/o 
scheduling, latter for e.g. a/v sync.

So one alternative would be to extend the driver interface, so that they 
could expose both pieces of info. The 'pointer' method would return 
ringbuffer/hw_ptr as currently, and a new interface would provide the 
"virtualized hw-ptr".

Then how to expose this to apps is a bit more tricky. Semantically just 
exposing this via snd_pcm_delay() would seem ok (as the info is needed for 
a/v sync), but it risks breaking existing apps (as the returned delay can 
be significantly higher than the overall ringbuffer size).

Alternatively, I'm missing some obvious and easy solution to this problem, 
but I'm hoping that in that case someone will point it out to me. :)

PS On existing mechanism is snd_pcm_hw_params_get_fifo_size(). But
    this is a fixed value, and very few apps seem to be using this (e.g.
    to fine-tune their a/v sync in a portable manner).
