From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: Add BUG() assertion if max98095_get_bq_channel
 returns -EINVAL
Date: Thu, 29 Sep 2011 09:33:14 +0800
Message-ID: <CABqxG0cswfkC9g65PyR9exX+X--Un8veUPS_5qjcZ=hZbfPvUA@mail.gmail.com>
References: <1317218471.8008.3.camel@phoenix>
	<1317218530.8008.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317218530.8008.4.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Peter Hsiang <peter.hsiang@maxim-ic.com>, Jesse Marroquin <jesse.marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 28, 2011 at 10:02 PM, Axel Lin <axel.lin@gmail.com> wrote:
> The callers use the return value of max98095_get_bq_channel as array =
index to
> access max98095->dai[] array.
> Add BUG() assertion for out of bound access of max98095->dai[] array.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =C2=A0sound/soc/codecs/max98095.c | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.=
c
> index 668434d..973c02d 100644
> --- a/sound/soc/codecs/max98095.c
> +++ b/sound/soc/codecs/max98095.c
> @@ -1998,6 +1998,7 @@ static int max98095_get_bq_channel(const char *=
name)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(name, "Biquad2 Mode") =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;
> + =C2=A0 =C2=A0 =C2=A0 BUG();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;

below better?
BUG_ON(strcmp(name, "Biquad2 Mode"));
return 1;

Or BUG_ON(channel < 0) in caller

> =C2=A0}
>
> --
> 1.7.4.1
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Regards
Dave
