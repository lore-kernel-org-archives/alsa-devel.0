From: Yakir <ykk@rock-chips.com>
Subject: Re: [RESEND PATCH v1 2/2] drm: bridge/dw_hdmi-i2s-audio: add audio
 driver
Date: Mon, 25 May 2015 17:38:48 +0800
Message-ID: <5562EDA8.1000609@rock-chips.com>
References: <1432307631-7667-1-git-send-email-ykk@rock-chips.com>	 <1432307696-7806-1-git-send-email-ykk@rock-chips.com> <1432542247.27695.137.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432542247.27695.137.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: alsa-devel <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ajay Kumar <ajaykumar.rs@samsung.com>, Dave Airlie <airlied@redhat.com>
List-Id: alsa-devel@alsa-project.org

Hi Paul,

=E5=9C=A8 2015/5/25 16:24, Paul Bolle =E5=86=99=E9=81=93:
> Just a nit: a license mismatch.
>
> On Fri, 2015-05-22 at 10:14 -0500, Yakir Yang wrote:
>> --- /dev/null
>> +++ b/drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
> This states the license is GPL v2.
>
>> +MODULE_LICENSE("GPL");
> And, according to include/linux/module.h, this states the license is =
GPL
> v2 or later. So I think that either the comment at the top of this fi=
le
> or the ident used in the MODULE_LICENSE() macro should change.

Thanks for your catch, got it  :-)

Yakir Yang

>
> Paul Bolle
>
>
>
>
