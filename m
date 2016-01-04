From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: Extend FLL function
Date: Mon, 4 Jan 2016 18:04:12 +0800
Message-ID: <568A439C.9070801@nuvoton.com>
References: <1451548510-4989-1-git-send-email-KCHSU0@nuvoton.com>
 <CAOMFOmX_fu94AYJpP5x4=r9GXb5CztxhMNNv7rHENO8fWbgjeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 497362604DF
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 11:04:16 +0100 (CET)
In-Reply-To: <CAOMFOmX_fu94AYJpP5x4=r9GXb5CztxhMNNv7rHENO8fWbgjeg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ben Zhang <benzh@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, Mark Brown <broonie@kernel.org>, CTLIN0@nuvoton.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Dear all,
Please check up in the following comment, and I cut off original mail.

On 12/31/2015 5:14 PM, Anatol Pomozov wrote:
>>  /* freq_out must be 256*Fs in order to achieve the best performance */
>> @@ -970,6 +981,37 @@ static int nau8825_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
>>         return 0;
>>  }
>>
>> +static int nau8825_mclk_prepare(struct nau8825 *nau8825, unsigned int freq)
>> +{
>> +       int ret = 0;
>> +
>> +       /* We selected MCLK source but the clock itself managed externally */
>> +       if (!nau8825->mclk)
>> +               goto done;
>>     
>
> A nitpick.
>
> This "goto" style is used for recovering resources or something that
> should be restored in case of error. But in your case "done:" does not
> recover anything. It is cleaner remove "goto" and replace with "return
> 0" or "return err".
>
>   
OK, I'll change it.
>> +
>> +       if (!nau8825->mclk_freq) {
>> +               ret = clk_prepare_enable(nau8825->mclk);
>> +               if (ret) {
>> +                       dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
>> +                       goto done;
>> +               }
>> +       }
>> +
>> +       if (nau8825->mclk_freq != freq) {
>> +               nau8825->mclk_freq = freq;
>> +
>> +               freq = clk_round_rate(nau8825->mclk, freq);
>> +               ret = clk_set_rate(nau8825->mclk, freq);
>> +               if (ret) {
>> +                       dev_err(nau8825->dev, "Unable to set mclk rate\n");
>> +                       goto done;
>> +               }
>> +       }
>> +
>> +done:
>> +       return ret;
>> +}
>> +
>>
>>                 break;
>>         case NAU8825_CLK_INTERNAL:
>> @@ -1018,6 +1040,30 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
>>                 }
>>
>>                 break;
>> +       case NAU8825_CLK_FLL_MCLK:
>> +               regmap_update_bits(regmap, NAU8825_REG_FLL3,
>> +                       NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_MCLK);
>> +               ret = nau8825_mclk_prepare(nau8825, freq);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               break;
>> +       case NAU8825_CLK_FLL_BLK:
>> +               regmap_update_bits(regmap, NAU8825_REG_FLL3,
>> +                       NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_BLK);
>> +               ret = nau8825_mclk_prepare(nau8825, freq);
>>     
>
>
> Based on names for these constants I believe CODEC is going to use
> BCLK/FS signal of I2S bus as a clock signal reference.
>
> Do you still need MCLK signal in this case? If no then you should
> disable MCLK to save some power.
>
>   
Yes, the MCLK should disable when FLL reference to BCLK/FS for power saving.
I'll disable it like internal clock case.


BR.
John
