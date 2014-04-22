From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: For firewire drivers,
 reduce period time down to 2msec?
Date: Tue, 22 Apr 2014 22:24:07 +0900
Message-ID: <53566D77.8000207@sakamocchi.jp>
References: <5355033F.7060606@sakamocchi.jp> <53557F6F.8080701@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id C64B8264F06
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 15:24:16 +0200 (CEST)
In-Reply-To: <53557F6F.8080701@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(Apr 22 2014 05:28), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> Currently I'm working for next patchsets and I'll post them in Friday.
>
> I should be healthy again by then.

I should careflly prepare for these patches, without any bugs which I 
can realize.

>> I want to reduce this to 2msec. The reason of this '2msec' is:
>>   - Currently firewire-lib process 16 packets in one time.
>>   - This equals to 2msec (= INTERRUPT_INTERVAL / 8000 * 1000)
>>   - During this 2msec, when pcm_period_pointer passes through period
>> boundary, snd_pcm_period_elapsed() is scheduled with tasklet.
>>   - But tasklet can execute one time even if the function is scheduled
>> several times before executing it.
>>   - The packetizing process is enough fast so the function can be
>> scheduled before executing.
>>   - As a result, snd_pcm_period_elapsed() can be called one time every 2msec.
>>
>> Actually my devices can work fine with period == 2msec or less than
>> 5msec, without any disadvantage.
>
> ALSA actually uses a fixed period _size_.  When the period length is set
> to exactly 2 ms, but the 16 packets between two FireWire interrupts
> contain one sample less than needed, the ALSA period interupt is delayed
> until the next FireWire interrupt.  In that case, Jack with two periods
> is likely to underrun.
>
> The minimum time should be increased so that at least one FireWire
> interrupt is guaranteed to happen for each period, even when there are
> rounding errors and clock differences.

I didn't consider about this case. Yes, exactly. I should remain 4msec 
or more for period time.

But against your expectation, the examples in my previous message are 
got with jackd. Today I did easy tests with jackd again but I didn't 
receive any XRUNs. Of cource, the size of period is nearly 2msec and the 
number of periods in buffer is 2.

I did also some tests with aplay/arecord. In this case, I can get 
'overrun' with arecord and M(mmap) or/and N(nonblock) option, but aplay 
works fine.

If your expectation and my understanding are correct, all of 
jackd/aplay/arecord should generate XRUNs. But actually not. Do you have 
any ideas for these differences?


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp

(Apr 21 2014 20:38), Takashi Sakamoto wrote:> Hi Clemens,
 >
 > Currently I'm working for next patchsets and I'll post them in Friday.
 > In this time, I add some patches newly, including your idea to use
 > channel mapping instead of CIP_HI_DUALWIRE for dice driver.
 >
 > The patchset also includes my idea to apply common PCM hw constraints to
 > dice/speakers(oxfw)/fireworks/bebob. Currently the constraints includes:
 > 1.Maximum bits for PCM sample is limited by 24.
 > 2.Minimum time for period is currently 2msec.
 > 3.In blocking mode, frames per period/buffer is aligned to SYT_INTERVAL
 >
 > I think you'll agree with 1 and 3. So I want to discuss the second one
 > beforehand.
 >
 > Currently dice/speakers driver apply 5msec for period time. I want to
 > reduce this to 2msec. The reason of this '2msec' is:
 >   - Currently firewire-lib process 16 packets in one time.
 >   - This equals to 2msec (= INTERRUPT_INTERVAL / 8000 * 1000)
 >   - During this 2msec, when pcm_period_pointer passes through period
 > boundary, snd_pcm_period_elapsed() is scheduled with tasklet.
 >   - But tasklet can execute one time even if the function is scheduled
 > several times before executing it.
 >   - The packetizing process is enough fast so the function can be
 > scheduled before executing.
 >   - As a result, snd_pcm_period_elapsed() can be called one time 
every 2msec.
 >
 > Actually my devices can work fine with period == 2msec or less than
 > 5msec, without any disadvantage. For example:
 >
 > (snd-bebob)
 > $ cat /proc/asound/GO46/pcm0p/sub0/hw_params
 > access: MMAP_INTERLEAVED
 > format: S32_LE
 > subformat: STD
 > channels: 6
 > rate: 32000 (32000/1)
 > period_size: 64
 > buffer_size: 128
 >
 > period: 1/32000 *  64 / 1000 = 2.0 msec
 > buffer: 1/32000 * 128 / 1000 = 4.0 msec
 >
 > $ cat /proc/asound/GO46/pcm0p/sub0/hw_params
 > access: MMAP_INTERLEAVED
 > format: S32_LE
 > subformat: STD
 > channels: 6
 > rate: 48000 (48000/1)
 > period_size: 128
 > buffer_size: 256
 >
 > period: 1/48000 * 128 * 1000 = 2.7 msec
 > buffer: 1/48000 * 256 * 1000 = 5.4 msec
 >
 > (snd-oxfw)
 > $ cat /proc/asound/FCA202/pcm0p/sub0/hw_params
 > access: MMAP_INTERLEAVED
 > format: S32_LE
 > subformat: STD
 > channels: 2
 > rate: 32000 (32000/1)
 > period_size: 64
 > buffer_size: 128
 >
 > period: 1/32000 *  64 / 1000 = 2.0 msec
 > buffer: 1/32000 * 128 / 1000 = 4.0 msec
 >
 > $ cat /proc/asound/FCA202/pcm0p/sub0/hw_params
 > access: MMAP_INTERLEAVED
 > format: S32_LE
 > subformat: STD
 > channels: 2
 > rate: 96000 (96000/1)
 > period_size: 256
 > buffer_size: 512
 >
 > period: 1/96000 * 256 * 1000 = 2.7 msec
 > buffer: 1/96000 * 512 * 1000 = 5.4 msec
 >
 >
 > How do you think about applyting these rules to dice/speakers?
 >
 >
 > Regards
 >
 > Takashi Sakamoto
 > o-takashi@sakamocchi.jp
