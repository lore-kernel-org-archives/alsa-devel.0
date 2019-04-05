From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 02/20] ASoC: efika-audio-fabric.c: Switch to SPDX
 identifier
Date: Fri, 5 Apr 2019 18:17:00 +0530
Message-ID: <8e16e9f5-2c0f-a1e6-df0d-67b982db294a@codeaurora.org>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
 <20190405115010.28838-3-andradanciu1997@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405115010.28838-3-andradanciu1997@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andra Danciu <andradanciu1997@gmail.com>, timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org


On 4/5/2019 5:19 PM, Andra Danciu wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>   sound/soc/fsl/efika-audio-fabric.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
> index 667f4215dfc0..3e832902fc99 100644
> --- a/sound/soc/fsl/efika-audio-fabric.c
> +++ b/sound/soc/fsl/efika-audio-fabric.c
> @@ -1,14 +1,9 @@
> -/*
> - * Efika driver for the PSC of the Freescale MPC52xx
> - * configured as AC97 interface
> - *
> - * Copyright 2008 Jon Smirl, Digispeaker
> - * Author: Jon Smirl <jonsmirl@gmail.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
> - */
> +// SPDX-License-Identifier: GPL-2.0

Don't change entire thing with //. only above line with the license is 
enough.

Please apply this rule every patch of yours.

Thanks,
Mukesh


> +// Efika driver for the PSC of the Freescale MPC52xx
> +// configured as AC97 interface
> +//
> +// Copyright 2008 Jon Smirl, Digispeaker
> +// Author: Jon Smirl <jonsmirl@gmail.com>

>   
>   #include <linux/init.h>
>   #include <linux/module.h>
