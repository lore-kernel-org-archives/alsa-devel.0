From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [Alsa-devel] Re: irq handler top half timestamps
Date: Fri, 10 Dec 2004 18:54:26 +0100
Message-ID: <20041210185426.5cd6ab23@mango.fruits.de>
References: <20041210182359.2a5dc4a4@mango.fruits.de>
	<200412101717.iBAHHZuW012442@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <200412101717.iBAHHZuW012442@localhost.localdomain>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Jaroslav Kysela <perex@suse.cz>, Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Dec 2004 12:17:35 -0500
Paul Davis <paul@linuxaudiosystems.com> wrote:

> >> We can do any timestamp in the IRQ handler (this enum can be extended):
> >> 
> >> enum sndrv_pcm_tstamp {
> >>         SNDRV_PCM_TSTAMP_NONE = 0,
> >>         SNDRV_PCM_TSTAMP_MMAP,
> >>         SNDRV_PCM_TSTAMP_LAST = SNDRV_PCM_TSTAMP_MMAP,
> >> };
> >> 
> >> And this structure is used to store timestamp value:
> >> 
> >> struct timespec tstamp;
> >
> >Way cool! But how to access it from userspace?
> 
> i was remembering this the other day. just a quick note: the timestamp
> will be taken in the "bottom half" handler, which hopefully makes no
> difference for JACK purposes because the audio interface IRQ is not
> threaded.

Hi,

i think this assumption is not always true. On a realtime preemptive
kernel, the bottom half of the alsa irq handler can run in a thread. In
the normal jackd usage case this thread should probably be the highest
priority thread in the system and this should eliminate most scheduling
delays. I still think the best way [also with respect to variable length
code paths in the bottom handler before taking the timestamp
(speculation on my part)] would be to take the timestamp in the top half
if that's possible. Bottom half timestamp will probably still be better
than a timestamp taken in jackd though as we eliminate the (variable)
time needed for waking up jackd.

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
