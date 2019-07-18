From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: add i.MX8M support
Date: Thu, 18 Jul 2019 21:11:13 +0200
Message-ID: <9ebe242b-ceac-6064-5b8b-698068fa11f0@intel.com>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-4-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71BBBF8015B
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 21:11:19 +0200 (CEST)
In-Reply-To: <20190717105635.18514-4-l.stach@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Angus Ainslie <angus@akkea.ca>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-17 12:56, Lucas Stach wrote:
>   static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
>   	.use_imx_pcm = false,
> +	.has_version_registers = false,
>   	.fifo_depth = 32,
>   };
>   
>   static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
>   	.use_imx_pcm = true,
> +	.has_version_registers = false,
>   	.fifo_depth = 32,
>   };
>   
> +static const struct fsl_sai_soc_data fsl_sai_imx8m_data = {
> +	.use_imx_pcm = true,
> +	.has_version_registers = true,
> +	.fifo_depth = 128,
> +};
> +
>   static const struct of_device_id fsl_sai_ids[] = {
>   	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
>   	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
>   	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
> +	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8m_data },
>   	{ /* sentinel */ }
>   };

These datas are populating quite rapidly. If you're planning for adding 
more (and/ or appending additional fields), declaring helper macro could 
prove useful.

Czarek
