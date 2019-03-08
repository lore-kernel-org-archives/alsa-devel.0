From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl: sai: Fix underrrun for playback stream
 start
Date: Fri, 8 Mar 2019 12:58:06 -0800
Message-ID: <20190308205805.GA8912@Asurada-Nvidia.nvidia.com>
References: <20190308173904.27298-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308173904.27298-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 08, 2019 at 05:39:30PM +0000, Daniel Baluta wrote:

> @@ -542,6 +544,11 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		for (i = 0; tx && i < channels; i++)
> +			regmap_write(sai->regmap, FSL_SAI_TDR, 0x0);

Though it could reduce underrrun for sure, I don't feel it's a
thorough fix, especially when dealing with a duplex case where
RX is the first stream while the driver enables both TE and RE
at the same time. So the transmitter might have started before
TX DMA request gets enabled.

We actually have something similar in the ESAI driver as that
one is well documented. But SAI is apparently more tricky at
the trigger() function. And the paragraph you pasted from the
RM doesn't explicitly sound like we should do this.

Btw, Instead of writing dummy data, have you tried polling the
WFP pointer of the TFR0 register to make sure data is copied
by the DMA?

> +		if (tx)
> +			udelay(10);

Any justification for the delay? Missing a line of comments? I
guess it's to address the 3-bit clocks timing. However, putting
it before enabling DMA request doesn't make much sense to me.

> +
>  		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
>  				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
>  
> -- 
> 2.17.1
> 
