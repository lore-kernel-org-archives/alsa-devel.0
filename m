From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 01/11] ASoC: phycore-ac97: Add DT support
Date: Wed, 10 Apr 2013 13:03:17 +0200
Message-ID: <20130410110317.GA16749@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-2-git-send-email-mpa@pengutronix.de>
 <516230E1.3070509@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A7F40265F46
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 13:03:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <516230E1.3070509@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 07, 2013 at 09:52:17PM -0500, Timur Tabi wrote:
> Markus Pargmann wrote:
> >Notes:
> >    Changes in v2:
> >     - Simplify the driver, by combining audmux port configurations. The
> >       audmux driver actually knows on which platform he is running and
> >       will return the appropriate error code if we use functions for
> >       another platform. So we don't need to have the knowledge about it
> >       in phycore-ac97 and can try both functions. This removes the need
> >       of different compatibilities and renames it to imx27-ac97.
> >     - Use a phandle for the cpu_dai link.
> >     - Add devicetree binding documentation.
> >     - Rename binding to phytec,phycore-ac97 and fsl,ssi to phytec,ssi
> 
> I think some of this information belongs in the changelog.

Okay

> 
> >+#ifdef CONFIG_MACH_IMX27_DT
> >+		.platform_name	= "imx-fiq-pcm-audio",
> >+#else
> >  		.cpu_dai_name	= "imx-ssi.0",
> >  		.platform_name	= "imx-fiq-pcm-audio.0",
> >+#endif
> 
> What's the difference between "imx-fiq-pcm-audio" and "imx-fiq-pcm-audio.0"?

The previous version of phycore-ac97 was using devices created by the
board init code. They passed a proper pdev id which was used in all
drivers they created. Since fsl-ssi is using DT, that id is -1 and is
ignored for the device name. So we have to remove the .0 for DT here.
This driver is not used multiple times in one system, so it shouldn't be
a problem.

Regards,

Markus

> 
> -- 
> Timur Tabi
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
