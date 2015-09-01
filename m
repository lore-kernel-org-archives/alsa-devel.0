From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 06/10] ALSA: axd: add basic files for sending/receiving
 axd cmds
Date: Tue, 1 Sep 2015 11:46:19 +0100
Message-ID: <55E581FB.4000202@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-7-git-send-email-qais.yousef@imgtec.com>
 <20150826191642.GG28760@sirena.org.uk> <55DF2F59.408@imgtec.com>
 <20150829101814.GA12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150829101814.GA12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/29/2015 11:18 AM, Mark Brown wrote:
> On Thu, Aug 27, 2015 at 04:40:09PM +0100, Qais Yousef wrote:
>> On 08/26/2015 08:16 PM, Mark Brown wrote:
>>> On Mon, Aug 24, 2015 at 01:39:15PM +0100, Qais Yousef wrote:
>>>> +unsigned long  axd_cmd_get_datain_address(struct axd_cmd *cmd)
>>>> +{
>>>> +	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
>>>> +
>>>> +	return (unsigned long) axd->buf_base_m;
>>>> +}
>>> What's going on with these casts?
>> As with the other cases. buf_base_m is void * __iomem but we want to do some
>> arithmatic to help AXD start up and understand where it needs to run. I
>> agree they don't look nice and if I can avoid them I'd be happy to do so.
> C supports poinnter arithmetic...
>
>>>> +static inline void axd_set_flag(unsigned int *flag, unsigned int value)
>>>> +{
>>>> +	*flag = value;
>>>> +	smp_wmb();	/* guarantee smp ordering */
>>>> +}
>>>> +static inline unsigned int axd_get_flag(unsigned int *flag)
>>>> +{
>>>> +	smp_rmb();	/* guarantee smp ordering */
>>>> +	return *flag;
>>>> +}
>>> Please use a normal locking construct rather than hand rolling
>>> something, or alternatively introduce new generic operations.  The fact
>>> that you're hand rolling these things that have no driver specific
>>> content is really worrying in terms of their safety.
>> I need to check atomic_ops.txt again but I think atomic_t is not always smb
>> safe. I definitely was running on a version of Meta archicture in the past
>> where atomic_t wasn't always smp safe.
>> I'll check if the rules have changed or something new was introduced to deal
>> with this.
> It is true that when using atomic_t with multiprocessor you still need
> memory barriers but that doesn't mean atomics bring no benefit.  But
> that's not really the point here - the point is the more general one
> that the whole idea of open coding memory barrier concurrency constructs
> doesn't look great.  It makes the code much more complex and error prone
> compared to using normal locking and other concurrency constructs (which
> Linux has a rich set of).
>
> If we really need performance then it can make sense but I'm not seeing
> anything here that appears to motivate this.  In general all the
> concurrency code looks much more complex than I would expect.

OK I'll improve on this.

>
>>>> +#define PIPE_STARTED	1
>>>> +#define PIPE_RUNNING	2
>>> Why is the case with in place buffers not a simple zero iteration loop?
>> This is important when AXD is not consuming the data through I2S and
>> returning them to Linux. What we're trying to deal with here is the firmware
>> processed some data and expects Linux to consume whatever it has sent back
>> to it. We want to ensure that if the user suddenly stopped consuming this
>> data by closing the pipe to drop anything we receive back from AXD otherwise
>> the workqueue would block indefinitely waiting for the user that disappeared
>> to consume it causing a deadlock.
> That doesn't seem to address the question...

I'm sorry I don't understand your question then. Can you rephrase it please?

>>>> +	axd_platform_irq_ack();
>>> When would this ever be called anywhere else?  Just inline it (and it's
>>> better practice to only ack things we handle...).
>> It wouldn't be called anywhere else but its implementation could be platform
>> specific that's why it's abstracted. At the moment it does nothing now we're
>> using MIPS but we shouldn't assume that this will always be the case.
>> The main purpose of this function is to deassert the interrupt line if the
>> way interrrupts are wired for that platform required so. In the past we were
>> running in hardware where interrupts are sent through special slave port and
>> the interrupt required to be acked or deasserted.
> This sounds like something that should be in the interrupt controller
> implementation not the leaf driver, just remove this unless you're
> actually abstracting something.

We're actually abstracting something. This mechanism might not be part 
of an interrupt controller that is understood by Linux. At least I had 
this case in the past where the interrupt generated by AXD must be acked 
by writing to a special memory address.
We don't have a current user for it now though so it makes sense to 
remove it and if a similar user comes up in the future we can sort it 
out then.

