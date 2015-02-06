From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH] ASoC: Intel: fix machine driver warnings
Date: Fri, 6 Feb 2015 07:42:03 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718BF49B0@ORSMSX113.amr.corp.intel.com>
References: <1423181956-108810-1-git-send-email-yang.a.fang@intel.com>
 <s5hzj8r1p2n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 22909260564
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 08:42:07 +0100 (CET)
In-Reply-To: <s5hzj8r1p2n.wl-tiwai@suse.de>
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
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "N,
 Harshapriya" <harshapriya.n@intel.com>, "Jain,
 Praveen K" <praveen.k.jain@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Strasser,
 Kevin" <kevin.strasser@intel.com>, "Iriawan, Denny" <denny.iriawan@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, February 05, 2015 11:23 PM
> To: Fang, Yang A
> Cc: broonie@kernel.org; lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> Iriawan, Denny; N, Harshapriya; Jain, Praveen K; Strasser, Kevin; Koul, Vinod;
> Lin, Mengdong
> Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: fix machine driver warnings
> 
> At Thu,  5 Feb 2015 16:19:16 -0800,
> yang.a.fang@intel.com wrote:
> >
> > From: "Fang, Yang A" <yang.a.fang@intel.com>
> >
> > this patch will fix below sparse warnings
> >
> > warning: incorrect type in argument 2 (different base types) expected
> > unsigned int [unsigned] val got restricted snd_pcm_format_t [usertype]
> > <noident>
> >
> > sound/soc/intel/haswell.c:61:37
> > sound/soc/intel/broadwell.c:115:37:
> > sound/soc/intel/bytcr_dpcm_rt5640.c:118:37:
> > sound/soc/intel/cht_bsw_rt5672.c:183:37:
> > sound/soc/intel/cht_bsw_rt5645.c:208:37:
> >
> > Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
> > ---
> >  sound/soc/intel/broadwell.c         |    2 +-
> >  sound/soc/intel/bytcr_dpcm_rt5640.c |    2 +-
> >  sound/soc/intel/cht_bsw_rt5645.c    |    2 +-
> >  sound/soc/intel/cht_bsw_rt5672.c    |    2 +-
> >  sound/soc/intel/haswell.c           |    2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
> > index 9cf7d01..0ca4015 100644
> > --- a/sound/soc/intel/broadwell.c
> > +++ b/sound/soc/intel/broadwell.c
> > @@ -112,7 +112,7 @@ static int broadwell_ssp0_fixup(struct
> snd_soc_pcm_runtime *rtd,
> >  	/* set SSP0 to 16 bit */
> >  	snd_mask_set(&params-
> >masks[SNDRV_PCM_HW_PARAM_FORMAT -
> >  				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
> > -				    SNDRV_PCM_FORMAT_S16_LE);
> > +				    (__force
> int)SNDRV_PCM_FORMAT_S16_LE);
> >  	return 0;
> >  }
> 
> Oh, it's ugly, but unavoidable as long as we use this form.
> 
> Maybe it's better to provide a helper, e.g. params_set_format() to do the
> forced cast.
> 
> Also, it would be possible to provide the whole hw constraints stuff to make
> it working independently.  But I guess it's overkill for DPCM hwparam fixups.
> 
> 
> Takashi

Hi Takashi,

Thanks for the feedback. Are you looking for something like this?
> >masks[SNDRV_PCM_HW_PARAM_FORMAT -
> >  				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
> > -				    SNDRV_PCM_FORMAT_S16_LE);
> > +				   params_set_format( SNDRV_PCM_FORMAT_S16_LE));
