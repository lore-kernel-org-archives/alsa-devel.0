From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] pcm: support for audio wallclock
Date: Fri, 15 Jun 2012 05:13:55 -0500
Message-ID: <4FDB0AE3.5030809@linux.intel.com>
References: <1339619267-2782-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<s5hehpiqqui.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id C7632246B5
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 12:13:57 +0200 (CEST)
In-Reply-To: <s5hehpiqqui.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> You need to provide a function to indicate whether htstamp_wallclk is
> available or not.  Since the function returning tstamp_wallclk is a
> void function and it itself can't return the error, user can't know
> whether it's a bogus value or not.

Yes, this was planned but I wasn't sure how to go about it. These types 
of routines usually rely on hw_params, I guess I could query them and 
check the .info field. Not sure if there's another way.
Also maybe I should change the return type to provide -EINVAL is somehow 
the audio timestamp is not available for a specific device (digital 
input as Clemens mentioned)


> And that function should check whether the running PCM protocol
> version is high enough to support the new ABI.
Yep


\
>> +#ifndef DOXYGEN
>> +void INTERNAL(snd_pcm_status_get_htstamp_wallclk)(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr)
>> +#else
>> +void snd_pcm_status_get_htstamp_wallclk(const snd_pcm_status_t *obj, snd_htimestamp_t *ptr)
>> +#endif
>
> I think you can avoid this hack for the new functions.

Ok, I have no idea what I am doing here, just copy-pasted to make it work...
