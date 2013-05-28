From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix VAG_POWER
	enabling/disabling order
Date: Tue, 28 May 2013 20:57:30 +0200
Message-ID: <201305282057.30204.marex@denx.de>
References: <1369366496-15329-1-git-send-email-marex@denx.de>
 <20130528145943.GS21462@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id CCEF6261691
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 20:57:40 +0200 (CEST)
In-Reply-To: <20130528145943.GS21462@opensource.wolfsonmicro.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Dong Aisheng <dong.aisheng@linaro.org>, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Dear Mark Brown,

> On Fri, May 24, 2013 at 05:34:56AM +0200, Marek Vasut wrote:
> > -	case SND_SOC_DAPM_POST_PMD:
> > 
> > +	case SND_SOC_DAPM_PRE_PMD:
> >  		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> >  		
> >  			SGTL5000_VAG_POWERUP, 0);
> > 
> > -		msleep(400);
> > +		mdelay(400);
> > 
> >  		break;
> 
> This looks to be both unrelated and a regression - mdelay() should be
> more resource intensive than sleeping and if it's 400ms we shouldn't be
> that worried about delaying slightly longer.

Definitelly, this was not supposed to be part of the patch. Fixed in V2.

> Please note my updated mail address which I've been using for a while
> now, the Wolfson one will go bad at the end of the week.

Roger. I hope you have a good time at your new position :)

Best regards,
Marek Vasut
