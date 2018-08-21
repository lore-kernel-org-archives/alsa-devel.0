From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
 mode support
Date: Tue, 21 Aug 2018 17:51:04 -0500
Message-ID: <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 593D3267657
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 00:51:11 +0200 (CEST)
In-Reply-To: <1534888610.4547.104.camel@intel.com>
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
To: "Guedes, Andre" <andre.guedes@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


>>> +static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
>>> +{
>>> +	int res;
>>> +	struct timespec now;
>>> +	struct itimerspec itspec;
>>> +	snd_pcm_ioplug_t *io = &aaf->io;
>>> +
>>> +	res = clock_gettime(CLOCK_REF, &now);
>>> +	if (res < 0) {
>>> +		SNDERR("Failed to get time from clock");
>>> +		return -errno;
>>> +	}
>>> +
>>> +	aaf->mclk_period = (NSEC_PER_SEC * aaf->frames_per_pkt) /
>>> io->rate;
>>
>> is this always an integer? If not, don't you have a systematic
>> arithmetic error?
> 
> NSEC_PER_SEC is 64-bit so I don't see an arithmetic error during
> calculation (e.g. integer overflow). Not sure this was your concern,
> though. Let me know otherwise.

No, I was talking about the fractional part, e.g with 256 frames with 
44.1kHz you have a period of 5804988.662131519274376 - so your math adds 
a truncation. same with 48khz, the fractional part is .333

I burned a number of my remaining neurons chasing a <100 ppb error which 
led to underruns after 10 hours, so careful now with truncation...

> 
>>> +static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd
>>> *pfd,
>>> +			    unsigned int nfds, unsigned short
>>> *revents)
>>> +{
>>> +	int res;
>>> +	snd_pcm_aaf_t *aaf = io->private_data;
>>> +
>>> +	if (nfds != FD_COUNT_PLAYBACK)
>>> +		return -EINVAL;
>>> +
>>> +	if (pfd[0].revents & POLLIN) {
>>> +		res = aaf_mclk_timeout_playback(aaf);
>>> +		if (res < 0)
>>> +			return res;
>>> +
>>> +		*revents = POLLIN;
>>> +	}
>>
>> I couldn't figure out how you use playback events and your timer.
> 
> Every time aaf->timer_fd expires, the audio buffer is consumed by the
> plugin, making some room available on the buffer. So here a POLLIN
> event is returned so alsa-lib layer can copy more data into the audio
> buffer.
> 
>> When there are two audio clock sources or timers that's usually where
>> the fun begins.
> 
> Regarding scenarios with two audio clock sources or timers, the plugin
> doesn't support them at the moment. This is something we should work on
> once the basic functionality is pushed upstream.

I was talking about adjusting the relationship between your 
CLOCK_REALTIME timer and the media/network clock. I don't quite get how 
this happens, I vaguely recall there should be a daemon which tracks the 
difference between local and media/network clock, and I don't see it here.

> 
> Thank you for your feedback.
> 
> Regards,
> 
> Andre
> 
