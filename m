From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 2/5 v4] drm/i2c/adv7511: Add audio support
Date: Fri, 8 Apr 2016 17:46:17 +0200
Message-ID: <5707D249.5040707@metafoo.de>
References: <cover.1460047238.git.joabreu@synopsys.com>
 <d56087fae14074198f6c1bc749ce4da3cab62324.1460047238.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d56087fae14074198f6c1bc749ce4da3cab62324.1460047238.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: architt@codeaurora.org, airlied@linux.ie, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, CARLOS.PALMINHA@synopsys.com, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 04/07/2016 06:53 PM, Jose Abreu wrote:
> This patch adds audio support for the ADV7511 HDMI transmitter
> using ALSA SoC.
> 
> The code was ported from Analog Devices linux tree from
> commit 1770c4a1e32b ("Merge remote-tracking branch
> 'xilinx/master' into xcomm_zynq"), which is available at:
> 	- https://github.com/analogdevicesinc/linux/

The reason why this driver is still out of tree, is because there has been
no conclusion yet on how to go forward with the whole HDMI integration. So
this is not going to get merged until that issue has been addressed.

[...]
> +- adi,enable-audio: If set the ADV7511 driver will register a codec interface
> +  into ALSA SoC.

This is not a description of the hardware.

[...]
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 964b7de..539c091 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -33,6 +33,7 @@ struct snd_compr_stream;
>  #define SND_SOC_DAIFMT_DSP_B		5 /* L data MSB during FRM LRC */
>  #define SND_SOC_DAIFMT_AC97		6 /* AC97 */
>  #define SND_SOC_DAIFMT_PDM		7 /* Pulse density modulation */
> +#define SND_SOC_DAIFMT_SPDIF		8 /* SPDIF */

This needs to be a separate patch.
