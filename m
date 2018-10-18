From: Timo Wischer <twischer@de.adit-jv.com>
Subject: Re: [PATCH - Intervals v2 1/1] interval: Interpret (x
 x+1] correctly and return x+1
Date: Thu, 18 Oct 2018 14:28:47 +0200
Message-ID: <81531fd0-2173-c274-5279-a48fdfdf5121@de.adit-jv.com>
References: <1539862404-21955-1-git-send-email-twischer@de.adit-jv.com>
 <s5hbm7rv4wf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id EEB6A2675B5
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 14:28:55 +0200 (CEST)
In-Reply-To: <s5hbm7rv4wf.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/18/18 14:02, Takashi Iwai wrote:
> On Thu, 18 Oct 2018 13:33:24 +0200,
> <twischer@de.adit-jv.com> wrote:
>> From: Timo Wischer <twischer@de.adit-jv.com>
>>
>> Without this change an interval of (x x+1] will be interpreted as an
>> empty interval but the right value would be x+1.
>> This leads to a failing snd_pcm_hw_params() call which returns -EINVAL.
>>
>> An example issue log is given in the following:
>> snd_pcm_hw_params failed with err -22 (Invalid argument)
>> ACCESS: MMAP_NONINTERLEAVED
>> FORMAT: S16_LE
>> SUBFORMAT: STD
>> SAMPLE_BITS: 16
>> FRAME_BITS: 16
>> CHANNELS: 1
>> RATE: 16000
>> PERIOD_TIME: (15999 16000]
>> PERIOD_SIZE: (255 256]
>> PERIOD_BYTES: (510 512]
>> PERIODS: [2 3)
>> BUFFER_TIME: 32000
>> BUFFER_SIZE: 512
>> BUFFER_BYTES: 1024
>>
>> In case of (x x+1) we have to interpret it anyway as a single value of x to
>> compensate rounding issues.
>> For example the period size will result in an interval of (352 353) when
>> the period time is 16ms and the sample rate 22050 Hz
>> (16ms * 22,05 kHz = 352,8 frames). But 352 has to be chosen to allow a
>> buffer size of 705 (32ms * 22,05 kHz = 705,6 frames) which has to be >= 2x
>> period size to avoid Xruns. The buffer size will not end up with an
>> interval of (705 706) simular to the period size because
>> snd_pcm_rate_hw_refine_cchange() calls snd_interval_floor() for the buffer
>> size. Therefore this value will be interpreted as an integer interval
>> instead of a real interval further on.
>>
>> This issue seems to exist since the change of 9bb985c38 ("pcm:
>> snd_interval_refine_first/last: exclude value only if also excluded
>> before")
>>
>> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
>> ---
>>> On 10/18/18 12:57, Takashi Iwai wrote:
>>> This change looks risky.  The snd_interval_value() might be called
>>> even if the interval isn't reduced to a single value.  Rather check
>>> openmin instead.
>> If I would do
>> "if (i->openmin)"
>> on an interval of (x x+1) x+1 would be returned. But this would result in
>> the second issue which I have tried to describe in the commit message:
>> x has to be returned otherwise it is not guaranteed that
>> buffer_size >= 2x period_size. And this would result in continuously Xruns.
>> Therefore I would like to prefer
>> "if (i->openmin && !i->openmax)"
> Hm, I overlooked that there is an assert() before that.  So a
> single-value interval is a must at this execution, so it doesn't
> matter which one to take.
>
> Didn't the assert() hit in your case with x+1, then?
No. For the implementation of

snd_interval_value()
(x x+1) is also a valid interval which has only a single value.
This is also required because the ALSA neogation rules often end up with intervals like (x x+1)
e.g. in case of rounding issues  32ms * 22,05 kHz = 705,6 frames -> (705 706)
Therefore assert(snd_interval_single(i)) has to not fail in case of (705 706).

Best regards
Timo

>
>
> Takashi
>
>> diff --git a/src/pcm/interval_inline.h b/src/pcm/interval_inline.h
>> index a68e292..d9a30b2 100644
>> --- a/src/pcm/interval_inline.h
>> +++ b/src/pcm/interval_inline.h
>> @@ -51,12 +51,14 @@ INTERVAL_INLINE int snd_interval_single(const snd_interval_t *i)
>>   {
>>   	assert(!snd_interval_empty(i));
>>   	return (i->min == i->max ||
>> -		(i->min + 1 == i->max && i->openmax));
>> +		(i->min + 1 == i->max && (i->openmin || i->openmax)));
>>   }
>>   
>>   INTERVAL_INLINE int snd_interval_value(const snd_interval_t *i)
>>   {
>>   	assert(snd_interval_single(i));
>> +	if (i->openmin && !i->openmax)
>> +		return i->max;
>>   	return i->min;
>>   }
>>   
>> -- 
>> 2.7.4
>>
