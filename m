From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/6] ASoC: mxs: add device tree support for
	mxs-sgtl5000
Date: Fri, 11 May 2012 22:14:38 +0800
Message-ID: <20120511141434.GA17875@S2101-09.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
	<1336639333-11561-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id D7BB324493
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 16:14:37 +0200 (CEST)
Received: by dajt11 with SMTP id t11so4193424daj.38
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2012 07:14:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336639333-11561-6-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Dong Aisheng <dong.aisheng@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 04:42:12PM +0800, Shawn Guo wrote:
> Add device tree probe for mxs-sgtl5000 machine driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/sound/mxs-audio-sgtl5000.txt          |   17 ++++++
>  sound/soc/mxs/mxs-sgtl5000.c                       |   57 ++++++++++++++++++++
>  2 files changed, 74 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
> new file mode 100644
> index 0000000..601c518
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
> @@ -0,0 +1,17 @@
> +* Freescale MXS audio complex with SGTL5000 codec
> +
> +Required properties:
> +- compatible: "fsl,mxs-audio-sgtl5000"
> +- model: The user-visible name of this sound complex
> +- saif-controllers: The phandle list of the MXS SAIF controller
> +- audio-codec: The phandle of the SGTL5000 audio codec
> +
> +Example:
> +
> +sound {
> +	compatible = "fsl,imx28-evk-sgtl5000",
> +		     "fsl,mxs-audio-sgtl5000";
> +	model = "imx28-evk-sgtl5000";
> +	saif-controllers = <&saif0 &saif1>;
> +	audio-codec = <&sgtl5000>;
> +};
> diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
> index e9e6112..d420f11 100644
> --- a/sound/soc/mxs/mxs-sgtl5000.c
> +++ b/sound/soc/mxs/mxs-sgtl5000.c
> @@ -18,6 +18,8 @@
>  
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/soc.h>
> @@ -110,11 +112,58 @@ static struct snd_soc_card mxs_sgtl5000 = {
>  	.num_links	= ARRAY_SIZE(mxs_sgtl5000_dai),
>  };
>  
> +static int __devinit mxs_sgtl5000_probe_dt(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *saif_np[2], *codec_np;
> +	struct platform_device *saif_pdev[2];

The saif_pdev is a left-over which can be removed completely now.

> +	int i, ret = 0;
> +
> +	if (!np)
> +		return 1; /* no device tree */
> +
> +	saif_np[0] = of_parse_phandle(np, "saif-controllers", 0);
> +	saif_np[1] = of_parse_phandle(np, "saif-controllers", 1);
> +	codec_np = of_parse_phandle(np, "audio-codec", 0);
> +	if (!saif_np[0] || !saif_np[1] || !codec_np) {
> +		dev_err(&pdev->dev, "phandle missing or invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	saif_pdev[0] = of_find_device_by_node(saif_np[0]);
> +	saif_pdev[1] = of_find_device_by_node(saif_np[1]);
> +	if (!saif_pdev[0] || !saif_pdev[1]) {
> +		dev_err(&pdev->dev, "failed to find saif platform device\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < 2; i++) {
> +		mxs_sgtl5000_dai[i].codec_name = NULL;
> +		mxs_sgtl5000_dai[i].codec_of_node = codec_np;
> +		mxs_sgtl5000_dai[i].cpu_dai_name = NULL;
> +		mxs_sgtl5000_dai[i].cpu_dai_of_node = saif_np[i];
> +		mxs_sgtl5000_dai[i].platform_name = NULL;
> +		mxs_sgtl5000_dai[i].platform_of_node = saif_np[i];
> +	}
> +
> +out:

The label is used nowhere now.  Will remove it in v2.

> +	of_node_put(codec_np);
> +	of_node_put(saif_np[0]);
> +	of_node_put(saif_np[1]);
> +
> +	return ret;
> +}
> +

-- 
Regards,
Shawn
