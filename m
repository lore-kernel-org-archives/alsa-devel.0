From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_asrc: Unify the supported input and
 output rate
Date: Thu, 11 Apr 2019 13:11:58 -0700
Message-ID: <20190411201158.GB13170@Asurada-Nvidia.nvidia.com>
References: <cover.1554975348.git.shengjiu.wang@nxp.com>
 <b7f4c8dd00743ddd09c33def00c1759757b8e743.1554975348.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b7f4c8dd00743ddd09c33def00c1759757b8e743.1554975348.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 11, 2019 at 09:39:09AM +0000, S.j. Wang wrote:
> Unify the supported input and output rate, add the

We previously didn't support 5KHz->5KHz, but now we do? That'd be
great if so.

>  static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
> @@ -626,14 +629,18 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
>  		.stream_name = "ASRC-Playback",
>  		.channels_min = 1,
>  		.channels_max = 10,
> -		.rates = FSL_ASRC_RATES,
> +		.rate_min = 5512,
> +		.rate_max = 192000,
> +		.rates = SNDRV_PCM_RATE_KNOT,
>  		.formats = FSL_ASRC_FORMATS,
>  	},
>  	.capture = {
>  		.stream_name = "ASRC-Capture",
>  		.channels_min = 1,
>  		.channels_max = 10,
> -		.rates = FSL_ASRC_RATES,

Probably could remove FSL_ASRC_RATES define since it's not used.

Thanks
