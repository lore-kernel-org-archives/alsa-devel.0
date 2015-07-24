From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH 2/2] ASoC: pcm1681: Improve the logic for
 de-emphasis sampling rate selection
Date: Fri, 24 Jul 2015 13:48:08 +0800
Message-ID: <CAFRkauBWWm9j0ZjqxU50hTkiaA24+6RfAFSELSys2k6=tmpNTg@mail.gmail.com>
References: <1437664946.20606.5.camel@ingics.com>
 <1437665015.20606.6.camel@ingics.com>
 <55B1451D.2020202@streamunlimited.com>
 <CAFRkauBcWnrhamUN=MCfMf0gTssb4aCbZ54-ysako-YAWjyJOg@mail.gmail.com>
 <55B1CB92.30104@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 00EC5260557
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 07:48:08 +0200 (CEST)
Received: by lbbzr7 with SMTP id zr7so8344719lbb.1
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 22:48:08 -0700 (PDT)
In-Reply-To: <55B1CB92.30104@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@streamunlimited.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

2015-07-24 13:22 GMT+08:00 Marek Belisko <marek.belisko@streamunlimited.com>:
> On 07/24/2015 03:17 AM, Axel Lin wrote:
>> 2015-07-24 3:48 GMT+08:00 Marek Belisko <marek.belisko@streamunlimited.com>:
>>> Hi Axel,
>>>
>>> On 23.07.2015 17:23, Axel Lin wrote:
>>>>
>>>> Slightly improve the logic for de-emphasis sampling rate selection by
>>>> break
>>>> out the loop if the rate is matched.
>>>>
>>>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>>>> ---
>>>>   sound/soc/codecs/pcm1681.c | 13 +++++++++----
>>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
>>>> index 1011142..5832523 100644
>>>> --- a/sound/soc/codecs/pcm1681.c
>>>> +++ b/sound/soc/codecs/pcm1681.c
>>>> @@ -95,17 +95,22 @@ static int pcm1681_set_deemph(struct snd_soc_codec
>>>> *codec)
>>>>         struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
>>>>         int i = 0, val = -1, enable = 0;
>>>>
>>>> -       if (priv->deemph)
>>>> -               for (i = 0; i < ARRAY_SIZE(pcm1681_deemph); i++)
>>>> -                       if (pcm1681_deemph[i] == priv->rate)
>>>> +       if (priv->deemph) {
>>>> +               for (i = 0; i < ARRAY_SIZE(pcm1681_deemph); i++) {
>>>> +                       if (pcm1681_deemph[i] == priv->rate) {
>>>>                                 val = i;
>>>> +                               break;
>>>> +                       }
>>>> +               }
>>>> +       }
>>>
>>> ^^^^^^^
>>> I think we don't need those brackets only for if statement (where you add
>>> break)
>>
>> Because I think having the brackets here makes the code looks better.
> If we follow CodingStyle then it says no brackets around single statement.

Yes, but it's not always good if the "single statement" is actually cross
multiple lines. And checkpatch does not complain this patch.

Well, this is probably a bit personal preference because I feel it has
better readability with the brackets here.

If you insist on removing the brackets, I can send v2 to do that.

Regards,
Axel
