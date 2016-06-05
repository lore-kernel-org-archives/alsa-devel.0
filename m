From: Pietro Di Costanzo <pxpert@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: use 19.2 MCLK instead of the
 bit clock for bytcr_rt5651.c machine driver
Date: Sun, 5 Jun 2016 23:36:39 +0200
Message-ID: <CAP0XwOLQFQQ0HTZfsbxN0JHyBL-hRGoCyVW8FM6XHcsE9Kxj7A@mail.gmail.com>
References: <1464967985-18355-1-git-send-email-pxpert@gmail.com>
 <6f5f71ae-3e96-628c-ebef-923043cb8e68@linux.intel.com>
 <2136089.cfVrPVxj7s@wks-pdc-gentoo>
 <cf461eb2-c067-3eae-163e-0c214e346716@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 600462654EB
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 23:36:41 +0200 (CEST)
Received: by mail-vk0-f67.google.com with SMTP id z65so2857125vka.0
 for <alsa-devel@alsa-project.org>; Sun, 05 Jun 2016 14:36:41 -0700 (PDT)
In-Reply-To: <cf461eb2-c067-3eae-163e-0c214e346716@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ok then, I'll wait for updates about it, and let you know if I'll find any
issues.

Thanks again, and have a good weekend :)

Pietro

2016-06-03 22:48 GMT+02:00 Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com>:

