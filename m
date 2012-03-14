From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4] ASoC: add imx-sgtl5000 machine driver
 working with fsl_ssi
Date: Wed, 14 Mar 2012 10:01:15 +0100
Message-ID: <20120314090115.GN3852@pengutronix.de>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 8F12510422E
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 10:01:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 12, 2012 at 07:58:47PM +0800, Shawn Guo wrote:
> Changes since v3:
>  * Change imx compatible to "fsl,imx21-ssi"
>  * Leave locking issue as a FIXME for Timur to sort out separately
> 
> ---
> Shawn Guo (10):
>       ASoC: fsl: separate SSI and DMA Kconfig options
>       ASoC: imx: merge sound/soc/imx into sound/soc/fsl
>       ASoC: fsl: rename imx-pcm Kconfig options and filename
>       ASoC: fsl: create fsl_utils to accommodate the common functions
>       ASoC: fsl: remove helper fsl_asoc_get_codec_dev_name
>       ASoC: fsl: check property 'compatible' for the machine name
>       ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
>       ASoC: fsl: remove the fatal error checking on codec-handle
>       ASoC: fsl: let fsl_ssi work with imx pcm and machine drivers
>       ASoC: fsl: add imx-sgtl5000 machine driver

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

What are the next steps here? Now we have fsl_ssi.c and imx-ssi.c, one
for dt bindings and the other one for platform bindings and also AC97
support. They should probably get merged some day which might be a bit
difficult since currently I don't see the platform users moving over
to devicetree and the seem to be no AC97 users in powerpc.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
