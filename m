From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 7/12] wm8940: fix resource reclaim in wm8940_register
	error path
Date: Thu, 15 Jul 2010 15:42:07 +0800
Message-ID: <AANLkTil_buBStfVy_L9iTgPrxosmSRFhNU1MbaXWJfMx@mail.gmail.com>
References: <1279162147.29294.2.camel@mola> <1279162893.29294.20.camel@mola>
	<Pine.LNX.4.64.1007150855200.5310@axis700.grange>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1007150855200.5310@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Guennadi,

2010/7/15 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> Hi Axel
>
> On Thu, 15 Jul 2010, Axel Lin wrote:
>
>> >>From 44c93254e5158e3086c4707148d24746067f6b14 Mon Sep 17 00:00:00 =
2001
>> From: Axel Lin <axel.lin@gmail.com>
>> Date: Thu, 15 Jul 2010 10:13:34 +0800
>> Subject: [PATCH] wm8940: fix resource reclaim in wm8940_register err=
or path
>>
>> This patch fixes the error path in wm8940_register to properly free =
resources.
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>
> Ok, these bugs are real, but let's fix them properly, i.e., release
> resources at the same level, where they have been acquired:

OK.
I'll send a revised patch now.
I change the patch titile to:
[PATCH v2 7/12] wm8940: fix a memory leak if wm8940_register return err=
or

>
> static int register_codec(struct drv_priv *data)
> {
> =A0 =A0 =A0 =A0int ret =3D snd_soc_register_codec();
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> =A0 =A0 =A0 =A0ret =3D try();
> =A0 =A0 =A0 =A0if (failed)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
>
> =A0 =A0 =A0 =A0...
>
> err:
> =A0 =A0 =A0 =A0snd_soc_unregister_codec();
> }
>
> static int probe()
> {
> =A0 =A0 =A0 =A0int ret;
> =A0 =A0 =A0 =A0struct drv_priv *data =3D kzalloc(sizeof(*data), GFP_K=
ERNEL);
> =A0 =A0 =A0 =A0if (!data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> =A0 =A0 =A0 =A0ret =3D register_codec(data);
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
>
> =A0 =A0 =A0 =A0...
>
> err:
> =A0 =A0 =A0 =A0kfree(data);
> =A0 =A0 =A0 =A0return ret;
> }
>
> That is, kfree() belongs to probe() and not to register_codec. This, =
of
> course, concerns all aour patches, at least those of them, that I hav=
e
> seen.

I agree that it is good to release resources at the same level,
where they have been acquired.
But I prefer to follow the maintainer/author's coding style.

=46or the changes in other drivers, I'd like to see Liam and Mark's com=
ments.
Or if the driver maintainers request it, I can fix it.

Regards,
Axel

>
> Thanks
> Guennadi
>
>> ---
>> =A0sound/soc/codecs/wm8940.c | =A0 22 ++++++++++++++--------
>> =A01 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
>> index e3c4bbf..9673e6f 100644
>> --- a/sound/soc/codecs/wm8940.c
>> +++ b/sound/soc/codecs/wm8940.c
>> @@ -766,7 +766,8 @@ static int wm8940_register(struct wm8940_priv *w=
m8940,
>> =A0 =A0 =A0 u16 reg;
>> =A0 =A0 =A0 if (wm8940_codec) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(codec->dev, "Another WM8940 is r=
egistered\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 INIT_LIST_HEAD(&codec->dapm_widgets);
>> @@ -785,7 +786,7 @@ static int wm8940_register(struct wm8940_priv *w=
m8940,
>> =A0 =A0 =A0 ret =3D snd_soc_codec_set_cache_io(codec, 8, 16, control=
);
>> =A0 =A0 =A0 if (ret < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(codec->dev, "Failed to set cache=
 I/O: %d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 memcpy(codec->reg_cache, wm8940_reg_defaults,
>> @@ -794,7 +795,7 @@ static int wm8940_register(struct wm8940_priv *w=
m8940,
>> =A0 =A0 =A0 ret =3D wm8940_reset(codec);
>> =A0 =A0 =A0 if (ret < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(codec->dev, "Failed to issue res=
et\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 wm8940_dai.dev =3D codec->dev;
>> @@ -803,7 +804,7 @@ static int wm8940_register(struct wm8940_priv *w=
m8940,
>>
>> =A0 =A0 =A0 ret =3D snd_soc_write(codec, WM8940_POWER1, 0x180);
>> =A0 =A0 =A0 if (ret < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>>
>> =A0 =A0 =A0 if (!pdata)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(codec->dev, "No platform data s=
upplied\n");
>> @@ -811,7 +812,7 @@ static int wm8940_register(struct wm8940_priv *w=
m8940,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D snd_soc_read(codec, WM8940_OUTPU=
TCTL);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D snd_soc_write(codec, WM8940_OUTP=
UTCTL, reg | pdata->vroi);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 }
>>
>>
>> @@ -820,17 +821,22 @@ static int wm8940_register(struct wm8940_priv =
*wm8940,
>> =A0 =A0 =A0 ret =3D snd_soc_register_codec(codec);
>> =A0 =A0 =A0 if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(codec->dev, "Failed to register =
codec: %d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 ret =3D snd_soc_register_dai(&wm8940_dai);
>> =A0 =A0 =A0 if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(codec->dev, "Failed to register =
DAI: %d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_unregister_codec(codec);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_codec;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return 0;
>> +
>> +err_codec:
>> + =A0 =A0 snd_soc_unregister_codec(codec);
>> +err:
>> + =A0 =A0 kfree(wm8940);
>> + =A0 =A0 return ret;
>> =A0}
>>
>> =A0static void wm8940_unregister(struct wm8940_priv *wm8940)
>> --
>> 1.5.4.3
>>
>>
>>
>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
