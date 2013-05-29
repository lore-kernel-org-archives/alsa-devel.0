From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v6 07/10] ASoC: fsl-ssi: imx ac97 support
Date: Wed, 29 May 2013 21:12:35 +0800
Message-ID: <20130529131233.GA29528@S2101-09.ap.freescale.net>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
 <1369752478-30260-8-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FE00261B19
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 15:12:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1369752478-30260-8-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2013 at 04:47:55PM +0200, Markus Pargmann wrote:
> +struct snd_ac97_bus_ops soc_ac97_ops = {
> +	.read		= fsl_ssi_ac97_read,
> +	.write		= fsl_ssi_ac97_write,
> +};
> +EXPORT_SYMBOL_GPL(soc_ac97_ops);

I'm seeing the following compile error.

  LD      sound/soc/fsl/built-in.o
sound/soc/fsl/snd-soc-imx-ssi.o: In function `__crc_soc_ac97_ops':
imx-ssi.c:(*ABS*+0xd390d3c4): multiple definition of `__crc_soc_ac97_ops'
sound/soc/fsl/snd-soc-imx-ssi.o:(.data+0x168): multiple definition of `soc_ac97_ops'
sound/soc/fsl/snd-soc-fsl-ssi.o:(.data+0x0): first defined here
make[4]: *** [sound/soc/fsl/built-in.o] Error 1

Shawn
