From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: core: add hooks for audio
 timestamps read from WALLCLOCK
Date: Fri, 15 Jun 2012 05:07:27 -0500
Message-ID: <4FDB095F.5030200@linux.intel.com>
References: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<1339619192-2733-2-git-send-email-pierre-louis.bossart@linux.intel.com>
	<s5hhaueqrob.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id B2D42246A5
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 12:07:29 +0200 (CEST)
In-Reply-To: <s5hhaueqrob.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>
> The biggest problem of struct timespec is that it's pretty much
> arch-dependent.  But since it's used in all other places, we need to
> live with that...
>
> Usually when we add a new field, we don't use union.  Just decrease
> sizeof(struct timespec) from reserved[] size.
>
> No matter whether using union or not, it doesn't mean that the whole
> struct size work is kept.  The field might be aligned since we haven't
> added the packed attribute.  Maybe better to add a padding to align
> 64bit before audio_tstamp, then cross your finger.

Ok, this is the feedback I needed, I had no idea if I could add a new 
field and why exactly the reserved field had to be zeroed out. On the 
first try I had an invalid ioctl error and found this workaround.
Will fix this.


>>   struct snd_pcm_mmap_status {
>> @@ -430,6 +434,7 @@ struct snd_pcm_mmap_status {
>>   	int pad1;			/* Needed for 64 bit alignment */
>>   	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
>>   	struct timespec tstamp;		/* Timestamp */
>> +	struct timespec audio_tstamp;	/* audio wall clock timestamp */
>>   	snd_pcm_state_t suspended_state; /* RO: suspended stream state */
>>   };
>
> struct snd_pcm_mmap_status is mmapped to user-space, thus it must be
> backward compatible.  Always append the new field.

will do.

> In addition, if you change the ABI, please change the PCM protocol
> version, so that alsa-lib can detect the ABI change

ok

> Also, last not but least, don't forget to convert pcm_compat.c.

will look into it

> Other than these, changes look good to me.

Cool, thanks for the feedback.
-Pierre
