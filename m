From: =?UTF-8?Q?Rapha=C3=ABl_Poggi?= <poggi.raph@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/4] sound: codecs: pcm1792a: clean function exit
Date: Sat, 21 Nov 2015 17:16:53 +0100
Message-ID: <CACqcpZACQiBkyj=a765rKjGi7Ft_MS4+t_0F90dQXGxecRm92Q@mail.gmail.com>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
 <1448014157-36526-2-git-send-email-raphael.poggi@avalun.com> <CAOf5uwmx95te=gHg5FnmNx+xOcpmGfnfzdgbnF8m8sms028PKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOf5uwmx95te=gHg5FnmNx+xOcpmGfnfzdgbnF8m8sms028PKQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: perex@perex.cz, tiwai@suse.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I know that almost all the codec do as before, but what is the goal of
using an extra condition when we can avoid it ?

Raphael

2015-11-21 10:31 GMT+01:00 Michael Trimarchi <michael@amarulasolutions.com>:
> Hi
>
> On Fri, Nov 20, 2015 at 11:09 AM, Raphael Poggi <poggi.raph@gmail.com> wrote:
>> From: Raphael Poggi <poggi.raph@gmail.com>
>>
>> Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
>> ---
>>  sound/soc/codecs/pcm1792a.c | 14 ++++----------
>>  1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
>> index 08bb486..cf42b24 100644
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
>
> Ok, I have seen that almost all the codecs use return regmap_upda...
>
>> -       return 0;
>>  }
>>
>>  static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
>> @@ -107,7 +102,8 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
>>  {
>>         struct snd_soc_codec *codec = dai->codec;
>>         struct pcm1792a_private *priv = snd_soc_codec_get_drvdata(codec);
>> -       int val = 0, ret;
>> +       int val = 0;
>> +       int ret = 0;
>>
>>         priv->rate = params_rate(params);
>>
>> @@ -147,10 +143,8 @@ static int pcm1792a_hw_params(struct snd_pcm_substream *substream,
>>
>>         ret = regmap_update_bits(priv->regmap, PCM1792A_FMT_CONTROL,
>>                                  PCM1792A_FMT_MASK | PCM1792A_ATLD_ENABLE, val);
>> -       if (ret < 0)
>> -               return ret;
>>
>
> Please do the same as before
>
> Michael
>
>
>> -       return 0;
>> +       return ret;
>>  }
>>
>>  static const struct snd_soc_dai_ops pcm1792a_dai_ops = {
>> --
>> 2.1.0
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
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
