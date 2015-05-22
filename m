From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 3/3] ASoC: qcom: fix STORM board Kconfig
Date: Fri, 22 May 2015 18:33:10 +0200
Message-ID: <11006188.h6ZK0CVLeu@wuerfel>
References: <1432309956-5228-1-git-send-email-srinivas.kandagatla@linaro.org> <1432310057-5358-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1432310057-5358-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Friday 22 May 2015 16:54:17 Srinivas Kandagatla wrote:
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 6ecac6c..f50197e 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -26,7 +26,7 @@ config SND_SOC_LPASS_APQ8016
>  
>  config SND_SOC_STORM
>         tristate "ASoC I2S support for Storm boards"
> -       depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
> +       depends on SND_SOC_QCOM && (ARCH_QCOM || COMPILE_TEST)
>         select SND_SOC_LPASS_IPQ806X
>         select SND_SOC_MAX98357A
>         help
> -- 

Do you still have the problem that you are selecting another symbol
that 'depends on OF', but this one does not have that dependency,
or did you drop that patch now before it could get picked up?

	Arnd
