From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: buffer/period constraint
Date: Wed, 21 Jul 2004 09:05:53 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0407210857590.27864-100000@studcom.urz.uni-halle.de>
References: <2461c072465f49.2465f492461c07@southeast.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <2461c072465f49.2465f492461c07@southeast.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: fmoraes@nc.rr.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

fmoraes@nc.rr.com wrote:
> [...]
> I've seen some cases where the buffer size is 1 or 2 frames bigger
> than n*period_size,

The hardware must generate interrupts at period boundaries.  In these
cases, the interrupts would happen at different positions in the
buffer, over time.

> so I am not sure how the driver is supposed to handle that.

The driver mustn't allow this unless the hardware can manage it.

> Second, is there an easy way to find the current position of the
> DMA being used?

In the good ol' times of the ISA bus, the DMA controller knew the
current position.  On the PCI bus, the DMA is controlled by the card
itself, so the card should have a register for the current position.
If there isn't such a register, you have to count interrupts (and hope
that none are lost).


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
