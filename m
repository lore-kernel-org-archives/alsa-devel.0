From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH] ASoC: cs4265: Add a MIC pre. switch
Date: Fri, 7 Sep 2018 20:18:05 +1000
Message-ID: <dc95df9e-e256-863a-3e53-ba18a2366143@flatmax.org>
References: <20180907032729.26532-1-flatmax@flatmax.org>
 <20180907082626.GF1653@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DAD526777B
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 12:18:13 +0200 (CEST)
In-Reply-To: <20180907082626.GF1653@imbe.wolfsonmicro.main>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, brian.austin@cirrus.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org



On 07/09/18 18:26, Charles Keepax wrote:
> On Fri, Sep 07, 2018 at 01:27:29PM +1000, Matt Flax wrote:
>> This patch adds a MIC preamp enable switch as a SOC_SINGLE.
>>
>> Signed-off-by: Matt Flax <flatmax@flatmax.org>
>> ---
>>   sound/soc/codecs/cs4265.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
>> index d9eebf6a..03476f93 100644
>> --- a/sound/soc/codecs/cs4265.c
>> +++ b/sound/soc/codecs/cs4265.c
>> @@ -161,6 +161,7 @@ static const struct snd_kcontrol_new cs4265_snd_controls[] = {
>>   	SOC_SINGLE("MMTLR Data Switch", CS4265_SPDIF_CTL2, 0, 1, 0),
>>   	SOC_ENUM("Mono Channel Select", spdif_mono_select_enum),
>>   	SND_SOC_BYTES("C Data Buffer", CS4265_C_DATA_BUFF, 24),
>> +	SOC_SINGLE("MIC Preamp", CS4265_PWRCTL, 3, 1, 1),
>>   };
> Is this the correct way to control this bit? There is already
> a SND_SOC_DAPM_PGA widget called "Pre-amp MIC" that controls
> the bit, it looks like this widget is not connected to the
> rest of the DAPM graph. Should we just be hooking that widget
> up instead?  The datasheet isn't abundantly clear but it looks
> like the bit needs to be set whenever the mic is in use:
>
> "The microphone preamplifier block will enter a low-power state
> whenever this bit is set."
>
> Which would really make DAPM a better fit, unless there are valid
> use-cases for using the mic with the preamp powered down?
>
>

Agreed, when you switch to the MIC rather then LINEIN it should be 
turned on.

This is the DAPM_MUX :
https://github.com/torvalds/linux/blob/master/sound/soc/codecs/cs4265.c#L178
This is the ENUM_SINGLE :
https://github.com/torvalds/linux/blob/master/sound/soc/codecs/cs4265.c#L98

What is the best way to do this ?

Matt
