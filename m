From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [question about DPCM] dpcm_be_disconnect race
	condition
Date: Thu, 28 Aug 2014 10:07:14 +0800
Message-ID: <53FE8ED2.80701@marvell.com>
References: <53FD9384.3020501@marvell.com>
 <20140827185225.GQ17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 18BB52659FA
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 04:07:24 +0200 (CEST)
In-Reply-To: <20140827185225.GQ17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Xin Qian <xqian@marvell.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On 08/28/2014 02:52 AM, Mark Brown wrote:
> On Wed, Aug 27, 2014 at 04:15:00PM +0800, Qiao Zhou wrote:
>> Hi Liam, Mark
>>
>> I'm developing audio with DPCM on one phone platform, and met one kernel
>> panic issue related with dpcm_be_connect. Could you please help to suggest?
>
> Adding Liam.
>
>> Taking audio playback for example:
>> 1. User space writes all the data into audio buffer. When the blocking write
>> returns, it closes audio path(which updates dapm and triggers
>> soc_dpcm_runtime_update).
>> 2. When user space closes audio path, kernel audio driver(DMA) is still
>> transferring data from audio buffer to audio peripheral. So DMA interrupt
>> will come, and the interrupt handler runs on different cpu comparing to
>> which the task to close audio path runs on.
>> 3. Due to system schedule, below case may happen.
>>
>>             cpu0                                      cpu1
>>
>> soc_dapm_mixer_update_power ->        |       DMA interrupt ->
>> soc_dpcm_runtime_update ->            |       snd_pcm_period_elapsed ->
>> dpcm_be_disconnect(old) ->            |       snd_pcm_update_hw_ptr0 ->
>>   __________________________           |       xrun ->
>> |                         |           |       snd_pcm_stop ->
>> |list_del(&dpcm->list_be) |           |       dpcm_fe_dai_trigger ->
>> |list_del(&dpcm->list_fe) |           |       dpcm_be_dai_trigger ->
>> |kfree(dpcm);             |           |       list_for_each_entry(dpcm..
>> |_________________________|           |
>>
>> On CPU1, list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
>> will get dpcm and corresponding be, but there is no protection against the
>> dpcm_be_disconnect on cpu0. Related dpcm for the BE may be invalid/freed
>> when cpu1 tries to access it.
>
>> Should we require user space to make sure audio transfer ends before closing
>> audio path to avoid such issue? I'm not sure if I missed anything or used it
>> wrongly.
>
> Well, it should do that in general if it wants to make sure that the
> audio actually gets played but the kernel should protect against this.
> We should be holding a lock whenever we update the lists.
Thanks a lot for your suggestion! Firstly we'll ask user space app to 
apply this rule currently to avoid such issue.
Currently it holds card->mutex in mutex_lock_nested whenever the list is 
updated. Here list_for_each_entry in snd_pcm_stop may run in interrupt 
context(the bottom half of tasklet), so it can not use this mutex 
simply. Is there any other way to protect it?
>
>> Thanks in advance!
>> --
>>
>> Best Regards
>> Qiao
>>
-- 

Best Regards
Qiao
