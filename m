From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: imx-pcm: Switch to SPDX identifier
Date: Thu, 4 Apr 2019 09:09:17 -0300
Message-ID: <CAOMZO5Co=+0wwXzfkc8aGAC7d6Dm7PsHBQcLyx2VVZjkcKrsVQ@mail.gmail.com>
References: <20190404120703.30054-1-andradanciu1997@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404120703.30054-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andra Danciu <andradanciu1997@gmail.com>
Cc: timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 4, 2019 at 9:07 AM Andra Danciu <andradanciu1997@gmail.com> wrote:
>
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>  sound/soc/fsl/imx-pcm.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
> index 133c4470acad..3ce2f437e645 100644
> --- a/sound/soc/fsl/imx-pcm.h
> +++ b/sound/soc/fsl/imx-pcm.h
> @@ -1,13 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

This is not correct...

>  /*
>   * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
>   *
>   * This code is based on code copyrighted by Freescale,
>   * Liam Girdwood, Javier Martin and probably others.
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.

as it does not match with the original license text.

You should use:

/* SPDX-License-Identifier: GPL-2.0+ */
