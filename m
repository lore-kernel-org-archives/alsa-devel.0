From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/10] ASoC: qcom: make lpass driver depend on OF
Date: Fri, 22 May 2015 09:24:35 +0200
Message-ID: <2534276.hIjFJK74Zh@wuerfel>
References: <1432245125-8939-1-git-send-email-srinivas.kandagatla@linaro.org> <1432245161-8990-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432245161-8990-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thursday 21 May 2015 22:52:41 Srinivas Kandagatla wrote:
> 
>  config SND_SOC_LPASS_CPU
>         tristate
> +       depends on OF
>         select REGMAP_MMIO
>  
>  config SND_SOC_LPASS_PLATFORM
>         tristate
> +       depends on OF
>         select REGMAP_MMIO
>  
>  config SND_SOC_LPASS_IPQ806X
> 

Could you instead make the drivers compile without OF being set?

I see that patch 7 and 8 introduces another two options doing


+config SND_SOC_LPASS_APQ8016
+       tristate
+       depends on SND_SOC_QCOM
+       select SND_SOC_LPASS_CPU
+       select SND_SOC_LPASS_PLATFORM
+

+config SND_SOC_APQ8016_SBC
+       tristate "SoC Audio support for APQ8016 SBC platforms"
+       depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
+       select SND_SOC_LPASS_APQ8016
+       help

so you get an obvious build failure here when SND_SOC_APQ8016_SBC
gets selected with COMPILE_TEST on a platform that does not support OF.

	Arnd
