From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1 2/3] ASoC: fsl_spdif: spba clk is needed
 by spdif device
Date: Thu, 17 Sep 2015 10:54:08 -0700
Message-ID: <20150917175407.GA2544@Asurada-CZ80>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
 <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
 <20150917110154.GC12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CB99261A80
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 19:54:14 +0200 (CEST)
Received: by padhy16 with SMTP id hy16so25691235pad.1
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 10:54:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150917110154.GC12027@sirena.org.uk>
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
Cc: mark.rutland@arm.com, Shengjiu Wang <shengjiu.wang@freescale.com>, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Xiubo.Lee@gmail.com, timur@tabi.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org, galak@codeaurora.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2015 at 12:01:54PM +0100, Mark Brown wrote:
> On Thu, Sep 17, 2015 at 02:09:24PM +0800, Shengjiu Wang wrote:
> 
> > +	"dma"		  The spba clock is needed when sdma share peripheral
> > +			  script is used.

> It sounds like this clock is used by the DMA controller - shouldn't the
> DMA controller driver be responsible for enabling it?

I agree but it doesn't seems to be easy to enable and disable it
dynamically along with ASoC open() and close() functions as the
current clocks of SDMA get enabled when its channels are allocated
during the system boot-up via generic DMA bindings.

Maybe we can put in the issue_pending() and terminate_all() which
are regularly called along with ASoC trigger(), or just open it
permanently if the penalty of power efficiency is ignorable.
