From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 01/11 RESEND] ASoC: wm8510: Convert to snd_soc_write
Date: Fri, 7 Oct 2011 21:10:21 +0800
Message-ID: <CAF+7xWkC5=9etjwde-nLegAEFd4AyzJcXyGUZyp9FWJjaE-fRA@mail.gmail.com>
References: <1317944619.5579.1.camel@phoenix> <1317944707.5579.3.camel@phoenix>
 <1317955220.7624.2.camel@phoenix> <20111007095720.GA19080@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111007095720.GA19080@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/10/7 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Oct 07, 2011 at 10:40:20AM +0800, Axel Lin wrote:
>
>> +static void wm8510_sync_cache(struct snd_soc_codec *codec)
>> +{
>> + =A0 =A0 short i;
>> + =A0 =A0 u16 *cache;
>> +
>> + =A0 =A0 if (!codec->cache_sync)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 codec->cache_only =3D 0;
>> + =A0 =A0 codec->cache_bypass =3D 1;
>> + =A0 =A0 /* restore cache */
>> + =A0 =A0 cache =3D codec->reg_cache;
>> + =A0 =A0 for (i =3D 0; i < codec->driver->reg_cache_size; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D WM8510_RESET || cache[i] =3D=3D=
 wm8510_reg[i])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_write(codec, i, cache[i]);
>> + =A0 =A0 }
>> + =A0 =A0 codec->cache_bypass =3D 0;
>> + =A0 =A0 codec->cache_sync =3D 0;
>
> The usual trick for avoiding this is to provide a register default va=
lue
> for the reset register and then write that value when the chip is res=
et.
> This then means that the write to the reset register is suppressed by
> the cache restore code when it skips writes of default registers.
>
Nice trick. Then we can use snd_soc_cache_sync() to replace the
customized xxxx_sync_cache() calls.

I'll send a v3 soon.

> Thanks for doing this work.
And thanks for your valuable review.

Regards,
Axel
