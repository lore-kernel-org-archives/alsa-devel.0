From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v1 05/13] ASoC: qcom: support bitclk and osrclk per i2s
 port
Date: Thu, 14 May 2015 22:23:30 -0700
Message-ID: <20150515052329.GA31687@kwestfie-linux.qualcomm.com>
References: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1431518452-7434-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431518452-7434-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2015 at 05:00:52AM -0700, Srinivas Kandagatla wrote:
> This patch adds support to allow bitclk and osrclk per i2s dai port.
> on APQ8016 there are 4 i2s ports each one has its own bit clks.
> 
> Without this patch its not possible to support multiple i2s ports in the
> lpass driver.

> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index 5965667..0d28ea7 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -33,7 +33,7 @@ static int lpass_cpu_daiops_set_sysclk(struct
> snd_soc_dai *dai, int clk_id,
>  	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
>  	int ret;
>  
> -	ret = clk_set_rate(drvdata->mi2s_osr_clk, freq);
> +	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->driver->id], freq);
>  	if (ret)
>  		dev_err(dai->dev, "%s() error setting mi2s osrclk to %u:
> %d\n",
>  				__func__, freq, ret);

Audio was broken on the Storm board with this patch series.  The issue
has to do with the mismatch of the clock position in the array (which
was 0) and the dai->driver->id (which was 4).  Basically, the position of
the bit/osr clocks in their respective arrays need to match the MI2S
port number, even if the port number doesn't start at the 0 position.

I realize there are multiple ways to address this.  The quick solution I
came up with (to get audio functioning again) was to change the DT clock
entries for the ipq806x (see changes below for your reference).  The
downside to the way I did this is, that now, there is no error-checking
for clocks that should be in the DT but aren't there.

Suggestions are welcome on how to best address this issue.

-----------------------><---------------------------------------------
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
index 21c6483..2684a4f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
@@ -8,8 +8,8 @@ Required properties:
 - clocks		: Must contain an entry for each entry in clock-names.
 - clock-names		: A list which must include the following entries:
 				* "ahbix-clk"
-				* "mi2s-osr-clk"
-				* "mi2s-bit-clk"
+				* "mi2s-osr-clk4"
+				* "mi2s-bit-clk4"
 			: required clocks for "qcom,lpass-cpu-apq8016"
 				* "ahbix-clk"
 				* "mi2s-bit-clk0"
@@ -42,7 +42,7 @@ Example:
 lpass@28100000 {
 	compatible = "qcom,lpass-cpu";
 	clocks = <&lcc AHBIX_CLK>, <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
-	clock-names = "ahbix-clk", "mi2s-osr-clk", "mi2s-bit-clk";
+	clock-names = "ahbix-clk", "mi2s-osr-clk4", "mi2s-bit-clk4";
 	interrupts = <0 85 1>;
 	interrupt-names = "lpass-irq-lpaif";
 	pinctrl-names = "default", "idle";
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 5a13366..090984f 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -189,8 +189,8 @@
 					<&lcc MI2S_OSR_CLK>,
 					<&lcc MI2S_BIT_CLK>;
 			clock-names = "ahbix-clk",
-					"mi2s-osr-clk",
-					"mi2s-bit-clk";
+					"mi2s-osr-clk4",
+					"mi2s-bit-clk4";
 			interrupts = <0 85 1>;
 			interrupt-names = "lpass-irq-lpaif";
 			reg = <0x28100000 0x10000>;
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 5053629..7b66e52 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -411,11 +411,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 	if (variant->init)
 		variant->init(pdev);
 
-	for (i = 0; i < variant->num_dai; i++) {
-		if (variant->num_dai > 1)
-			sprintf(clk_name, "mi2s-osr-clk%d", i);
-		else
-			sprintf(clk_name, "mi2s-osr-clk");
+	for (i = 0; i < LPASS_MAX_MI2S_PORTS; i++) {
+		sprintf(clk_name, "mi2s-osr-clk%d", i);
 
 		drvdata->mi2s_osr_clk[i] = devm_clk_get(&pdev->dev,
 								clk_name);
@@ -427,19 +424,14 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		}
 	}
 
-	for (i = 0; i < variant->num_dai; i++) {
-
-		if (variant->num_dai > 1)
-			sprintf(clk_name, "mi2s-bit-clk%d", i);
-		else
-			sprintf(clk_name, "mi2s-bit-clk");
+	for (i = 0; i < LPASS_MAX_MI2S_PORTS; i++) {
+		sprintf(clk_name, "mi2s-bit-clk%d", i);
 
 		drvdata->mi2s_bit_clk[i] = devm_clk_get(&pdev->dev, clk_name);
 		if (IS_ERR(drvdata->mi2s_bit_clk[i])) {
 			dev_err(&pdev->dev,
 				"%s() error getting mi2s-bit-clk: %ld\n",
 				__func__, PTR_ERR(drvdata->mi2s_bit_clk[i]));
-			return PTR_ERR(drvdata->mi2s_bit_clk[i]);
 		}
 	}
-----------------------><---------------------------------------------

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
