From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel][PATCH 2/3] ASoC: fsl_sai: Add support for tdm slots
 operation
Date: Wed, 21 Jan 2015 10:08:03 -0800
Message-ID: <20150121180801.GA3361@Alpha>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-3-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421756480-7055-3-git-send-email-zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 20, 2015 at 08:21:19PM +0800, Zidan Wang wrote:
> @@ -369,10 +380,25 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	u32 word_width = snd_pcm_format_width(params_format(params));
>  	u32 val_cr4 = 0, val_cr5 = 0;
>  	int ret;
> +	u32 bclk;
> +
> +	if (channels == 1)
> +		channels = 2;
> +
> +	if (!sai->slots || sai->slots % channels)
> +		sai->slots = channels;
> +
> +	sai->slots = sai->slots / channels;
> +
> +	if (sai->slot_width < word_width || sai->is_dsp_mode)
> +		sai->slot_width = word_width;

Could you pls explain a bit what's this overriding for?
Or it might be better to put into a comment.

Nicolin
