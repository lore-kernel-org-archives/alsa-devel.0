From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 2/7] slimbus: Add messaging APIs to slimbus framework
Date: Wed, 18 Oct 2017 17:39:08 +0100
Message-ID: <1dfaba0b-78c2-8445-3b04-0bd6a25bf221@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
 <20171018061500.GE1575@tuxbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018061500.GE1575@tuxbook>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

Thanks for Review Comments,


On 18/10/17 07:15, Bjorn Andersson wrote:
> On Fri 06 Oct 08:51 PDT 2017, srinivas.kandagatla@linaro.org wrote:
> 
>> From: Sagar Dharia <sdharia@codeaurora.org>
>>
>> Slimbus devices use value-element, and information elements to
>> control device parameters (e.g. value element is used to represent
>> gain for codec, information element is used to represent interrupt
>> status for codec when codec interrupt fires).
>> Messaging APIs are used to set/get these value and information
>> elements. Slimbus specification uses 8-bit "transaction IDs" for
>> messages where a read-value is anticipated. Framework uses a table
>> of pointers to store those TIDs and responds back to the caller in
>> O(1).
> 
> I think we can implement this "optimization" with less complex code,
> regardless I don't think we need to mention this in the commit
> message...
> 
> [..]
>> diff --git a/drivers/slimbus/slim-messaging.c b/drivers/slimbus/slim-messaging.c
> [..]
>> +/**
>> + * slim_msg_response: Deliver Message response received from a device to the
>> + *	framework.
>> + * @ctrl: Controller handle
>> + * @reply: Reply received from the device
>> + * @len: Length of the reply
>> + * @tid: Transaction ID received with which framework can associate reply.
>> + * Called by controller to inform framework about the response received.
>> + * This helps in making the API asynchronous, and controller-driver doesn't need
>> + * to manage 1 more table other than the one managed by framework mapping TID
>> + * with buffers
>> + */
>> +void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
> 
> Even if tid and len comes from the spec I recommend you making them int
> and size_t.
okay, will give that a go.
> 
>> +{
>> +	struct slim_val_inf *msg;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ctrl->txn_lock, flags);
>> +	msg = ctrl->tid_tbl[tid];
>> +	if (msg == NULL || msg->rbuf == NULL) {
> 
> if (!msg || !msg->rbuf)
> 
> 
> When is it valid to add a transaction to tid_tbl with msg->rbuf = NULL?
> Should we reject it earlier?

We do sanity checks before posting the request, however there are cases 
where this checks are not in place like calling slim_processtxn() directly.

May be we should add this check all the case
> 
>> +		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
>> +		dev_err(&ctrl->dev, "Got response to invalid TID:%d, len:%d\n",
>> +				tid, len);
>> +		return;
>> +	}
>> +	ctrl->tid_tbl[tid] = NULL;
>> +	spin_unlock_irqrestore(&ctrl->txn_lock, flags);
>> +
>> +	memcpy(msg->rbuf, reply, len);
>> +	if (msg->comp_cb)
>> +		msg->comp_cb(msg->ctx, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_msg_response);
> [..]
>> +int slim_processtxn(struct slim_controller *ctrl,
>> +				struct slim_msg_txn *txn)
>> +{
>> +	int ret, i = 0;
>> +	unsigned long flags;
>> +	u8 *buf;
>> +	bool async = false;
>> +	struct slim_cb_data cbd;
>> +	DECLARE_COMPLETION_ONSTACK(done);
>> +	bool need_tid = slim_tid_txn(txn->mt, txn->mc);
>> +
>> +	if (!txn->msg->comp_cb) {
>> +		txn->msg->comp_cb = slim_sync_default_cb;
>> +		cbd.comp = &done;
>> +		txn->msg->ctx = &cbd;
>> +	} else {
>> +		async = true;
>> +	}
>> +
>> +	buf = slim_get_tx(ctrl, txn, need_tid);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	if (need_tid) {
>> +		spin_lock_irqsave(&ctrl->txn_lock, flags);
>> +		for (i = 0; i < ctrl->last_tid; i++) {
>> +			if (ctrl->tid_tbl[i] == NULL)
>> +				break;
>> +		}
>> +		if (i >= ctrl->last_tid) {
>> +			if (ctrl->last_tid == (SLIM_MAX_TIDS - 1)) {
>> +				spin_unlock_irqrestore(&ctrl->txn_lock, flags);
>> +				slim_return_tx(ctrl, -ENOMEM);
>> +				return -ENOMEM;
>> +			}
>> +			ctrl->last_tid++;
>> +		}
>> +		ctrl->tid_tbl[i] = txn->msg;
>> +		txn->tid = i;
>> +		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
>> +	}
>> +
>> +	ret = ctrl->xfer_msg(ctrl, txn, buf);
>> +
>> +	if (!ret && !async) { /* sync transaction */
>> +		/* Fine-tune calculation after bandwidth management */
>> +		unsigned long ms = txn->rl + 100;
>> +
>> +		ret = wait_for_completion_timeout(&done,
>> +						  msecs_to_jiffies(ms));
>> +		if (!ret)
>> +			slim_return_tx(ctrl, -ETIMEDOUT);
>> +
>> +		ret = cbd.ret;
>> +	}
>> +
>> +	if (ret && need_tid) {
>> +		spin_lock_irqsave(&ctrl->txn_lock, flags);
>> +		/* Invalidate the transaction */
>> +		ctrl->tid_tbl[txn->tid] = NULL;
>> +		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
>> +	}
>> +	if (ret)
>> +		dev_err(&ctrl->dev, "Tx:MT:0x%x, MC:0x%x, LA:0x%x failed:%d\n",
>> +			txn->mt, txn->mc, txn->la, ret);
> 
> if (ret) {
> 	if (need_tid)
> 		drop();
> 	
> 	dev_err();
> }
> 
> Would probably make this a little bit cleaner...

I agree.

> 
>> +	if (!async) {
>> +		txn->msg->comp_cb = NULL;
>> +		txn->msg->ctx = NULL;
> 
> I believe txn->msg is always required, so you don't need to do this
> contidionally.

I don't get this, why do you want to set comp_cb to NULL unconditionally?


> 
>> +	}
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(slim_processtxn);
> [..]
>> +int slim_request_val_element(struct slim_device *sb,
>> +				struct slim_val_inf *msg)
>> +{
>> +	struct slim_controller *ctrl = sb->ctrl;
>> +
>> +	if (!ctrl)
>> +		return -EINVAL;
> 
>  From patch 1 I believe it's invalid for sb->ctrl to be NULL, so there
> shouldn't be a need to check this.
> 
yep.

>> +
>> +	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_VALUE);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_request_val_element);
> [..]
>> +int slim_return_rx(struct slim_controller *ctrl, void *buf)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ctrl->rx.lock, flags);
>> +	if (ctrl->rx.tail == ctrl->rx.head) {
>> +		spin_unlock_irqrestore(&ctrl->rx.lock, flags);
>> +		return -ENODATA;
>> +	}
>> +	memcpy(buf, ctrl->rx.base + (ctrl->rx.head * ctrl->rx.sl_sz),
>> +				ctrl->rx.sl_sz);
>> +	ctrl->rx.head = (ctrl->rx.head + 1) % ctrl->rx.n;
>> +	spin_unlock_irqrestore(&ctrl->rx.lock, flags);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(slim_return_rx);
>> +
> 
> Please provide kerneldoc for exported symbols.
> 

