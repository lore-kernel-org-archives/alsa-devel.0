From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
 mode support
Date: Wed, 22 Aug 2018 21:25:58 -0500
Message-ID: <73a0095c-b58c-366b-424b-c2c518fd6f70@linux.intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
 <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
 <1534985162.3235.50.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 83030267663
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 04:26:08 +0200 (CEST)
In-Reply-To: <1534985162.3235.50.camel@intel.com>
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



On 08/22/2018 07:46 PM, Guedes, Andre wrote:
> Hi Pierre,
>
> On Tue, 2018-08-21 at 17:51 -0500, Pierre-Louis Bossart wrote:
>>>>> +static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
>>>>> +{
>>>>> +	int res;
>>>>> +	struct timespec now;
>>>>> +	struct itimerspec itspec;
>>>>> +	snd_pcm_ioplug_t *io = &aaf->io;
>>>>> +
>>>>> +	res = clock_gettime(CLOCK_REF, &now);
>>>>> +	if (res < 0) {
>>>>> +		SNDERR("Failed to get time from clock");
>>>>> +		return -errno;
>>>>> +	}
>>>>> +
>>>>> +	aaf->mclk_period = (NSEC_PER_SEC * aaf-
>>>>>> frames_per_pkt) /
>>>>> io->rate;
>>>> is this always an integer? If not, don't you have a systematic
>>>> arithmetic error?
>>> NSEC_PER_SEC is 64-bit so I don't see an arithmetic error during
>>> calculation (e.g. integer overflow). Not sure this was your
>>> concern,
>>> though. Let me know otherwise.
>> No, I was talking about the fractional part, e.g with 256 frames
>> with
>> 44.1kHz you have a period of 5804988.662131519274376 - so your math
>> adds
>> a truncation. same with 48khz, the fractional part is .333
>>
>> I burned a number of my remaining neurons chasing a <100 ppb error
>> which
>> led to underruns after 10 hours, so careful now with truncation...
> Thanks for clarifying.
>
> Yes, we can end up having a fractional period which is truncated. Note
> that both 'frames' and 'rate' are configured by the user. The user
> should set 'frames' as multiple of 'rate' whenever possible to avoid
> inaccuracy.
It's unlikely to happen. it's classic in audio that people want powers 
of two for fast filtering, and don't really care that the periods are 
fractional. If you cannot guarantee long-term operation without timing 
issues, you should add constraints to the frames and rates so that there 
is no surprise.

>
>  From the plugin perspective, I'm not sure what we could do. Truncating
> might lead to underruns as you said, but I'm afraid that rounding up
> might lead to overruns, theoretically.
Yes, you don't want to round-up either, you'd want to track when 
deviations become too high and compensate for it.

>
>>>>> +static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct
>>>>> pollfd
>>>>> *pfd,
>>>>> +			    unsigned int nfds, unsigned short
>>>>> *revents)
>>>>> +{
>>>>> +	int res;
>>>>> +	snd_pcm_aaf_t *aaf = io->private_data;
>>>>> +
>>>>> +	if (nfds != FD_COUNT_PLAYBACK)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	if (pfd[0].revents & POLLIN) {
>>>>> +		res = aaf_mclk_timeout_playback(aaf);
>>>>> +		if (res < 0)
>>>>> +			return res;
>>>>> +
>>>>> +		*revents = POLLIN;
>>>>> +	}
>>>> I couldn't figure out how you use playback events and your timer.
>>> Every time aaf->timer_fd expires, the audio buffer is consumed by
>>> the
>>> plugin, making some room available on the buffer. So here a POLLIN
>>> event is returned so alsa-lib layer can copy more data into the
>>> audio
>>> buffer.
>>>
>>>> When there are two audio clock sources or timers that's usually
>>>> where
>>>> the fun begins.
>>> Regarding scenarios with two audio clock sources or timers, the
>>> plugin
>>> doesn't support them at the moment. This is something we should
>>> work on
>>> once the basic functionality is pushed upstream.
>> I was talking about adjusting the relationship between your
>> CLOCK_REALTIME timer and the media/network clock. I don't quite get
>> how
>> this happens, I vaguely recall there should be a daemon which tracks
>> the
>> difference between local and media/network clock, and I don't see it
>> here.
> Oh okay, I thought you were talking about something else :)
>
> I believe you are referring to the gptp daemon from Openavnu [1]. The
> AAF plugin doesn't use it. Instead, it uses linuxptp [2] which is
> distributed by several Linux distros.
>
> Linuxptp provides the phc2sys daemon that synchronizes both system
> clock (i.e. CLOCK_REALTIME) and network clock (i.e. PTP clock). The
> daemon disciplines the clocks instead of providing the time difference
> to applications. So we don't need to do any cross-timestamping at the
> plugin.
Humm, I don't get this. The CLOCK_REALTIME is based on the local 
oscillator + NTP updates. And the network clock isn't necessarily owned 
by the transmitter, so how do you adjust?
