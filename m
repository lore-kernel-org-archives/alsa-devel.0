From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 6/6] ASoC: max9867: Use continuous sample
	rate
Date: Thu, 1 Mar 2018 22:47:08 +0100
Message-ID: <20180301214708.GA4302@lenoch>
References: <20180301141843.GB30722@lenoch> <20180301142216.GH30722@lenoch>
 <20180301182202.GH12864@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BCC4267C62
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 22:47:11 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992966AbeCAVrKd8Lik (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 22:47:10 +0100
Content-Disposition: inline
In-Reply-To: <20180301182202.GH12864@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 01, 2018 at 06:22:02PM +0000, Mark Brown wrote:
> On Thu, Mar 01, 2018 at 03:22:16PM +0100, Ladislav Michl wrote:
> 
> >  what is exact meaning of SNDRV_PCM_RATE_CONTINUOUS? What if codec is
> >  able to set "any" rate, but there are rounding errors?
> >  Shall we pick exact matches based on master clock frequency?
> >  Few other drivers are also setting SNDRV_PCM_RATE_CONTINUOUS, but
> >  certainly cannot set any rate exactly.
> 
> It means being able to set any rate exactly.  Many devices have hardware
> which is only specified to work at specific rates but some are more
> flexible.  Devices don't need to be able to do this independently, you
> can have a flexible external clock tree for example.

Thanks for clarifying this. So in this particular case we should use
snd_pcm_hw_constraint_list for SNDRV_PCM_HW_PARAM_RATE to enforce only
supported rates based on master clock, right? I'll rework this patch then.

	ladis
