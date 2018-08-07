From: "Zhi, Yong" <yong.zhi@intel.com>
Subject: Re: [PATCH] ASoC: Intel: hdac_hdmi: Add
	sampling	frequencies constraint
Date: Tue, 7 Aug 2018 15:36:12 +0000
Message-ID: <C193D76D23A22742993887E6D207B54D3420A4AB@ORSMSX106.amr.corp.intel.com>
References: <1533653765-26080-1-git-send-email-yong.zhi@intel.com>
 <s5hzhxy2oc5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 4574E26785E
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 17:36:15 +0200 (CEST)
In-Reply-To: <s5hzhxy2oc5.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "N,
 Harshapriya" <harshapriya.n@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "vkoul@kernel.org" <vkoul@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "M, Naveen" <naveen.m@intel.com>, "Kale, Sanyog R" <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi,

Thanks for the review.

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, August 7, 2018 10:23 AM
> To: Zhi, Yong <yong.zhi@intel.com>
> Cc: broonie@kernel.org; pierre-louis.bossart@linux.intel.com; alsa-
> devel@alsa-project.org; N, Harshapriya <harshapriya.n@intel.com>;
> vkoul@kernel.org; M, Naveen <naveen.m@intel.com>; Kale, Sanyog R
> <sanyog.r.kale@intel.com>
> Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: hdac_hdmi: Add sampling
> frequencies constraint
> 
> On Tue, 07 Aug 2018 16:56:05 +0200,
> Yong Zhi wrote:
> >
> > Playback of 44.1Khz contents with HDMI plugged returns "Invalid pipe
> > config".
> 
> Why?  Is it a limitation of i915 graphics side?
> If it's a generic issue, we'd need to fix also in the legacy HDMI driver, too.
> 

The HDMI paths in DFW topology are configured for 48Khz operation.

> (snip)
> ....
> > +
> > +			sad_rates = sad_sample_rates_lpcm(sad);
> > +			/* Filter out 44.1, 88.2 and 176.4Khz */
> > +			for (j = 0; j < 7; j += 2)
> > +				if (sad_rates & BIT(j))
> > +					rates |= cea_sampling_freqs[j];
> > +
> > +			snd_pcm_hw_constraint_mask64(runtime,
> > +
> SNDRV_PCM_HW_PARAM_RATE,
> > +						     rates);
> 
> The whole changes are too complex.  You don't have to reduce the list
> dynamically, but just need to tell the all possible rates with a static array.
> 
> Or, even simpler, just filter the rates bits in
> hdac_hdmi_create_dais() from the beginning like below.
> 
> 
> thanks,
> 
> Takashi
> 

Ack, will make changes in hdac_hdmi_create_dais() thanks!!


> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1410,6 +1410,12 @@ static int hdac_hdmi_create_dais(struct
> hdac_device *hdev,
>  		if (ret)
>  			return ret;
> 
> +		/* Filter out 44.1, 88.2 and 176.4Khz */
> +		rates &= ~(SNDRV_PCM_RATE_44100 |
> SNDRV_PCM_RATE_88200 |
> +			   SNDRV_PCM_RATE_176400);
> +		if (!rates)
> +			return -EINVAL;
> +
>  		sprintf(dai_name, "intel-hdmi-hifi%d", i+1);
>  		hdmi_dais[i].name = devm_kstrdup(&hdev->dev,
>  					dai_name, GFP_KERNEL);
