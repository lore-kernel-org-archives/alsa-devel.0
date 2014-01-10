From: Nenghua Cao <nhcao@marvell.com>
Subject: Re: [PATCH] ASoC: dpcm: don't do hw_param when BE has
 done	hw_param
Date: Fri, 10 Jan 2014 19:21:34 +0800
Message-ID: <52CFD7BE.5030907@marvell.com>
References: <1389332195-15900-1-git-send-email-nhcao@marvell.com>
 <s5htxdcxg0q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 049F92602F3
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 12:18:18 +0100 (CET)
In-Reply-To: <s5htxdcxg0q.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/10/2014 06:55 PM, Takashi Iwai wrote:
> [Corrected mail addresses of both Mark and Liam]
> 
Hi, Takashi:
Thanks for correcting my mistake.
> At Fri, 10 Jan 2014 13:36:35 +0800,
> Nenghua Cao wrote:
>>
>> From: Nenghua Cao <nhcao@marvell.com>
>>
>>     It fixes the following case:
>>     Two FEs connects the same BE; FE1 & BE path has been opened and hw_paramed.
>> At this momment, FE2 & BE path is being opened and hw_paramed. The BE
>> dai will do hw_param again even if it has done hw_param. It is not
>> reasonable.
>> FE1------------>BE
>> FE2-------------^
> 
> What happens if FE2 tries to set up an incompatible hw_params?
> (Through a quick glance, it won't work properly well, too, though...)
> 
If FE2 uses an incompatible param, it will make FE1 doesn't work. Maybe
FE2 works well.
If FE2 uses the same param, BE hw_param function will be called twice
(This is the most happening case).
So we can't get benefits from it.
> 
> Takashi
> 
>>
>> Signed-off-by: Nenghua Cao <nhcao@marvell.com>
>> ---
>>  sound/soc/soc-pcm.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>> index 891b9a9..ec07e37 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -1339,7 +1339,6 @@ static int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
>>  			continue;
>>  
>>  		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN) &&
>> -		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
>>  		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE))
>>  			continue;
>>  
>> -- 
>> 1.7.0.4
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
