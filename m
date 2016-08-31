From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: tlv320dac33: Remove deprecated
 create_singlethread_workqueue
Date: Wed, 31 Aug 2016 22:10:47 +0300
Message-ID: <88b9a137-b934-f928-535f-719cfbc9bff3@ti.com>
References: <20160830182750.GA8074@Karyakshetra>
 <7abb8b68-760b-cf67-17a5-d120136d6ec5@ti.com>
 <20160831144408.GX12660@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160831144408.GX12660@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/31/16 17:44, Tejun Heo wrote:
> Hello, Peter.
>
> On Wed, Aug 31, 2016 at 02:56:50PM +0300, Peter Ujfalusi wrote:
>> On 08/30/16 21:27, Bhaktipriya Shridhar wrote:
>>> The workqueue "dac33_wq" queues a single work item &dac33->work and hence
>>> doesn't require ordering. Also, it is not being used on a memory reclaim
>>> path. Hence, it has been converted to use system_wq.
>>>
>>> The work item has been flushed in dac33_soc_remove to ensure that
>>> there are no pending tasks while disconnecting the driver.
>>
>> The reason why dac33 had it's own wq is that it is absolutely time critical
>> that the work is not going to be delayed by the scheduling needs with the
>> system_wq. If the work execution is delayed, we could run out of time in FIFO
>> mode, which can cause the chip to hang do to FIFO underrun.
>
> In the current implementation of wq, which has been around for many
> years now, there's no real timing advantage to using a dedicated
> workqueue or rather system_wq doesn't get blocked by other work items
> on it.  They are all served by the same backend pools and dedicated
> workqueues mostly serve as attribute, flush and mem-reclaim domains.

The dac33 driver was productised with 2.6.32 kernel and there the dedicated wq
was needed. I know lots have changed, so it is most likely not the case anymore.

>> Unfortunately I'm no longer able to test the dac33 as I don't have the HW any
>> more.
>>
>> If you are 100% percent sure that this is not going to delay the work, then
>> I'm OK with the change, but I have used the dedicated queue at the time,
>> because the system_wq given unpredictable latencies.
>
> What kind of time frame are we talking about?  If it really needs high
> priority, the right thing to do would be using a WQ_HIGHPRI workqueue.

In order to be tune the performance and power saving during audio playback
lower is better, but consistency matters more to be able have stable system.
I have some latency compensation in the code so it could tolerate some drift,
but big spikes can cause the codec to go underflow and we can not recover from
that w/o hard reset of the codec.

I do believe that Linux got much better over the years since I wrote the dac33
driver, so I'm fine with the move to system_wq. The most problematic mode (I
think it was MODE7LP or smthing) is not upstream so this change should not
break audio on the n9/n950.

-- 
Péter
