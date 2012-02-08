From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 08 Feb 2012 15:07:34 +0530
Message-ID: <1328693854.21099.5.camel@vkoul-udesk3>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com>  <1328692723.3955.4.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E931A103D69
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 10:35:18 +0100 (CET)
In-Reply-To: <1328692723.3955.4.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 09:18 +0000, Liam Girdwood wrote:
> The set_pll() function is meant to take the input and output frequencies
> passed in as parameters and then use these to configure the PLL. If the
> output frequency is 0 then you should switch OFF your PLL to conserve
> power. 
> 
> Your function is just enabling the PLLs. Where do you configure the PLL
> dividers (to divide the input frequency into the output frequency)?
> Where do you switch the PLL off when it's not in use ?
> 

A different question...

how does a codec driver ensure that input clock is ON. Codec doesn't
know anything about platform so shouldn't there be a callback to
machine/platform to turn on the input clock?

-- 
~Vinod
