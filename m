From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Tue, 09 Sep 2014 14:37:42 -0500
Message-ID: <540F5706.1050303@tabi.org>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com> <20140909183804.GA6944@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140909183804.GA6944@Asurada>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, mpa@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 09/09/2014 01:38 PM, Nicolin Chen wrote:
> make sure to have the call for imx only because it seems that
> the other platforms do not depend on the clock.

Although I doubt anyone will every add support for clocks to PowerPC 
"side" of this driver, I would prefer to avoid IMX-specific changes. 
Instead, the code should check if a clock is available.  That's why I 
suggested this change:

-	if (ssi_private->soc->imx)
+	if (!IS_ERR(ssi_private->clk))
