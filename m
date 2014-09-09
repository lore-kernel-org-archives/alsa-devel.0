From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Tue, 9 Sep 2014 09:55:41 +0000
Message-ID: <a2df014417624f0790c01b0ccd21853f@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>, "timur@tabi.org" <timur@tabi.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

> Subject: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
> 
> Move the ipg clock enable and disable operation to startup and shutdown,
> that is only enable ipg clock when ssi is working. we don't need to enable
> ipg clock in probe.
> Another register accessing need the ipg clock, so use
> devm_regmap_init_mmio_clk
> instead of devm_regmap_init_mmio.
>

You should split this into two separate patches, which will be more
Easy to be reviewed.
 
Thanks,

BRs
Xiubo