Yes, I will fix this in next version.

>> +void slim_return_tx(struct slim_controller *ctrl, int err)
>> +{
>> +	unsigned long flags;
>> +	int idx;
>> +	struct slim_pending cur;
>> +
>> +	spin_lock_irqsave(&ctrl->tx.lock, flags);
>> +	idx = ctrl->tx.head;
>> +	ctrl->tx.head = (ctrl->tx.head + 1) % ctrl->tx.n;
>> +	cur = ctrl->pending_wr[idx];
> 
> Why is this doing struct copy?
> 
Not sure, do you see any issue with this?

>> +	spin_unlock_irqrestore(&ctrl->tx.lock, flags);
>> +
>> +	if (!cur.cb)
>> +		dev_err(&ctrl->dev, "NULL Transaction or completion");
>> +	else
>> +		cur.cb(cur.ctx, err);
>> +
>> +	up(&ctrl->tx_sem);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_return_tx);
> [..]
>>   /**
>> + * struct slim_val_inf: Slimbus value or information element
>> + * @start_offset: Specifies starting offset in information/value element map
>> + * @num_bytes: upto 16. This ensures that the message will fit the slicesize
>> + *		per slimbus spec
>> + * @comp_cb: Callback if this read/write is asynchronous
>> + * @ctx: Argument for comp_cb
>> + */
>> +struct slim_val_inf {
>> +	u16			start_offset;
>> +	u8			num_bytes;
>> +	u8			*rbuf;
> 
> This is not mentioned in the kerneldoc. Use void * for data buffers.
> 
>> +	const u8		*wbuf;
> 
> Can a message ever be read and write? Otherwise it should be sufficient
> to only have one data pointer.

some of the SLIMBus commands are request_response type, meaning the old 
value is returned and at the same time the new value is updated.
> 
>> +	void			(*comp_cb)(void *ctx, int err);
>> +	void			*ctx;
>> +};
>> +
> [..]
>> +/**
>> + * struct slim_ctrl_buf: circular buffer used by contoller for TX, RX
>> + * @base: virtual base address for this buffer
>> + * @phy: physical address for this buffer (this is useful if controller can
>> + *	  DMA the buffers for TX and RX to/from controller hardware
>> + * @lock: lock protecting head and tail
>> + * @head: index where buffer is returned back
>> + * @tail: index from where buffer is consumed
>> + * @sl_sz: byte-size of each slot in this buffer
>> + * @n:	  number of elements in this circular ring, note that this needs to be
>> + *	1 more than actual buffers to allow for one open slot
>> + */
> 
> Is this ringbuffer mechanism defined in the slimbus specification? Looks
> like something specific to the Qualcomm controller, rather than
> something that should be enforced in the framework.
> 

