From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Make register_card API available
	to	drivers
Date: Thu, 13 Jan 2011 17:06:19 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010844671F9B@bgsmsx502.gar.corp.intel.com>
References: <1294901358-14364-1-git-send-email-vinod.koul@intel.com>
	<20110113112607.GA9936@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BAD59245F6
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 12:36:35 +0100 (CET)
In-Reply-To: <20110113112607.GA9936@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "Bensaid,
	Selma" <selma.bensaid@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> > This patch makes register_card and unregister_card API available to machine
> > drivers. This also maintains compatibility with older method of registration
> > which can be marked depreciated and removed eventually.
> 
> This is probably mostly OK but it'd be good if you could break it down
> into a small patch series.  At present it does a bunch of refactoring
> and also adds the API - it'd be better if there were a sequence of
> patches, each doing a single refactor, followed by a final patch which
> exports the API.
Sure will do that...

> > @@ -1870,16 +1868,12 @@ static int soc_probe(struct platform_device *pdev)
> >  	struct snd_soc_card *card = platform_get_drvdata(pdev);
> >  	int ret = 0;
> >
> > +	/* no card, so machine driver will register explictly */
> > +	if (!card)
> > +		return 0;
> > +
> 
> Hrm, this looks a bit surprising.  When we're registering directly from
> the machine drivers I'd not expect us to end up going through soc-probe
> at all and...
> 
> >  	/* Bodge while we unpick instantiation */
> >  	card->dev = &pdev->dev;
> 
> ...that the card device would be something passed in from the machine
> driver (probably something that the architecture code registered in
> order to allow the machine driver to probe, but possibly something
> else).
Yes on both of these, but I didn't want to break current method.
So I kept these to ensure both methods work fine.

One we have converted all driver to use register then we can remove these.
Would have made sense to put a comment for that

~Vinod
