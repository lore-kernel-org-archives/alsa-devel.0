From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: BE dai needs prepare when
 pause release after resume
Date: Tue, 7 May 2019 08:15:25 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1952837B35@SHSMSX103.ccr.corp.intel.com>
References: <1557038262-26356-1-git-send-email-libin.yang@intel.com>
 <1135262a-0488-3261-e8d3-5e538837ba8d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19484F80726
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 10:15:31 +0200 (CEST)
In-Reply-To: <1135262a-0488-3261-e8d3-5e538837ba8d@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>, "Wang,
 Rander" <rander.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Monday, May 6, 2019 11:08 PM
>To: Yang, Libin <libin.yang@intel.com>; alsa-devel@alsa-project.org;
>broonie@kernel.org
>Cc: Sridharan, Ranjani <ranjani.sridharan@intel.com>; Wang, Rander
><rander.wang@intel.com>
>Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: BE dai needs prepare when
>pause release after resume
>
>On 5/5/19 1:37 AM, libin.yang@intel.com wrote:
>> From: Libin Yang <libin.yang@intel.com>
>>
>> If playback/capture is paused and system enters S3, after system
>> returns from suspend, BE dai needs to call prepare() callback when
>> playback/capture is released from pause.
>
>Libin, this patch was discussed at length on GitHub [1] and the commit
>message does not convey any of the information we looked into. It's not very
>helpful to send such patches to a larger audience without explaining context

Thanks for pointing it out. I will add more context in the patch description.

>and goals. I personally still have no idea of the state machine and if all
>solutions need this or if this is only needed in the case where the
>RESUME_INFO flag is not set.

Let me describe the bug for the reviewers who doesn't know the details.

The patch is trying to fix the below bug:
Playback -> pause -> suspend -> resume -> pause release.

When pause release, playback should continue to play. However
we found playback will quit abnormally.

This is because we should restore the registers after S3.
Currently RESUME_INFO flag is not set, so alsa will call prepare()
callback. But as you can see, dpcm_be_dai_prepare() will block
calling prepare() because it lacks of this patch. This means prepare()
of BE will not be called, which is wrong. 

So this patch adds the judgement to let the driver call the prepare()
if the state is SND_SOC_DPCM_STATE_PAUSED. And the state is
SND_SOC_DPCM_STATE_PAUSED because it is paused. Although
S3 happens before pause release, but the state is still in
SND_SOC_DPCM_STATE_PAUSED based on the code of
dpcm_be_dai_trigger().

If RESUME_INFO flag is not set, prepare() will not be called by alsa
after S3. So the patch is not necessary.

Regards,
Libin

>
>[1] https://github.com/thesofproject/linux/pull/868
>
>
>>
>> Signed-off-by: Libin Yang <libin.yang@intel.com>
>> ---
>>   sound/soc/soc-pcm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c index
>> d2aa560..0888995 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -2471,7 +2471,8 @@ int dpcm_be_dai_prepare(struct
>> snd_soc_pcm_runtime *fe, int stream)
>>
>>   		if ((be->dpcm[stream].state !=
>SND_SOC_DPCM_STATE_HW_PARAMS) &&
>>   		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP)
>&&
>> -		    (be->dpcm[stream].state !=
>SND_SOC_DPCM_STATE_SUSPEND))
>> +		    (be->dpcm[stream].state !=
>SND_SOC_DPCM_STATE_SUSPEND) &&
>> +		    (be->dpcm[stream].state !=
>SND_SOC_DPCM_STATE_PAUSED))
>>   			continue;
>>
>>   		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
>>
