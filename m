From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 2/7] slimbus: Add messaging APIs to
 slimbus framework
Date: Tue, 10 Oct 2017 14:01:10 +0100
Message-ID: <205220e0-1486-29db-6e53-1871f9f81697@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
 <20171010121938.2uwzauf6uaivoe7f@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id EE8CA266B38
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 15:01:13 +0200 (CEST)
Received: by mail-wm0-f43.google.com with SMTP id m72so4947390wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 06:01:13 -0700 (PDT)
In-Reply-To: <20171010121938.2uwzauf6uaivoe7f@localhost.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, gregkh@linuxfoundation.org, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

Thanks for the review comments,

On 10/10/17 13:19, Charles Keepax wrote:
> On Fri, Oct 06, 2017 at 05:51:31PM +0200, srinivas.kandagatla@linaro.org wrote:
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
>> Caller can opt to do synchronous, or asynchronous reads/writes. For
>> asynchronous operations, the callback will be called from atomic
>> context.
>> TX and RX circular rings are used to allow queuing of multiple
>> transfers per controller. Controller can choose size of these rings
>> based of controller HW implementation. The buffers are coerently
>> mapped so that controller can utilize DMA operations for the
>> transactions without remapping every transaction buffer.
>> Statically allocated rings help to improve performance by avoiding
>> overhead of dynamically allocating transactions on need basis.
>>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Tested-by: Naveen Kaje <nkaje@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/slimbus/Makefile         |   2 +-
>>   drivers/slimbus/slim-core.c      |  15 ++
>>   drivers/slimbus/slim-messaging.c | 471 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/slimbus.h          | 161 +++++++++++++
>>   4 files changed, 648 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/slimbus/slim-messaging.c
>>
>> +/**
>> + * slim_processtxn: Process a slimbus-messaging transaction
>> + * @ctrl: Controller handle
>> + * @txn: Transaction to be sent over SLIMbus
>> + * Called by controller to transmit messaging transactions not dealing with
>> + * Interface/Value elements. (e.g. transmittting a message to assign logical
>> + * address to a slave device
>> + * Returns:
>> + * -ETIMEDOUT: If transmission of this message timed out (e.g. due to bus lines
>> + *	not being clocked or driven by controller)
>> + * -ENOTCONN: If the transmitted message was not ACKed by destination device.
>> + */
>> +int slim_processtxn(struct slim_controller *ctrl,
>> +				struct slim_msg_txn *txn)
> 
> Can all go on one line.
Thats true, Will fix it in next version.
> 
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
>> +	if (!async) {
>> +		txn->msg->comp_cb = NULL;
>> +		txn->msg->ctx = NULL;
>> +	}
> 
> What is the intent of this if statement here? We set async
> locally so this code only runs if we executed the else on the if
> statement at the top. If its just clearing anything the user
> might have put in these fields why not do it up there.
Its clearing the temporary callback and context field when user wants to 
read/write on simbus synchronously.

If async is false user should not put anything in comp_cb or ctx.
comp_cb and ctx are only used when drivers are doing asynchronous 
read/writes on slimbus. Completion of those are indicated by comp_cb() 
with context.



