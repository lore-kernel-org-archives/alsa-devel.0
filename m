From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Fri, 10 Dec 2004 14:00:59 -0500
Message-ID: <1102705260.29919.7.camel@krustophenia.net>
References: <20041210182359.2a5dc4a4@mango.fruits.de>
	 <200412101717.iBAHHZuW012442@localhost.localdomain>
	 <20041210185426.5cd6ab23@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041210185426.5cd6ab23@mango.fruits.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-12-10 at 18:54 +0100, Florian Schmidt wrote:
> i think this assumption is not always true. On a realtime preemptive
> kernel, the bottom half of the alsa irq handler can run in a thread. In
> the normal jackd usage case this thread should probably be the highest
> priority thread in the system and this should eliminate most scheduling
> delays. I still think the best way [also with respect to variable length
> code paths in the bottom handler before taking the timestamp
> (speculation on my part)] would be to take the timestamp in the top half
> if that's possible. Bottom half timestamp will probably still be better
> than a timestamp taken in jackd though as we eliminate the (variable)
> time needed for waking up jackd.

Maybe I am not understanding the ALSA code correctly, but I was under
the impression that ALSA interrupt handlers do not really have a bottom
half as such, in that they do not schedule any work for later via
raising a softirq or scheduling a tasklet.  They just do it all in the
top half.  It's possible for ALSA to do everything in the top half
because all you do in an ALSA interrupt handler is call
snd_pcm_period_elapsed on one or more substreams.  For this to work it
seem like snd_pcm_period_elapsed has to be O(N) and therefore realtime
safe.

Am I getting this all wrong?

Lee





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
