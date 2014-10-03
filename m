From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: proposal: snd_pcm_start_at()
Date: Fri, 03 Oct 2014 17:24:22 -0500
Message-ID: <542F2216.7050801@linux.intel.com>
References: <1412260460.3891605.174362449.667FB9BE@webmail.messagingengine.com>
 <542D8E3F.4080400@linux.intel.com> <542E8FE4.4080904@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AD2792604CD
 for <alsa-devel@alsa-project.org>; Sat,  4 Oct 2014 00:24:25 +0200 (CEST)
In-Reply-To: <542E8FE4.4080904@eml.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/3/14, 7:00 AM, Tim Cussins wrote:
> Hi Peirre,
>
> On 02/10/14 18:41, Pierre-Louis Bossart wrote:
>> On 10/2/14, 9:34 AM, Tim Cussins wrote:
>>> Hi all,
>>>
>>> I'm Tim: I work at Linn Products Ltd - we make Network Music Players,
>>> amongst other things.
>>>
>>> As you might imagine, synchronised-start is important when multiple
>>> devices on the network are rendering the same audio. We'd be interested
>>> in contributing a small expansion of the alsa-lib API to support
>>> synchronised start.
>>>
>>> Assuming we can synchronise the audio clocks (I'm aware this is not
>>> trivial - It's not the topic of this post), we'd propose something like:
>>>
>>>      int snd_pcm_start_at(snd_pcm_t* pcm, snd_htimestamp_t* tstamp);
>>>
>>> and playback would begin as close to tstamp as possible. If tstamp is in
>>> the past, it would should return an error.
>>>
>>> Recent work by Takashi Iwai enables client code to set the clock type of
>>> timestamps using snd_pcm_sw_params_set_tstamp_type(). This context could
>>> quite naturally extend to tstamp argument of snd_pcm_start_at().
>>>
>>> Before I get stuck into working up the details under the hood, it'd be
>>> good to get some feedback/objections regarding this approach.
>>
>> It's probably better idea to start PCM playback with a bunch of zeroes
>> and then rely on existing timestamping to insert samples at the right
>> location in the ring buffer - which you have to do anyway to compensate
>> for drifts between your network clock and audio clock. This is a more
>> predictable solution that abstracts away all the time needed to arm DMA,
>> FIFOs, etc. The only hardware-dependent variable that would remain is
>> the precision/granularity of the timestamping.
>> -Pierre
>
> Thanks heaps for the feedback :)
>
> Agreed - streaming zeros 'as required' is pretty much the obvious
> solution when confined to the existing API.
>
> So I guess I'll have to show a few more cards from my hand :D
>
> The next iteration of our hardware platform will be accompanied by a
> move to linux, which explains our interest in ALSA for sound delivery.
>
> The pcm hardware for the new platform can start rendering when a compare
> register matches a hw counter (driven by the audio clock). This allows
> for starting with frame-accurate timing.

Interesting. I wonder if you actually need a new extension for this, you 
could write the timestamp in an ALSA control and implement your .trigger 
function by using the contents of the control, i.e. delay the actual 
start. it wouldn't be generic but your hardware isn't either.

> By adding another tstamp_type - let's call it
> SND_PCM_TSTAMP_TYPE_HARDWARE for now - snd_pcm_start_at() could
> internally delegate to the driver (if it supports it, otherwise error)
>
> I take your point about drift, but we're approaching that as a related,
> but orthogonal, problem. As a business we've decided that dropouts are
> unacceptable. Our products have several audio clock sources available,
> one of which is a high-quality VXCO. With an appropriate servo, it will
> track a clock recovered from the incoming stream.

The drift control can be done with ASRC or tweaking the clock, either 
way you need a servo loop based on timestamping info reported by the 
hardware.

> I'm still working through a couple of options for exposing the VXCO
> audio clock to a userspace servo [The linux kernel has the PCH
> framework, for example, which is almost enough, but doesn't dovetail
> with ALSA in an obvious way].

That part would benefit other implementations - whether they have a VCO 
or can do ASRC with a fixed clock. Looking forward to your ideas.

>
> In summary, we'd like to leverage our pcm hardware's ability to start on
> time (hence the chat about snd_pcm_start_at), and we'd also like to
> expose control of the pcm's audio clock in some way (WIP, suggestions
> welcome!).
>
> The clock control stuff is harder, but I wanted to get on the ml with
> something simple, say hi, propose a thing
>
> Thanks for reading - I'll have questions about clock control soon
> enough, see ya then.
>
> Cheers,
> Tim
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
