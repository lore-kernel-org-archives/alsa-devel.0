From: noman pouigt <variksla@gmail.com>
Subject: Re: ALSA Core: Sound Card registration (CPU -->
 CODEC_1 --> CODEC_2)
Date: Thu, 11 Sep 2014 01:17:46 -0700
Message-ID: <CAES_P+9NAq6RWGUadmhnqK14kO5xjbFJuFKYZ1CA77Fw5iJKRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f50.google.com (mail-oa0-f50.google.com
 [209.85.219.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A1068265531
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 10:17:47 +0200 (CEST)
Received: by mail-oa0-f50.google.com with SMTP id o6so13899239oag.37
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 01:17:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> We have a question regarding how sound card can be registered for the
> following scenario:
>
> CPU connecting to Audio CODEC_1 and then CODEC_1 connecting to another
> Audio CODEC_2 (over some bus like i2c). CODEC_1 can be represented as a

so you mean codec_1 is controlling codec_2 ? or you mean
the CPU is going to control both the codecs?

> codec_dai and can be registered to ASoC framework (with
> snd_soc_register_codec()) during system boot up. However, for end-to-end
> audio to work on this system, we also need CODEC_2 somehow registered to
> ASoC framework so that audio path on CODEC_2 can configured.

>From this i understand that your CPU is going to configure the codec_2
but then why it is connected to codec_1 with i2c?
>
> Could you please let us know if CODEC_2 can also registered as another dai
> and if yes, how it can be achieved ? Or is there any other way to
> probe_defer sound card registration till CODEC_2 is enumerated on the bus.

why not register both as codecs to the ALSA? Anyway i think
ALSA can support multiple codecs.
> In this case, to what component of the sound card dailink structure, the
> Audio CODEC_2 can be represented ?
as a codec. However this would not work if there is a dependecny in detection
i.e. if you have a requirement where codec_1 needs to be detected first
and then codec_2 then probably you need a different approach as there
is no way to set dependency.
>
> Please share your thoughts on this.

I would explain more about the setup if i were you to get ideas from
ALSA experts.
>
> Best Regards,
> Phani
>
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
>
>
>
> ------------------------------
>
> Message: 2
> Date: Thu, 4 Sep 2014 12:03:52 +0530
> From: Vinod Koul <vinod.koul@intel.com>
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
>         "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Liam Girdwood
>         <lgirdwood@gmail.com>
> Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: Add
>         snd_soc_component_{get, set}_drvdata()
> Message-ID: <20140904063352.GC1610@intel.com>
> Content-Type: text/plain; charset=us-ascii
>
> On Wed, Sep 03, 2014 at 09:06:49PM +0200, Lars-Peter Clausen wrote:
>> On 09/03/2014 02:22 PM, Vinod Koul wrote:
>> >On Wed, Aug 20, 2014 at 01:08:46PM +0200, Lars-Peter Clausen wrote:
>> >>Add Add snd_soc_component_{get,set}_drvdata() similar to
>> >>snd_soc_codec_{get,set}_drvdata() and
>> >> snd_soc_platform_{get,set}_drvdata().
>> >>Also update them to use the new functions internally.
>> >>
>> >>Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> >Reviewed-by: Vinod Koul <vinod.koul@intel.com>
>>
>> Is this for the first patch or for the whole series?
> Patch only. The HSW driver changes, I think Liam should ack
>
> --
> ~Vinod
>
>
>
> ------------------------------
>
> Message: 3
> Date: Thu, 4 Sep 2014 10:52:53 +0300
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> To: Mark Brown <broonie@kernel.org>, Liam Girdwood
>         <lgirdwood@gmail.com>
> Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
> Subject: [alsa-devel] [PATCH] ASoC: davinci-mcasp: Correct rx format
>         unit    configuration
> Message-ID: <1409817173-29234-1-git-send-email-peter.ujfalusi@ti.com>
> Content-Type: text/plain
>
> In case of capture we should not use rotation. The reverse and mask is
> enough to get the data align correctly from the bus to MCU:
> Format    data from bus    after reverse (XRBUF)
> S16_LE:  |LSB|MSB|xxx|xxx|  |xxx|xxx|MSB|LSB|
> S24_3LE: |LSB|DAT|MSB|xxx|  |xxx|MSB|DAT|LSB|
> S24_LE:  |LSB|DAT|MSB|xxx|  |xxx|MSB|DAT|LSB|
> S32_LE:  |LSB|DAT|DAT|MSB|  |MSB|DAT|DAT|LSB|
>
> With this patch all supported formats will work for playback and capture.
>
> Reported-by: Jyri Sarha <jsarha@ti.com> (broken S24_3LE capture)
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/davinci/davinci-mcasp.c
> b/sound/soc/davinci/davinci-mcasp.c
> index 6a6b2ff7d7d7..68347b55f6e1 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -467,8 +467,17 @@ static int davinci_config_channel_size(struct
> davinci_mcasp *mcasp,
>  {
>         u32 fmt;
>         u32 tx_rotate = (word_length / 4) & 0x7;
> -       u32 rx_rotate = (32 - word_length) / 4;
>         u32 mask = (1ULL << word_length) - 1;
> +       /*
> +        * For captured data we should not rotate, inversion and masking is
> +        * enoguh to get the data to the right position:
> +        * Format         data from bus         after reverse (XRBUF)
> +        * S16_LE:      |LSB|MSB|xxx|xxx|       |xxx|xxx|MSB|LSB|
> +        * S24_3LE:     |LSB|DAT|MSB|xxx|       |xxx|MSB|DAT|LSB|
> +        * S24_LE:      |LSB|DAT|MSB|xxx|       |xxx|MSB|DAT|LSB|
> +        * S32_LE:      |LSB|DAT|DAT|MSB|       |MSB|DAT|DAT|LSB|
> +        */
> +       u32 rx_rotate = 0;
>
>         /*
>          * if s BCLK-to-LRCLK ratio has been configured via the set_clkdiv()
> --
> 2.1.0
>
>
>
> ------------------------------
>
> Message: 4
> Date: Thu, 4 Sep 2014 10:59:41 +0300
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> To: Mark Brown <broonie@kernel.org>, Liam Girdwood
>         <lgirdwood@gmail.com>
> Cc: alsa-devel@alsa-project.org, jsarha@ti.com
> Subject: [alsa-devel] [PATCH] ASoC: tlv320aic31xx: Enable support for
>         S24_LE  format
> Message-ID: <1409817581-29496-1-git-send-email-peter.ujfalusi@ti.com>
> Content-Type: text/plain
>
> S24_LE is the same on the bus as S24_3LE, which means the codec can support
> it.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/codecs/tlv320aic31xx.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tlv320aic31xx.h
> b/sound/soc/codecs/tlv320aic31xx.h
> index 52ed57c69dfa..fe16c34607bb 100644
> --- a/sound/soc/codecs/tlv320aic31xx.h
> +++ b/sound/soc/codecs/tlv320aic31xx.h
> @@ -18,7 +18,8 @@
>  #define AIC31XX_RATES  SNDRV_PCM_RATE_8000_192000
>
>  #define AIC31XX_FORMATS        (SNDRV_PCM_FMTBIT_S16_LE |
> SNDRV_PCM_FMTBIT_S20_3LE \
> -                        | SNDRV_PCM_FMTBIT_S24_3LE |
> SNDRV_PCM_FMTBIT_S32_LE)
> +                        | SNDRV_PCM_FMTBIT_S24_3LE |
> SNDRV_PCM_FMTBIT_S24_LE \
> +                        | SNDRV_PCM_FMTBIT_S32_LE)
>
>
>  #define AIC31XX_STEREO_CLASS_D_BIT     0x1
> --
> 2.1.0
>
>
>
> ------------------------------
>
> Message: 5
> Date: Thu, 4 Sep 2014 17:13:06 +0800
> From: Xavier Hsu <xavier.hsu@linaro.org>
> To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Andy Green <andy.green@linaro.org>, alsa-devel@alsa-project.org,
>         patches@opensource.wolfsonmicro.com, Patch Tracking
>         <patches@linaro.org>
> Subject: Re: [alsa-devel] [PATCHv3 5/9] Using the constraint based on
>         wm8971_set_dai_sysclk
> Message-ID:
>         <CAHa2TOYHbA7nEQQeqxB+r3KyA=BxXOmfQ6psuouZgqWomb=pEg@mail.gmail.com>
> Content-Type: text/plain; charset=UTF-8
>
> Hi Charles :
> Thanks for yours feedback.
>
> According your suggestion, I combine the redundant codes and fix some
> mistakes.
> (rates_12288[] and rates_18432[]      => rates_48000[]
>  rates_112896[] and rates_169344[]  => rates_44100[]
>  2400 => 24000
> )
> I also add snd_pcm_hw_constraint_list() to restrict sysclk.
>
> Thanks.
>
> BR,
> Xavier
>
>
> 2014-09-02 17:28 GMT+08:00 Charles Keepax <
> ckeepax@opensource.wolfsonmicro.com>:
>
>> On Tue, Sep 02, 2014 at 11:27:46AM +0800, Xavier Hsu wrote:
>> > This patch improves WM8971.
>> > We use the constraint based on the function of
>> > wm8971_set_dai_sysclk().
>> >
>> > Any comments about improving the patch are welcome.
>> > Thanks.
>>
>> Comments like this are probably best put after the --- as they
>> don't need to appear in the change log.
>>
>> >
>> > Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
>> > Signed-off-by: Andy Green <andy.green@linaro.org>
>> > ---
>> >  sound/soc/codecs/wm8971.c |   77
>> +++++++++++++++++++++++++++++++++++++++++----
>> >  1 file changed, 71 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
>> > index 64ed226..20cfdd3 100755
>> > --- a/sound/soc/codecs/wm8971.c
>> > +++ b/sound/soc/codecs/wm8971.c
>> > @@ -41,6 +41,7 @@ static struct workqueue_struct *wm8971_workq;
>> >  /* codec private data */
>> >  struct wm8971_priv {
>> >       unsigned int sysclk;
>> > +     struct snd_pcm_hw_constraint_list *sysclk_constraints;
>> >       int playback_fs;
>> >       bool deemph;
>> >  };
>> > @@ -528,6 +529,53 @@ static int get_coeff(int mclk, int rate)
>> >       return -EINVAL;
>> >  }
>> >
>> > +/* The set of rates we can generate from the above for each SYSCLK */
>> > +static const unsigned int rates_12288[] = {
>> > +     8000, 12000, 16000, 24000, 32000, 48000, 96000
>> > +};
>> > +
>> > +static struct snd_pcm_hw_constraint_list constraints_12288 = {
>> > +     .count  = ARRAY_SIZE(rates_12288),
>> > +     .list   = rates_12288,
>> > +};
>> > +
>> > +static const unsigned int rates_112896[] = {
>> > +     8000, 11025, 22050, 44100, 88200
>> > +};
>> > +
>> > +static struct snd_pcm_hw_constraint_list constraints_112896 = {
>> > +     .count  = ARRAY_SIZE(rates_112896),
>> > +     .list   = rates_112896,
>> > +};
>> > +
>> > +static const unsigned int rates_18432[] = {
>> > +     8000, 12000, 16000, 24000, 32000, 48000, 96000
>> > +};
>> > +
>> > +static struct snd_pcm_hw_constraint_list constraints_18432 = {
>> > +     .count  = ARRAY_SIZE(rates_18432),
>> > +     .list   = rates_18432,
>> > +};
>>
>> This one is identical to the 12288 array, why not combine them
>> and call them the 48k array?
>>
>> > +
>> > +static const unsigned int rates_169344[] = {
>> > +     8000, 11025, 22050, 44100, 88200
>> > +};
>>
>> This one is identical to the 112896 array, why not combine them
>> and call them the 44k1 array?
>>
>> > +
>> > +static struct snd_pcm_hw_constraint_list constraints_169344 = {
>> > +     .count  = ARRAY_SIZE(rates_169344),
>> > +     .list   = rates_169344,
>> > +};
>> > +
>> > +static const unsigned int rates_12[] = {
>> > +     8000, 11025, 12000, 16000, 22050, 2400, 32000, 41100, 48000,
>>
>> Typo 0 missing                            ^^^^
>>
>> > +     48000, 88235, 96000,
>> > +};
>> > +
>> > +static struct snd_pcm_hw_constraint_list constraints_12 = {
>> > +     .count  = ARRAY_SIZE(rates_12),
>> > +     .list   = rates_12,
>> > +};
>> > +
>> >  static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>> >                                int clk_id, unsigned int freq, int dir)
>> >  {
>> > @@ -535,15 +583,32 @@ static int wm8971_set_dai_sysclk(struct
>> snd_soc_dai *codec_dai,
>> >       struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
>> >
>> >       switch (freq) {
>> > -     case 11289600:
>> > -     case 12000000:
>> >       case 12288000:
>> > -     case 16934400:
>> > +     case 24576000:
>> > +             wm8971->sysclk_constraints = &constraints_12288;
>> > +             break;
>> > +     case 11289600:
>> > +     case 22579200:
>> > +             wm8971->sysclk_constraints = &constraints_112896;
>> > +             break;
>> >       case 18432000:
>> > -             wm8971->sysclk = freq;
>> > -             return 0;
>> > +             wm8971->sysclk_constraints = &constraints_18432;
>> > +             break;
>> > +     case 16934400:
>> > +     case 33868800:
>> > +             wm8971->sysclk_constraints = &constraints_169344;
>> > +             break;
>> > +     case 12000000:
>> > +     case 24000000:
>> > +             wm8971->sysclk_constraints = &constraints_12;
>> > +             break;
>> > +     default:
>> > +             return -EINVAL;
>> >       }
>> > -     return -EINVAL;
>>
>> You pick out the constraints here but you never actually set them
>> with snd_pcm_hw_constraint_list?
>>
>> > +
>> > +     wm8971->sysclk = freq;
>> > +
>> > +     return 0;
>> >  }
>> >
>> >  static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
>> > --
>>
>> Thanks,
>> Charles
>>
>
>
> ------------------------------
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
> End of Alsa-devel Digest, Vol 91, Issue 41
> ******************************************
>
