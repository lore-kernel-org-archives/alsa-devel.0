From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 4/4] ASoC: soc core allow machine driver to
 register the card
Date: Fri, 14 Jan 2011 16:55:47 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010844672488@bgsmsx502.gar.corp.intel.com>
References: <1294939150-26443-1-git-send-email-vinod.koul@intel.com>
	<20110113234135.GD13717@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844672180@bgsmsx502.gar.corp.intel.com>
	<20110114105224.GA13256@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A5B0103B98
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 12:26:17 +0100 (CET)
In-Reply-To: <20110114105224.GA13256@opensource.wolfsonmicro.com>
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

> > > I'll review this one more closely tomorrow - as I said with the combined
> > > patch I'd not expect the soc-audio device to be involved when the
> > > machine driver is registering a card so I'd like to understand in more
> > > detail why this is still required.
> 
> > If someone is still creating soc-audio device and not adding the drvdata the
> > code following this will use a null pointer :(. So tried to protect, but again
> > if people are doing right, then this shouldn't be invoked at all
> 
> If that's all it is then the check should be changed to return -EINVAL
> or similar as this is an error which prevents the device being
> instantiated.  It shouldn't pretend it succeeded, and not doing so will
> save us having to check in any of the other functions.

Agreed, but on the other hand if someone is using register api they should
not be creating the device, so probe shouldn't be called at all.
We can leave this check. What do you think?

~Vinod
