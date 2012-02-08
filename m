From: Liam Girdwood <lrg@ti.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 08 Feb 2012 09:54:37 +0000
Message-ID: <1328694877.3955.9.camel@odin>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com>  <1328692723.3955.4.camel@odin>
	<1328693854.21099.5.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog121.obsmtp.com (na3sys009aog121.obsmtp.com
	[74.125.149.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BFE7245A1
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 10:54:54 +0100 (CET)
Received: by werm13 with SMTP id m13so373859wer.13
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 01:54:39 -0800 (PST)
In-Reply-To: <1328693854.21099.5.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 15:07 +0530, Vinod Koul wrote:
> On Wed, 2012-02-08 at 09:18 +0000, Liam Girdwood wrote:
> > The set_pll() function is meant to take the input and output frequencies
> > passed in as parameters and then use these to configure the PLL. If the
> > output frequency is 0 then you should switch OFF your PLL to conserve
> > power. 
> > 
> > Your function is just enabling the PLLs. Where do you configure the PLL
> > dividers (to divide the input frequency into the output frequency)?
> > Where do you switch the PLL off when it's not in use ?
> > 
> 
> A different question...
> 
> how does a codec driver ensure that input clock is ON. Codec doesn't
> know anything about platform so shouldn't there be a callback to
> machine/platform to turn on the input clock?
> 

Atm, the machine driver would have to enable any system clocks before
the codec driver could use them.

However, I think one of the intentions of the clk framework rework is to
allow non CPU clocks like CODEC PLLs to register as clocks and have
their dependencies worked out. I've no idea of the status of this atm,
but maybe Mark knows or you could ask on lkml.

Liam
