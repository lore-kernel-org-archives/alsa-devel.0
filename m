From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] ALSA: core: let low-level driver or
 userspace disable rewinds
Date: Mon, 12 Jun 2017 20:44:19 +0200
Message-ID: <abe002a6-af72-124d-9b6e-04d1ccfe3369@ladisch.de>
References: <1497245230-18436-1-git-send-email-subhransu.s.prusty@intel.com>
 <d79788a1-8e96-7d99-28b5-0500c3c17c5b@ladisch.de>
 <4c337eb7-5f41-5c87-e572-3b891b9e9ee4@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 7253C266EAF
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 20:46:19 +0200 (CEST)
Received: from [192.168.42.84] (tmo-126-127.customers.d1-online.com
 [80.187.126.127])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 97AF85580F57
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 20:46:18 +0200 (CEST)
In-Reply-To: <4c337eb7-5f41-5c87-e572-3b891b9e9ee4@linux.intel.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> On 6/12/17 1:50 AM, Clemens Ladisch wrote:
>> Subhransu S. Prusty wrote:
>>> Add new hw_params flag to explicitly tell driver that rewinds will never
>>> be used. [...]
>>
>>> +++ b/sound/core/pcm_native.c
>>> @@ -2521,6 +2523,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
>>>      if (frames == 0)
>>>          return 0;
>>>
>>> +    if (runtime->no_rewinds)
>>> +        return 0;
>>
>> Doing a rewind when you've promised not to is an error.  So why doesn't
>> this return an error code?
>
> there were earlier patches where we switched from 0 to an error code
> based on Takashi's feedback. I am not that convinced that applications
> actually interpret signed frames as error codes and might interpret
> negative values literally

When the application has set SND_PCM_HW_PARAMS_NO_REWINDS, calling
snd_pcm_rewind() already is an error to begin with.  There's no point
in trying to make it work, you can just choose how it breaks.


Regards,
Clemens
