From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 3/6] topology: Parse flags for PCM
Date: Sat, 5 Nov 2016 16:54:02 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F88198DA6F@shsmsx102.ccr.corp.intel.com>
References: <cover.1478212626.git.mengdong.lin@linux.intel.com>
 <34d6902914df281d29cb4f01ccb5e8ffe1b78d8a.1478212626.git.mengdong.lin@linux.intel.com>
 <s5hshr6ylp1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E034526647B
 for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2016 17:54:09 +0100 (CET)
In-Reply-To: <s5hshr6ylp1.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Shah,
 Hardik T" <hardik.t.shah@intel.com>, "Singh,
 Guneshwor O" <guneshwor.o.singh@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Saturday, November 5, 2016 11:46 PM
> >
> > +/* parse a flag bit of the given mask */ static int
> > +parse_flag(snd_config_t *n, unsigned int mask_in,
> > +		      unsigned int *mask, unsigned int *flags) {
> > +	const char *val = NULL;
> > +
> > +	if (snd_config_get_string(n, &val) < 0)
> > +		return -EINVAL;
> > +
> > +	*mask |= mask_in;
> > +	if (strcmp(val, "true") == 0)
> > +		*flags |= mask_in;
> > +	else
> > +		*flags &= ~mask_in;
> 
> This can be simplified with snd_config_get_bool().

Okay, I'll fix it in my later patches. Thank you so much for the review!

There will be ~15 patches left for topology user space. I'll split into 2 series.

Regards
Mengdong

> 
> 
> thanks,
> 
> Takashi
> 
> > +
> > +	return 0;
> > +}
> > +
> >  /* Parse pcm (for front end DAI & DAI link) */  int
> > tplg_parse_pcm(snd_tplg_t *tplg,
> >  	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED) @@ -430,6
> +448,34
> > @@ int tplg_parse_pcm(snd_tplg_t *tplg,
> >  				return err;
> >  			continue;
> >  		}
> > +
> > +		/* flags */
> > +		if (strcmp(id, "symmetric_rates") == 0) {
> > +			err = parse_flag(n,
> > +
> 	SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES,
> > +				&pcm->flag_mask, &pcm->flags);
> > +			if (err < 0)
> > +				return err;
> > +			continue;
> > +		}
> > +
> > +		if (strcmp(id, "symmetric_channels") == 0) {
> > +			err = parse_flag(n,
> > +
> 	SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS,
> > +				&pcm->flag_mask, &pcm->flags);
> > +			if (err < 0)
> > +				return err;
> > +			continue;
> > +		}
> > +
> > +		if (strcmp(id, "symmetric_sample_bits") == 0) {
> > +			err = parse_flag(n,
> > +
> 	SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS,
> > +				&pcm->flag_mask, &pcm->flags);
> > +			if (err < 0)
> > +				return err;
> > +			continue;
> > +		}
> >  	}
> >
> >  	return 0;
> > @@ -610,6 +656,9 @@ int tplg_add_pcm_object(snd_tplg_t *tplg,
> snd_tplg_obj_template_t *t)
> >  			tplg_add_stream_caps(&pcm->caps[i], pcm_tpl-
> >caps[i]);
> >  	}
> >
> > +	pcm->flag_mask = pcm_tpl->flag_mask;
> > +	pcm->flags = pcm_tpl->flags;
> > +
> >  	pcm->num_streams = pcm_tpl->num_streams;
> >  	for (i = 0; i < pcm_tpl->num_streams; i++)
> >  		tplg_add_stream_object(&pcm->stream[i], &pcm_tpl-
> >stream[i]);
> > --
> > 2.7.4
> >
