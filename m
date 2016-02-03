From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH RFC 08/15] ASoC: qcom: add wrdma dma channel
 start
Date: Tue, 2 Feb 2016 16:36:56 -0800
Message-ID: <20160203003656.GI14436@kwestfie-linux.qualcomm.com>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347741-10696-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454347741-10696-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2016 at 09:29:01AM -0800, Srinivas Kandagatla wrote:
> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
> index 30449f3..8475b60 100644
> --- a/sound/soc/qcom/lpass.h
> +++ b/sound/soc/qcom/lpass.h
> @@ -80,6 +80,7 @@ struct lpass_variant {
>  	 * at different offset to ipq806x
>  	 **/
>  	u32	dmactl_audif_start;
> +	u32	wrdma_channel_start;

This patch should come before patch 6 (ASoC: qcom: ipq806x: add wrdma
related register offsets) as that patch references this field.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
