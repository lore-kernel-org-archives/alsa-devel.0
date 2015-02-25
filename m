From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch V6 08/10] ASoC: qcom: Add ability to build QCOM drivers
Date: Wed, 25 Feb 2015 08:40:50 +0000
Message-ID: <54ED8A92.2030702@linaro.org>
References: <1424846385-23700-1-git-send-email-kwestfie@codeaurora.org> <1424846385-23700-9-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424846385-23700-9-git-send-email-kwestfie@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 25/02/15 06:39, Kenneth Westfield wrote:
> From: Kenneth Westfield <kwestfie@codeaurora.org>
>
> Define the LPASS platform driver, the LPASS
> CPU DAI driver and the Storm machine driver
> configurations, and how to build them.
>
> Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig  | 23 +++++++++++++++++++++++
>   sound/soc/qcom/Makefile | 11 +++++++++++
>   2 files changed, 34 insertions(+)
>   create mode 100644 sound/soc/qcom/Kconfig
>   create mode 100644 sound/soc/qcom/Makefile
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..90e686be613a5ef7689582a9d085835d2fe12678
> --- /dev/null
> +++ b/sound/soc/qcom/Kconfig
> @@ -0,0 +1,23 @@
> +config SND_SOC_QCOM
> +	tristate "ASoC support for QCOM platforms"
> +	help
> +          Say Y or M if you want to add support to use audio devices
> +          in Qualcomm Technologies SOC-based platforms.
> +
> +config SND_SOC_LPASS_CPU
> +	tristate
> +	depends on SND_SOC_QCOM
> +
> +config SND_SOC_LPASS_PLATFORM
> +	tristate
> +	depends on SND_SOC_QCOM

I think both of the above configs should select REGMAP_MMIO.

> +
> +config SND_SOC_STORM
> +	tristate "ASoC I2S support for Storm boards"
> +	depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
> +	select SND_SOC_LPASS_CPU
> +	select SND_SOC_LPASS_PLATFORM
> +	select SND_SOC_MAX98357A
> +	help
> +          Say Y or M if you want add support for SoC audio on the
> +          Qualcomm Technologies IPQ806X-based Storm board.
> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..c5ce96c761c47b3a1b98e27d863fe0b5b9bc019e
> --- /dev/null
> +++ b/sound/soc/qcom/Makefile
> @@ -0,0 +1,11 @@
> +# Platform
> +snd-soc-lpass-cpu-objs := lpass-cpu.o
> +snd-soc-lpass-platform-objs := lpass-platform.o
> +
> +obj-$(CONFIG_SND_SOC_LPASS_CPU) += snd-soc-lpass-cpu.o
> +obj-$(CONFIG_SND_SOC_LPASS_PLATFORM) += snd-soc-lpass-platform.o
> +
> +# Machine
> +snd-soc-storm-objs := storm.o
> +
> +obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>
