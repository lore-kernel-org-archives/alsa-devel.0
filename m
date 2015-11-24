From: =?UTF-8?Q?Rapha=C3=ABl_Poggi?= <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 4/4] sound: codecs: pcm1792a: introduce
 channel side
Date: Tue, 24 Nov 2015 17:04:58 +0100
Message-ID: <CACqcpZDQRtSqmLDC65ajNGY=VU8TFZBnVxhaM+cES37rv7zmyg@mail.gmail.com>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
 <1448014157-36526-5-git-send-email-raphael.poggi@avalun.com>
 <CAOf5uwmGk7WqOaAFj=fTw8+D+EszWPqReyfmS0njix=d7AokOA@mail.gmail.com>
 <CACqcpZCSMwj2WOhX0ddD43VKCgOcNyrkkZrR0sWEsHE+H27TVg@mail.gmail.com> <CAOf5uwmdwcdbxx2b6DvMeOJBahkZ3iiosWtHPD2zhxcDqO2b_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwmdwcdbxx2b6DvMeOJBahkZ3iiosWtHPD2zhxcDqO2b_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

2015-11-24 9:27 GMT+01:00 Michael Trimarchi <michael@amarulasolutions.c=
om>:
> Hi
>
> On Tue, Nov 24, 2015 at 9:21 AM, Rapha=C3=ABl Poggi <poggi.raph@gmail=
=2Ecom> wrote:
>> Hi,
>>
>> 2015-11-21 10:37 GMT+01:00 Michael Trimarchi <michael@amarulasolutio=
ns.com>:
>>> Hi
>>>
>>> On Fri, Nov 20, 2015 at 11:09 AM, Raphael Poggi <poggi.raph@gmail.c=
om> wrote:
>>>> From: Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>
>>>> Add possibility to choose the channel side using the device tree,
>>>> and also modify it using alsa ctrl.
>>>>
>>>> Signed-off-by: Raphael Poggi <poggi.raph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>  sound/soc/codecs/pcm1792a.c | 46 ++++++++++++++++++++++++++++++++=
+++++++++++++
>>>>  1 file changed, 46 insertions(+)
>>>>
>>>> diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm179=
2a.c
>>>> index febaa48..005b679 100644
>>>> --- a/sound/soc/codecs/pcm1792a.c
>>>> +++ b/sound/soc/codecs/pcm1792a.c
>>>> @@ -65,6 +65,12 @@ static const struct reg_default pcm1792a_reg_de=
faults[] =3D {
>>>>         { PCM1792A_DEVICE_ID, 0x00 },
>>>>  };
>>>>
>>>> +enum __pcm1792_side {
>>>> +       STEREO,
>>>> +       MONORAL_LEFT,
>>>> +       MONORAL_RIGHT
>>>> +};
>>>> +
>>>>  static bool pcm1792a_accessible_reg(struct device *dev, unsigned =
int reg)
>>>>  {
>>>>         return reg >=3D 0x10 && reg <=3D 0x17;
>>>> @@ -83,6 +89,7 @@ struct pcm1792a_private {
>>>>         struct regmap *regmap;
>>>>         unsigned int format;
>>>>         unsigned int rate;
>>>> +       unsigned int side;
>>>>  };
>>>>
>>>>  static int pcm1792a_set_dai_fmt(struct snd_soc_dai *codec_dai,
>>>> @@ -153,6 +160,13 @@ static int pcm1792a_hw_params(struct snd_pcm_=
substream *substream,
>>>>         ret =3D regmap_update_bits(priv->regmap, PCM1792A_FMT_CONT=
ROL,
>>>>                                  PCM1792A_FMT_MASK | PCM1792A_ATLD=
_ENABLE, val);
>>>>
>>>> +       if (priv->side =3D=3D MONORAL_LEFT)
>>>> +               val =3D PCM1792A_CHANNEL_MONO_LEFT;
>>>> +       else if (priv->side =3D=3D MONORAL_RIGHT)
>>>> +               val =3D PCM1792A_CHANNEL_MONO_RIGHT;
>>>> +
>>>> +       regmap_update_bits(priv->regmap, PCM1792A_CHANNEL, PCM1792=
A_CHANNEL_MONO_MASK, val);
>>>> +
>>>>         return ret;
>>>>  }
>>>>
>>>> @@ -222,10 +236,31 @@ static struct snd_soc_codec_driver soc_codec=
_dev_pcm1792a =3D {
>>>>         .num_dapm_routes        =3D ARRAY_SIZE(pcm1792a_dapm_route=
s),
>>>>  };
>>>>
>>>> +static int pcm1792a_of_init(struct spi_device *spi)
>>>> +{
>>>> +       int ret =3D 0;
>>>> +       struct pcm1792a_private *pcm1792a =3D dev_get_drvdata(&spi=
->dev);
>>>> +       const char *name;
>>>> +       struct device_node *np =3D spi->dev.of_node;
>>>> +
>>>> +       name =3D of_get_property(np, "ti,side", NULL);
>>>> +       if (name) {
>>>> +               if (!strcmp(name, "left"))
>>>> +                       pcm1792a->side =3D MONORAL_LEFT;
>>>> +               else
>>>> +                       pcm1792a->side =3D MONORAL_RIGHT;
>>>> +       }
>>>> +       else
>>>> +               pcm1792a->side =3D STEREO;
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>>  static int pcm1792a_spi_probe(struct spi_device *spi)
>>>>  {
>>>>         struct pcm1792a_private *pcm1792a;
>>>>         int ret;
>>>> +       struct device_node *np =3D spi->dev.of_node;
>>>>
>>>>         pcm1792a =3D devm_kzalloc(&spi->dev, sizeof(struct pcm1792=
a_private),
>>>>                                 GFP_KERNEL);
>>>> @@ -241,6 +276,17 @@ static int pcm1792a_spi_probe(struct spi_devi=
ce *spi)
>>>>                 return ret;
>>>>         }
>>>>
>>>> +       if (np) {
>>>> +               ret =3D pcm1792a_of_init(spi);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +       }
>>>> +
>>>> +       if (pcm1792a->side =3D=3D MONORAL_LEFT)
>>>> +               regmap_update_bits(pcm1792a->regmap, PCM1792A_CHAN=
NEL, PCM1792A_CHANNEL_MONO_MASK, PCM1792A_CHANNEL_MONO_LEFT);
>>>> +       else if (pcm1792a->side =3D=3D MONORAL_RIGHT)
>>>> +               regmap_update_bits(pcm1792a->regmap, PCM1792A_CHAN=
NEL, PCM1792A_CHANNEL_MONO_MASK, PCM1792A_CHANNEL_MONO_RIGHT);
>>>> +
>>>
>>> Why this is a part of dts and not a part of mixer control?
>>>
>>> Michael
>>>
>>
>> The "channel side" bindings should be used when the pcm7192a is used
>> in monaural mode (which requires two DACs, both DACs operate in a
>> balanced mode for one channel of audio input data).
>> This is a hardware level design, it will never change at runtime.
>> I feel that a device tree binding is more appropriate than a control=
=2E
>>
>
> Well I know exactly why is used for, but I don't really know if it's
> somenthing that should be
> in dts. Do I want to do channel inversion?
>
> Michael
>

I am not sure to understand. You mean "What if I want to do channel
inversion", right ?
If so, we have two differents "problems", one at hardware level design
because monaural mode requires two DACs, and an another one at
software level
"channel inversion".
I have always thought that hardware description should be in dts,
that's why I implement monaural mode using dts.

Honestly, I don't know what is the best solution between "this is a
hardware design, it should be in dts and shouldn't change" vs "this
should be an alsa controler because we want extra features independent
from hardware design"

Rapha=C3=ABl

>>>>         return snd_soc_register_codec(&spi->dev,
>>>>                         &soc_codec_dev_pcm1792a, &pcm1792a_dai, 1)=
;
>>>>  }
>>>> --
>>>> 2.1.0
>>>>
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>
>>>
>>>
>>> --
>>> | Michael Nazzareno Trimarchi                     Amarula Solutions=
 BV |
>>> | COO  -  Founder                                      Cruquiuskade=
 47 |
>>> | +31(0)851119172                                 Amsterdam 1018 AM=
 NL |
>>> |                  [`as] http://www.amarulasolutions.com           =
    |
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
> --
> | Michael Nazzareno Trimarchi                     Amarula Solutions B=
V |
> | COO  -  Founder                                      Cruquiuskade 4=
7 |
> | +31(0)851119172                                 Amsterdam 1018 AM N=
L |
> |                  [`as] http://www.amarulasolutions.com             =
  |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
