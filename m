From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Thu, 29 Mar 2012 11:24:35 +0000
Message-ID: <7FE21149F4667147B645348EC6057885150AE0@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
	<20120329111605.GK3668@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id E405F1043FD
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 13:24:43 +0200 (CEST)
In-Reply-To: <20120329111605.GK3668@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Mark Brown
> Sent: Thursday, March 29, 2012 7:16 PM
> To: Shawn Guo
> Cc: alsa-devel@alsa-project.org; Zeng Zhaoming
> Subject: Re: [alsa-devel] [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC
> up
> 
> On Thu, Mar 29, 2012 at 01:51:45PM +0800, Shawn Guo wrote:
> 
> > +	SND_SOC_DAPM_ADC_E("ADC", "Capture", SGTL5000_CHIP_ANA_POWER, 1, 0,
> > +			power_vag_event,
> > +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> > +	SND_SOC_DAPM_DAC_E("DAC", "Playback", SGTL5000_CHIP_ANA_POWER, 3, 0,
> > +			power_vag_event,
> > +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> 
> What would be more idiomatic here would be to make VAG a supply widget
> and then connect it to DAC and ADC rather than have the event on both -
> It looks like with your current code simultaneous playback and capture
> will break, you'll run through the power sequences twice and if you stop
> one stream it'll power down the other.
> 
It's true.

Regards
Dong Aisheng
