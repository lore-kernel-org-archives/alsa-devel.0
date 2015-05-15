From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v1 02/13] ASoC: qcom: move ipq806x specific bits out of
 lpass driver.
Date: Thu, 14 May 2015 22:23:57 -0700
Message-ID: <20150515052356.GD31687@kwestfie-linux.qualcomm.com>
References: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1431518426-7307-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431518426-7307-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2015 at 05:00:26AM -0700, Srinivas Kandagatla wrote:
> This patch tries to make the lpass driver more generic by moving the
> ipq806x specific bits out of the cpu and platform driver, also allows the
> SOC specific drivers to add the correct register offsets.
> 
> This patch also renames the register definition header file into more
> generic header file.

> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 05b9840..865205e 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig

> @@ -14,11 +14,16 @@ config SND_SOC_LPASS_PLATFORM
>  	depends on SND_SOC_QCOM && OF
>  	select REGMAP_MMIO
>  
> +config SND_SOC_LPASS_IPQ806X
> +	tristate
> +	depends on SND_SOC_QCOM
> +	select SND_SOC_LPASS_CPU
> +	select SND_SOC_LPASS_PLATFORM

Based on moving the of_device_id table from lpass-cpu.c to
lpass-ipq806x.c, shouldn't the OF dependency follow to the
SND_SOC_LPASS_IPQ806X config (and not SND_SOC_LPASS_CPU)?

> +
>  config SND_SOC_STORM
>  	tristate "ASoC I2S support for Storm boards"
>  	depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
> -	select SND_SOC_LPASS_CPU
> -	select SND_SOC_LPASS_PLATFORM
> +	select SND_SOC_LPASS_IPQ806X
>  	select SND_SOC_MAX98357A
>  	help
>            Say Y or M if you want add support for SoC audio on the

> diff --git a/sound/soc/qcom/lpass-ipq806x.c
> b/sound/soc/qcom/lpass-ipq806x.c
> new file mode 100644
> index 0000000..d1f698c
> --- /dev/null
> +++ b/sound/soc/qcom/lpass-ipq806x.c

> +static struct platform_driver ipq806x_lpass_cpu_platform_driver = {
> +	.driver	= {
> +		.name		= "lpass-cpu",
> +		.of_match_table	=
> of_match_ptr(ipq806x_lpass_cpu_device_id),
> +	},
> +	.probe	= asoc_qcom_lpass_cpu_platform_probe,
> +	.remove	= asoc_qcom_lpass_cpu_platform_remove,
> +};
> +module_platform_driver(ipq801x_lpass_cpu_platform_driver);

Patch below fixes the above typo (which breaks compilation):

-----------------------><---------------------------------------------
diff --git a/sound/soc/qcom/lpass-ipq806x.c
b/sound/soc/qcom/lpass-ipq806x.c
index ad1d67a..2eab828 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -103,7 +103,7 @@ static struct platform_driver ipq806x_lpass_cpu_platform_driver = {
        .probe  = asoc_qcom_lpass_cpu_platform_probe,
        .remove = asoc_qcom_lpass_cpu_platform_remove,
 };
-module_platform_driver(ipq801x_lpass_cpu_platform_driver);
+module_platform_driver(ipq806x_lpass_cpu_platform_driver);
                  
 MODULE_DESCRIPTION("QTi LPASS CPU Driver");
 MODULE_LICENSE("GPL v2");
-----------------------><---------------------------------------------

> +
> +MODULE_DESCRIPTION("QTi LPASS CPU Driver");
> +MODULE_LICENSE("GPL v2");

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
