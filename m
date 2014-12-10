From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH RFC 6/9] ALSA: core: pass audio tstamp
 config from userspace
Date: Wed, 10 Dec 2014 11:35:42 -0600
Message-ID: <5488846E.1050202@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>	<1418077426-8309-7-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hiohjmn1m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DFAEB2605A3
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 18:35:44 +0100 (CET)
In-Reply-To: <s5hiohjmn1m.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/10/14, 11:28 AM, Takashi Iwai wrote:
> At Mon,  8 Dec 2014 16:23:43 -0600,
> Pierre-Louis Bossart wrote:
>>
>> Let userspace select audio timestamp config, ignore and zero all
>> other fields
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/core/pcm_native.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>> index 37a7137..7dcd6bd 100644
>> --- a/sound/core/pcm_native.c
>> +++ b/sound/core/pcm_native.c
>> @@ -706,6 +706,7 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
>>   	struct snd_pcm_runtime *runtime = substream->runtime;
>>
>>   	snd_pcm_stream_lock_irq(substream);
>> +	memset(status, 0, sizeof(*status));
>
> This memset() can be outside the lock.
>
>>   	status->state = runtime->status->state;
>>   	status->suspended_state = runtime->status->suspended_state;
>>   	if (status->state == SNDRV_PCM_STATE_OPEN)
>> @@ -757,7 +758,8 @@ static int snd_pcm_status_user(struct snd_pcm_substream *substream,
>>   	struct snd_pcm_status status;
>>   	int res;
>>   	
>> -	memset(&status, 0, sizeof(status));
>> +	if (copy_from_user(&status, _status, sizeof(status)))
>> +		return -EFAULT;
>>   	res = snd_pcm_status(substream, &status);
>
> You're clearing the data at the beginning of snd_pcm_status(), so it
> doesn't make sense to do copy_from_user().
>
> In anyway, I prefer passing the extra argument for the parameter user
> may set instead of initializing the whole struct beforehand.
> snd_pcm_status() is called only internally, so it's no big problem to
> change the arguments.

Did you mean something like this, only read the relevant field from the 
larger structure?

	if (copy_from_user(&audio_tstamp_data, _status.audio_tstamp_data, 
sizeof(int)))
		return -EFAULT;
  	res = snd_pcm_status(substream, &status, audio_tstamp_data);
