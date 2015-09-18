From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 6/9] ASoC: Intel: Skylake: Initialize
 and load DSP controls
Date: Fri, 18 Sep 2015 20:41:31 +0530
Message-ID: <20150918151131.GE19522@localhost>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-7-git-send-email-vinod.koul@intel.com>
 <1442570334.7634.39.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 25C9B265A03
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 17:08:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1442570334.7634.39.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2015 at 10:58:54AM +0100, Liam Girdwood wrote:

> > +static int skl_be_hw_params(struct snd_pcm_substream *substream,
> > +				struct snd_pcm_hw_params *params,
> > +				struct snd_soc_dai *dai)
> > +{
> > +	struct skl_pipe_params p_params = {0};
> > +
> > +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> > +
> 
> Seeing a lot of dev_dbg(__func__) in this series that really are just
> tracing. Probably best to trace the calls properly or remove if it's
> just development debugging.

Yes tracing will be added later, I will remove bunch of these but keep few
to help debug as we are still adding features :)

-- 
~Vinod
