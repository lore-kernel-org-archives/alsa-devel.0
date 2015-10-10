From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V1 2/3] ASoC: fsl_spdif: spba clk is needed
 by spdif device
Date: Sat, 10 Oct 2015 18:26:58 +0800
Message-ID: <20151010102657.GC25804@shlinux2>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
 <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
 <20150917110154.GC12027@sirena.org.uk>
 <20150917175407.GA2544@Asurada-CZ80>
 <20150919135040.GM12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0116.outbound.protection.outlook.com [157.56.111.116])
 by alsa0.perex.cz (Postfix) with ESMTP id A50DF260436
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 12:27:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150919135040.GM12027@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Xiubo.Lee@gmail.com, timur@tabi.org, lgirdwood@gmail.com, Nicolin Chen <nicoleotsuka@gmail.com>, robh+dt@kernel.org, galak@codeaurora.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 19, 2015 at 06:50:40AM -0700, Mark Brown wrote:
> On Thu, Sep 17, 2015 at 10:54:08AM -0700, Nicolin Chen wrote:
> > On Thu, Sep 17, 2015 at 12:01:54PM +0100, Mark Brown wrote:
> > > On Thu, Sep 17, 2015 at 02:09:24PM +0800, Shengjiu Wang wrote:
> 
> > > > +	"dma"		  The spba clock is needed when sdma share peripheral
> > > > +			  script is used.
> 
> > > It sounds like this clock is used by the DMA controller - shouldn't the
> > > DMA controller driver be responsible for enabling it?
> 
> > I agree but it doesn't seems to be easy to enable and disable it
> > dynamically along with ASoC open() and close() functions as the
> > current clocks of SDMA get enabled when its channels are allocated
> > during the system boot-up via generic DMA bindings.
> 
> Do we need to do things along with open() and close() or wouldn't doing
> things along with the DMA operatiosn suffice?
> 
> > Maybe we can put in the issue_pending() and terminate_all() which
> > are regularly called along with ASoC trigger(), or just open it
> > permanently if the penalty of power efficiency is ignorable.
> 
> Or some kind of runtime PM usage within the DMA driver (possibly at
> those points)?  It does seem like something we should solve in the DMA
> code rather than in generic code.
> 

I think spba clock should be used by the audio IP not DMA, because in same
situation the FSL_SSI doesn't need this clock.

best regards
wang shengjiu