Yes, this is not part of the slimbus specs, but Qcom SOCs have concept 
of Message Queues.

Are you suggesting that this buffer handling has to be moved out of core 
into controller driver?


>> +struct slim_ctrl_buf {
>> +	void		*base;
>> +	phys_addr_t	phy;
>> +	spinlock_t	lock;
>> +	int		head;
>> +	int		tail;
>> +	int		sl_sz;
>> +	int		n;
>> +};
> [..]
>> +/**
>>    * struct slim_controller: Controls every instance of SLIMbus
>>    *				(similar to 'master' on SPI)
>>    *	'Manager device' is responsible for  device management, bandwidth
>> @@ -139,6 +246,16 @@ struct slim_addrt {
>>    * @addrt: Logical address table
>>    * @num_dev: Number of active slimbus slaves on this bus
>>    * @wq: Workqueue per controller used to notify devices when they report present
>> + * @tid_tbl: Table of transactions having transaction ID
>> + * @txn_lock: Lock to protect table of transactions
>> + * @rx: RX buffers used by controller to receive messages. Ctrl may receive more
>> + *	than 1 message (e.g. multiple report-present messages or messages from
>> + *	multiple slaves).
>> + * @tx: TX buffers used by controller to transmit messages. Ctrl may have
>> + *	ability to send/queue multiple messages to HW at once.
>> + * @pending_wr: Pending write transactions to be acknowledged by controller
> 
> This is out list of pending write requests, yet it's implemented as an
> array used in a complex ring buffer fashion. Wouldn't it be easier to
> just have this as a linked list of slim_pending struct?

Yes, its possible to implement this as list, i will give that a try.

> 
>> + * @tx_sem: Semaphore for available TX buffers for this controller
>> + * @last_tid: Last used entry for TID transactions
>>    * @xfer_msg: Transfer a message on this controller (this can be a broadcast
>>    *	control/status message like data channel setup, or a unicast message
>>    *	like value element read/write.
>> @@ -161,6 +278,15 @@ struct slim_controller {
>>   	struct slim_addrt	*addrt;
>>   	u8			num_dev;
>>   	struct workqueue_struct *wq;
>> +	struct slim_val_inf	*tid_tbl[SLIM_MAX_TIDS];
>> +	u8			last_tid;
> 
> I suggest that you replace these two with an idr, rather than having a
> fixed size array and then last_tid as an optimization to limit how far
> you linear search for an empty space.

Will try that and see how it looks!


> 
>> +	spinlock_t		txn_lock;
>> +	struct slim_ctrl_buf	tx;
>> +	struct slim_ctrl_buf	rx;
>> +	struct slim_pending	*pending_wr;
>> +	struct semaphore	tx_sem;
> 
> Please don't use semaphores. If you keep pending_wr as a list you can
> use list_empty() instead...

will give that a go.

> 
>> +	int			(*xfer_msg)(struct slim_controller *ctrl,
>> +					    struct slim_msg_txn *tx, void *buf);
> 
> I believe buf has fixed size, so please document this.
Yep. Will do that in next version.
> 
>>   	int			(*set_laddr)(struct slim_controller *ctrl,
>>   					     struct slim_eaddr *ea, u8 laddr);
>>   	int			(*get_laddr)(struct slim_controller *ctrl,
>> @@ -295,5 +421,40 @@ static inline void slim_set_devicedata(struct slim_device *dev, void *data)
>>   {
>>   	dev_set_drvdata(&dev->dev, data);
>>   }
> 
> Regards,
> Bjorn
> 
