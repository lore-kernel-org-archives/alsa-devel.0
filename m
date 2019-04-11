From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 4/4] ASoC: fsl_audmix: cache pdev->dev pointer
Date: Thu, 11 Apr 2019 13:21:18 -0700
Message-ID: <20190411202117.GC13170@Asurada-Nvidia.nvidia.com>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
 <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lis>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 10, 2019 at 11:06:39AM +0000, Viorel Suman wrote:
> There should be no trouble to understand dev = pdev->dev.
> This can save some space to have more print info or save
> some wrapped lines.

Change looks fine. Ack.

> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>

I think usually Suggested-by comes above Signed-off-by.

This was originally in your change already, so you can replace:
-Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
-Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Just a chance for it to get resent without being a noise :)
