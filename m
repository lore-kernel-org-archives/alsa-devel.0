From: =?UTF-8?Q?Rapha=C3=ABl_Poggi?= <poggi.raph@gmail.com>
Subject: Re: [PATCH v2] sound: codecs: pcm1792a: clean function exit
Date: Mon, 14 Dec 2015 12:48:48 +0100
Message-ID: <CACqcpZDCkRPb5j3WYaHVWiJw-v9FOitP-uCoBeCnVY97nM3WaA@mail.gmail.com>
References: <1448439009-9778-1-git-send-email-poggi.raph@gmail.com> <CAOf5uwn3R+Q=3TbkZfLtTUr=xhCovG1LNy6aaiEhpszwH5iR=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOf5uwn3R+Q=3TbkZfLtTUr=xhCovG1LNy6aaiEhpszwH5iR=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: LKML <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

ping ?

2015-11-25 9:18 GMT+01:00 Michael Trimarchi <michael@amarulasolutions.com>:
> Hi
>
> On Wed, Nov 25, 2015 at 9:10 AM, Raphael Poggi <poggi.raph@gmail.com> wrote:
>> Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
>> ---
>>  sound/soc/codecs/pcm1792a.c | 15 +++------------
>>  1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
>> index 08bb486..27d54bc 100644
>> --- a/sound/soc/codecs/pcm1792a.c
>> +++ b/sound/soc/codecs/pcm1792a.c
>> @@ -91,14 +91,9 @@ static int pcm1792a_digital_mute(struct snd_soc_dai *dai, int mute)
>>  {
>>         struct snd_soc_codec *codec = dai->codec;
>>         struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
>> -       int ret;
>>
>> -       ret = regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
>> +       return regmap_update_bits(priv->regmap, PCM1792A_SOFT_MUTE,
>>                                  PCM1792A_MUTE_MASK, !!mute);
>> -       if (ret < 0)
>> -               return ret;
>> -
>> -       return 0;
>>  }
>>
>>  static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
>> @@ -107,7 +102,7 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
>>  {
>>         struct snd_soc_codec *codec = dai->codec;
>>         struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
>> -       int val = 0, ret;
>> +       int val = 0;
>>
>>         priv->rate = params_rate(params);
>>
>> @@ -145,12 +140,8 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
>>
>>         val = val << PCM1792A_FMT_SHIFT | PCM1792A_ATLD_ENABLE;
>>
>> -       ret = regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
>> +       return regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
>>                                  PCM1792A_FMT_MASK | PCM1792A_ATLD_ENABLE, val);
>> -       if (ret < 0)
>> -               return ret;
>> -
>> -       return 0;
>>  }
>>
>>  static const struct snd_soc_dai_ops pcm1792a_dai_ops = {
>> --
>> 2.1.0
>>
>
> It's fine for me
>
> reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
>
>
> --
> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> | COO  -  Founder                                      Cruquiuskade 47 |
> | +31(0)851119172                                 Amsterdam 1018 AM NL |
> |                  [`as] http://www.amarulasolutions.com               |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
