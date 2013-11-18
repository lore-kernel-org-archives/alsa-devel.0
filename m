From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [RFC 4/9] ASoC: fsl-ssi: Add imx50-ssi and
	of_device_id matching
Date: Mon, 18 Nov 2013 09:38:49 +0800
Message-ID: <20131118013848.GM11014@S2101-09.ap.freescale.net>
References: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
 <1384530584-31273-5-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id D265E261728
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 02:37:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1384530584-31273-5-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 15, 2013 at 04:49:39PM +0100, Markus Pargmann wrote:
> @@ -190,6 +190,20 @@ struct fsl_ssi_private {
>  	char name[1];
>  };
>  
> +enum fsl_ssi_type {
> +	FSL_SSI_MCP8610,
> +	FSL_SSI_MX21,
> +	FSL_SSI_MX50,
> +};
> +
> +static const struct of_device_id fsl_ssi_ids[] = {
> +	{ .compatible = "fsl,mpc8610-ssi", .data = (void *) FSL_SSI_MCP8610},
> +	{ .compatible = "fsl,imx21-ssi", .data = (void *) FSL_SSI_MX21},
> +	{ .compatible = "fsl,imx50-ssi", .data = (void *) FSL_SSI_MX50},

As a good practice, please sort it from the specific to the generic.
That said, "fsl,imx50-ssi" should be put before "fsl,imx21-ssi".

Shawn

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
