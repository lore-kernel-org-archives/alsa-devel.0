From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH RFC 10/15] ASoC: qcom: apq8016: add wrdma
 support
Date: Tue, 2 Feb 2016 16:37:14 -0800
Message-ID: <20160203003714.GK14436@kwestfie-linux.qualcomm.com>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347760-10856-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454347760-10856-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2016 at 09:29:20AM -0800, Srinivas Kandagatla wrote:
> diff --git a/sound/soc/qcom/lpass-apq8016.c
> b/sound/soc/qcom/lpass-apq8016.c
> index df44f09..3eef0c3 100644
> --- a/sound/soc/qcom/lpass-apq8016.c
> +++ b/sound/soc/qcom/lpass-apq8016.c

...

> @@ -213,7 +225,11 @@ static struct lpass_variant apq8016_data = {
>  	.rdma_reg_base		= 0x8400,
>  	.rdma_reg_stride	= 0x1000,
>  	.rdma_channels		= 2,
> -	.rdmactl_audif_start	= 1,
> +	.dmactl_audif_start	= 1,

Changing rdma.. to dma.. should be done in patch 3 (ASoC: qcom: rename
rdmactl_audif_start to dmactrl_audif_start).  The build should
fail otherwise if bisecting between this patch and patch 3.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
