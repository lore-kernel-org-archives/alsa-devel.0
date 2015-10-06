From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH v3 6/8] ASoC: Intel: Skylake: Initialize
 and load DSP controls
Date: Tue, 6 Oct 2015 22:22:12 +0000
Message-ID: <1444170130.25504.35.camel@intel.com>
References: <1443020604-22282-7-git-send-email-vinod.koul@intel.com>
 <20151006162347.GA30592@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D66F72606ED
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 00:22:17 +0200 (CEST)
In-Reply-To: <20151006162347.GA30592@sirena.org.uk>
Content-Language: en-US
Content-ID: <964F8A6E58C0DD4CA5608F7012121369@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "Kp, Jeeja" <jeeja.kp@intel.com>, "Prusty, Subhransu S" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-10-06 at 17:23 +0100, Mark Brown wrote:
> On Wed, Sep 23, 2015 at 08:33:22PM +0530, Vinod Koul wrote:
> 
> >  	if (link_dev->link_prepared) {
> > -		dev_dbg(dai->dev, "already stream is prepared - returning\n");
> > +		dev_info(dai->dev, "already stream is prepared - returning\n");
> >  		return 0;
> >  	}
> 
> Why is the severity of this being raised and if it does need raising why
> isn't it a warning or error?

On production systems, this helps to debug issues when something goes wrong and alsa
invokes prepare. But this might be false positive, usermode calling prepare for
usermode actions, that's why we cant say it is an error.

Thanks
-- 
~Vinod
