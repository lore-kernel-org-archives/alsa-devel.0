From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/10] ASoC: tlv320aic32x4: Remove filename
 from header and switch to SPDX
Date: Tue, 12 Dec 2017 18:19:35 -0800
Message-ID: <1513131575.3036.67.camel@perches.com>
References: <20171212224311.24045-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0109.hostedemail.com
 [216.40.44.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 24DA12677E3
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 03:19:39 +0100 (CET)
In-Reply-To: <20171212224311.24045-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-12-12 at 16:43 -0600, Andrew F. Davis wrote:
> The filename is often wrong after moves and adds nothing of value,
> lets drop it. While already here, switch to SPDX.
[]
> diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
[]
> @@ -1,21 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * linux/sound/soc/codecs/tlv320aic32x4-i2c.c
> - *
>   * Copyright 2011 NW Digital Radio
>   *
>   * Author: Jeremy McDermond <nh6z@nh6z.net>
>   *
>   * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.

nack.  Note the "(at your option) any later version"

If you are going to update to spdx and remove the old license
verbiage, make sure you are adding the correct spdx tag.
