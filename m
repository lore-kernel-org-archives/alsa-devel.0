From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC] AVB - network-based soundcards in ALSA
Date: Tue, 27 May 2014 18:10:40 +0600
Message-ID: <538480C0.5000204@gmail.com>
References: <20140526130352.GA17414@austad.us> <538369F6.4040306@gmail.com>
 <20140527090216.GB20915@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 19C982655AF
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 14:09:46 +0200 (CEST)
Received: by mail-lb0-f179.google.com with SMTP id c11so4855198lbj.38
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 05:09:45 -0700 (PDT)
In-Reply-To: <20140527090216.GB20915@austad.us>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Henrik Austad <henrik@austad.us>
Cc: Takashi Iwai <tiwai@suse.de>, hansverk@cisco.com, alsa-devel@alsa-project.org, haustad@cisco.com
List-Id: alsa-devel@alsa-project.org

27.05.2014 15:02, Henrik Austad wrote:
> On Mon, May 26, 2014 at 10:21:10PM +0600, Alexander E. Patrakov wrote:
>> 26.05.2014 19:03, Henrik Austad wrote:
>>> Hi all!
>>>
>>> This is an RFC for a new class of soundcards. I am not very familiar
>>> with how ALSA is tied together underneath the hood, so what you see
>>> here, is based on my naive understanding of ALSA. I wear asbestos
>>> underwear on a regular basis, so I prefer honesty over sugarcoating :)
>>
>> Hello. All of this looks very interesting, but a bit more
>> information is needed in order to put this in context.
>
> Hi Alexander, thank you for the feedback.
>
> First a disclaimer, I am in no sense an expert in this area, so if
> something seems fishy, it might just be.

I am not an expert in the kernel part of ALSA, either.
>> Obviously, as the intention is to create something that looks like a
>> regular ALSA sound card, there should be a circular buffer that
>> holds sound samples (just like the DMA buffer on regular sound
>> cards). There also needs to be "something" that sends samples from
>> this buffer into the network. Is my understanding correct?
>
> Yes, that is pretty much what I've planned. Since we cannot interrupt
> userspace to fill the buffer all the time, I was planning on adding a ~20ms
> buffer. If this is enough, I don't know yet.

Actually a sound card with only 20 ms of buffer would be a very strange 
beast. "Typical sound card" buffers have a 200-2000 ms range. When 
setting hardware parameters, an ALSA application specifies the desired 
buffer size (that is, how much they want to survive without getting 
scheduled) and the period size (i.e. how often they want to be notified 
that the sound card has played something - in order to supply additional 
samples). So that "20 ms" buffer size should be client-settable.

You also have, in the ideal world, to provide the following:

  * An option to disable period wakeups for the application that relies 
on some other clock source and position queries.
  * A method to get the position of the sample currently being played, 
with good-enough (<= 0.25 ms) precision for the application-level 
synchronization with other sound cards not sharing the same clock source 
(via adaptive resampling).
  * A method to get the position of the first safe-to-rewrite sample 
(aka DMA position), for implementing dynamic-latency tricks at the 
application level (via snd_pcm_rewind).

>
> As stated in the previous mail, I'm no alsa-expert, I expect to learn a lot
> as I dig into this :)
>
> As to moving samples from the buffer onto the network, one approach would
> be to wrap a set of samples and place it into a ready frame with headers
> and bits set and leave it in a buffer for the network layer to pick up.
>
> The exact method here is not clear to me yet, I need to experiment, and
> probably send something off to the networking guys. But before I do that,
> I'd like to have a reasonable sane idea of how ALSA should handle this.
>
> I expect this to be rewritten a few times :)

I think that snd-pcsp should provide you some insight on this, possibly 
even yielding (as a quick hack) a very very suboptimal (8k interrupts 
per second) but somewhat-working version, assuming that the arguments 
for doing this in the kernel are valid. Which is not a given - please 
talk to BlueTooth guys about that, they opted for a special socket type 
+ userspace solution in a similar situation.


>
>>> * IEEE 1722 (and 1733 for layer-3) Layer 2 Transport for
>>>    audio/video. The packing is similar to what is done in Firewire. You
>>>    have 8kHz frame intervals for class A, 4kHz for class B. This gives
>>>    relatively few samples pr. frame. Currently we only look at Layer 2 as
>>>    small peripherals (microphones, speakers) will only have to implement
>>>    L2 instead of the entire IP-stack.
>>
>> So, are you proposing to create a real-time kernel thread that will
>> wake up 4000 or 8000 times per second in order to turn a few samples
>> from the circular buffer into an Ethernet packet and send it, also
>> advancing the "hardware pointer" in the process? Or do you have an
>> idea how to avoid that rate of wakeups?
>
> I'm hoping to get some help from the NICs hardware and a DMA engine here as
> it would be pretty crazy to do a task wakeup 8k times/sec. Not only would
> the overhead be high, but if you have a 125us window for filling a buffer,
> you are going to fail miserably in a GPOS.
>
> For instance, if you can prepare, say 5ms worth of samples at a go, that
> would mean you have to prepare 40 frames. If you then could get the NIC and
> network infrastructure take thos frames and even them out over the next 5
> ms, all would be well.

Except that on cheap cards, all of this will be software timer-based 
anyway, and thus will not avoid the 8 kHz interrupt-rate requirement. So 
maybe we just have to accept this requirement for now at least as a 
fallback path (especially since even a DNS server at your ISP has more 
stringent requirements) and add optimizations later.

> The process of evening out the rate of samples is what traffic shaping and
> stream reservation will help you do (or enforce, ymmv), to some extent at
> least. The credit based shaper algorithm is designed to force bursty
> traffic into a steady stream. How much you can press the queues, I'm not
> sure. It may very well be that 40 frames is too much.

Well, yes, because some software (e.g. PulseAudio) sometimes wants to 
rewind as close to the currently-playing sample as possible. Currently, 
PulseAudio allows for only 1.3 ms of the safety margin.


-- 
Alexander E. Patrakov
