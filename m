From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: sgtl5000: Fix the cache handling
Date: Fri, 23 May 2014 09:39:41 -0300
Message-ID: <CAOMZO5AG==Evkn6Sdgmp-7LhigXWK2=d=eoFCUPVn7hCYyBnLg@mail.gmail.com>
References: <1400821880-20939-1-git-send-email-festevam@gmail.com>
 <537F0884.3050605@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 00BE2264FE3
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 14:39:42 +0200 (CEST)
Received: by mail-vc0-f174.google.com with SMTP id hq11so401326vcb.33
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 05:39:41 -0700 (PDT)
In-Reply-To: <537F0884.3050605@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Lars-Peter,

On Fri, May 23, 2014 at 5:36 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> [...]
>
>> @@ -1075,7 +1079,6 @@ static int sgtl5000_suspend(struct snd_soc_codec
>> *codec)
>>    */
>>   static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
>>   {
>> -       u16 *cache = codec->reg_cache;
>>         u16 reg;
>>
>>         /* restore regular registers */
>> @@ -1089,12 +1092,12 @@ static int sgtl5000_restore_regs(struct
>> snd_soc_codec *codec)
>>                         reg == SGTL5000_CHIP_REF_CTRL)
>>                         continue;
>>
>> -               snd_soc_write(codec, reg, cache[reg]);
>> +               snd_soc_write(codec, reg, snd_soc_read(codec, reg));
>>         }
>>
>>         /* restore dap registers */
>>         for (reg = SGTL5000_DAP_REG_OFFSET; reg < SGTL5000_MAX_REG_OFFSET;
>> reg += 2)
>> -               snd_soc_write(codec, reg, cache[reg]);
>> +               snd_soc_write(codec, reg, snd_soc_read(codec, reg));
>>
>>         /*
>>          * restore these regs according to the power setting sequence in
>> @@ -1110,29 +1113,32 @@ static int sgtl5000_restore_regs(struct
>> snd_soc_codec *codec)
>>          *    prefer to resotre it after SGTL5000_CHIP_ANA_POWER restored
>>          */
>>         snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
>> -                       cache[SGTL5000_CHIP_LINREG_CTRL]);
>> +                       snd_soc_read(codec, SGTL5000_CHIP_LINREG_CTRL));
>>
>>         snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
>> -                       cache[SGTL5000_CHIP_ANA_POWER]);
>> +                       snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER));
>>
>>         snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
>> -                       cache[SGTL5000_CHIP_CLK_CTRL]);
>> +                       snd_soc_read(codec, SGTL5000_CHIP_CLK_CTRL));
>>
>>         snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
>> -                       cache[SGTL5000_CHIP_REF_CTRL]);
>> +                       snd_soc_read(codec, SGTL5000_CHIP_REF_CTRL));
>>
>>         snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
>> -                       cache[SGTL5000_CHIP_LINE_OUT_CTRL]);
>> +                       snd_soc_read(codec, SGTL5000_CHIP_LINE_OUT_CTRL));
>>         return 0;
>>   }
>>
>>   static int sgtl5000_resume(struct snd_soc_codec *codec)
>>   {
>> +       struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
>>         /* Bring the codec back up to standby to enable regulators */
>>         sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>>
>>         /* Restore registers by cached in memory */
>>         sgtl5000_restore_regs(codec);
>> +
>> +       regcache_cache_only(sgtl5000->regmap, false);
>
>
> That doesn't make too much sense, if regmap is in cache only mode
> snd_soc_read() will read from the cache and snd_soc_write() will write to
> the cache and nothing else happens. So you read from the cache only to write
> the same value back.

I would appreciate some guidance here as I am not very familiar with
the caching details.

What would be the recommended approach in this case?
