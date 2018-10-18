From: Timo Wischer <twischer@de.adit-jv.com>
Subject: Re: [PATCH - Intervals v2 1/1] interval: Interpret (x
 x+1] correctly and return x+1
Date: Thu, 18 Oct 2018 17:55:32 +0200
Message-ID: <c376a304-a683-d0aa-30b9-df65f9884644@de.adit-jv.com>
References: <1539862404-21955-1-git-send-email-twischer@de.adit-jv.com>
 <s5hbm7rv4wf.wl-tiwai@suse.de>
 <81531fd0-2173-c274-5279-a48fdfdf5121@de.adit-jv.com>
 <s5hr2gntmt0.wl-tiwai@suse.de>
 <4fb00512-47f2-4a1f-b434-ccec896355e9@de.adit-jv.com>
 <s5h36t3ti74.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C890D26751A
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 17:55:41 +0200 (CEST)
In-Reply-To: <s5h36t3ti74.wl-tiwai@suse.de>
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


Best regards
*Timo Wischer*
Engineering Software Base (ADITG/ESB)

Tel. +49 5121 49 6938
On 10/18/18 16:58, Takashi Iwai wrote:
> On Thu, 18 Oct 2018 16:31:21 +0200,
> Timo Wischer wrote:
>> On 10/18/18 15:19, Takashi Iwai wrote:
>>> On Thu, 18 Oct 2018 14:28:47 +0200,
>>> Timo Wischer wrote:
>>>> On 10/18/18 14:02, Takashi Iwai wrote:
>>>>> On Thu, 18 Oct 2018 13:33:24 +0200,
>>>>> <twischer@de.adit-jv.com> wrote:
>>>>>> From: Timo Wischer <twischer@de.adit-jv.com>
>>>>>>
>>>>>> Without this change an interval of (x x+1] will be interpreted as an
>>>>>> empty interval but the right value would be x+1.
>>>>>> This leads to a failing snd_pcm_hw_params() call which returns -EINVAL.
>>>>>>
>>>>>> An example issue log is given in the following:
>>>>>> snd_pcm_hw_params failed with err -22 (Invalid argument)
>>>>>> ACCESS: MMAP_NONINTERLEAVED
>>>>>> FORMAT: S16_LE
>>>>>> SUBFORMAT: STD
>>>>>> SAMPLE_BITS: 16
>>>>>> FRAME_BITS: 16
>>>>>> CHANNELS: 1
>>>>>> RATE: 16000
>>>>>> PERIOD_TIME: (15999 16000]
>>>>>> PERIOD_SIZE: (255 256]
>>>>>> PERIOD_BYTES: (510 512]
>>>>>> PERIODS: [2 3)
>>>>>> BUFFER_TIME: 32000
>>>>>> BUFFER_SIZE: 512
>>>>>> BUFFER_BYTES: 1024
>>>>>>
>>>>>> In case of (x x+1) we have to interpret it anyway as a single value of x to
>>>>>> compensate rounding issues.
>>>>>> For example the period size will result in an interval of (352 353) when
>>>>>> the period time is 16ms and the sample rate 22050 Hz
>>>>>> (16ms * 22,05 kHz = 352,8 frames). But 352 has to be chosen to allow a
>>>>>> buffer size of 705 (32ms * 22,05 kHz = 705,6 frames) which has to be >= 2x
>>>>>> period size to avoid Xruns. The buffer size will not end up with an
>>>>>> interval of (705 706) simular to the period size because
>>>>>> snd_pcm_rate_hw_refine_cchange() calls snd_interval_floor() for the buffer
>>>>>> size. Therefore this value will be interpreted as an integer interval
>>>>>> instead of a real interval further on.
>>>>>>
>>>>>> This issue seems to exist since the change of 9bb985c38 ("pcm:
>>>>>> snd_interval_refine_first/last: exclude value only if also excluded
>>>>>> before")
>>>>>>
>>>>>> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
>>>>>> ---
>>>>>>> On 10/18/18 12:57, Takashi Iwai wrote:
>>>>>>> This change looks risky.  The snd_interval_value() might be called
>>>>>>> even if the interval isn't reduced to a single value.  Rather check
>>>>>>> openmin instead.
>>>>>> If I would do
>>>>>> "if (i->openmin)"
>>>>>> on an interval of (x x+1) x+1 would be returned. But this would result in
>>>>>> the second issue which I have tried to describe in the commit message:
>>>>>> x has to be returned otherwise it is not guaranteed that
>>>>>> buffer_size >= 2x period_size. And this would result in continuously Xruns.
>>>>>> Therefore I would like to prefer
>>>>>> "if (i->openmin && !i->openmax)"
>>>>> Hm, I overlooked that there is an assert() before that.  So a
>>>>> single-value interval is a must at this execution, so it doesn't
>>>>> matter which one to take.
>>>>>
>>>>> Didn't the assert() hit in your case with x+1, then?
>>>> No. For the implementation of
>>>>
>>>> snd_interval_value()
>>>> (x x+1) is also a valid interval which has only a single value.
>>>> This is also required because the ALSA neogation rules often end up with intervals like (x x+1)
>>>> e.g. in case of rounding issues  32ms * 22,05 kHz = 705,6 frames -> (705 706)
>>>> Therefore assert(snd_interval_single(i)) has to not fail in case of (705 706).
>>> And this is a problematic case no matter which value to take.
>>> Your change might "fix" your specific case, but it might break
>>> others.  No matter which value (min or max) to take, it's basically
>>> invalid.
>>>
>>> If your fix is logically correct, it's fine.  But, judging from the
>>> description, it looks like nothing but heuristic based on your
>>> specific use cases.
>>
>> The reason for this fix was an issue where an interval of (x x+1] is
>> interpreted as not a single value.
>> Before the change in snd_interval_single() the following intervals
>> were interpreted as a single value:
>>
>>   * (x x) -> required for rounding issues e.g. 32ms * 22,05 kHz = 705,6
>>     frames => (705 706)
> Wait... Isn't it (x x+1) at this point?
> Otherwise they can't be a valid value, per definition.


Yes, you are right. May mistake.
I have also no idea why and if these intervals required

  * (x x)
  *

    [x x)

  *

    [x x]

At least snd_interval_checkempty() is interpreting them correctly and 
returning true


>
>>   * (x x]
>>   * [x x)
>>   * [x x]
>>   * (x x+1)
>>   * [x x+1)
>>
>> With this change (x x+1] will also be interpreted as a single value
>> (which looks reasonable for me).
>> But the interval [x x+1] is still not interpreted as a single value
>> (which also sounds right for me)
>>
>> Before the change in snd_interval_value() for all intervals x was returned.
>> With this change only in case (x x+1] x+1 will be returned. All other
>> intervals are not changed.
>>
>> Therefore this is a minimal change which solves issues. I have already
>> at least two use cases which
>> are failing without this fix. (Somehow simple use cases with
>> rate->dmix->hw where the hw truncates
>> the default period_time of 125ms and fails with EINVAL on
>> snd_pcm_set_period_near()).
>> Therefore I would expect that these issues will be seen soon by other users.
>>
>> If there is a use case which breaks in future due to the right
>> interpretation of (x x+1] I think we should try
>> to find the root cause why this (x x+1] interval has to be interpreted
>> wrongly to get the use case to work.
> I'm not against fixing the handling of (x x+1] or (x x+1).
> Although (x x+1) can't be handled correctly at obtaining the exact
> value, often PERIOD_TIME or BUFFER_TIME may reach to this state, so
> allowing it still makes sense.
>
> But what I don't understand is why
>
> snd_interval_value() {
> 	if (openmin)
> 		return min+1;
> 	return min;
> }
>
> doesn't work.  I don't mean that this is better than returning max
> (like your v1 patch), but just want to understand the problem
> correctly.
In the issue case which I had I got a buffer size < 2x period size while 
I have requested 16ms period and 32ms buffer. Unfortunately this results 
in continuously under runs.
The following audio path was used: aplay->rate->dmix->hw. aplay streams 
with 22050 Hz. Therefore we got the following intervals:
period: 16ms * 22,05 kHz = 352,8 frames => (352 353)
buffer: 32ms * 22,05 kHz = 705,6 frames => [705 706]
The buffer size will not end up with an interval of (705 706) similar to 
the period size because snd_pcm_rate_hw_refine_cchange() calls 
snd_interval_floor() for the buffer size. Therefore this value will be 
interpreted as an integer interval (integer flag is set) instead of a 
real interval further on.

With your solution we would use 353 frames for period and 705 frames for 
buffer. Therefore we will get Xruns because 2*353 > 705.

>
>
>>> IOW, if we have a good set of unit tests to cover most of possible use
>>> cases and this is proven to improve all these, I'll happily take it.
>>> But unfortunately there is no good test coverage, so far.
>> At least I have executed several tests on my end which are using
>> different combination of ALSA plugins
>> (plug, rate, dmix, dsnoop), sample rates, channels, period and buffer
>> sizes on different hardware with different
>> sound cards.
>> I would expect that you are talking about the tests in the test
>> directory of the alsa-lib sources. Or is there
>> anything else? May be I could try to extend/add some tests at least to
>> reproduce the issue of this patch.
> I'd think of a test program linked with these functions for executing
> only this configuration stuff without actual plugins.  Then we can
> give a bunch of sets to evaluate the extreme cases.
So you mean only testing the corner cases of the functions of 
src/pcm/interval_inline.h without any other alsa-lib dependencies?
>
>
> thanks,
>
> Takashi