> 
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(slim_processtxn);
>> +
>> +int slim_xfer_msg(struct slim_controller *ctrl,
>> +			struct slim_device *sbdev, struct slim_val_inf *msg,
>> +			u8 mc)
>> +{
>> +	DEFINE_SLIM_LDEST_TXN(txn_stack, mc, 6, sbdev->laddr, msg);
>> +	struct slim_msg_txn *txn = &txn_stack;
>> +	int ret;
>> +	u16 sl, cur;
>> +
>> +	ret = slim_val_inf_sanity(ctrl, msg, mc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	sl = slim_slicesize(msg->num_bytes);
>> +
>> +	dev_dbg(&ctrl->dev, "SB xfer msg:os:%x, len:%d, MC:%x, sl:%x\n",
>> +		msg->start_offset, msg->num_bytes, mc, sl);
>> +
>> +	cur = slim_slicecodefromsize(sl);
> 
> cur should probably be removed until it is needed.
Yep.

> 
>> +	txn->ec = ((sl | (1 << 3)) | ((msg->start_offset & 0xFFF) << 4));
>> +
>> +	switch (mc) {
>> +	case SLIM_MSG_MC_REQUEST_CHANGE_VALUE:
>> +	case SLIM_MSG_MC_CHANGE_VALUE:
>> +	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
>> +	case SLIM_MSG_MC_CLEAR_INFORMATION:
>> +		txn->rl += msg->num_bytes;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (slim_tid_txn(txn->mt, txn->mc))
>> +		txn->rl++;
>> +
>> +	return slim_processtxn(ctrl, txn);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_xfer_msg);
>> +
>> +/* Message APIs Unicast message APIs used by slimbus slave drivers */
>> +
>> +/*
>> + * slim_request_val_element: request value element
>> + * @sb: client handle requesting elemental message reads, writes.
>> + * @msg: Input structure for start-offset, number of bytes to read.
>> + * context: can sleep
>> + * Returns:
>> + * -EINVAL: Invalid parameters
>> + * -ETIMEDOUT: If transmission of this message timed out (e.g. due to bus lines
>> + *	not being clocked or driven by controller)
>> + * -ENOTCONN: If the transmitted message was not ACKed by destination device.
>> + */
>> +int slim_request_val_element(struct slim_device *sb,
>> +				struct slim_val_inf *msg)
>> +{
>> +	struct slim_controller *ctrl = sb->ctrl;
>> +
>> +	if (!ctrl)
>> +		return -EINVAL;
> 
> You could put this check into slim_xfer_msg and save duplicating
> it. Would also then cover cases that call that function directly,
> also would let you make these functions either inlines or macros.

I will give that a try in next version.

> 
>> +
>> +	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_VALUE);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_request_val_element);
>> +
>> +/* Functions to get/return TX, RX buffers for messaging. */
>> +
>> +/**
>> + * slim_get_rx: To get RX buffers for messaging.
>> + * @ctrl: Controller handle
>> + * These functions are called by controller to process the RX buffers.
>> + * RX buffer is requested by controller when data is received from HW, but is
>> + * not processed (e.g. 'report-present message was sent by HW in ISR and SW
>> + * needs more time to process the buffer to assign Logical Address)
>> + * RX buffer is returned back to the pool when associated RX action
>> + * is taken (e.g. Received message is decoded and client's
>> + * response buffer is filled in.)
>> + */
>> +void *slim_get_rx(struct slim_controller *ctrl)
>> +{
>> +	unsigned long flags;
>> +	int idx;
>> +
>> +	spin_lock_irqsave(&ctrl->rx.lock, flags);
>> +	if ((ctrl->rx.tail + 1) % ctrl->rx.n == ctrl->rx.head) {
>> +		spin_unlock_irqrestore(&ctrl->rx.lock, flags);
>> +		dev_err(&ctrl->dev, "RX QUEUE full!");
>> +		return NULL;
>> +	}
>> +	idx = ctrl->rx.tail;
>> +	ctrl->rx.tail = (ctrl->rx.tail + 1) % ctrl->rx.n;
>> +	spin_unlock_irqrestore(&ctrl->rx.lock, flags);
>> +
>> +	return ctrl->rx.base + (idx * ctrl->rx.sl_sz);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_get_rx);
>> +
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
> 
> I find the combination of get/return a bit odd, would get/put
> maybe more idiomatic? Also the return could use some kernel doc.

If that makes it more readable I can rename the functions as suggested, 
and I will also add kernel doc in next version.

> 
>> +
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
>> +
>> +/**
>> + * slim_get_tx: To get TX buffers for messaging.
>> + * @ctrl: Controller handle
>> + * These functions are called by controller to process the TX buffers.
>> + * TX buffer is requested by controller when it's filled-in and sent to the
>> + * HW. When HW has finished processing this buffer, controller should return it
>> + * back to the pool.
>> + */
>> +void *slim_get_tx(struct slim_controller *ctrl, struct slim_msg_txn *txn,
>> +		bool need_tid)
>> +{
>> +	unsigned long flags;
>> +	int ret, idx;
>> +
>> +	ret = down_interruptible(&ctrl->tx_sem);
>> +	if (ret < 0) {
>> +		dev_err(&ctrl->dev, "TX semaphore down returned:%d", ret);
>> +		return NULL;
>> +	}
>> +	spin_lock_irqsave(&ctrl->tx.lock, flags);
>> +
>> +	if (((ctrl->tx.head + 1) % ctrl->tx.n) == ctrl->tx.tail) {
>> +		spin_unlock_irqrestore(&ctrl->tx.lock, flags);
>> +		dev_err(&ctrl->dev, "controller TX buf unavailable");
>> +		up(&ctrl->tx_sem);
>> +		return NULL;
>> +	}
>> +	idx = ctrl->tx.tail;
>> +	ctrl->tx.tail = (ctrl->tx.tail + 1) % ctrl->tx.n;
>> +	ctrl->pending_wr[idx].cb = txn->msg->comp_cb;
>> +	ctrl->pending_wr[idx].ctx = txn->msg->ctx;
>> +	ctrl->pending_wr[idx].need_tid = need_tid;
>> +	spin_unlock_irqrestore(&ctrl->tx.lock, flags);
>> +
>> +	return ctrl->tx.base + (idx * ctrl->tx.sl_sz);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_get_tx);
> 
> The rx calls seem ok that is basically the controller's job to
> call those, but with these two calls it seems sometimes the
> framework calls them sometimes the controller driver has to. Is
> there anyway we can simplify that a bit? Or at least include some
> documentation as to when the controller should call them.

I will try to do add some details in the document in next version.

> 
>> diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
>> index b5064b6..080d86a 100644
>> --- a/include/linux/slimbus.h
>> +++ b/include/linux/slimbus.h
>> @@ -15,6 +15,7 @@
>>   #include <linux/module.h>
>>   #include <linux/device.h>
>>   #include <linux/mutex.h>
>> +#include <linux/semaphore.h>
>>   #include <linux/mod_devicetable.h>
>>   
>>   /**
>> @@ -34,6 +35,9 @@ extern struct bus_type slimbus_type;
>>   #define SLIM_FRM_SLOTS_PER_SUPERFRAME	16
>>   #define SLIM_GDE_SLOTS_PER_SUPERFRAME	2
>>   
>> +/* MAX in-flight transactions neededing transaction ID (8-bit, per spec) */
> 
> s/neededing/needing/
> 
Will fix this in next version.
>> +
>> +/* Frequently used message transaction structures */
>> +#define DEFINE_SLIM_LDEST_TXN(name, mc, rl, la, msg) \
>> +	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_LOGICALADDR, 0,\
>> +					0, la, msg, }
>> +
>> +#define DEFINE_SLIM_BCAST_TXN(name, mc, rl, la, msg) \
>> +	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_BROADCAST, 0,\
>> +					0, la, msg, }
> 
> If the LA isn't used in broadcast messages wouldn't it be simpler
> to set it to a fixed value in this macro?
> 
Yep, if the destination type is broadcast we should not set la or ea in 
the header. may be set 0 here.

>> +
>> +#define DEFINE_SLIM_EDEST_TXN(name, mc, rl, la, msg) \
>> +	struct slim_msg_txn name = { rl, 0, mc, SLIM_MSG_DEST_ENUMADDR, 0,\
>> +					0, la, msg, }
>> +
> 
> Also one final overall comment this commit contains a lot of two
> and three letter abreviations that are not always clear. I would
> probably suggest expanding a few of the less standard ones out to
> make the code a little easier to follow.
Will do that!!

thanks
srini
> 
> Thanks,
> Charles
> 
