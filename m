From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: pxa: remove clock divider and pll
 setup from zylonite and magician
Date: Mon, 16 Jul 2018 08:19:51 +0200
Message-ID: <6bc549d0-51a9-e39f-1220-6a67355cd136@zonque.org>
References: <20180713160717.4862-1-daniel@zonque.org>
 <87a7qs9rpp.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id EDF3C2673C7
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 08:19:52 +0200 (CEST)
In-Reply-To: <87a7qs9rpp.fsf@belgarion.home>
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
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sunday, July 15, 2018 10:20 PM, Robert Jarzmik wrote:
> Daniel Mack <daniel@zonque.org> writes:
> 
>> The SSP DAI now handles the clocking setup itself, all it needs is the
>> master clock frequency. Remove the code from Zylonite and Magician
>> platforms.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
>>   sound/soc/pxa/magician.c | 105 +--------------------------------------
>>   sound/soc/pxa/zylonite.c |   9 ----
>>   2 files changed, 1 insertion(+), 113 deletions(-)
>>
>> diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
>> index 2fc012b06c43..2746725a898c 100644
>> --- a/sound/soc/pxa/magician.c
>> +++ b/sound/soc/pxa/magician.c
>> @@ -90,95 +90,9 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
>>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>   	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> -	unsigned int acps, acds, width;
>> -	unsigned int div4 = PXA_SSP_CLK_SCDB_4;
>> +	unsigned int width;
>>   	int ret = 0;
>>   
>> -	width = snd_pcm_format_physical_width(params_format(params));
> Ok so width is not initialized anymore ...
> Either it is used and an assignement should be there somewhere, or it is not
> used and the declaration is not necessary .
> 
> Or width is assigned in a former patch I didn't apply and I don't see it in my
> branch ...

Thanks for spotting this! You're right, I was a bit overzealous in my 
cleanups. I'll bring back the assignment and resend.


Thanks,
Daniel
