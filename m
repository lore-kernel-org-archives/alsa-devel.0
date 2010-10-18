From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Mon, 18 Oct 2010 11:34:00 +0100
Message-ID: <20101018113400.113161d6@linux.intel.com>
References: <20101003112244.488282fd@linux.intel.com>
	<20101003201943.GA31764@opensource.wolfsonmicro.com>
	<20101004100424.4e5cf40c@linux.intel.com>
	<s5hr5fpur7u.wl%tiwai@suse.de>
	<20101017103626.GB6311@opensource.wolfsonmicro.com>
	<s5hk4lhul3j.wl%tiwai@suse.de>
	<20101017161808.GA4437@opensource.wolfsonmicro.com>
	<s5h39s4v6wi.wl%tiwai@suse.de>
	<20101017221126.GA11666@opensource.wolfsonmicro.com>
	<s5hwrpgt4cn.wl%tiwai@suse.de>
	<20101018072017.GA25031@opensource.wolfsonmicro.com>
	<s5heibnudjb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 005D9243ED
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 13:26:47 +0200 (CEST)
In-Reply-To: <s5heibnudjb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: greg@kroah.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

> > This is all driver specific stuff, there's nothing that needs doing
> > here immediately outside of the driver that I can spot right now.
> 
> ... so the whole messages can be reduced to a sentense:
>   "Rewrite the driver based on ASoC!"

Rework rather than rewrite I think. Plus fix the abuse of the jack
inputs etc. Our intent is to do the job properly.

>  - whether to keep it in upstream or not

I think so - it gets more visiblity and it is already benefitting from
that

>  - where to keep it, in staging or in sound tree

I would prefer staging as again it gets more visibility. The second
reason I would prefer that visibility is that separate to the plain
ALSA driver there needs to be a bigger discussion around audio offload
interfaces and standardizing them.

Alan
