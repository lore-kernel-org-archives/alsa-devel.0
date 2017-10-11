From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [Patch v6 2/7] slimbus: Add messaging APIs to
 slimbus framework
Date: Wed, 11 Oct 2017 10:08:14 +0530
Message-ID: <20171011043814.GF30097@localhost>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 06, 2017 at 05:51:31PM +0200, srinivas.kandagatla@linaro.org wrote:

>  	mutex_init(&ctrl->m_ctrl);
> +	spin_lock_init(&ctrl->tx.lock);
> +	spin_lock_init(&ctrl->rx.lock);

locks galore :) My assumption is that you want to optimize these? But given
that audio user is going to be serialized do we practically need two locks?

> +
> +	ctrl->pending_wr = kcalloc((ctrl->tx.n - 1),
> +				   sizeof(struct slim_pending),
> +				   GFP_KERNEL);
> +	if (!ctrl->pending_wr) {
> +		ret = -ENOMEM;
> +		goto wr_alloc_failed;
> +	}
> +
> +	sema_init(&ctrl->tx_sem, (ctrl->tx.n - 1));

i though v5 comment from Arnd was not to use semaphores..

> +/* Copyright (c) 2011-2016, The Linux Foundation. All rights reserved.

2017?

> +int slim_processtxn(struct slim_controller *ctrl,

slim_process_txn seems more readable to me

> +				struct slim_msg_txn *txn)
> +{
> +	int ret, i = 0;
> +	unsigned long flags;
> +	u8 *buf;
> +	bool async = false;
> +	struct slim_cb_data cbd;
> +	DECLARE_COMPLETION_ONSTACK(done);
> +	bool need_tid = slim_tid_txn(txn->mt, txn->mc);
> +
> +	if (!txn->msg->comp_cb) {
> +		txn->msg->comp_cb = slim_sync_default_cb;
> +		cbd.comp = &done;
> +		txn->msg->ctx = &cbd;
> +	} else {
> +		async = true;
> +	}
> +
> +	buf = slim_get_tx(ctrl, txn, need_tid);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (need_tid) {
> +		spin_lock_irqsave(&ctrl->txn_lock, flags);
> +		for (i = 0; i < ctrl->last_tid; i++) {
> +			if (ctrl->tid_tbl[i] == NULL)
> +				break;
> +		}
> +		if (i >= ctrl->last_tid) {
> +			if (ctrl->last_tid == (SLIM_MAX_TIDS - 1)) {
> +				spin_unlock_irqrestore(&ctrl->txn_lock, flags);
> +				slim_return_tx(ctrl, -ENOMEM);
> +				return -ENOMEM;
> +			}
> +			ctrl->last_tid++;
> +		}
> +		ctrl->tid_tbl[i] = txn->msg;
> +		txn->tid = i;
> +		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
> +	}
> +
> +	ret = ctrl->xfer_msg(ctrl, txn, buf);
> +
> +	if (!ret && !async) { /* sync transaction */
> +		/* Fine-tune calculation after bandwidth management */
> +		unsigned long ms = txn->rl + 100;
> +
> +		ret = wait_for_completion_timeout(&done,
> +						  msecs_to_jiffies(ms));
> +		if (!ret)
> +			slim_return_tx(ctrl, -ETIMEDOUT);
> +
> +		ret = cbd.ret;
> +	}
> +
> +	if (ret && need_tid) {
> +		spin_lock_irqsave(&ctrl->txn_lock, flags);
> +		/* Invalidate the transaction */
> +		ctrl->tid_tbl[txn->tid] = NULL;
> +		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
> +	}
> +	if (ret)
> +		dev_err(&ctrl->dev, "Tx:MT:0x%x, MC:0x%x, LA:0x%x failed:%d\n",
> +			txn->mt, txn->mc, txn->la, ret);
> +	if (!async) {
> +		txn->msg->comp_cb = NULL;
> +		txn->msg->ctx = NULL;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(slim_processtxn);

that is interesting, I was expecting this to be internal API. So users are
expected to use this which is not very convenient IMO. Can we hide the gory
details and give users simple tx/rx or read/write APIs. FWIW most of the
usage would be thru regmap where people would call regmap_read/write()

> +
> +static int slim_val_inf_sanity(struct slim_controller *ctrl,
> +			       struct slim_val_inf *msg, u8 mc)
> +{
> +	if (!msg || msg->num_bytes > 16 ||
> +	    (msg->start_offset + msg->num_bytes) > 0xC00)
> +		goto reterr;

line break here

> +	switch (mc) {
> +	case SLIM_MSG_MC_REQUEST_VALUE:
> +	case SLIM_MSG_MC_REQUEST_INFORMATION:

what does MC refer to?

> +		if (msg->rbuf != NULL)
> +			return 0;
> +		break;

after each break too

> +static u16 slim_slicecodefromsize(u16 req)

hmmm Linux code doesnt prefernamesnames like this :)

> +EXPORT_SYMBOL_GPL(slim_request_inf_element);
> +
> +

unnecessary double space

> +struct slim_val_inf {
> +	u16			start_offset;
> +	u8			num_bytes;
> +	u8			*rbuf;
> +	const u8		*wbuf;

can we do read and write, if not it can be a buf which maybe rbuf or wbug
based on type

-- 
~Vinod
