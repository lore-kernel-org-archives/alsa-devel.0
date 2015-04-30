From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH 3/4] ASoC: ts3a227e: add platform data for
 ts3a227e driver
Date: Thu, 30 Apr 2015 20:45:40 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718CC6E89@ORSMSX113.amr.corp.intel.com>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-3-git-send-email-yang.a.fang@intel.com>
 <20150430200220.GH22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 23B84261ABF
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 22:45:41 +0200 (CEST)
In-Reply-To: <20150430200220.GH22845@sirena.org.uk>
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
To: 'Mark Brown' <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, "Diwakar, Praveen" <praveen.diwakar@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, April 30, 2015 1:02 PM
> To: Fang, Yang A
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> dgreid@chromium.org; Koul, Vinod; Diwakar, Praveen;
> kevin.strasser@linux.intel.com; Jain, Praveen K; Iriawan, Denny
> Subject: Re: [PATCH 3/4] ASoC: ts3a227e: add platform data for ts3a227e
> driver
> 
> On Wed, Apr 29, 2015 at 06:43:57PM -0700, yang.a.fang@intel.com wrote:
> 
> > @@ -296,7 +303,7 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
> >  	}
> >
> >  	ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
> ts3a227e_interrupt,
> > -					IRQF_TRIGGER_LOW |
> IRQF_ONESHOT,
> > +					ts3a227e->pdata.irqflag,
> >  					"TS3A227E", ts3a227e);
> >  	if (ret) {
> >  		dev_err(dev, "Cannot request irq %d (%d)\n", i2c->irq, ret);
> 
> This doesn't make much sense to me - no change is made to the
> configuration of the device, the driver just passes the flag through to the
> interrupt controller code.  I can't see how that's going to work well,
> somewhere along the line something must be misconfigured.

Hi Mark,

My intention is to make irqflag configurable. I made them two patches.
Patch 3/4 to make sure existing code no impact. 4/4 is set different 
Irq value via DMI for specific platform. Maybe I should squash them?

Thanks,
Yang
