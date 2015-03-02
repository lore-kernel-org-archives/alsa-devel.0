From: Yakir Yang <ykk@rock-chips.com>
Subject: Re: [PATCH v4 14/15] ASoC: rockchip/rockchip-hdmi-audio: add sound
 driver for hdmi audio
Date: Mon, 02 Mar 2015 19:32:08 +0800
Message-ID: <54F44A38.4050405@rock-chips.com>
References: <1425175834-24661-1-git-send-email-ykk@rock-chips.com>	 <1425179070-2736-1-git-send-email-ykk@rock-chips.com> <1425287247.24292.82.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425287247.24292.82.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Andy Yan <andy.yan@rock-chips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@freescale.com>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Max Filippov <jcmvbkbc@gmail.com>, Axel Lin <axel.lin@ingics.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Sean Cross <xobs@kosagi.com>, Ben Zhang <benzh@chromium.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-
List-Id: alsa-devel@alsa-project.org



=E5=9C=A8 2015/3/2 17:07, Paul Bolle =E5=86=99=E9=81=93:
> On Sat, 2015-02-28 at 22:04 -0500, Yakir Yang wrote:
>> --- /dev/null
>> +++ b/sound/soc/rockchip/rockchip_hdmi_audio.c
>> @@ -0,0 +1,169 @@
>> +/*
>> + * rockchip-hdmi-card.c
> Doesn't match the filename. Is this line needed anyway?

Thanks, this comment are good for read, and seems others codec driver=20
also content this comment,
so I think we can keep this comment.
I will correct the file name it in next version.

Thanks for you reply   :)

>> + *
>> + * ROCKCHIP ALSA SoC DAI driver for HDMI audio on rockchip processo=
rs.
>> + * Copyright (c) 2014, ROCKCHIP CORPORATION. All rights reserved.
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
> This states the license is plain GPL v2.

Okay, thanks, correct it in next version.

Thanks

Yakir Yang
Best regards.
>> +MODULE_LICENSE("GPL");
> So you probably want
>      MODULE_LICENSE("GPL v2");
>
> here.
>
>
> Paul Bolle
>
>
>
>
