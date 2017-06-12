From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: core: let low-level driver or
 userspace disable rewinds
Date: Mon, 12 Jun 2017 06:57:29 -0500
Message-ID: <4c337eb7-5f41-5c87-e572-3b891b9e9ee4@linux.intel.com>
References: <1497245230-18436-1-git-send-email-subhransu.s.prusty@intel.com>
 <d79788a1-8e96-7d99-28b5-0500c3c17c5b@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ECEB2669FF
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 16:03:29 +0200 (CEST)
In-Reply-To: <d79788a1-8e96-7d99-28b5-0500c3c17c5b@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/12/17 1:50 AM, Clemens Ladisch wrote:
> Subhransu S. Prusty wrote:
>> Add new hw_params flag to explicitly tell driver that rewinds will never
>> be used. [...]
>
>> +++ b/sound/core/pcm_native.c
>> @@ -2521,6 +2523,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
>>  	if (frames == 0)
>>  		return 0;
>>
>> +	if (runtime->no_rewinds)
>> +		return 0;
>
> Doing a rewind when you've promised not to is an error.  So why doesn't
> this return an error code?

there were earlier patches where we switched from 0 to an error code 
based on Takashi's feedback. I am not that convinced that applications 
actually interpret signed frames as error codes and might interpret 
negative values literally, but I am not going to lay on the tracks on 
this one. If we do move to error codes then we might want to update the 
documentation to make the behavior self-explanatory.
