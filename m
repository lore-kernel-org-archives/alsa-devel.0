From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] emu10k1: various (mostly trivial) small
 cleanups
Date: Tue, 15 Mar 2005 09:07:28 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503150853370.186-100000@studcom.urz.uni-halle.de>
References: <1110844578.15588.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110844578.15588.12.camel@mindpipe>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Mon, 2005-03-14 at 09:23 +0100, Clemens Ladisch wrote:
> > BTW: Does the Emu10k1 have some sample/tick counter that runs even if
> > no PCMs are running?  If so, it would be possible to detect lost timer
> > interrupts.
>
> In practice I have found that interrupts are basically never lost.  The
> only time I ever saw this happen was when the VIA Unichrome XAA (yep,
> userspace!) driver had a FIFO related bug where it would temporarily
> stall the PCI bus.

I saw it when ripping audio from CDs with a 2.4 kernels (does not
support DMA in this case).

> I guess I am wondering whether this would be worth implementing.  Do
> you think the overhead of reading the wall clock register on every timer
> interrupt is worth it?

Probably not, when we declare 2.4 obsolete. :)  Drivers that disable
interrupts for too long _are_ considered broken, after all.

I'd think the only case where it's really worth it would be if the
hardware has direct support for this, with a timer overflow counter or
something like this.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
