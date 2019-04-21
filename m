From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Date: Sat, 20 Apr 2019 22:37:52 -0700
Message-ID: <20190421053749.GA5552@Asurada>
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190420154038.14576-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>
List-Id: alsa-devel@alsa-project.org

By following the pattern of previous Subjects:
ASoC: fsl_sai: Fix clock Source for mclk0

On Sat, Apr 20, 2019 at 03:41:04PM +0000, Daniel Baluta wrote:
> SAI provide multiple master clock source options selectable
> via bit MSEL of TCR2/RCR2.
> 
> All possible master clock sources are stored in sai->mclk_clk
> array. Current implementation assumes that MCLK0 source is always
> busclk, but this is wrong!
> 
> For example, on i.MX8QM we have:
> 
> 00b - Bus Clock selected.
> 01b - Master Clock (MCLK) 1 option selected.
> 10b - Master Clock (MCLK) 2 option selected.
> 11b - Master Clock (MCLK) 3 option selected.
> 
> while on i.MX6SX we have:
> 
> 00b - Master Clock (MCLK) 1 option selected.
> 01b - Master Clock (MCLK) 1 option selected.
> 10b - Master Clock (MCLK) 2 option selected.
> 11b - Master Clock (MCLK) 3 option selected.
> 
> So, this patch will read mclk0 source clock from device tree.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d2a4dc744fd7..faa8de87ff83 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -829,8 +829,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		sai->bus_clk = NULL;
>  	}
>  
> -	sai->mclk_clk[0] = sai->bus_clk;
> -	for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
> +	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
>  		sprintf(tmp, "mclk%d", i);

Firstly, according to your commit message, neither imx8qm nor
imx6sx has an "mclk0" clock in the clock list. Either of them
starts with "mclk1". So, before you change the driver, I don't
think it's even a right thing to define an "mclk0" in the DT.

>  		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
>  		if (IS_ERR(sai->mclk_clk[i])) {

Secondly, this would break existing DT bindings of imx6sx and
imx7 platforms as they both have clock-names defined in DTB:
	clock-names = "bus", "mclk1", "mclk2", "mclk3";
Since there's no "mclk0", the entire probe() would error-out.
And mainline has a DT backward-compatible policy, which means
you can't just rename the "bus" in the DTBs but would have to
support them, not to mention "mclk0" is still questionable.

So the right way to fix it is, in my option, to differentiate
the mclk_clk[0] clock source name with the compatible string.
Then you can get the clock name and simply do:
-	sai->mclk_clk[0] = sai->bus_clk;
+	sai->mclk_clk[0] = devm_clk_get(&pdev->dev, tmp);
+	if (IS_ERR(sai->mclk_clk[0)) {
+		/* error-out*/
+	}
