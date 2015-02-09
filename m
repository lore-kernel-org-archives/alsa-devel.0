From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH v2 1/2] ALSA: Add params_set_format helper
Date: Mon, 9 Feb 2015 06:58:39 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718BF71BE@ORSMSX113.amr.corp.intel.com>
References: <1423181956-108810-1-git-send-email-yang.a.fang@intel.com>
 <1423440097-95191-1-git-send-email-yang.a.fang@intel.com>
 <s5htwyvpoyi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 276392604E9
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 07:58:42 +0100 (CET)
In-Reply-To: <s5htwyvpoyi.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, "N, Harshapriya" <harshapriya.n@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Strasser,
 Kevin" <kevin.strasser@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Lin,
 Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Sunday, February 08, 2015 10:41 PM
> To: Fang, Yang A
> Cc: broonie@kernel.org; lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> N, Harshapriya; Koul, Vinod; Jain, Praveen K; Iriawan, Denny; Strasser, Kevin;
> Lin, Mengdong
> Subject: Re: [PATCH v2 1/2] ALSA: Add params_set_format helper
> 
> At Sun,  8 Feb 2015 16:01:36 -0800,
> yang.a.fang@intel.com wrote:
> >
> > From: "Fang, Yang A" <yang.a.fang@intel.com>
> >
> > Add a helper to set pcm format directly from params
> >
> > Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
> > ---
> >  include/sound/pcm_params.h |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
> > index 6b1c78f..e6fe584 100644
> > --- a/include/sound/pcm_params.h
> > +++ b/include/sound/pcm_params.h
> > @@ -366,4 +366,11 @@ params_physical_width(const struct
> snd_pcm_hw_params *p)
> >  	return snd_pcm_format_physical_width(params_format(p));
> >  }
> >
> > +static inline void
> > +params_set_format(struct snd_pcm_hw_params *p, snd_pcm_format_t
> fmt)
> > +{
> > +	snd_mask_set(&p->masks[SNDRV_PCM_HW_PARAM_FORMAT -
> > +		SNDRV_PCM_HW_PARAM_FIRST_MASK], (__force int)fmt);
> 
> Use hw_params_mask().
> 
> 
> Takashi

Did not find hw_params_mask .
Do you mean change params_set_format (struct snd_pcm_hw_params *p, snd_pcm_format_t fmt)
To 
hw_params_mask(struct snd_pcm_hw_params *p, snd_pcm_format_t fmt) ?

Thanks,
Yang
