From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Skylake: Fix jack name format
 substitution
Date: Thu, 28 Sep 2017 08:40:36 +0530
Message-ID: <20170928031036.GU30097@localhost>
References: <y>
 <1505749403-31346-1-git-send-email-chintan.m.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505749403-31346-1-git-send-email-chintan.m.patel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Patel <chintan.m.patel@intel.com>
Cc: alsa-devel@alsa-project.org, Hsin-yu Chao <hychao@google.com>, harshapriya.n@intel.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, naveen.m@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 18, 2017 at 08:43:18AM -0700, Chintan Patel wrote:
> Jack name is not getting formatted correctly hence resulting
> in invalid name for HDMI/DP input devices.
> 
> This was recently exposed due changes brought by MST:
> commit 3a13347f05fd ("ASoC: Intel: kbl: Add jack port initialize
> in kbl machine drivers")

Acked-By: Vinod Koul <vinod.koul@intel.com>

> 
> Signed-off-by: Chintan Patel <chintan.m.patel@intel.com>
> ---
>  sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index 4689991bcc86..c127b7b0ee3f 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -611,6 +611,8 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
>  
>  	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
>  		codec = pcm->codec_dai->codec;
> +		snprintf(jack_name, sizeof(jack_name),
> +			"HDMI/DP, pcm=%d Jack", pcm->device);
>  		err = snd_soc_card_jack_new(card, jack_name,
>  				SND_JACK_AVOUT, &ctx->kabylake_hdmi[i],
>  				NULL, 0);
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
