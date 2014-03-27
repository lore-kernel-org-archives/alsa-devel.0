From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: fsl_sai: Add isr to deal with error flag
Date: Thu, 27 Mar 2014 02:13:48 +0000
Message-ID: <11a8271c31044515bd2657a93aefdaec@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> +	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
> +	regmap_write(sai->regmap, FSL_SAI_TCSR, xcsr);
> +
> +	if (xcsr & FSL_SAI_CSR_WSF)
> +		dev_dbg(dev, "isr: Start of Tx word detected\n");
> +
> +	if (xcsr & FSL_SAI_CSR_SEF)
> +		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
> +
> +	if (xcsr & FSL_SAI_CSR_FEF)
> +		dev_dbg(dev, "isr: Transmit underrun detected\n");
> +

Actually, the above three isrs should to write a logic 1 to this field
to clear this flag.


> +	if (xcsr & FSL_SAI_CSR_FWF)
> +		dev_dbg(dev, "isr: Enabled transmit FIFO is empty\n");
> +
> +	if (xcsr & FSL_SAI_CSR_FRF)
> +		dev_dbg(dev, "isr: Transmit FIFO watermark has been reached\n");
> +

While are these ones really needed to clear manually ?


Thanks,
--

Best Regards,
Xiubo
