From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v1 11/13] ASoC: qcom: add apq8016 sound card support
Date: Thu, 14 May 2015 22:23:48 -0700
Message-ID: <20150515052348.GC31687@kwestfie-linux.qualcomm.com>
References: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1431518594-7752-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431518594-7752-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2015 at 05:03:14AM -0700, Srinivas Kandagatla wrote:
> This patch adds apq8016 machine driver support. This patch was tested on
> two apq8016-sbc and msm8916-mtp board for both hdmi and analog audio
> features.

> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 9cc5ed7..e71b0f2 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -34,3 +34,12 @@ config SND_SOC_STORM
>  	help
>            Say Y or M if you want add support for SoC audio on the
>            Qualcomm Technologies IPQ806X-based Storm board.
> +
> +config SND_SOC_APQ8016_SBC
> +	tristate "SoC Audio support for APQ8016 SBC platforms"
> +	depends on SND_SOC_QCOM || ARCH_QCOM || COMPILE_TEST

I believe this should be:
        depends on (SND_SOC_QCOM && ARCH_QCOM) || COMPILE_TEST

> +	select SND_SOC_LPASS_APQ8016
> +	help
> +          Support for Qualcomm Technologies LPASS audio block in
> +          APQ8016 SOC-based systems.
> +          Say Y if you want to use audio devices on MI2S

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
