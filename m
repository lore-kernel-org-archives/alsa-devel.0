From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Sat, 11 Dec 2004 01:56:10 +0100
Message-ID: <20041211015610.1798af34@mango.fruits.de>
References: <200412102051.iBAKphFL012668@localhost.localdomain>
	<1102712509.29919.46.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1102712509.29919.46.camel@krustophenia.net>
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
Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Dec 2004 16:01:48 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> > with ingo's RP patches, every IRQ has a top half and bottom half. the
> > question is whether the top half calls the bottom half directly or
> > arranges for it to run in a thread "later".
> 
> Yeah, exactly.  I was speaking in terms of the traditional bottom
> half/top half model.
> 
> With Ingo's patches we actually have 3 levels of IRQ context, they
> effectively add a level above the traditional "top half" which is just a
> tiny asm routine to mark the IRQ thread runnable (if threaded) or
> execute the "real" top half directly if nonthreaded.

I see. For the best estimate, the timestamp would have to be taken as
soon as possible after the irq was raised. For this purpose alone it
would be great if that tiny asm routine actually would do the
timestamping, but i assume this would introduce some overhead (dunno, if
2 or 3 operations, or whatever is needed to read the TSC would really
count, but with the number of irqs happening, it might be
significant[??]). Also there would certainly extra code be needed to
pass this info along to the next irq handler stage..

> 
> I don't really consider this new level very significant in practice
> because it's fast and exactly the same for all devices.  IOW the
> snd_pcm_period_elapsed timestamp should be good.  I don't think we need
> to worry about the threaded ALSA IRQ case.

When exactly is snd_pcm_period_elapsed called? Is it called from the
ALSA driver interrupt handler (excuse, if this question is stupid, i'm
not too well versed (mildly speaking) when it comes to driver hacking)?
Is it the first thing in the irq handling routine?

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
