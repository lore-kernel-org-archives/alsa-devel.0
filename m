From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] twl6040: fix wrong kfree in twl6040_remove and
	twl6040_codec_remove
Date: Fri, 16 Jul 2010 17:54:08 +0800
Message-ID: <AANLkTikMGIj-0WKXFT1Y6c7l1ObtVDx_j5pYOA_esvwG@mail.gmail.com>
References: <1279272408.2594.1.camel@mola> <20100716093625.GD18376@sirena.org.uk>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100716093625.GD18376@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Margarita Olaya Cabrera <magi.olaya@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi Mark,

2010/7/16 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jul 16, 2010 at 05:26:48PM +0800, Axel Lin wrote:
>> Memory allocation part:
>> We allocate a memory in twl6040_codec_probe():
>> =A0 =A0 =A0 =A0 priv =3D kzalloc(sizeof(struct twl6040_data), GFP_KE=
RNEL);
>> =A0 =A0 =A0 =A0 twl6040_codec =3D codec =3D &priv->codec;
>
> Could you please try to take on board the feedback you were given
> yesterday about this sort of stuff? =A0Both the feedback about format=
ting
> your patch so it's easy to apply and the collisions with other, more
> substantial, work that's going on?
>
Ok. I will resend the patch.
( I just thought it may takes some time for review )
( Due a vacation this weekend, I'll do it next Monday )

Regards,
Axel
