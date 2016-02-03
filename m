From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH RFC 12/15] ASoC: qcom: add generic bit masks
 for RDMA and WRDMA
Date: Tue, 2 Feb 2016 16:37:28 -0800
Message-ID: <20160203003727.GM14436@kwestfie-linux.qualcomm.com>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347772-10960-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454347772-10960-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2016 at 09:29:32AM -0800, Srinivas Kandagatla wrote:
> diff --git a/sound/soc/qcom/lpass-lpaif-reg.h
> b/sound/soc/qcom/lpass-lpaif-reg.h
> index 2008f9f..2114b3e 100644
> --- a/sound/soc/qcom/lpass-lpaif-reg.h
> +++ b/sound/soc/qcom/lpass-lpaif-reg.h

...

> +#define __LPAIF_DMA_REG(v, chan, dir, reg)  \
> +	(dir ==  SNDRV_PCM_STREAM_PLAYBACK) ? \
> +		LPAIF_RDMA##reg##_REG(v, chan) : \
> +		LPAIF_WRDMA##reg##_REG(v, chan)
> +
> +#define LPAIF_DMACTL_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan, dir, CTL)
> +#define LPAIF_DMABASE_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan, dir,
> BASE)
> +#define	LPAIF_DMABUFF_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan,
> dir, BUFF)
> +#define LPAIF_DMACURR_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan, dir,
> CURR)
> +#define	LPAIF_DMAPER_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan,
> dir, PER)
> +#define	LPAIF_DMAPERCNT_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan,
> dir, PERCNT)
> +
> +
> +#define LPAIF_DMACTL_AUDINTF(id)	(id << LPAIF_DMACTL_AUDINTF_SHIFT)

IMO, it would make more sense to place this definition here ...

> +
> +#define LPAIF_DMACTL_BURSTEN_MASK	0x800
> +#define LPAIF_DMACTL_BURSTEN_SHIFT	11
> +#define LPAIF_DMACTL_BURSTEN_SINGLE	(0 << LPAIF_DMACTL_BURSTEN_SHIFT)
> +#define LPAIF_DMACTL_BURSTEN_INCR4	(1 << LPAIF_DMACTL_BURSTEN_SHIFT)
> +
> +#define LPAIF_DMACTL_WPSCNT_MASK	0x700
> +#define LPAIF_DMACTL_WPSCNT_SHIFT	8
> +#define LPAIF_DMACTL_WPSCNT_ONE	(0 << LPAIF_DMACTL_WPSCNT_SHIFT)
> +#define LPAIF_DMACTL_WPSCNT_TWO	(1 << LPAIF_DMACTL_WPSCNT_SHIFT)
> +#define LPAIF_DMACTL_WPSCNT_THREE	(2 << LPAIF_DMACTL_WPSCNT_SHIFT)
> +#define LPAIF_DMACTL_WPSCNT_FOUR	(3 << LPAIF_DMACTL_WPSCNT_SHIFT)
> +#define LPAIF_DMACTL_WPSCNT_SIX	(5 << LPAIF_DMACTL_WPSCNT_SHIFT)
> +#define LPAIF_DMACTL_WPSCNT_EIGHT	(7 << LPAIF_DMACTL_WPSCNT_SHIFT)
> +
> +#define LPAIF_DMACTL_AUDINTF_MASK	0x0F0
> +#define LPAIF_DMACTL_AUDINTF_SHIFT	4
...
   #define LPAIF_DMACTL_AUDINTF(id)     (id << LPAIF_DMACTL_AUDINTF_SHIFT)


-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
