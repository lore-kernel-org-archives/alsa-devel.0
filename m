From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v4 13/15] ASoC: codec/dw-hdmi-audio: add codec driver
 for dw hdmi audio
Date: Mon, 02 Mar 2015 10:15:16 +0100
Message-ID: <1425287716.24292.87.camel@x220>
References: <1425175834-24661-1-git-send-email-ykk@rock-chips.com>
	 <1425178760-2655-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425178760-2655-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yakir Yang <ykk@rock-chips.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Andy Yan <andy.yan@rock-chips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@freescale.com>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Max Filippov <jcmvbkbc@gmail.com>, Axel Lin <axel.lin@ingics.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Sean Cross <xobs@kosagi.com>, Ben Zhang <benzh@chromium.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-
List-Id: alsa-devel@alsa-project.org

On Sat, 2015-02-28 at 21:59 -0500, Yakir Yang wrote:
> --- /dev/null
> +++ b/sound/soc/codecs/dw-hdmi-audio.c
> @@ -0,0 +1,379 @@
> +/*
> + * dw-hdmi-codec.c

Doesn't match the filename. Is this line needed?

> + * DesignerWare ALSA SoC DAI driver for DW HDMI audio.
> + * Copyright (c) 2014,  CORPORATION. All rights reserved.
> + * Authors: Yakir Yang <ykk@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.*
> + *
> + */

This states that the license is plain GPL v2.

(Missing empty line here.)

> +#include <linux/init.h>

[...]

> +MODULE_LICENSE("GPL");

So you probably want
    MODULE_LICENSE("GPL v2");

here.


Paul Bolle
