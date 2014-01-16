From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: compress: Add suport for DPCM
 into	compressed audio
Date: Thu, 16 Jan 2014 17:08:01 +0000
Message-ID: <1389892081.2298.61.camel@loki>
References: <1389804717-5985-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1389804717-5985-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hbnzbsysd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 61B532619FB
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 18:08:30 +0100 (CET)
In-Reply-To: <s5hbnzbsysd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2014-01-16 at 16:59 +0100, Takashi Iwai wrote:
> At Wed, 15 Jan 2014 16:51:57 +0000,
> Liam Girdwood wrote:
> > 

> 
> > +	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> > +
> > +	if (platform->driver->compr_ops && platform->driver->compr_ops->set_params) {
> > +		ret = platform->driver->compr_ops->set_params(cstream, params);
> > +		if (ret < 0)
> > +			goto out;
> > +	}
> > +
> > +	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->set_params) {
> > +		ret = fe->dai_link->compr_ops->set_params(cstream);
> > +		if (ret < 0)
> > +			goto out;
> > +	}
> > +
> > +	memcpy(&fe->dpcm[fe_substream->stream].hw_params, params,
> > +			sizeof(struct snd_pcm_hw_params));
> 
> Does this really work?  params is snd_compr_params and hw_parmas is
> snd_pcm_hw_params, isn't it?
> 

Hmmm, no one reported a failure here to me. It is complete nonsense
though so I dont know why the testers didn't run into this. I'll fix it
for V2.

Thanks

Liam
