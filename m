From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: Add BUG() assertion if max98095_get_bq_channel
 returns -EINVAL
Date: Thu, 29 Sep 2011 09:59:13 +0800
Message-ID: <CABqxG0eWVMTBAF=Tq_a0USEXFeVYGpR7kRGRTCpUrrfP+0AGmw@mail.gmail.com>
References: <1317218471.8008.3.camel@phoenix>
	<1317218530.8008.4.camel@phoenix>
	<4E83AB6A.1090203@gmail.com>
	<CABqxG0dainno-pZiqjMLzTYkWs-bsnt95acfsDMWqSnjTU4mHQ@mail.gmail.com>
	<4E83CF74.1040701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E83CF74.1040701@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Mallon <rmallon@gmail.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Peter Hsiang <peter.hsiang@maxim-ic.com>, Jesse Marroquin <jesse.marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 29, 2011 at 9:52 AM, Ryan Mallon <rmallon@gmail.com> wrote:
> On 29/09/11 11:35, Dave Young wrote:
>
>> On Thu, Sep 29, 2011 at 7:19 AM, Ryan Mallon <rmallon@gmail.com> wro=
te:
>>> On 29/09/11 00:02, Axel Lin wrote:
>>>> The callers use the return value of max98095_get_bq_channel as arr=
ay index to
>>>> access max98095->dai[] array.
>>>> Add BUG() assertion for out of bound access of max98095->dai[] arr=
ay.
>>>
>>> Same here, fix the problem in the callers.
>>>
>>> ----
>>> Check the return value of max98095_get_bq_channel in the callers an=
d
>>> propagate any errors up. Remove the BUG_ON(channel > 1) since
>>> max98095_get_bq_channel never returns a value larger than 1.
>>>
>>> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
>>> ---
>>>
>>> diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max9809=
5.c
>>> index 668434d..55eccea 100644
>>> --- a/sound/soc/codecs/max98095.c
>>> +++ b/sound/soc/codecs/max98095.c
>>> @@ -2014,7 +2014,8 @@ static int max98095_put_bq_enum(struct snd_kc=
ontrol *kcontrol,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int fs, best, best_val, i;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int regmask, regsave;
>>>
>>> - =C2=A0 =C2=A0 =C2=A0 BUG_ON(channel > 1);
>>> + =C2=A0 =C2=A0 =C2=A0 if (channel < 0)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return channel;
>>
>> If use BUG() happens in =C2=A0max98095_get_bq_channel, it will not r=
eturn here?
>
>
> Not quite sure what you mean?

I means if Axel Lin's patch applied, and CONFIG_BUG is on, it will
panic firstly the if condition will be never entered.

>
> If CONFIG_BUG was not enabled for the original version, then it would
> not return at the BUG_ON and would either crash or cause odd behaviou=
r
> if it tried to index channel as -1.
>
> My patch is removing the BUG_ON and replacing it with a proper check =
and
> return. It doesn't need to check > 1 since max98095_get_bq_channel ne=
ver
> returns that.
>
> My understanding is that device drivers, in general, should not call
> BUG. BUG is for unrecoverable errors which leave the kernel in some
> unstable state. Here we can just return an error code.

Agree

>
> ~Ryan
>
>>
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pdata || !max98095->bq_textcnt)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>>> @@ -2069,6 +2070,9 @@ static int max98095_get_bq_enum(struct snd_kc=
ontrol *kcontrol,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int channel =3D max98095_get_bq_channel(=
kcontrol->id.name);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct max98095_cdata *cdata;
>>>
>>> + =C2=A0 =C2=A0 =C2=A0 if (channel < 0)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return channel;
>>> +
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cdata =3D &max98095->dai[channel];
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ucontrol->value.enumerated.item[0] =3D c=
data->bq_sel;
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>>>
>>
>>
>>
>
>
>



--=20
Regards
Dave