>>>> +	flags = axd_platform_lock();
>>>> +	int_status = ioread32(&cmd->message->int_status);
>>>> +	iowrite32(0, &cmd->message->int_status);
>>>> +
>>>> +	if (!int_status)
>>>> +		goto out;
>>> This should cause us to return IRQ_NONE.
>> I don't think it's necessary. It could happen that AXD sent a DATAIN
>> interrupt and shortly after sent DATAOUT interrupt but the handler was
>> running before the DATAOUT case is handled causing both interrupts to be
>> handled in one go but the handler could be called again to find out that
>> there's nothing to do.
> Please implement your interrupt handler properly so that the genirq
> error handling code can work and it is robust against things going
> wrong in future.  It's not like it's a huge amount of complex code.

OK. I thought that since the situation of int_satus being 0 is something 
we expect we don't need to trigger a failure for then; it's just a 
special case where we don't actually need to work.
I'll change it to return IRQ_NONE if that's what you think is more 
appropriate.

>
>>>> +	if (int_status & AXD_INT_ERROR) {
>>>> +		struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
>>>> +		int error = ioread32(&cmd->message->error);
>>>> +
>>>> +		pr_debug("<---- Received error interrupt\n");
>>>> +		switch (error) {
>>>> +		default:
>>>> +		case 0:
>>>> +			break;
>>> We just ignore these?
>> Case 0 doesn't indicate anything anymore. I can print a warning about
>> unexpected error code for the default case.
> That's more what I'd expect, yes.
>
>>>> +	/*
>>>> +	 * if we could lock the semaphore, then we're guaranteed that the
>>>> +	 * current rd_idx is valid and ready to be used. So no need to verify
>>>> +	 * that the status of the descriptor at rd_idx is valid.
>>>> +	 */
>>>> +	spin_lock(&desc_ctrl->rd_lock);
>>> It really feels like this locking is all complicated and fragile.  I'm
>>> not entirely sure the optimisation is worth it - are we really sending
>>> compressed audio at such a high rate that it's worth having concurrency
>>> handling that's hard to think about?
>> This is similar to how the bufferq implementation work. What is the other
>> alternative to this? We do want this to be as fast as possible.
> Why not just reuse the bufferq implementation if that's what you want to
> use?  More generally most audio ring buffers just keep track of the last
> place read or written and don't bother with semaphores (why do we even
> need to block?).  It's not just the semaphore you're using here but also
> some non-atomic variables accessed with memory barriers and mutexes all
> scattered over a very large block of code.  It is far too much effort to
> reason about what the locking scheme is supposed to be here to determine
> if it is safe, and that's not going to get any easier when reviewing
> future changes.

We need to block because in the past at least the driver could work on 
blocking mode and it would return the buffers back to Linux and there 
was no guarantee that the reader and writer would be on the same rate. 
The worst case assumption was that the writer and the reader could be 2 
different apps. For example an app getting data from network to AXD to 
be encoded and another app reading the encoded data to store it on disk. 
And AXD supports multi-pipeline, so more one of these operations could 
be happening at the same time.

Again I hear you and I'll work on refactoring the code to make it 
simpler and easier to read and hopefully I can get rid of some of the 
complexity.

>
> Trying to make something overly optimised at the expense of
> comprehensibility and maintainability is not good, if there is a
> pressing performance reason then by all means but that needs to be
> something concrete not just a statement that we want things to run
> faster.
>
>> Maybe my use of the semaphore count to keep track of how many descriptors
>> are available and cause the caller to block is the confusing part? Would
>> better comments help?
> Documentation would help somewhat but I really think this is far too
> complicated for what it's trying to do.  As far as I can tell all this
> is doing is simple FIFO type tracking of where the last write and last
> read in the buffer were (which is what most audio drivers do with their
> data buffers).  That should be something that can be done with something
> more like just a single lock.
>
> Based on some of your other comments I think this may have been
> overengineered for some other APIs you were implementing but with the
> ALSA API it should be possible to dramatically simplify it.

I'll work at addressing all of your comments and hopefully the result 
will be something much simpler.

Many thanks,
Qais

>
>>>> +	/*
>>>> +	 * Based on the defined axd_pipe->buf_size and number of input pipes
>>>> +	 * supported by the firmware, we calculate the number of descriptors we
>>>> +	 * need to use using this formula:
>>>> +	 *
>>>> +	 *	axd_pipe->buf_size * num_desc = total_size / num_inputs
>>>> +	 */
>>>> +	num_desc = total_size / (cmd->num_inputs * axd_pipe->buf_size);
>>> I'm not sure that was an especially tricky line of code to follow...  am
>>> I missing something here?
>> The driver receive a pointer to a contiguous buffer area that it needs to
>> divide it into buffers based on its size, number of pipes in the system, and
>> the desired buffer size.
> That is what I think the code is doing but apparently it's sufficiently
> complex that it needs a five line comment including a rewritten version
> of the equation?
