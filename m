From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 06/10] ALSA: axd: add basic files for sending/receiving
 axd cmds
Date: Thu, 27 Aug 2015 16:40:09 +0100
Message-ID: <55DF2F59.408@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-7-git-send-email-qais.yousef@imgtec.com>
 <20150826191642.GG28760@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150826191642.GG28760@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/26/2015 08:16 PM, Mark Brown wrote:
> On Mon, Aug 24, 2015 at 01:39:15PM +0100, Qais Yousef wrote:
>
>> +int axd_cmd_set_pc(struct axd_cmd *cmd, unsigned int thread, unsigned long pc)
>> +{
>> +	if (thread >= THREAD_COUNT)
>> +		return -1;
> Return sensible error codes please.

OK.

>
>> +unsigned long  axd_cmd_get_datain_address(struct axd_cmd *cmd)
>> +{
>> +	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
>> +
>> +	return (unsigned long) axd->buf_base_m;
>> +}
> What's going on with these casts?

As with the other cases. buf_base_m is void * __iomem but we want to do 
some arithmatic to help AXD start up and understand where it needs to 
run. I agree they don't look nice and if I can avoid them I'd be happy 
to do so.

>
>> +static inline void axd_set_flag(unsigned int *flag, unsigned int value)
>> +{
>> +	*flag = value;
>> +	smp_wmb();	/* guarantee smp ordering */
>> +}
>> +
>> +static inline unsigned int axd_get_flag(unsigned int *flag)
>> +{
>> +	smp_rmb();	/* guarantee smp ordering */
>> +	return *flag;
>> +}
> Please use a normal locking construct rather than hand rolling
> something, or alternatively introduce new generic operations.  The fact
> that you're hand rolling these things that have no driver specific
> content is really worrying in terms of their safety.

I need to check atomic_ops.txt again but I think atomic_t is not always 
smb safe. I definitely was running on a version of Meta archicture in 
the past where atomic_t wasn't always smp safe.

I'll check if the rules have changed or something new was introduced to 
deal with this.

>
>> +/*
>> + * axd_pipe->enabled_flg for output pipes is overloaded to mean two things:
>> + *
>> + * - PIPE_STARTED: indicates that pipe was opened but no buffers were passed.
>> + *   When stopping the pipes, we know that we don't need to discard anything if
>> + *   the discard_flg is set in cmd struct. Which allows us to terminate easily
>> + *   and quickly.
>> + *
>> + * - PIPE_RUNNING: indicates that pipe has processed some buffers, so we should
>> + *   discard if user terminates early (and discard_flg is set in cmd struct).
>> + */
>> +#define PIPE_STARTED	1
>> +#define PIPE_RUNNING	2
> Why is the case with in place buffers not a simple zero iteration loop?

This is important when AXD is not consuming the data through I2S and 
returning them to Linux. What we're trying to deal with here is the 
firmware processed some data and expects Linux to consume whatever it 
has sent back to it. We want to ensure that if the user suddenly stopped 
consuming this data by closing the pipe to drop anything we receive back 
from AXD otherwise the workqueue would block indefinitely waiting for 
the user that disappeared to consume it causing a deadlock.

>
>> +#ifdef AXD_DEBUG_DIAG
>> +static unsigned int inSentCount[AXD_MAX_PIPES];
>> +static unsigned int inRecvCount[AXD_MAX_PIPES];
>> +static unsigned int outSentCount[AXD_MAX_PIPES];
>> +static unsigned int outRecvCount[AXD_MAX_PIPES];
>> +static unsigned int primeupCount[AXD_MAX_PIPES];
>> +static unsigned int read_size[AXD_MAX_PIPES];
>> +static unsigned int write_size[AXD_MAX_PIPES];
>> +static unsigned int recv_size[AXD_MAX_PIPES];
> No static globals and please follow the kernel coding style.

OK I'll fix.

>
>> +static inline void axd_datain_kick(struct axd_pipe *axd_pipe)
>> +{
>> +	unsigned long flags;
>> +	struct axd_memory_map __iomem *message = axd_pipe->cmd->message;
>> +	unsigned int pipe = axd_pipe->id;
>> +	unsigned int temp;
>> +
>> +#ifdef AXD_DEBUG_DIAG
>> +	inSentCount[pipe]++;
>> +#endif
> Define accessor macros for these and then define them to noops when not
> debugging rather than having #defines in the code.

Yep sounds a better way to do it.

>> +static irqreturn_t axd_irq(int irq, void *data)
>> +{
>> +	struct axd_cmd *cmd = data;
>> +	unsigned int int_status;
>> +	unsigned long flags;
>> +	int i, ret;
>> +
>> +	/*
>> +	 * int_status is ioremapped() which means it could page fault. When axd
>> +	 * is running on the same core as the host, holding lock2 would disable
>> +	 * exception handling in that core which means a page fault would stuff
>> +	 * host thread executing the driver. We do a double read here to ensure
>> +	 * that we stall until the memory access is done before lock2 is
>> +	 * acquired, hence ensuring that any page fault is handled outside lock2
>> +	 * region.
>> +	*/
>> +	int_status = ioread32(&cmd->message->int_status);
>> +	int_status = ioread32(&cmd->message->int_status);
> Eew.

Luckily this is not a problem anymore. This must have slipped back in 
while preparing the patches for submission. I'll audit the code again to 
make sure this didn't happen somewhere else.

>
>> +
>> +	axd_platform_irq_ack();
> When would this ever be called anywhere else?  Just inline it (and it's
> better practice to only ack things we handle...).

It wouldn't be called anywhere else but its implementation could be 
platform specific that's why it's abstracted. At the moment it does 
nothing now we're using MIPS but we shouldn't assume that this will 
always be the case.
The main purpose of this function is to deassert the interrupt line if 
the way interrrupts are wired for that platform required so. In the past 
we were running in hardware where interrupts are sent through special 
slave port and the interrupt required to be acked or deasserted.

>
>> +	flags = axd_platform_lock();
>> +	int_status = ioread32(&cmd->message->int_status);
>> +	iowrite32(0, &cmd->message->int_status);
>> +
>> +	if (!int_status)
>> +		goto out;
> This should cause us to return IRQ_NONE.

I don't think it's necessary. It could happen that AXD sent a DATAIN 
interrupt and shortly after sent DATAOUT interrupt but the handler was 
running before the DATAOUT case is handled causing both interrupts to be 
handled in one go but the handler could be called again to find out that 
there's nothing to do.

>
>> +	if (int_status & AXD_INT_ERROR) {
>> +		struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
>> +		int error = ioread32(&cmd->message->error);
>> +
>> +		pr_debug("<---- Received error interrupt\n");
>> +		switch (error) {
>> +		default:
>> +		case 0:
>> +			break;
> We just ignore these?

Case 0 doesn't indicate anything anymore. I can print a warning about 
unexpected error code for the default case.

>
>> +		case 2:
>> +			dev_warn(axd->dev, "Failed to set last configuration command\n");
>> +			break;
> Does the configuration command notice?

Yes. When send a configuration command we expect a response back that it 
was service (by setting resopnse_flg in AXD_INT_CTRL), we timeout if we 
don't get one and report an error to the caller.

This error code could mean other things as well so I might modify this 
message to be more descriptive.

>
>> +	/*
>> +	 * if we could lock the semaphore, then we're guaranteed that the
>> +	 * current rd_idx is valid and ready to be used. So no need to verify
>> +	 * that the status of the descriptor at rd_idx is valid.
>> +	 */
>> +	spin_lock(&desc_ctrl->rd_lock);
> It really feels like this locking is all complicated and fragile.  I'm
> not entirely sure the optimisation is worth it - are we really sending
> compressed audio at such a high rate that it's worth having concurrency
> handling that's hard to think about?

This is similar to how the bufferq implementation work. What is the 
other alternative to this? We do want this to be as fast as possible.

What is happening here is that the semaphore count is again controlling 
how many descriptors are available, if nothing is available it will 
cause the caller to block. If it succeeds and more than 1 descriptors is 
available potentially more than one SMP user could reach the later point 
so we hold the spinlock while modifying the shared buf_desc structure. 
The variable we're explicitly protecting is rd_idx.

Maybe my use of the semaphore count to keep track of how many 
descriptors are available and cause the caller to block is the confusing 
part? Would better comments help?

>
>> +void axd_cmd_free_irq(struct axd_cmd *cmd, unsigned int irqnum)
>> +{
>> +	flush_workqueue(cmd->in_workq);
> _sync()

OK.

>> +	destroy_workqueue(cmd->in_workq);
>> +	flush_workqueue(cmd->out_workq);
>> +	destroy_workqueue(cmd->out_workq);
>> +	free_irq(irqnum, cmd);
> We're freeing the interrupts after we destroy the workqueue which means
> we could try to schedule new work after destruction.

Right! I'll move it up.

>
>> +	/*
>> +	 * Based on the defined axd_pipe->buf_size and number of input pipes
>> +	 * supported by the firmware, we calculate the number of descriptors we
>> +	 * need to use using this formula:
>> +	 *
>> +	 *	axd_pipe->buf_size * num_desc = total_size / num_inputs
>> +	 */
>> +	num_desc = total_size / (cmd->num_inputs * axd_pipe->buf_size);
> I'm not sure that was an especially tricky line of code to follow...  am
> I missing something here?

The driver receive a pointer to a contiguous buffer area that it needs 
to divide it into buffers based on its size, number of pipes in the 
system, and the desired buffer size.

We then calculate our buffer queue size or how many out of the available 
descriptors we need.

For example if the total buffer area reserved for inputs is 10KiB and we 
have 1 input pipe and the desired buffer size is 1KiB, then we can use 
all 10 Descriptors AXD provides. If we have 2 input pipes in the system, 
then each 1 will take 5KiB and we need 5 descriptors for each pipe. It 
is equivalent to saying 'the size of input X buffer queue is 5'.

>
> I've stopped reviewing here mostly because it's the end of my day and
> this patch is 72K which is enormous for something that's not just lots
> of defines or whatever and actually needs reading in considerable detail
> given all the tricky concurrency stuff you're doing.  Please split this
> code up into multiple patches for ease of review.  For example all the
> queue management and allocation seems rather separate to the interrupt
> handling.

Thanks a lot for your efforts so far. I'll try to split this into 
smaller chunks though it feels really like it's all one entity but 2K of 
code is quite a lot.

>
> It also feels like there's room for pruning the code, perhaps sharing
> more of it between input and output paths and removing some layers of
> abstraction.

I'll look into that. If there's some specific suggestions in mind I'd 
appreciate hearing them.

Many thanks,
Qais
