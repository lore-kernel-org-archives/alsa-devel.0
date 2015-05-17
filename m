From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v2 06/13] ASoC: qcom: make osr clock optional
Date: Sun, 17 May 2015 09:15:03 -0700
Message-ID: <20150517161502.GB10901@kwestfie-linux.qualcomm.com>
References: <1431779462-1732-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1431779569-2091-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431779569-2091-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 16, 2015 at 05:32:49AM -0700, Srinivas Kandagatla wrote:
> Some LPASS integrations like on APQ8016 do not have OSR clk, so making
> osr clk optional would allow such integrations to use lpass driver.

> @@ -415,7 +424,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct
> platform_device *pdev)
>  			dev_err(&pdev->dev,
>  				"%s() error getting mi2s-osr-clk: %ld\n",
>  				__func__,
> -			return PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
> +			PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
>  		}

NIT:
Perhaps make this a dev_warn or dev_notice log message, as it's no longer
really an error.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
