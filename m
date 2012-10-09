From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/3] ALSA: core: add hooks for
	audio	timestamps
Date: Tue, 09 Oct 2012 18:50:17 -0500
Message-ID: <5074B839.9080306@linux.intel.com>
References: <1349716318-2649-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1349716318-2649-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5h1uh8gfc2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 45E1F264FEA
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 01:50:19 +0200 (CEST)
In-Reply-To: <s5h1uh8gfc2.wl%tiwai@suse.de>
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

On 10/09/2012 04:33 AM, Takashi Iwai wrote:
>> +	struct timespec audio_tstamp;
>
> It must be struct compat_timespec...

ok


>> +	    put_user(status.suspended_state, &src->suspended_state) ||
>> +	    put_user(status.audio_tstamp.tv_sec, &src->audio_tstamp.tv_sec) ||
>> +	    put_user(status.audio_tstamp.tv_nsec, &src->audio_tstamp.tv_nsec))
>
> ... and use compat_put_timespec().

I don't get this. I copy/pasted the code used for regular timestamps. 
Why should it be any different for audio timestamps?

>>   	if (put_user(sstatus.state, &src->s.status.state) ||
>>   	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
>>   	    put_user(sstatus.tstamp.tv_sec, &src->s.status.tstamp.tv_sec) ||
>>   	    put_user(sstatus.tstamp.tv_nsec, &src->s.status.tstamp.tv_nsec) ||
>>   	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
>> +	    put_user(sstatus.audio_tstamp.tv_sec,
>> +		    &src->s.status.audio_tstamp.tv_sec) ||
>> +	    put_user(sstatus.audio_tstamp.tv_nsec,
>> +		    &src->s.status.audio_tstamp.tv_nsec) ||
>
> Ditto.

Again I don't see why I should make a difference between tstamp and 
audio_tstamp? It's really the same type, so either my code is correct or 
the existing code is wrong as well.
All other comments fixed, thanks for the review.
-Pierre
