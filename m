From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Remove expensive print in
	irq handler
Date: Fri, 18 Jan 2019 12:08:32 -0800
Message-ID: <20190118200831.GB11798@Asurada-Nvidia.nvidia.com>
References: <20190118142623.17720-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5983B266BE8
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 21:08:36 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id v28so6542606pgk.10
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 12:08:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190118142623.17720-1-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2019 at 02:26:46PM +0000, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> When stopping audio, ASoC will first stop DMA then CPU DAI.
> Sometimes there is a delay between DMA stop and CPU DAI stop, which
> triggers an underrun error. Now, because of the delay introduced
> by dev_err another underrun error will occur causing a vicious circle
> making impossible to stop CPU DAI.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 4163f2cfc06f..db9e0872f73d 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -62,10 +62,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
>  		dev_dbg(dev, "isr: Start of Tx word detected\n");
>  
>  	if (flags & FSL_SAI_CSR_SEF)
> -		dev_warn(dev, "isr: Tx Frame sync error detected\n");
> +		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
>  
>  	if (flags & FSL_SAI_CSR_FEF) {
> -		dev_warn(dev, "isr: Transmit underrun detected\n");
> +		dev_dbg(dev, "isr: Transmit underrun detected\n");
>  		/* FIFO reset for safety */
>  		xcsr |= FSL_SAI_CSR_FR;
>  	}
> @@ -96,10 +96,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
>  		dev_dbg(dev, "isr: Start of Rx word detected\n");
>  
>  	if (flags & FSL_SAI_CSR_SEF)
> -		dev_warn(dev, "isr: Rx Frame sync error detected\n");
> +		dev_dbg(dev, "isr: Rx Frame sync error detected\n");
>  
>  	if (flags & FSL_SAI_CSR_FEF) {
> -		dev_warn(dev, "isr: Receive overflow detected\n");
> +		dev_dbg(dev, "isr: Receive overflow detected\n");
>  		/* FIFO reset for safety */
>  		xcsr |= FSL_SAI_CSR_FR;
>  	}
> -- 
> 2.17.1
> 
