From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH 2/2] slimbus: ngd: add stream support
Date: Mon, 25 Jun 2018 10:13:06 +0530
Message-ID: <20180625044306.GA2404@vkoul-mobl>
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621134009.27116-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, sdharia@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, ctatlor97@gmail.com
List-Id: alsa-devel@alsa-project.org

On 21-06-18, 14:40, Srinivas Kandagatla wrote:

> +	if (txn->mt == SLIM_MSG_MT_CORE &&
> +		(txn->mc == SLIM_MSG_MC_CONNECT_SOURCE ||
> +		txn->mc == SLIM_MSG_MC_CONNECT_SINK ||
> +		txn->mc == SLIM_MSG_MC_DISCONNECT_PORT)) {
> +
> +		txn->mt = SLIM_MSG_MT_DEST_REFERRED_USER;
> +		if (txn->mc == SLIM_MSG_MC_CONNECT_SOURCE)
> +			txn->mc = SLIM_USR_MC_CONNECT_SRC;
> +		else if (txn->mc == SLIM_MSG_MC_CONNECT_SINK)
> +			txn->mc = SLIM_USR_MC_CONNECT_SINK;
> +		else if (txn->mc == SLIM_MSG_MC_DISCONNECT_PORT)
> +			txn->mc = SLIM_USR_MC_DISCONNECT_PORT;

How about a switch case for this

> +		i = 0;
> +		wbuf[i++] = txn->la;
> +		la = SLIM_LA_MGR;
> +		wbuf[i++] = txn->msg->wbuf[0];
> +		if (txn->mc != SLIM_USR_MC_DISCONNECT_PORT)
> +			wbuf[i++] = txn->msg->wbuf[1];
> +
> +		txn->comp = &done;
> +		ret = slim_alloc_txn_tid(sctrl, txn);
> +		if (ret) {
> +			dev_err(ctrl->dev, "Unable to allocate TID\n");
> +			return ret;
> +		}
> +
> +		wbuf[i++] = txn->tid;
> +
> +		txn->msg->num_bytes = i;
> +		txn->msg->wbuf = wbuf;
> +		txn->msg->rbuf = rbuf;
> +		txn->rl = txn->msg->num_bytes + 4;
> +	}
> +
>  	/* HW expects length field to be excluded */
>  	txn->rl--;
>  	puc = (u8 *)pbuf;
> @@ -830,6 +869,19 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
>  		return -ETIMEDOUT;
>  	}
>  
> +	if (txn->mt == SLIM_MSG_MT_DEST_REFERRED_USER &&
> +		(txn->mc == SLIM_USR_MC_CONNECT_SRC ||
> +		 txn->mc == SLIM_USR_MC_CONNECT_SINK ||
> +		 txn->mc == SLIM_USR_MC_DISCONNECT_PORT)) {

how about precalculate this check and use:
        bool something = txn->mt == SLIM_MSG_MT_DEST_REFERRED_USER &&
                              txn->mc == SLIM_USR_MC_CONNECT_SRC ||
                              txn->mc == SLIM_USR_MC_CONNECT_SINK ||
                              txn->mc == SLIM_USR_MC_DISCONNECT_PORT;

and then use in this case and previous one, make code better to read

        if (something) {
> +		timeout = wait_for_completion_timeout(&done, HZ);
> +		if (!timeout) {
> +			dev_err(sctrl->dev, "TX timed out:MC:0x%x,mt:0x%x",
> +				txn->mc, txn->mt);
> +			return -ETIMEDOUT;
> +		}
> +
> +	}
> +

[...]

> +		struct slim_port *port = &rt->ports[i];
> +
> +		if (txn.msg->num_bytes == 0) {
> +			int seg_interval = SLIM_SLOTS_PER_SUPERFRAME/rt->ratem;
> +			int exp;
> +
> +			wbuf[txn.msg->num_bytes++] = sdev->laddr;
> +			wbuf[txn.msg->num_bytes] = rt->bps >> 2 |
> +						   (port->ch.aux_fmt << 6);
> +
> +			/* Data channel segment interval not multiple of 3 */
> +			exp = seg_interval % 3;
> +			if (exp)
> +				wbuf[txn.msg->num_bytes] |= BIT(5);
> +
> +			txn.msg->num_bytes++;
> +			wbuf[txn.msg->num_bytes++] = exp << 4 | rt->prot;
> +
> +			if (rt->prot == SLIM_PROTO_ISO)
> +				wbuf[txn.msg->num_bytes++] =
> +						port->ch.prrate |
> +						SLIM_CHANNEL_CONTENT_FL;
> +			else
> +				wbuf[txn.msg->num_bytes++] =  port->ch.prrate;
> +
> +			ret = slim_alloc_txn_tid(ctrl, &txn);
> +			if (ret) {
> +				dev_err(&sdev->dev, "Fail to allocate TID\n");
> +				return -ENXIO;
> +			}
> +			wbuf[txn.msg->num_bytes++] = txn.tid;
> +		}
> +		wbuf[txn.msg->num_bytes++] = port->ch.id;
> +	}
> +
> +	txn.mc = SLIM_USR_MC_DEF_ACT_CHAN;
> +	txn.rl = txn.msg->num_bytes + 4;
> +	ret = qcom_slim_ngd_xfer_msg_sync(ctrl, &txn);
> +	if (ret) {
> +		slim_free_txn_tid(ctrl, &txn);
> +		dev_err(&sdev->dev, "TX timed out:MC:0x%x,mt:0x%x", txn.mc,
> +				txn.mt);
> +		return ret;
> +	}
> +
> +	txn.mc = SLIM_USR_MC_RECONFIG_NOW;
> +	txn.msg->num_bytes = 2;
> +	wbuf[1] = sdev->laddr;
> +	txn.rl = txn.msg->num_bytes + 4;
> +
> +	ret = slim_alloc_txn_tid(ctrl, &txn);
> +	if (ret) {

what about tid allocated in previous loop.. they are not freed here on
error and seems to be overwritten by this allocation.
-- 
~Vinod
