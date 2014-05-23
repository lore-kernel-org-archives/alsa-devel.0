From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH RFT] ASoC: cs42l56: Fix new value argument
 in snd_soc_update_bits calls
Date: Fri, 23 May 2014 12:02:58 +0800
Message-ID: <CAFRkauDb458cWzvHb2eZqCiWq8R6ixOfe1KtNUEyvwLdx6Ok9w@mail.gmail.com>
References: <1400033616.10054.2.camel@phoenix>
 <alpine.DEB.2.02.1405221248370.10781@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 00D8D265638
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 06:03:01 +0200 (CEST)
Received: by mail-qg0-f42.google.com with SMTP id q107so7381232qgd.29
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 21:02:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1405221248370.10781@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

2014-05-23 1:56 GMT+08:00 Brian Austin <brian.austin@cirrus.com>:
> On Tue, 13 May 2014, Axel Lin wrote:
>
>>
>> The new value argument needs proper shift to match the mask bit fields.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>> Hi Brian,
>> This patch replaces
>> [PATCH RFT] ASoC: cs42l56: Fix update mute register bits in
>> cs42l56_digital_mute.
>> I just found more places of snd_soc_update_bits calls needs fix.
>> Regards,
>> Axel
>> sound/soc/codecs/cs42l56.c | 71
>> ++++++++++++++++++----------------------------
>> sound/soc/codecs/cs42l56.h | 14 ++++-----
>> 2 files changed, 35 insertions(+), 50 deletions(-)
>>
>> diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
>> index 5bb134b..c0be526 100644
>> --- a/sound/soc/codecs/cs42l56.c
>> +++ b/sound/soc/codecs/cs42l56.c
>> {
>>         struct snd_soc_codec *codec = dai->codec;
>> +       unsigned int mask;
>>
>>         if (mute) {
>>                 /* Hit the DSP Mixer first */
>> -               snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
>> -                                   CS42L56_ADCAMIX_MUTE_MASK |
>> -                               CS42L56_ADCBMIX_MUTE_MASK |
>> -                               CS42L56_PCMAMIX_MUTE_MASK |
>> -                               CS42L56_PCMBMIX_MUTE_MASK |
>> -                               CS42L56_MSTB_MUTE_MASK |
>> -                               CS42L56_MSTA_MUTE_MASK,
>> -                               CS42L56_MUTE);
>> +               mask = CS42L56_ADCAMIX_MUTE_MASK |
>> CS42L56_ADCBMIX_MUTE_MASK |
>> +                      CS42L56_PCMAMIX_MUTE_MASK |
>> CS42L56_PCMBMIX_MUTE_MASK |
>> +                      CS42L56_MSTB_MUTE_MASK | CS42L56_MSTA_MUTE_MASK;
>> +               snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL, mask,
>> mask);
>> +
>
>
> I see where my MUTE is not actually doing what I want and since this is for
> just .digital_mute, I would rather just declare a MUTE_ALL define instead of
> adding variables to the function
>
>
>>                 snd_soc_update_bits(codec, CS42L56_LOB_VOLUME,
>> -                               CS42L56_LO_MUTE_MASK,
>> -                               CS42L56_MUTE);
>> +                                   CS42L56_LO_MUTE_MASK,
>> CS42L56_LO_MUTE_MASK);
>
>
> Yes, this is my fault for not understanding this correctly. I don't like it
> and think odd you have to do it like this BTW.
It's to set CS42L56_LO_MUTE_MASK bit (0x80).

>
>
>>
>>
>>         } else {
>> -               snd_soc_update_bits(codec, CS42L56_DSP_MUTE_CTL,
>> -                                   CS42L56_ADCAMIX_MUTE_MASK |
>> -                               CS42L56_ADCBMIX_MUTE_MASK |
>> -                               CS42L56_PCMAMIX_MUTE_MASK |
>> -                               CS42L56_PCMBMIX_MUTE_MASK |
>> -                               CS42L56_MSTB_MUTE_MASK |
>> -                               CS42L56_MSTA_MUTE_MASK,
>> -                               CS42L56_UNMUTE);
>> -               snd_soc_update_bits(codec, CS42L56_MISC_ADC_CTL,
>> -                               CS42L56_ADCA_MUTE_MASK |
>> -                               CS42L56_ADCB_MUTE_MASK,
>> -                               CS42L56_UNMUTE);
>
>
> This should work fine.
>
>
>> -                               CS42L56_UNMUTE);
>> +                                   CS42L56_LO_MUTE_MASK, 0);
>
> What is the difference here? Consistency?

>From my point of view, pass 0 here means to clear the MASK bits.
Note, the mask bit is different in various snd_soc_update_bits calls here,
so it only make sense if CS42L56_UNMUTE is 0.
In this case, CS42L56_UNMUTE actually is defined as 0. so either is ok.

>
>
>>         }
>>         return 0;
>> }
>> diff --git a/sound/soc/codecs/cs42l56.h b/sound/soc/codecs/cs42l56.h
>> index ad2b50a..d2f68c6 100644
>> --- a/sound/soc/codecs/cs42l56.h
>> +++ b/sound/soc/codecs/cs42l56.h
>> @@ -80,19 +80,21 @@
>> #define CS42L56_PDN_HPB_MASK            0xc0
>>
>> /* serial port and clk masks */
>> -#define CS42L56_MASTER_MODE            1
>> -#define CS42L56_SLAVE_MODE             0
>> +#define CS42L56_MASTER_MODE            (1 << 6)
>> +#define CS42L56_SLAVE_MODE             (0 << 6)
>> #define CS42L56_MS_MODE_MASK            0x40
>> -#define CS42L56_SCLK_INV               1
>> +#define CS42L56_SCLK_INV               (1 << 5)
>> #define CS42L56_SCLK_INV_MASK           0x20
>> #define CS42L56_SCLK_MCLK_MASK          0x18
>> +#define CS42L56_MCLK_PREDIV            (1 << 6)
>
> Your way off on this one. It is the third bit in the register

Fixed in v2.

>
> In general for myself I am trying to get away from the "shift" defines and
> use something more meaningful with just a value. I have not tested yet as I
It's nothing wrong using the "shift" in defines.
I personal think using "shift" in the defines makes it easier to
understand the meaning which is mapping
to the bits documented in datasheet.
But since you prefer not using the "shift", I updated the defines in v2.

Thanks for the review,
Axel
