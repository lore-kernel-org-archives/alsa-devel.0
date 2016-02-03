From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH RFC 03/15] ASoC: qcom: rename
 rdmactl_audif_start to dmactrl_audif_start
Date: Tue, 2 Feb 2016 16:35:47 -0800
Message-ID: <20160203003547.GD14436@kwestfie-linux.qualcomm.com>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347708-10446-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454347708-10446-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2016 at 09:28:28AM -0800, Srinivas Kandagatla wrote:
> diff --git a/sound/soc/qcom/lpass-platform.c
> b/sound/soc/qcom/lpass-platform.c
> index a6dce1b..bfc9de6 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -91,7 +91,7 @@ static int lpass_platform_pcmops_hw_params(struct
> snd_pcm_substream *substream,
>  	unsigned int channels = params_channels(params);
>  	unsigned int regval;
>  	int bitwidth;
> -	int ret, rdma_port = pcm_data->i2s_port + v->rdmactl_audif_start;
> +	int ret, rdma_port = pcm_data->i2s_port + v->dmactl_audif_start;

I was wondering why rdma_port had not been changed as well, until I saw
that in a later patch.  Would it make sense to combine all changes
related to removing read-only indications from identifiers to one patch?

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
