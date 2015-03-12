From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add suspend_pre and
 resume_post for Braswell snd_soc_card
Date: Thu, 12 Mar 2015 20:42:55 +0800
Message-ID: <550189CF.6020304@linux.intel.com>
References: <1426045713-1738-1-git-send-email-yao.jin@linux.intel.com>
 <20150311125047.GD28806@sirena.org.uk> <5500E346.8020700@linux.intel.com>
 <ABFD875FF5FB574BA706497D987D48D701059B20@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C20EB26068A
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 13:43:02 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701059B20@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: "mengdong.lin@intel.com" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "subhransu.s.prusty@intel.com" <subhransu.s.prusty@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Bard, Mark,

I pull the for-next branch right now and I can see the following rt5670
patches have been integrated.

66454b3 ASoC: rt5670: Replace w->codec snd_soc_dapm_to_codec(w->dapm)
cc3c340 ASoC: rt5670: export jack suspend/resume APIs
d3ef705 ASoC: rt5670: Add IRQ function

Then I build the for-next branch with my patches (reverted before):

ASoC: Intel: Add suspend_pre and resume_post for Braswell snd_soc_card
ASoC: Intel: move the jack creation to Braswell machine driver

The build is successful. So it looks we don't need to resend the patch
series, just re-applying my patches should be OK.

Thanks
Jin Yao

On 2015/3/12 10:38, Bard Liao wrote:
>> -----Original Message-----
>> From: Jin, Yao [mailto:yao.jin@linux.intel.com]
>> Sent: Thursday, March 12, 2015 8:52 AM
>> To: Mark Brown
>> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
>> mengdong.lin@intel.com; subhransu.s.prusty@intel.com; Bard Liao
>> Subject: Re: [PATCH] ASoC: Intel: Add suspend_pre and resume_post for
>> Braswell snd_soc_card
>>
>> Hi Mark, Bard,
>>
>> This patch has dependency on Bard's patch "ASoC: rt5670: export jack
>> suspend/resume APIs". I pull the Mark's for-next branch right now and I
>> can see Bard's patch "ASoC: rt5670: export jack suspend/resume APIs" has
>> been integrated.
> 
> I think we should send the dependency patches in a series.
> 
>> function 'snd_soc_card_jack_new' [-Werror=implicit-function-declaration]
>>             ret = snd_soc_card_jack_new(runtime->card, "Headset",
>>             ^
> 
> I think it is due to Lars-Peter's "ASoC: simple-card: Register jacks at
> the card level" patch is not applied on branch topic/intel.
> 
>>
>> So there now is only one build error in rt5670.c:
>>
>> sound/soc/codecs/rt5670.c: In function 'is_sys_clk_from_pll':
>> sound/soc/codecs/rt5670.c:702:38: error: 'struct snd_soc_dapm_widget'
>> has no member named 'codec'
>>   struct snd_soc_codec *codec = source->codec;
>>                                       ^
>> After I fix it with my change as following, the build is successful.
>>
>> --- a/sound/soc/codecs/rt5670.c
>> +++ b/sound/soc/codecs/rt5670.c
>> @@ -699,7 +699,7 @@ static int set_dmic_clk(struct
>> snd_soc_dapm_widget *w,  static int is_sys_clk_from_pll(struct
>> snd_soc_dapm_widget *source,
>>                          struct snd_soc_dapm_widget *sink)  {
>> -       struct snd_soc_codec *codec = source->codec;
>> +       struct snd_soc_codec *codec =
>> + snd_soc_dapm_to_codec(source->dapm);
>>         struct rt5670_priv *rt5670 =
>> snd_soc_codec_get_drvdata(codec);
>>
>>         if (rt5670->sysclk_src == RT5670_SCLK_S_PLL1)
>>
>> Could Bard take a look at it?
> 
> It is already in Lars-Peter's "ASoC: rt5670: Replace w->codec
> snd_soc_dapm_to_codec(w->dapm)" patch
> 
>>
>> For my patch, the build is successful.
>>
>> ASoC: Intel: Add suspend_pre and resume_post for Braswell snd_soc_card
>> ASoC: Intel: move the jack creation to Braswell machine driver
>>
>> Thanks
>> Jin Yao
>>
>> On 2015/3/11 20:50, Mark Brown wrote:
>>> On Wed, Mar 11, 2015 at 11:48:33AM +0800, Jin Yao wrote:
>>>> On Braswell, we need to add some machine specific setting before
>>>> suspend and after resume. For example, disable/enable jack detection
>>>> in codec so use snd_soc_card suspend_pre and resume_post ops for
>> this purpose.
>>>
>>> Reverted since it doesn't build!
>>>
>>
>> ------Please consider the environment before printing this e-mail.
