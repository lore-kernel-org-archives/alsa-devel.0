From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_sai: Add imx7d platform
	support
Date: Fri, 7 Aug 2015 12:34:37 -0700
Message-ID: <20150807193436.GA6840@Asurada>
References: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
 <f269bace628dd8ebac7c1833b743d4d5e5d528db.1438928571.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A34D2606CA
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 21:34:49 +0200 (CEST)
Received: by pacrr5 with SMTP id rr5so58829186pac.3
 for <alsa-devel@alsa-project.org>; Fri, 07 Aug 2015 12:34:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f269bace628dd8ebac7c1833b743d4d5e5d528db.1438928571.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 07, 2015 at 02:23:52PM +0800, Zidan Wang wrote:
> i.MX7d SoC contains SAI module, so add imx7d platform support.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 5c737f1..390197e 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -704,6 +704,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
>  		sai->sai_on_imx = true;
>  
> +	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx7d-sai"))
> +		sai->sai_on_imx = true;

What's the difference between imx6sx-sai and imx7d-sai?

I think you may put its compatible model in the DT instead of adding
a copy in the driver unless the SAI on the imx7d really has something
different.

For example:
	compatible = "fsl,imx6q-ssi", "fsl,imx51-ssi";
	/* The driver only has imx51-ssi */