> On 6/3/16 2:47 PM, Pietro wrote:
>
>> Hi Pierre,
>>
>> If needed I can patch it in one of these ways:
>> - Split the driver in one for Baytrail Platforms, and another one for
>> Cherryview
>> - Use conditional compilations, with an addictional Kernel option to
>> select between Baytrail and Cherryview
>> - Select the proper way to set the clock at runtime by detect the
>> platform in the driver context (Some help needed here to distinguish
>> between the 2 platforms)
>>
>> Or just tell me if you think this is not needed, because the clock driver
>> you are working on will be released soon.
>>
>
> this should be coming 'soon'. There are really two options to handle,
> - PLL driven from MCLK (default) or BCLK (using DMI to identify specific
> boards where MCLK is not available)
> - MCLK configured at 19.2 by default (CHT) or explicitly configured
> (Baytrail)
>
> I have code already for most of the changes so it's better if I do it in a
> couple of weeks time. In the mean time maybe you can work on the capture
> part that I can't test except for the headset mic
>
>
>> Pietro
>>
>> On Friday 03 June 2016 11:15:00 Pierre-Louis Bossart wrote:
>>
>>> On 6/3/16 10:33 AM, Pietro Di Costanzo wrote:
>>>
>>>> Use the MCLK to solve audio quality issues found on some
>>>> Cherryview-based platforms
>>>>
>>>> Signed-off-by: Pietro Di Costanzo <pxpert@gmail.com>
>>>>
>>>
>>> Thanks Pietro.
>>> this can't be merged as is as it wouldn't work on Baytrail platforms. I
>>> will merge it with the clock driver we are working to have a single
>>> driver that works for both cases.
>>>
>>> ---
>>>>  sound/soc/intel/boards/bytcr_rt5651.c | 84
>>>> +++++++++++++++++++++++++++++++----
>>>>  1 file changed, 75 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c
>>>> b/sound/soc/intel/boards/bytcr_rt5651.c
>>>> index 35f591e..e51ea5b 100644
>>>> --- a/sound/soc/intel/boards/bytcr_rt5651.c
>>>> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
>>>> @@ -31,11 +31,76 @@
>>>>  #include "../../codecs/rt5651.h"
>>>>  #include "../atom/sst-atom-controls.h"
>>>>
>>>> +#define CHT_PLAT_CLK_3_HZ       19200000
>>>> +#define CHT_CODEC_DAI_5651   "rt5651-aif1"
>>>> +
>>>> +struct cht_acpi_card {
>>>> +       char *codec_id;
>>>> +       int codec_type;
>>>> +       struct snd_soc_card *soc_card;
>>>> +};
>>>> +
>>>> +struct cht_mc_private {
>>>> +       struct snd_soc_jack jack;
>>>> +       struct cht_acpi_card *acpi_card;
>>>> +};
>>>> +
>>>> +
>>>> +static inline struct snd_soc_dai *cht_get_codec_dai(struct
>>>> snd_soc_card *card)
>>>> +{
>>>> +       struct snd_soc_pcm_runtime *rtd;
>>>> +
>>>> +       list_for_each_entry(rtd, &card->rtd_list, list) {
>>>> +               if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI_5651,
>>>> +                         strlen(CHT_CODEC_DAI_5651)))
>>>> +                       return rtd->codec_dai;
>>>> +       }
>>>> +       return NULL;
>>>> +}
>>>> +
>>>> +static int platform_clock_control(struct snd_soc_dapm_widget *w,
>>>> +               struct snd_kcontrol *k, int  event)
>>>> +{
>>>> +       struct snd_soc_dapm_context *dapm = w->dapm;
>>>> +       struct snd_soc_card *card = dapm->card;
>>>> +       struct snd_soc_dai *codec_dai;
>>>> +       int ret;
>>>> +
>>>> +       codec_dai = cht_get_codec_dai(card);
>>>> +       if (!codec_dai) {
>>>> +               dev_err(card->dev, "Codec dai not found; Unable to set
>>>> platform clock\n");
>>>> +               return -EIO;
>>>> +       }
>>>> +
>>>> +       if (!SND_SOC_DAPM_EVENT_OFF(event))
>>>> +               return 0;
>>>> +
>>>> +       /* Set codec sysclk source to its internal clock because codec
>>>> PLL will
>>>> +        * be off when idle and MCLK will also be off by ACPI when
>>>> codec is
>>>> +        * runtime suspended. Codec needs clock for jack detection and
>>>> button
>>>> +        * press.
>>>> +        */
>>>> +       ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_RCCLK,
>>>> +                       0, SND_SOC_CLOCK_IN);
>>>> +       if (ret < 0) {
>>>> +               dev_err(card->dev, "can't set codec sysclk: %d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +
>>>> +
>>>> +
>>>>  static const struct snd_soc_dapm_widget byt_rt5651_widgets[] = {
>>>>         SND_SOC_DAPM_HP("Headphone", NULL),
>>>>         SND_SOC_DAPM_MIC("Headset Mic", NULL),
>>>>         SND_SOC_DAPM_MIC("Internal Mic", NULL),
>>>>         SND_SOC_DAPM_SPK("Speaker", NULL),
>>>> +       SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
>>>> +                       platform_clock_control, SND_SOC_DAPM_POST_PMD),
>>>> +
>>>>  };
>>>>
>>>>  static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
>>>> @@ -52,6 +117,9 @@ static const struct snd_soc_dapm_route
>>>> byt_rt5651_audio_map[] = {
>>>>         {"Headphone", NULL, "HPOR"},
>>>>         {"Speaker", NULL, "LOUTL"},
>>>>         {"Speaker", NULL, "LOUTR"},
>>>> +       {"Headphone", NULL, "Platform Clock"},
>>>> +       {"Speaker", NULL, "Platform Clock"},
>>>> +
>>>>  };
>>>>
>>>>  static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic1_map[] =
>>>> {
>>>> @@ -93,7 +161,13 @@ static int byt_rt5651_aif1_hw_params(struct
>>>> snd_pcm_substream *substream,
>>>>         struct snd_soc_dai *codec_dai = rtd->codec_dai;
>>>>         int ret;
>>>>
>>>> -       snd_soc_dai_set_bclk_ratio(codec_dai, 50);
>>>> +       /* set codec PLL source to the 19.2MHz platform clock (MCLK) */
>>>> +       ret = snd_soc_dai_set_pll(codec_dai, 0, RT5651_PLL1_S_MCLK,
>>>> +                                 CHT_PLAT_CLK_3_HZ,
>>>> params_rate(params) * 512);
>>>> +       if (ret < 0) {
>>>> +               dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>>
>>>>         ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_PLL1,
>>>>                                      params_rate(params) * 512,
>>>> @@ -103,14 +177,6 @@ static int byt_rt5651_aif1_hw_params(struct
>>>> snd_pcm_substream *substream,
>>>>                 return ret;
>>>>         }
>>>>
>>>> -       ret = snd_soc_dai_set_pll(codec_dai, 0, RT5651_PLL1_S_BCLK1,
>>>> -                                 params_rate(params) * 50,
>>>> -                                 params_rate(params) * 512);
>>>> -       if (ret < 0) {
>>>> -               dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
>>>> -               return ret;
>>>> -       }
>>>> -
>>>>         return 0;
>>>>  }
>>>>
>>>>
>>>>
>>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
>
