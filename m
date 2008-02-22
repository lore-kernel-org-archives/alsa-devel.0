From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: asihpi: Need help converting volatile to memory
 barriers
Date: Fri, 22 Feb 2008 11:44:20 +0100
Message-ID: <47BEA784.5060006@ladisch.de>
References: <200802221218.18249.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 5934524358
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 11:42:36 +0100 (CET)
In-Reply-To: <200802221218.18249.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eliot Blennerhassett wrote:
> Theres quite a bit written about barriers, but most seems to be assuming SMP
> situation or memory mapped devices. Not much about devices doing DMA.
> I.e I have read Documentation/memory-barriers.txt

See also <Documentation/DMA-mapping.txt>.

> interface->cmd = command;
> wmb();
> iowrite(device_interrupt, 1);
> [device reads interface->cmd by dma]
>
> Is the wmb() a guarantee that the command will be in memory visible to the
> device when the driver informs it of a new command?

Yes.  Please not that accesses to I/O space have an implicit barrier, so
you don't even need the wmb() in this case.

> One assumption I am making is that the compiler is not going to optimise
> across functions
> E.g. in the following scenario, is the compiler going to optimise the loop
> away without a rmb()?  If not, is this because of something inherent in the C
> standard, or just because the optimiser isn't yet smart enough to see it?
> I.e. it might work now, but when whole-file-optimisation is introduced, it
> will fail?
>
> int get_ack(interface) { return interface->ack }
> ...
> while (get_ack(interface) != OK) {
> 	sleep(a while);
> }

The get_ack() function is an obvious candidate for inlining.  The C
standard definitely allows it to be optimized away (if the compiler can
prove that sleep() doesn't write to interface->ack).  Both gcc an icc
are able to do (or plan to introduce) this optimization.


HTH
Clemens
