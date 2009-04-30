From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Thu, 30 Apr 2009 08:08:58 +0100
Message-ID: <20090430070858.GA3242@n2100.arm.linux.org.uk>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
	<20090428222035.GG29277@n2100.arm.linux.org.uk>
	<1240959968.30410.1.camel@brutus>
	<20090429072706.GA31566@n2100.arm.linux.org.uk>
	<20090429082152.GA2628@sirena.org.uk>
	<20090429084109.GB10541@n2100.arm.linux.org.uk>
	<f17812d70904290214g110f2a5ax5da4af478688f3d1@mail.gmail.com>
	<20090429185151.GC21459@n2100.arm.linux.org.uk>
	<f17812d70904291931o7bbf4df6g2827bdb28920f82b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id A8B552446F
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 09:09:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904291931o7bbf4df6g2827bdb28920f82b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2009 at 10:31:53AM +0800, Eric Miao wrote:
> On Thu, Apr 30, 2009 at 2:51 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > The transfers happen under control of PCON not the PXA; PCON asserts a
> > GPIO to activate the DMA to control when the transfer happens.
> 
> That's too bad then. Does that GPIO act like a chip select or it's just a
> signal to inform the host to do a transfer? And it also depends on the
> SCLK direction.
> 
> If the GPIO behaves like an IRQ to inform the host for a transfer, maybe
> the driver can arrange a transfer initiated by that event.

I don't know what the timing requirement is.  What I do know is what
the current code does, which is to use the signal to control the
transmit DMA when PCON wants to transfer data.

Now, remember that PCON has a habbit of resetting the PXA when things
happen that it doesn't like, I really don't want to go round
experimenting with this thing; as already stated it's really not worth
trying to merge this code if that's what will be required.
