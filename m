From: Tejun Heo <tj@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: tlv320dac33: Remove deprecated
 create_singlethread_workqueue
Date: Wed, 31 Aug 2016 10:44:08 -0400
Message-ID: <20160831144408.GX12660@htj.duckdns.org>
References: <20160830182750.GA8074@Karyakshetra>
 <7abb8b68-760b-cf67-17a5-d120136d6ec5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7abb8b68-760b-cf67-17a5-d120136d6ec5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello, Peter.

On Wed, Aug 31, 2016 at 02:56:50PM +0300, Peter Ujfalusi wrote:
> On 08/30/16 21:27, Bhaktipriya Shridhar wrote:
> > The workqueue "dac33_wq" queues a single work item &dac33->work and hence
> > doesn't require ordering. Also, it is not being used on a memory reclaim
> > path. Hence, it has been converted to use system_wq.
> >
> > The work item has been flushed in dac33_soc_remove to ensure that
> > there are no pending tasks while disconnecting the driver.
> 
> The reason why dac33 had it's own wq is that it is absolutely time critical
> that the work is not going to be delayed by the scheduling needs with the
> system_wq. If the work execution is delayed, we could run out of time in FIFO
> mode, which can cause the chip to hang do to FIFO underrun.

In the current implementation of wq, which has been around for many
years now, there's no real timing advantage to using a dedicated
workqueue or rather system_wq doesn't get blocked by other work items
on it.  They are all served by the same backend pools and dedicated
workqueues mostly serve as attribute, flush and mem-reclaim domains.

> Unfortunately I'm no longer able to test the dac33 as I don't have the HW any
> more.
> 
> If you are 100% percent sure that this is not going to delay the work, then
> I'm OK with the change, but I have used the dedicated queue at the time,
> because the system_wq given unpredictable latencies.

What kind of time frame are we talking about?  If it really needs high
priority, the right thing to do would be using a WQ_HIGHPRI workqueue.

Thanks.

-- 
tejun
