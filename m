From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [alsa-devel] [PATCH 4/4] sound: codecs: pcm1792a: introduce
 channel side
Date: Tue, 24 Nov 2015 09:27:41 +0100
Message-ID: <CAOf5uwmdwcdbxx2b6DvMeOJBahkZ3iiosWtHPD2zhxcDqO2b_A@mail.gmail.com>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
	<1448014157-36526-5-git-send-email-raphael.poggi@avalun.com>
	<CAOf5uwmGk7WqOaAFj=fTw8+D+EszWPqReyfmS0njix=d7AokOA@mail.gmail.com>
	<CACqcpZCSMwj2WOhX0ddD43VKCgOcNyrkkZrR0sWEsHE+H27TVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACqcpZCSMwj2WOhX0ddD43VKCgOcNyrkkZrR0sWEsHE+H27TVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Rapha=C3=ABl_Poggi?= <poggi.raph@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Tue, Nov 24, 2015 at 9:21 AM, Rapha=C3=ABl Poggi <poggi.raph@gmail.c=
om> wrote:
> Hi,
>
> 2015-11-21 10:37 GMT+01:00 Michael Trimarchi <michael@amarulasolution=
s.com>:
>> Hi
>>
>> On Fri, Nov 20, 2015 at 11:09 AM, Raphael Poggi <poggi.raph@gmail.co=
m> wrote:
>>> From: Raphael Poggi <poggi.raph@gmail.com>
>>>
>>> Add possibility to choose the channel side using the device tree,
>>> and also modify it using alsa ctrl.
>>>
>>> Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
>>> ---
>>>  sound/soc/codecs/pcm1792a.c | 46 +++++++++++++++++++++++++++++++++=
++++++++++++
>>>  1 file changed, 46 insertions(+)
>>>
>>> diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792=
a.c
>>> index febaa48..005b679 100644
>>> --- a/sound/soc/codecs/pcm1792a.c
>>> +++ b/sound/soc/codecs/pcm1792a.c
>>> @@ -65,6 +65,12 @@ static const struct reg_default pcm1792a_reg_def=
aults[] =3D {
>>>         { PCM1792A_DEVICE_ID, 0x00 },
>>>  };
>>>
>>> +enum __pcm1792_side {
>>> +       STEREO,
>>> +       MONORAL_LEFT,
>>> +       MONORAL_RIGHT
>>> +};
>>> +
>>>  static bool pcm1792a_accessible_reg(struct device *dev, unsigned i=
nt reg)
>>>  {
>>>         return reg >=3D 0x10 && reg <=3D 0x17;
>>> @@ -83,6 +89,7 @@ struct pcm1792a_private {
>>>         struct regmap *regmap;
>>>         unsigned int format;
>>>         unsigned int rate;
>>> +       unsigned int side;
>>>  };
>>>
>>>  static int pcm1792a_set_dai_fmt(struct snd_soc_dai *codec_dai,
>>> @@ -153,6 +160,13 @@ static int pcm1792a_hw_params(struct snd_pcm_s=
ubstream *substream,
>>>         ret =3D regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTR=
OL,
>>>                                  PCM1792A_FMT_MASK | PCM1792A_ATLD_=
ENABLE, val);
>>>
>>> +       if (priv->side =3D=3D MONORAL_LEFT)
>>> +               val =3D PCM1792A_CHANNEL_MONO_LEFT;
>>> +       else if (priv->side =3D=3D MONORAL_RIGHT)
>>> +               val =3D PCM1792A_CHANNEL_MONO_RIGHT;
>>> +
>>> +       regmap_update_bits(priv->regmap, PCM1792A_CHANNEL, PCM1792A=
_CHANNEL_MONO_MASK, val);
>>> +
>>>         return ret;
>>>  }
>>>
>>> @@ -222,10 +236,31 @@ static struct snd_soc_codec_driver soc_codec_=
dev_pcm1792a =3D {
>>>         .num_dapm_routes        =3D ARRAY_SIZE(pcm1792a_dapm_routes=
),
>>>  };
>>>
>>> +static int pcm1792a_of_init(struct spi_device *spi)
>>> +{
>>> +       int ret =3D 0;
>>> +       struct pcm1792a_private *pcm1792a =3D dev_get_drvdata(&spi-=
>dev);
>>> +       const char *name;
>>> +       struct device_node *np =3D spi->dev.of_node;
>>> +
>>> +       name =3D of_get_property(np, "ti,side", NULL);
>>> +       if (name) {
>>> +               if (!strcmp(name, "left"))
>>> +                       pcm1792a->side =3D MONORAL_LEFT;
>>> +               else
>>> +                       pcm1792a->side =3D MONORAL_RIGHT;
>>> +       }
>>> +       else
>>> +               pcm1792a->side =3D STEREO;
>>> +
>>> +       return ret;
>>> +}
>>> +
>>>  static int pcm1792a_spi_probe(struct spi_device *spi)
>>>  {
>>>         struct pcm1792a_private *pcm1792a;
>>>         int ret;
>>> +       struct device_node *np =3D spi->dev.of_node;
>>>
>>>         pcm1792a =3D devm_kzalloc(&spi->dev, sizeof(struct pcm1792a=
_private),
>>>                                 GFP_KERNEL);
>>> @@ -241,6 +276,17 @@ static int pcm1792a_spi_probe(struct spi_devic=
e *spi)
>>>                 return ret;
>>>         }
>>>
>>> +       if (np) {
>>> +               ret =3D pcm1792a_of_init(spi);
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
>>> +
>>> +       if (pcm1792a->side =3D=3D MONORAL_LEFT)
>>> +               regmap_update_bits(pcm1792a->regmap, PCM1792A_CHANN=
EL, PCM1792A_CHANNEL_MONO_MASK, PCM1792A_CHANNEL_MONO_LEFT);
>>> +       else if (pcm1792a->side =3D=3D MONORAL_RIGHT)
>>> +               regmap_update_bits(pcm1792a->regmap, PCM1792A_CHANN=
EL, PCM1792A_CHANNEL_MONO_MASK, PCM1792A_CHANNEL_MONO_RIGHT);
>>> +
>>
>> Why this is a part of dts and not a part of mixer control?
>>
>> Michael
>>
>
> The "channel side" bindings should be used when the pcm7192a is used
> in monaural mode (which requires two DACs, both DACs operate in a
> balanced mode for one channel of audio input data).
> This is a hardware level design, it will never change at runtime.
> I feel that a device tree binding is more appropriate than a control.
>

Well I know exactly why is used for, but I don't really know if it's
somenthing that should be
in dts. Do I want to do channel inversion?

Michael

>>>         return snd_soc_register_codec(&spi->dev,
>>>                         &soc_codec_dev_pcm1792a, &pcm1792a_dai, 1);
>>>  }
>>> --
>>> 2.1.0
>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
>>
>> --
>> | Michael Nazzareno Trimarchi                     Amarula Solutions =
BV |
>> | COO  -  Founder                                      Cruquiuskade =
47 |
>> | +31(0)851119172                                 Amsterdam 1018 AM =
NL |
>> |                  [`as] http://www.amarulasolutions.com            =
   |
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/



--=20
| Michael Nazzareno Trimarchi                     Amarula Solutions BV =
|
| COO  -  Founder                                      Cruquiuskade 47 =
|
| +31(0)851119172                                 Amsterdam 1018 AM NL =
|
|                  [`as] http://www.amarulasolutions.com               =
|
