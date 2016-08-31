From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] ASoC: Remove deprecated create_singlethread_workqueue
Date: Wed, 31 Aug 2016 10:26:48 -0400
Message-ID: <20160831142648.GP12660@htj.duckdns.org>
References: <20160830192709.GA16591@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160830192709.GA16591@Karyakshetra>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 31, 2016 at 12:57:09AM +0530, Bhaktipriya Shridhar wrote:
> The workqueue "dac33_wq" queues a single work item &dac33->work and hence
> doesn't require ordering. Also, it is not being used on a memory reclaim
> path. Hence, it has been converted to use system_wq.
> 
> The work item has been flushed in dac33_soc_remove to ensure that
> there are no pending tasks while disconnecting the driver.
> 
> The workqueue "post_msg_wq" queues a single work item
> &drv->ipc_post_msg_wq and hence doesn't require ordering. Also, it is
> not being used on a memory reclaim path. Hence, it has been converted to
> use system_wq.
> 
> The work item has been flushed in sst_context_cleanup to ensure that
> there are no pending tasks while disconnecting the driver.
> 
> System workqueues have been able to handle high level of concurrency
> for a long time now and hence it's not required to have a singlethreaded
> workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
> created with create_singlethread_workqueue(), system_wq allows multiple
> work items to overlap executions even on the same CPU; however, a
> per-cpu workqueue doesn't have any CPU locality or global ordering
> guarantee unless the target CPU is explicitly specified and thus the
> increase of local concurrency shouldn't make any difference.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
