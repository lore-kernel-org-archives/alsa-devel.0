From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2 01/11] ASoC: phycore-ac97: Add DT support
Date: Sun, 07 Apr 2013 21:52:17 -0500
Message-ID: <516230E1.3070509@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id A79CC265289
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2013 04:52:20 +0200 (CEST)
In-Reply-To: <1365362721-3731-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> Notes:
>     Changes in v2:
>      - Simplify the driver, by combining audmux port configurations. The
>        audmux driver actually knows on which platform he is running and
>        will return the appropriate error code if we use functions for
>        another platform. So we don't need to have the knowledge about it
>        in phycore-ac97 and can try both functions. This removes the need
>        of different compatibilities and renames it to imx27-ac97.
>      - Use a phandle for the cpu_dai link.
>      - Add devicetree binding documentation.
>      - Rename binding to phytec,phycore-ac97 and fsl,ssi to phytec,ssi

I think some of this information belongs in the changelog.

> +#ifdef CONFIG_MACH_IMX27_DT
> +		.platform_name	= "imx-fiq-pcm-audio",
> +#else
>   		.cpu_dai_name	= "imx-ssi.0",
>   		.platform_name	= "imx-fiq-pcm-audio.0",
> +#endif

What's the difference between "imx-fiq-pcm-audio" and "imx-fiq-pcm-audio.0"?

-- 
Timur Tabi
