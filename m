From: Yakir Yang <ykk@rock-chips.com>
Subject: Re: [PATCH v4 13/15] ASoC: codec/dw-hdmi-audio: add codec driver
 for dw hdmi audio
Date: Mon, 02 Mar 2015 19:31:02 +0800
Message-ID: <54F449F6.90508@rock-chips.com>
References: <1425175834-24661-1-git-send-email-ykk@rock-chips.com>	 <1425178760-2655-1-git-send-email-ykk@rock-chips.com> <1425287716.24292.87.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425287716.24292.87.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Andy Yan <andy.yan@rock-chips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@freescale.com>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Max Filippov <jcmvbkbc@gmail.com>, Axel Lin <axel.lin@ingics.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Sean Cross <xobs@kosagi.com>, Ben Zhang <benzh@chromium.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-
List-Id: alsa-devel@alsa-project.org



=E5=9C=A8 2015/3/2 17:15, Paul Bolle =E5=86=99=E9=81=93:
> On Sat, 2015-02-28 at 21:59 -0500, Yakir Yang wrote:
>> --- /dev/null
>> +++ b/sound/soc/codecs/dw-hdmi-audio.c
>> @@ -0,0 +1,379 @@
>> +/*
>> + * dw-hdmi-codec.c
> Doesn't match the filename. Is this line needed?

Thanks, this comment are good for read, and seems others codec driver=20
also content this comment,
so I think we can keep this comment.
I will correct the file name it in next version.

Thanks for you reply :)
>
>> + * DesignerWare ALSA SoC DAI driver for DW HDMI audio.
>> + * Copyright (c) 2014,  CORPORATION. All rights reserved.
>> + * Authors: Yakir Yang <ykk@rock-chips.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms and conditions of the GNU General Public License=
,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but W=
ITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Li=
cense for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program.  If not, see <http://www.gnu.org/licens=
es/>.*
>> + *
>> + */
> This states that the license is plain GPL v2.
>
> (Missing empty line here.)

Okay, thanks, correct it in next version.

Thanks :)
>> +#include <linux/init.h>
> [...]
>
>> +MODULE_LICENSE("GPL");
> So you probably want
>      MODULE_LICENSE("GPL v2");
>
> here.
Okay, thanks, correct it in next version.

Thanks :)

Yakir Yang
Best regards.

>
> Paul Bolle
>
>
>
>
