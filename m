From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Fri, 10 Dec 2004 16:01:48 -0500
Message-ID: <1102712509.29919.46.camel@krustophenia.net>
References: <200412102051.iBAKphFL012668@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200412102051.iBAKphFL012668@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-12-10 at 15:51 -0500, Paul Davis wrote:
> >Maybe I am not understanding the ALSA code correctly, but I was under
> >the impression that ALSA interrupt handlers do not really have a bottom
> >half as such, in that they do not schedule any work for later via
> >raising a softirq or scheduling a tasklet.  They just do it all in the
> >top half.  It's possible for ALSA to do everything in the top half
> >because all you do in an ALSA interrupt handler is call
> >snd_pcm_period_elapsed on one or more substreams.  For this to work it
> >seem like snd_pcm_period_elapsed has to be O(N) and therefore realtime
> >safe.
> 
> with ingo's RP patches, every IRQ has a top half and bottom half. the
> question is whether the top half calls the bottom half directly or
> arranges for it to run in a thread "later".

Yeah, exactly.  I was speaking in terms of the traditional bottom
half/top half model.

With Ingo's patches we actually have 3 levels of IRQ context, they
effectively add a level above the traditional "top half" which is just a
tiny asm routine to mark the IRQ thread runnable (if threaded) or
execute the "real" top half directly if nonthreaded.

I don't really consider this new level very significant in practice
because it's fast and exactly the same for all devices.  IOW the
snd_pcm_period_elapsed timestamp should be good.  I don't think we need
to worry about the threaded ALSA IRQ case.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
