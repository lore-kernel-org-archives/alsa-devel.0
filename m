From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv5] dmaengine: Add support for BCM2835
Date: Fri, 15 Nov 2013 17:43:37 +0000
Message-ID: <20131115174337.GP16735@n2100.arm.linux.org.uk>
References: <52864BBC.7000506@koalo.de> <1384535016.18739.23.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 4E85F2619E6
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2013 18:44:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1384535016.18739.23.camel@joe-AO722>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: devicetree <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, dmaengine <dmaengine@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 15, 2013 at 09:03:36AM -0800, Joe Perches wrote:
> On Fri, 2013-11-15 at 17:28 +0100, Florian Meier wrote:
> > +static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
> > +{
> > +	unsigned i;
> > +	size_t size;
> 
> Please set size to 0 here and not in the for loop
> > +
> > +	for (size = i = 0; i < d->frames; i++) {

I disagree with that comment; I think the above is not only cleaner, but
also more obvious that _this_ loop is calculating _this_ size.
