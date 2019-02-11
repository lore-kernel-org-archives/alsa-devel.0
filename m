From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: PCM: check if ops are defined before
 suspending PCM
Date: Mon, 11 Feb 2019 10:59:49 -0600
Message-ID: <b19ec392-4385-a2b6-9809-1ed7267db2ec@linux.intel.com>
References: <20190208232953.7266-1-pierre-louis.bossart@linux.intel.com>
 <s5hwom971m9.wl-tiwai@suse.de>
 <339832c2-0072-34c7-3a11-29999969662b@linux.intel.com>
 <s5hlg2m5n0d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A45C6267418
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2019 17:59:51 +0100 (CET)
In-Reply-To: <s5hlg2m5n0d.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>>>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>>>> index 818dff1de545..b6e158ce6650 100644
>>>> --- a/sound/core/pcm_native.c
>>>> +++ b/sound/core/pcm_native.c
>>>> @@ -1506,6 +1506,14 @@ int snd_pcm_suspend_all(struct snd_pcm *pcm)
>>>>    			/* FIXME: the open/close code should lock this as well */
>>>>    			if (substream->runtime == NULL)
>>>>    				continue;
>>>> +
>>>> +			/*
>>>> +			 * Skip BE dai link PCM's that are internal and may
>>>> +			 * not have their substream ops set.
>>>> +			 */
>>>> +			if (!substream->ops)
>>>> +				continue;
>>>> +
>>>>    			err = snd_pcm_suspend(substream);
>>>>    			if (err < 0 && err != -EBUSY)
>>>>    				return err;
>>> Basically it's OK and safe to apply this check.  We may need to add
>>> such sanity checks in more places if this really hits.
>>>
>>> But I still wonder how this can go through.  Is substream->runtime set
>>> even if substream->ops is NULL?  The substream->runtime is assigned
>>> dynamically at opening a substream via snd_pcm_attach_substream(), so
>>> without opening it, it must be NULL.
>> This error case was exposed when we tried to get rid of
>> snd_pcm_suspend() per your recommendation, and use snd_soc_suspend()
>> instead to do the work for us.
>>
>> In the case of back-ends, all initializations are bypassed in
>> soc_new_pcm() - see below a code snippet - and the ops aren't set
>> before suspend is called.
>> The complete thread where we discussed this is at
>> https://github.com/thesofproject/linux/pull/582
> Thanks, now I took a look at the code.  And, this surfaced that the
> another part of the problem is that DPCM does the substream open
> handling by itself in soc-pcm.c.  Oh well.  I'm afraid that we have
> some hidden bugs there that may lead to a crash easily.  (Fortunately
> (or unfortunately) fuzzer isn't performed on ASoC because we have no
> virtual device driver :)
>
> IMO, some of DPCM code should be raised to the upper level, to ALSA
> PCM core.  The current code is still in a rough form of early
> plumbing.

Can't disagree, we were surprised to hit this issue knowing that the SOF 
code isn't the first to use DPCM at all (same with some topology 
issues). It's very likely that there are specific initialization flows 
that aren't quite right, hopefully we'll fix them one after the other :-)

>
> In anyway, I merged the patch now with a bit more comments.
>
>
> Thanks!
>
> Takashi

Thanks for the review+additional comments, much appreciated.
