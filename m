From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 4/4] ASoC: soc core allow machine driver to
 register the card
Date: Fri, 14 Jan 2011 09:54:59 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010844672180@bgsmsx502.gar.corp.intel.com>
References: <1294939150-26443-1-git-send-email-vinod.koul@intel.com>
	<20110113234135.GD13717@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E87D103B73
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 05:27:09 +0100 (CET)
In-Reply-To: <20110113234135.GD13717@opensource.wolfsonmicro.com>
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

> > @@ -1870,6 +1868,10 @@ static int soc_probe(struct platform_device *pdev)
> >  	struct snd_soc_card *card = platform_get_drvdata(pdev);
> >  	int ret = 0;
> >
> > +	/* no card, so machine driver is registering card */
> > +	if (!card)
> > +		return 0;
> > +
> 
> I'll review this one more closely tomorrow - as I said with the combined
> patch I'd not expect the soc-audio device to be involved when the
> machine driver is registering a card so I'd like to understand in more
> detail why this is still required.

If someone is still creating soc-audio device and not adding the drvdata the
code following this will use a null pointer :(. So tried to protect, but again
if people are doing right, then this shouldn't be invoked at all

~Vinod
