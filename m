From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: Intel: add a status for runtime
	suspend/resume
Date: Thu, 5 Feb 2015 08:28:57 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BA9E55@SHSMSX101.ccr.corp.intel.com>
References: <1423057334-26654-1-git-send-email-yang.jie@intel.com>
 <20150204201731.GE21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C0BBF2604FA
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 09:29:03 +0100 (CET)
In-Reply-To: <20150204201731.GE21293@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, February 05, 2015 4:18 AM
> To: Jie, Yang
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH] ASoC: Intel: add a status for runtime suspend/resume
> 
> On Wed, Feb 04, 2015 at 09:42:14PM +0800, Jie Yang wrote:
> 
> > +	else if (pdata->pm_state == HSW_PM_STATE_RTD3)
> > +		goto suspend;
> > +
> 
> >  	sst_hsw_dsp_runtime_sleep(hsw);
> > +
> > +suspend:
> > +	snd_soc_suspend(pdata->soc_card->dev);
> > +	snd_soc_poweroff(pdata->soc_card->dev);
> > +
> >  	pdata->pm_state = HSW_PM_STATE_D3;
> 
> This is a pretty big jump for goto and it's not the usual goto as error handling
> idiom either; it seems better to refactor the code so that this isn't required.
> For example have a runtime PM function which is also called by the system
> suspend path.
[Keyon] OK, thanks, let me refactor it and remove the goto. I don't wan't call runtime PM function in system suspend directly because of the suspend/resume(specially the resume) sequence have slight difference, also for not mixing the RTD3 and D3 status.
Will send updated v2 patch soon.
