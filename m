From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Finding xruun sources in cs46xx
Date: Mon, 8 Nov 2004 18:39:21 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411081835301.16893-100000@studcom.urz.uni-halle.de>
References: <20041108181705.456b1aea@mango.fruits.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D15C62A9
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2004 18:39:22 +0100 (MET)
In-Reply-To: <20041108181705.456b1aea@mango.fruits.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Florian Schmidt wrote:
> I wonder: how can i approach finding the source of these xruns? Would the
> xrun debugging messages of ALSA provide a starting point?

Yes, they show the point where the interrupt finally occurred which
should be immediately after the code that blocked interrupt for too
long.

> And one more question: what happens to an IRQ raised by a pci device which
> get's ignored [either due to a cli or because it's masked by another IRQ
> with a higher prio]?

PCI uses level-triggered interrupts, i.e., the interrupt line stays in
raised state until the driver tells the device that the interrupt has
been handled.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
