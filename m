From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ASoC: omap-mcbsp: Convert to use
 devm_ioremap_resource
Date: Mon, 24 Aug 2015 13:28:06 +0300
Message-ID: <55DAF1B6.2050605@ti.com>
References: <1440406056.27868.0.camel@ingics.com>
 <1440406145.27868.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id DA2CA2606B7
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 12:28:10 +0200 (CEST)
In-Reply-To: <1440406145.27868.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, =?UTF-8?Q?Thomas_Niederpr=c3=bcm?= <niederp@physik.uni-kl.de>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/24/2015 11:49 AM, Axel Lin wrote:
> Use devm_ioremap_resource() instead of open code.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/omap/mcbsp.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> =

> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 68a1252..c7563e2 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -965,25 +965,15 @@ int omap_mcbsp_init(struct platform_device *pdev)
>  	mcbsp->free =3D true;
>  =

>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
> -	if (!res) {
> +	if (!res)
>  		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (!res) {
> -			dev_err(mcbsp->dev, "invalid memory resource\n");
> -			return -ENOMEM;
> -		}
> -	}
> -	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
> -				     dev_name(&pdev->dev))) {
> -		dev_err(mcbsp->dev, "memory region already claimed\n");
> -		return -ENODEV;
> -	}
> +
> +	mcbsp->io_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mcbsp->io_base))
> +		return PTR_ERR(mcbsp->io_base);
>  =

>  	mcbsp->phys_base =3D res->start;
>  	mcbsp->reg_cache_size =3D resource_size(res);
> -	mcbsp->io_base =3D devm_ioremap(&pdev->dev, res->start,
> -				      resource_size(res));
> -	if (!mcbsp->io_base)
> -		return -ENOMEM;
>  =

>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
>  	if (!res)
> =



-- =

P=E9ter
