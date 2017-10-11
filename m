From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 2/7] slimbus: Add messaging APIs to
 slimbus framework
Date: Wed, 11 Oct 2017 10:42:28 +0100
Message-ID: <aa117cb8-ba59-894c-5a82-1b38facfa841@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
 <20171011043814.GF30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A82926735C
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 11:42:31 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id q124so3243424wmb.0
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 02:42:31 -0700 (PDT)
In-Reply-To: <20171011043814.GF30097@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, gregkh@linuxfoundation.org, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org



On 11/10/17 05:38, Vinod Koul wrote:
> On Fri, Oct 06, 2017 at 05:51:31PM +0200, srinivas.kandagatla@linaro.org wrote:
> 
>>   	mutex_init(&ctrl->m_ctrl);
>> +	spin_lock_init(&ctrl->tx.lock);
>> +	spin_lock_init(&ctrl->rx.lock);
> 
> locks galore :) My assumption is that you want to optimize these? But given
> that audio user is going to be serialized do we practically need two locks?
> 
If we remove the locking, It will be issue if we have multiple devices 
in a component, which is common atleast with the codec which am looking at.


>> +
>> +	ctrl->pending_wr = kcalloc((ctrl->tx.n - 1),
>> +				   sizeof(struct slim_pending),
>> +				   GFP_KERNEL);
>> +	if (!ctrl->pending_wr) {
>> +		ret = -ENOMEM;
>> +		goto wr_alloc_failed;
>> +	}
>> +
>> +	sema_init(&ctrl->tx_sem, (ctrl->tx.n - 1));
> 
> i though v5 comment from Arnd was not to use semaphores..

I will revisit this area once again and get rid of this semaphore all 
together in next version.

> 
>> +/* Copyright (c) 2011-2016, The Linux Foundation. All rights reserved.
> 
> 2017?
Yep.
> 
>> +int slim_processtxn(struct slim_controller *ctrl,
> 
> slim_process_txn seems more readable to me
> 
I can change it in next version.

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
>> +	if (!async) {
>> +		txn->msg->comp_cb = NULL;
>> +		txn->msg->ctx = NULL;
>> +	}
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(slim_processtxn);
> 
> that is interesting, I was expecting this to be internal API. So users are
> expected to use this which is not very convenient IMO. Can we hide the gory
> details and give users simple tx/rx or read/write APIs. FWIW most of the
> usage would be thru regmap where people would call regmap_read/write()
> 

Currently the only user of the api is qcom slim controller. May be the 
reason for it to use this api is to fit in with all the locking and 
sequencing mechanism with in the core.

I will be revisiting the semaphore thingy before I send next version, 
hopefully I can to align with your above comments.



>> +
>> +static int slim_val_inf_sanity(struct slim_controller *ctrl,
>> +			       struct slim_val_inf *msg, u8 mc)
>> +{
>> +	if (!msg || msg->num_bytes > 16 ||
>> +	    (msg->start_offset + msg->num_bytes) > 0xC00)
>> +		goto reterr;
> 
> line break here

I agree.

> 
>> +	switch (mc) {
>> +	case SLIM_MSG_MC_REQUEST_VALUE:
>> +	case SLIM_MSG_MC_REQUEST_INFORMATION:
> 
> what does MC refer to?

Message Code.

> 
>> +		if (msg->rbuf != NULL)
>> +			return 0;
>> +		break;
> 
> after each break too
> 
Sure, will fix it in next version.

>> +static u16 slim_slicecodefromsize(u16 req)
> 
> hmmm Linux code doesnt prefernamesnames like this :)
Yep, this function is unused, am going to delete this in next version.
> 
>> +EXPORT_SYMBOL_GPL(slim_request_inf_element);
>> +
>> +
> 
> unnecessary double space
> 
>> +struct slim_val_inf {
>> +	u16			start_offset;
>> +	u8			num_bytes;
>> +	u8			*rbuf;
>> +	const u8		*wbuf;
> 
> can we do read and write, if not it can be a buf which maybe rbuf or wbug
> based on type
With REQUEST_CHANGE_VALUE single command we can read old value at the 
same time we can write new value.

> 
