From: Joe Perches <joe@perches.com>
Subject: Re: [PATCHv5] dmaengine: Add support for BCM2835
Date: Fri, 15 Nov 2013 10:20:24 -0800
Message-ID: <1384539624.18739.27.camel@joe-AO722>
References: <52864BBC.7000506@koalo.de> <1384535016.18739.23.camel@joe-AO722>
 <20131115174337.GP16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0149.hostedemail.com
 [216.40.44.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 62CA0261AF4
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2013 19:20:27 +0100 (CET)
In-Reply-To: <20131115174337.GP16735@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, dmaengine <dmaengine@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-11-15 at 17:43 +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 15, 2013 at 09:03:36AM -0800, Joe Perches wrote:
> > On Fri, 2013-11-15 at 17:28 +0100, Florian Meier wrote:
> > > +static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
> > > +{
> > > +	unsigned i;
> > > +	size_t size;
> > 
> > Please set size to 0 here and not in the for loop
> > > +
> > > +	for (size = i = 0; i < d->frames; i++) {
> 
> I disagree with that comment; I think the above is not only cleaner, but
> also more obvious that _this_ loop is calculating _this_ size.

I think that using
	size_t size = 0;
is not only _much_ more commonly used
throughout the kernel but makes it
clearer that the initialization of the
return value is done before the loop.

Reasonable minds can differ and there
is no style guide that prefers one over
the other.

No matter really to me.
As I said, it's trivial.

cheers, Joe
