From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_max98090
Date: Fri, 1 May 2015 10:14:16 +0530
Message-ID: <20150501044416.GS3521@localhost>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
 <20150430043651.GJ3521@localhost> <20150430062418.GA76535@mocha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BCB526042F
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 06:43:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150430062418.GA76535@mocha>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yang Fang <yang.a.fang@intel.com>
Cc: alsa-devel@alsa-project.org, praveen.k.jain@intel.com, praveen.diwakar@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, broonie@kernel.org, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2015 at 11:24:18PM -0700, Yang Fang wrote:
> > > +	/* back ends */
> > > +	{
> > > +		.name = "SSP2-Codec",
> > > +		.be_id = 1,
> > > +		.cpu_dai_name = "ssp2-port",
> > > +		.platform_name = "sst-mfld-platform",
> > > +		.no_pcm = 1,
> > > +		.codec_dai_name = "HiFi",
> > > +		.codec_name = "i2c-193C9890:00",
> > > +		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> > > +					| SND_SOC_DAIFMT_CBS_CFS,
> > > +		.init = cht_codec_init,
> > > +		.be_hw_params_fixup = cht_codec_fixup,
> > > +		.nonatomic = true,
> > this doesnt make sense for BEs
> this is taking the fix from below commit for another braswell machine driver
> 
Thanks for pinting, it makes sense for FE dailinks where trigger ops are
invoked. Not for BE dailinks. I will get it removed from BE one

-- 
~Vinod
