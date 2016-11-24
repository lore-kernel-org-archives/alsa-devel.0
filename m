From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC v2 1/3] ASoC: core: allow DAI PCM controls
 bound to PCM device
Date: Thu, 24 Nov 2016 10:25:13 +0530
Message-ID: <20161124045513.GS2698@localhost>
References: <1479811996-2238-1-git-send-email-arnaud.pouliquen@st.com>
 <1479811996-2238-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 106D1266DF6
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2016 05:45:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1479811996-2238-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2016 at 11:53:14AM +0100, Arnaud Pouliquen wrote:

Sorry I have not looked at previous discussions, so if my questions are
repeat please do point me to relevant thread and I will read up.

> In case of several instances of the same PCM control (e.g IEC controls).

Why are we calling it PCM controls? They are just alsa kcontrols, maybe
used for doing some PCM configuration but then they are just controls.

The same problem (same control names IIUC) existis on codec and SoC's, now
that both have DSP, we can have DSP "Volume control"...

Would this solve that as well..?

> Application should be able to address the control using the
> device field number, according to the PCM character device.
> This patch allows to link DAI PCM controls to the PCM device.

why is that part required..? Is the problem being solved to address a
control uniquely or something else?

> During DAI_link probe, PCM controls are added after device field is forced
> to the PCM device number.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  include/sound/soc-dai.h |  4 ++++
>  sound/soc/soc-core.c    | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 200e1f0..3ff1a86 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -273,6 +273,10 @@ struct snd_soc_dai_driver {
>  	/* probe ordering - for components with runtime dependencies */
>  	int probe_order;
>  	int remove_order;
> +
> +	/* Optional PCM controls to bind to PCM device on DAIs link*/
> +	const struct snd_kcontrol_new *pcm_controls;
> +	int num_pcm_controls;
>  };
>  
>  /*
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index aaab26a..a494287 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1598,6 +1598,25 @@ static int soc_probe_dai(struct snd_soc_dai *dai, int order)
>  	return 0;
>  }
>  
> +static int soc_link_dai_pcm_controls(struct snd_soc_card *card,
> +				     struct snd_soc_dai *dai,
> +				     struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_kcontrol_new kctl;
> +	struct snd_soc_dai_driver *drv = dai->driver;
> +	int i, err;
> +
> +	for (i = 0; i < drv->num_pcm_controls; i++) {
> +		kctl = drv->pcm_controls[i];
> +		if (!rtd->dai_link->no_pcm)
> +			kctl.device = rtd->pcm->device;
> +		if (snd_soc_add_dai_controls(dai, &kctl, 1))
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int soc_link_dai_widgets(struct snd_soc_card *card,
>  				struct snd_soc_dai_link *dai_link,
>  				struct snd_soc_pcm_runtime *rtd)
> @@ -1709,6 +1728,24 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>  				       dai_link->stream_name, ret);
>  				return ret;
>  			}
> +
> +			/* Bind DAIs pcm controls to the PCM device */
> +			if (cpu_dai->driver->pcm_controls) {
> +				ret = soc_link_dai_pcm_controls(card, cpu_dai,
> +								rtd);
> +				if (ret < 0)
> +					return ret;
> +			}
> +			for (i = 0; i < rtd->num_codecs; i++) {
> +				struct snd_soc_dai *dai = rtd->codec_dais[i];
> +
> +				if (dai->driver->pcm_controls)
> +					ret = soc_link_dai_pcm_controls(card,
> +									dai,
> +									rtd);
> +				if (ret < 0)
> +					return ret;
> +			}
>  		} else {
>  			INIT_DELAYED_WORK(&rtd->delayed_work,
>  						codec2codec_close_delayed_work);
> -- 
> 1.9.1
> 

-- 
~Vinod
