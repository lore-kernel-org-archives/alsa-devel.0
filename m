From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [patch] ASoC: hdac_hdmi: Potential NULL deref in
 hdac_hdmi_get_spk_alloc()
Date: Tue, 3 May 2016 15:26:39 +0530
Message-ID: <20160503095639.GS2274@localhost>
References: <20160503074258.GA9722@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160503074258.GA9722@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2016 at 10:42:58AM +0300, Dan Carpenter wrote:
> We intended || here instead of &&.  The original code potentially leads
> to a NULL dereference.

This looks good to me, I will test this and get back

> 
> Fixes: 2889099eb8cd ('ASoC: hdac_hdmi: Register chmap controls and ops')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index 3043120..7e7ff1b 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1609,7 +1609,7 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
>  	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
>  	struct hdac_hdmi_pin *pin = pcm->pin;
>  
> -	if (!pin && !pin->eld.eld_valid)
> +	if (!pin || !pin->eld.eld_valid)
>  		return 0;
>  
>  	return pin->eld.info.spk_alloc;

-- 
~Vinod
