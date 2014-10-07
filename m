From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: fsl: imx-spdif: Delete unneeded
 test before of_node_put
Date: Tue, 7 Oct 2014 11:42:03 -0700
Message-ID: <20141007184202.GA12286@Alpha>
References: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
 <1412706598-18796-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id DF1BA260427
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:42:09 +0200 (CEST)
Received: by mail-pd0-f177.google.com with SMTP id v10so5399298pde.8
 for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2014 11:42:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1412706598-18796-2-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 07, 2014 at 03:29:56PM -0300, Fabio Estevam wrote:
> of_node_put() supports NULL as its argument, so the initial test is not
> necessary.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked for two fsl ones.

Thank you again
Nicolin

> ---
>  sound/soc/fsl/imx-spdif.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
> index e1dc401..0c9068e 100644
> --- a/sound/soc/fsl/imx-spdif.c
> +++ b/sound/soc/fsl/imx-spdif.c
> @@ -74,8 +74,7 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, data);
>  
>  end:
> -	if (spdif_np)
> -		of_node_put(spdif_np);
> +	of_node_put(spdif_np);
>  
>  	return ret;
>  }
> -- 
> 1.9.1
> 
