From: Nenghua Cao <nhcao@marvell.com>
Subject: Re: [PATCH] ASOC:DAPM: update DPCM runtime when
 mixer/mux changes
Date: Mon, 16 Dec 2013 10:43:05 +0800
Message-ID: <52AE68B9.2060101@marvell.com>
References: <1386936829-9627-1-git-send-email-nhcao@marvell.com>
 <1386936829-9627-2-git-send-email-nhcao@marvell.com>
 <20131215135630.GS29580@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 57FEA261B2B
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 03:36:55 +0100 (CET)
In-Reply-To: <20131215135630.GS29580@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Henry Zhao <xzhao10@marvell.com>, Mark Brown <broonie@kernel.org>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 12/15/2013 09:56 PM, Vinod Koul wrote:
> On Fri, Dec 13, 2013 at 08:13:49PM +0800, Nenghua Cao wrote:
>> > From: Nenghua Cao <nhcao@marvell.com>
>> > 
>> >     DPCM can dynamically alter the FE to BE PCM links at runtime based
>> > on mixer/mux setting updates. Add soc_dpcm_runtime_update() calling in
>> > get/put function for mixer/mux to support this feature.
>> > 
>> > Signed-off-by: Nenghua Cao <nhcao@marvell.com>
>> > ---
>> >  sound/soc/soc-dapm.c |   28 ++++++++++++++++++++++++----
>> >  1 files changed, 24 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
>> > index dcade13..67e63ab 100644
>> > --- a/sound/soc/soc-dapm.c
>> > +++ b/sound/soc/soc-dapm.c
>> > @@ -2868,6 +2868,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
>> >  	unsigned int val;
>> >  	int connect, change;
>> >  	struct snd_soc_dapm_update update;
>> > +	int ret = 0;
>> >  
>> >  	if (snd_soc_volsw_is_stereo(mc))
>> >  		dev_warn(codec->dapm.dev,
>> > @@ -2901,12 +2902,16 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
>> >  			card->update = &update;
>> >  		}
>> >  
>> > -		soc_dapm_mixer_update_power(card, kcontrol, connect);
>> > +		ret = soc_dapm_mixer_update_power(card, kcontrol, connect);
>> >  
>> >  		card->update = NULL;
>> >  	}
>> >  
>> >  	mutex_unlock(&card->dapm_mutex);
>> > +
>> > +	if (ret > 0)
>> > +		soc_dpcm_runtime_update(card);
> This version looks much better! Btw would it make sense to have flag in card
> for dynmaic support and call soc_dpcm_runtime_update() for only these cards?
> 
Hi, Vinod

    In soc_dpcm_runtime_update(), it traverses the FE dai_link's
"dynamic" flag. If the asoc driver supports DPCM, it will do update
work. Or it will do nothing. After discussing with Mark and Takashi, it
seems no more meaning to add this flag.
> --
> ~Vinod
>> > +
>> >  	return change;
>> >  }
>> >  EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
>> > @@ -2955,6 +2960,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
>> >  	unsigned int val, mux, change;
>> >  	unsigned int mask;
>> >  	struct snd_soc_dapm_update update;
>> > +	int ret = 0;
>> >  
>> >  	if (ucontrol->value.enumerated.item[0] > e->max - 1)
>> >  		return -EINVAL;
>> > @@ -2978,12 +2984,16 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
>> >  		update.val = val;
>> >  		card->update = &update;
>> >  
>> > -		soc_dapm_mux_update_power(card, kcontrol, mux, e);
>> > +		ret = soc_dapm_mux_update_power(card, kcontrol, mux, e);
>> >  
>> >  		card->update = NULL;
>> >  	}
>> >  
>> >  	mutex_unlock(&card->dapm_mutex);
>> > +
>> > +	if (ret > 0)
>> > +		soc_dpcm_runtime_update(card);
>> > +
>> >  	return change;
>> >  }
>> >  EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
>> > @@ -3019,6 +3029,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
>> >  	struct soc_enum *e =
>> >  		(struct soc_enum *)kcontrol->private_value;
>> >  	int change;
>> > +	int ret = 0;
>> >  
>> >  	if (ucontrol->value.enumerated.item[0] >= e->max)
>> >  		return -EINVAL;
>> > @@ -3028,9 +3039,13 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
>> >  	value = ucontrol->value.enumerated.item[0];
>> >  	change = dapm_kcontrol_set_value(kcontrol, value);
>> >  	if (change)
>> > -		soc_dapm_mux_update_power(card, kcontrol, value, e);
>> > +		ret = soc_dapm_mux_update_power(card, kcontrol, value, e);
>> >  
>> >  	mutex_unlock(&card->dapm_mutex);
>> > +
>> > +	if (ret > 0)
>> > +		soc_dpcm_runtime_update(card);
>> > +
>> >  	return change;
>> >  }
>> >  EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
>> > @@ -3097,6 +3112,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
>> >  	unsigned int val, mux, change;
>> >  	unsigned int mask;
>> >  	struct snd_soc_dapm_update update;
>> > +	int ret = 0;
>> >  
>> >  	if (ucontrol->value.enumerated.item[0] > e->max - 1)
>> >  		return -EINVAL;
>> > @@ -3120,12 +3136,16 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
>> >  		update.val = val;
>> >  		card->update = &update;
>> >  
>> > -		soc_dapm_mux_update_power(card, kcontrol, mux, e);
>> > +		ret = soc_dapm_mux_update_power(card, kcontrol, mux, e);
>> >  
>> >  		card->update = NULL;
>> >  	}
>> >  
>> >  	mutex_unlock(&card->dapm_mutex);
>> > +
>> > +	if (ret > 0)
>> > +		soc_dpcm_runtime_update(card);
>> > +
>> >  	return change;
>> >  }
>> >  EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
>> > -- 
>> > 1.7.0.4
>> > 
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
