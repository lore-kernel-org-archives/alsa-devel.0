From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export
	gic_send_ipi
Date: Wed, 2 Sep 2015 12:12:09 +0000
Message-ID: <20150902121209.GA10628@io.lakedaemon.net>
References: <55DDA1C4.4070301@imgtec.com>
 <alpine.DEB.2.11.1508261427280.15006@nanos>
 <55DDD3E3.7070009@imgtec.com>
 <alpine.DEB.2.11.1508261701430.15006@nanos>
 <55DDDE3C.8030609@imgtec.com>
 <alpine.DEB.2.11.1508262101450.15006@nanos>
 <55E03A2B.3070805@imgtec.com>
 <alpine.DEB.2.11.1508281619311.15006@nanos>
 <55E6C250.50100@imgtec.com> <55E6C788.2000405@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmta2.delivery5.ore.mailhop.org
 (pmta2.delivery5.ore.mailhop.org [54.186.218.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 6039E260537
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2015 14:12:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55E6C788.2000405@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Qais Yousef <qais.yousef@imgtec.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lisa Parratt <Lisa.Parratt@imgtec.com>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 02, 2015 at 10:55:20AM +0100, Marc Zyngier wrote:
> On 02/09/15 10:33, Qais Yousef wrote:
> > On 08/28/2015 03:22 PM, Thomas Gleixner wrote:
> >> On Fri, 28 Aug 2015, Qais Yousef wrote:
> >>> Thanks a lot for the detailed explanation. I wasn't looking for a quick and
> >>> dirty solution but my view of the problem is much simpler than yours so my
> >>> idea of a solution would look quick and dirty. I have a better appreciation of
> >>> the problem now and a way to approach it :-)
> >>>
> >>>  From DT point of view are we OK with this form then
> >>>
> >>>      coprocessor {
> >>>              interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
> >>>              interrupt-sink = <&intc INT_SPEC CPU_HWAFFINITY>;
> >>>      }
> >>>
> >>> and if the root controller sends normal IPI as it sends normal device
> >>> interrupts then interrupt-sink can be a standard interrupts property (like in
> >>> my case)
> >>>
> >>>      coprocessor {
> >>>              interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
> >>>              interrupts = <INT_SPEC>;
> >>>      }
> >>>
> >>> Does this look right to you? Is there something else that needs to be covered
> >>> still?
> >> I'm not an DT wizard. I leave that to the DT experts.
> >>   
> > 
> > Hi Marc Zyngier, Mark Rutland,
> > 
> > Any comments about the DT binding for the IPIs?
> > 
> > To recap, the proposal which is based on Marc Zyngier's is to use 
> > interrupt-source to represent an IPI from Linux CPU to a coprocessor and 
> > interrupt-sink to receive an IPI from coprocessor to Linux CPU. 
> > Hopefully the description above is self explanatory. Please let me know 
> > if you need more info. Thomas covered the routing, synthesising, and 
> > requesting parts in the core code. The remaining (high level) issue is 
> > how to describe the IPIs in DT.
> 
> I'm definitely *not* a DT expert! ;-) My initial binding proposal was
> only for wired interrupts, not for IPIs. There is definitely some common
> aspects, except for one part:
> 
> Who decides on the IPI number? So far, we've avoided encoding IPI
> numbers in the DT just like we don't encode MSIs, because they are
> programmable things. My feeling is that we shouldn't put the IPI number
> in the DT because the rest of the kernel uses them as well and could
> decide to use this particular IPI number for its own use: *clash*.

Agree.  The best way I've found to design DT bindings is to imagine
providing the DT to something other than Linux.  The DT should *only* be
describing the hardware.  As such, I think we should be describing the
connection here, and leaving the assignment up to the OS.

thx,

Jason.
