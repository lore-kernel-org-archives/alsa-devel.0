From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] ASoC: compress: Add suport for DPCM
 into	compressed audio
Date: Fri, 17 Jan 2014 09:23:26 +0530
Message-ID: <20140117035326.GK25466@intel.com>
References: <1389804717-5985-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1389804717-5985-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hbnzbsysd.wl%tiwai@suse.de> <1389892081.2298.61.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 815B8264FFB
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 05:55:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1389892081.2298.61.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.jf.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 16, 2014 at 05:08:01PM +0000, Liam Girdwood wrote:
> On Thu, 2014-01-16 at 16:59 +0100, Takashi Iwai wrote:
> > At Wed, 15 Jan 2014 16:51:57 +0000,
> > Liam Girdwood wrote:
> > > 
> 
> > 
> > > +	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> > > +
> > > +	if (platform->driver->compr_ops && platform->driver->compr_ops->set_params) {
> > > +		ret = platform->driver->compr_ops->set_params(cstream, params);
> > > +		if (ret < 0)
> > > +			goto out;
> > > +	}
> > > +
> > > +	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->set_params) {
> > > +		ret = fe->dai_link->compr_ops->set_params(cstream);
> > > +		if (ret < 0)
> > > +			goto out;
> > > +	}
> > > +
> > > +	memcpy(&fe->dpcm[fe_substream->stream].hw_params, params,
> > > +			sizeof(struct snd_pcm_hw_params));
> > 
> > Does this really work?  params is snd_compr_params and hw_parmas is
> > snd_pcm_hw_params, isn't it?
> > 
> 
> Hmmm, no one reported a failure here to me. It is complete nonsense
> though so I dont know why the testers didn't run into this. I'll fix it
> for V2.
I think that due to the fixup fn noone noticed this. The issue will be seen only
by folks who dont have the fixup function.

--
~Vinod
