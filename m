From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 05/10] ALSA: axd: add buffers manipulation
	files
Date: Tue, 1 Sep 2015 11:00:42 +0100
Message-ID: <55E5774A.8070808@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-6-git-send-email-qais.yousef@imgtec.com>
 <20150826184323.GE28760@sirena.org.uk> <55DF1CDD.6040109@imgtec.com>
 <20150829094711.GZ12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BD07265068
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 12:00:44 +0200 (CEST)
In-Reply-To: <20150829094711.GZ12027@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/29/2015 10:47 AM, Mark Brown wrote:
> On Thu, Aug 27, 2015 at 03:21:17PM +0100, Qais Yousef wrote:
>> On 08/26/2015 07:43 PM, Mark Brown wrote:
>>> On Mon, Aug 24, 2015 at 01:39:14PM +0100, Qais Yousef wrote:
>>>> +	/*
>>>> +	 * must ensure we have one access at a time to the queue and rd_idx
>>>> +	 * to be preemption and SMP safe
>>>> +	 * Sempahores will ensure that we will only read after a complete write
>>>> +	 * has finished, so we will never read and write from the same location.
>>>> +	 */
>>> In what way will sempahores ensure that we will only read after a
>>> complete write?
>> This comment needs fixing. What it is trying to say is that if we reached
>> this point of the code then we're certainly allowed to modify the buffer
>> queue and {rd, wr}_idx because the semaphore would have gone to sleep
>> otherwise if the queue is full/empty.
>> Should I just remove the reference to Semaphores from the comment or worth
>> rephrasing it?
> Any comments need to be comprehensible.
>
>> Would it be better to rename {rd, wr}_{idx, sem} to {take, put}_{idx, sem}?
> I'm not sure that helps to be honest, the main issue is that the scheme
> is fairly complex and unexplained.
>
>>>> +	buf = bufferq->queue[bufferq->rd_idx];
>>> So buffers are always retired in the same order that they are acquired?
>> I don't think I get you here. axd_bufferq_take() and axd_bufferq_put() could
>> be called in any order.
> Retiring buffers in the order they are acquired means that buffers are
> always freed in the same order they are acquired, you can't free one
> buffer before another that was acquired first.
>> What this code is trying to do is make a contiguous memory area behave as a
>> ring buffer. Then this ring buffer behave as a queue. We use semaphore
>> counts to control how many are available to take/put. rd_idx and wr_idx
>> should always point at the next location to take/put from/to.
>> Does this help answering your question?
> No.  Why are we doing this?  Essentially all ALSA buffers are ring
> buffers handled in blocks, why does this one need this complex locking
> scheme?

There are 2 sides to this. The ALSA/driver iface and the driver/firmware 
one. The ALSA/driver iface is called from ALSA ops but the 
driver/firmware is handled by the interrupt and workqueues. The code is 
trying to deal with this concurrency. Also once AXD consumed a buffer it 
sends back an interrupt to the driver that it can reuse it, there's no 
guarantee that this returned buffer is in the same order it was sent.

I hear you though. Let me see how I can simplify this :-)

>>>> +void axd_bufferq_abort_put(struct axd_bufferq *bufferq)
>>>> +{
>>>> +	if (axd_bufferq_is_full(bufferq)) {
>>>> +		bufferq->abort_put = 1;
>>>> +		up(&bufferq->wr_sem);
>>>> +	}
>>>> +}
>>> These look *incredibly* racy.  Why are they here and why are they safe?
>> If we want to restart the firmware we will need to abort any blocking reads
>> or writes for the user space to react. I also needed that to implement
> I'm not questioning what the functionns are doing, I'm questioning their
> implementation - it doesn't look like they are safe or reliable.  They
> just set a flag, relying on something else to notice that the flag has
> been set and act appropriately before it goes on and corrupts data.
> That just screams concurrency issues.

OK. I'll see how I can rework the code to address all of your comments.

Thanks,
Qais

>> nonblocking access in user space when this was a sysfs based driver. It was
>> important then to implement omx IL component correctly.
> Nobody cares about OMX ILs in mainline or sysfs based interfaces.
>
>> Do I need to support nonblock reads and writes in ALSA? If I use SIGKILL as
>> you suggested in the other email when restarting and nonblock is not
>> important then I can remove this.
> It would be better to support non blocking access.
