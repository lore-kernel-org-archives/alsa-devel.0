From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Mon, 20 Dec 2004 16:08:55 +0100
Message-ID: <20041220160855.699a1014@mango.fruits.de>
References: <200412102051.iBAKphFL012668@localhost.localdomain>
	<1102712509.29919.46.camel@krustophenia.net>
	<20041211015610.1798af34@mango.fruits.de>
	<20041211032214.5121a003@mango.fruits.de>
	<20041216003255.6e65360b@mango.fruits.de>
	<20041216091812.GE11047@elte.hu>
	<20041216173353.4348dd15@mango.fruits.de>
	<1103222119.23735.2.camel@krustophenia.net>
	<20041220004511.579be209@mango.fruits.de>
	<1103499499.32415.35.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1103499499.32415.35.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: tapas <tapas@affenbande.org>, Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 19 Dec 2004 18:38:19 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> OK the interrupt handler calls snd_pcm_period_elapsed, which calls
> snd_pcm_update_hw_ptr_interrupt, which calls snd_pcm_update_hw_ptr_pos.
> snd_pcm_update_hw_ptr_pos does this (from alsa-kernel/core/pcm-lib.c):
> 
> 151         pos = substream->ops->pointer(substream);
> 152         if (pos == SNDRV_PCM_POS_XRUN)
> 153                 return pos; /* XRUN */
> 154         if (runtime->tstamp_mode & SNDRV_PCM_TSTAMP_MMAP)
> 155                 snd_timestamp_now((snd_timestamp_t*)&runtime->status->tstamp, runtime->tstamp_timespec);

I see. And all these calls have constant execution time?

> 
> Here is snd_timestamp_now (from alsa-kernel/include/core.h):
> 
> 464 static inline void snd_timestamp_now(struct timespec *tstamp, int timespec)
> 465 {
> 466         struct timeval val;
> 467         /* FIXME: use a linear time source */
> 468         do_gettimeofday(&val);
> 469         tstamp->tv_sec = val.tv_sec;
> 470         tstamp->tv_nsec = val.tv_usec;
> 471         if (timespec)
> 472                 tstamp->tv_nsec *= 1000L;
> 473 }
> 
> Note the FIXME.
> 
> So this timestamp should be OK for our purposes.  Note the pointer
> callback is called before the timestamp is taken, so this will introduce
> variable delay as the pointer callback is different in every driver and
> requires accessing the PCI bus to read the pointer from the hardware.
> 
> The API function to get the timestamp is snd_pcm_status_get_tstamp,
> defined in alsa-lib/src/pcm/pcm.c.

Hmm,

how is do_gettimeofday implemented? Is it based on the TSC? It seems it
is for X86 which has a TSC. into arch/i386/kernel/time.c also points out
that it is subject to adjustments due to NTP.

I suppose it would be better to get the TSC timestamp directly as Ingo's
patch produces for RP kernels. OTOH gettimeofday is a more general API
and i suppose it should provide the best timestamping mechanism a
platform can offer, right?

I might be talking out of my behind here though. As i don't know pretty
much anything about ALSA nor kernel internals..

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
