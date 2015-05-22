From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/10] ASoC: qcom: make lpass driver depend on OF
Date: Fri, 22 May 2015 15:15:15 +0200
Message-ID: <2168878.0V0FR6oKgi@wuerfel>
References: <1432245125-8939-1-git-send-email-srinivas.kandagatla@linaro.org> <1432245161-8990-1-git-send-email-srinivas.kandagatla@linaro.org> <2534276.hIjFJK74Zh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <2534276.hIjFJK74Zh@wuerfel>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Friday 22 May 2015 09:24:35 Arnd Bergmann wrote:
> Could you instead make the drivers compile without OF being set?
> 
> I see that patch 7 and 8 introduces another two options doing
> 
> 
> +config SND_SOC_LPASS_APQ8016
> +       tristate
> +       depends on SND_SOC_QCOM
> +       select SND_SOC_LPASS_CPU
> +       select SND_SOC_LPASS_PLATFORM
> +
> 
> +config SND_SOC_APQ8016_SBC
> +       tristate "SoC Audio support for APQ8016 SBC platforms"
> +       depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
> +       select SND_SOC_LPASS_APQ8016
> +       help
> 
> so you get an obvious build failure here when SND_SOC_APQ8016_SBC
> gets selected with COMPILE_TEST on a platform that does not support OF.
> 
> 

Actually, the patch 9bae4880acee ("ASoC: qcom: move ipq806x specific
bits out of lpass driver.") already broke things more after I fixed it
up. Please fold in this bit too before you send it again, and
try to test the changes you send:

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index b30c2baa7501..08ebc9b8f915 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -20,7 +20,7 @@ config SND_SOC_LPASS_IPQ806X
 
 config SND_SOC_STORM
 	tristate "ASoC I2S support for Storm boards"
-	depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
+	depends on SND_SOC_QCOM && (ARCH_QCOM || COMPILE_TEST)
 	select SND_SOC_LPASS_IPQ806X
 	select SND_SOC_MAX98357A
 	help




	Arnd
