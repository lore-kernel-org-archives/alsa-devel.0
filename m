From: Sergey Kiselev <sergey.kiselev@intel.com>
Subject: Re: [PATCH] ASoC: wm8731: initialize the hardware when
 loading the codec driver
Date: Fri, 5 Jun 2015 11:20:26 -0700
Message-ID: <20150605112026.5ec1809046fdd1817691ce05@intel.com>
References: <20150603131926.eba497d0b22010838fb094f4@intel.com>
 <20150605162546.GB32730@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AC052668DA
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 20:20:28 +0200 (CEST)
In-Reply-To: <20150605162546.GB32730@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 5 Jun 2015 17:25:46 +0100
Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:

> On Wed, Jun 03, 2015 at 01:19:26PM -0700, Sergey Kiselev wrote:
> > From: Sergey Kiselev <sergey.kiselev@intel.com>
> [] 
> >  	/* Regulators will have been enabled by bias management */
> 
> This comment needs an update because this function is only called
> from the bus probe so no bias management will have been called
> yet. Basically we are powering down here after probe is complete
> and the bias management will power us up again.

I think that's what the comment says (future perfect tense?!). I can
rephrase it with something simpler like "regulators will be enabled by
bias management". English is not my mother tongue, and I appreciate any
corrections. :-)

> 
> >  	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
> > @@ -621,19 +631,7 @@ err_regulator_enable:
> 
> Looks like you really should just combine the error and normal
> exit paths for this function.
> 

Will do.

> >  	return ret;
> > +	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
> > +
> 
> Do we actually need to bulk_disable here? The enable we did
> during bus probe is balanced with the disable we do there two.
> Then I would expect that ASoC has put us back into bias off
> before we are removing the i2c. Not a 100% sure on this one but
> it looks like it is redundant.
> 

I think you're correct. Actually the DAPM will turn the bias off when
machine driver is removed, which must happen before codec is removed.

> Thanks,
> Charles

-- 
Sergey
