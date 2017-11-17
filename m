From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 06/13] slimbus: Add messaging APIs to slimbus framework
Date: Fri, 17 Nov 2017 13:18:35 +0530
Message-ID: <20171117074834.GM3187@localhost>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-7-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171115141043.29202-7-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 02:10:36PM +0000, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:

> +void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
> +{
> +	struct slim_msg_txn *txn;
> +	struct slim_val_inf *msg;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ctrl->txn_lock, flags);

Do you need this to be a _irqsave variant? What is the context of io
transfers in this case

> +/**
> + * slim_do_transfer() - Process a slimbus-messaging transaction
> + *
> + * @ctrl: Controller handle
> + * @txn: Transaction to be sent over SLIMbus
> + *
> + * Called by controller to transmit messaging transactions not dealing with
> + * Interface/Value elements. (e.g. transmittting a message to assign logical
> + * address to a slave device
> + *
> + * Return: -ETIMEDOUT: If transmission of this message timed out
> + *	(e.g. due to bus lines not being clocked or driven by controller)
> + *	-ENOTCONN: If the transmitted message was not ACKed by destination
> + *	device.

I am preferring ENODATA in SDW for this case, as Slaves didnt respond or
ACK.

ENOTCONN is defined as /* Transport endpoint is not connected */ which is
not the case here, connected yes but not responded.

> +static int slim_val_inf_sanity(struct slim_controller *ctrl,
> +			       struct slim_val_inf *msg, u8 mc)
> +{
> +	if (!msg || msg->num_bytes > 16 ||
> +	    (msg->start_offset + msg->num_bytes) > 0xC00)
> +		goto reterr;
> +	switch (mc) {
> +	case SLIM_MSG_MC_REQUEST_VALUE:
> +	case SLIM_MSG_MC_REQUEST_INFORMATION:
> +		if (msg->rbuf != NULL)
> +			return 0;
> +		break;

empty line here and after each break make it look better

> +	case SLIM_MSG_MC_CHANGE_VALUE:
> +	case SLIM_MSG_MC_CLEAR_INFORMATION:
> +		if (msg->wbuf != NULL)
> +			return 0;
> +		break;
> +	case SLIM_MSG_MC_REQUEST_CHANGE_VALUE:
> +	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
> +		if (msg->rbuf != NULL && msg->wbuf != NULL)
> +			return 0;
> +		break;
> +	default:
> +		break;

this seems superflous and we can just fall thru to error below.

> +	}
> +reterr:
> +	dev_err(ctrl->dev, "Sanity check failed:msg:offset:0x%x, mc:%d\n",
> +		msg->start_offset, mc);
> +	return -EINVAL;

...

> +static int slim_xfer_msg(struct slim_controller *ctrl,
> +			 struct slim_device *sbdev,
> +			 struct slim_val_inf *msg, u8 mc)
> +{
> +	DEFINE_SLIM_LDEST_TXN(txn_stack, mc, 6, sbdev->laddr, msg);
> +	struct slim_msg_txn *txn = &txn_stack;
> +	int ret;
> +	u16 sl;
> +
> +	ret = slim_val_inf_sanity(ctrl, msg, mc);
> +	if (ret)
> +		return ret;
> +
> +	sl = slim_slicesize(msg->num_bytes);
> +
> +	dev_dbg(ctrl->dev, "SB xfer msg:os:%x, len:%d, MC:%x, sl:%x\n",
> +		msg->start_offset, msg->num_bytes, mc, sl);

better to add tracing support for these debug prints

> +
> +	txn->ec = ((sl | (1 << 3)) | ((msg->start_offset & 0xFFF) << 4));
> +
> +	switch (mc) {
> +	case SLIM_MSG_MC_REQUEST_CHANGE_VALUE:
> +	case SLIM_MSG_MC_CHANGE_VALUE:
> +	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
> +	case SLIM_MSG_MC_CLEAR_INFORMATION:
> +		txn->rl += msg->num_bytes;
> +	default:
> +		break;
> +	}
> +
> +	if (slim_tid_txn(txn->mt, txn->mc))
> +		txn->rl++;
> +
> +	return slim_do_transfer(ctrl, txn);
> +}
> +
> +/**
> + * slim_request_val_element() - request value element
> + *
> + * @sb: client handle requesting elemental message reads, writes.
> + * @msg: Input structure for start-offset, number of bytes to read.
> + * context: can sleep
> + *
> + * Return: -EINVAL: Invalid parameters
> + *	-ETIMEDOUT: If transmission of this message timed out (e.g. due to
> + *	 bus lines not being clocked or driven by controller)
> + *	-ENOTCONN: If the transmitted message was not ACKed by the device.
> + */
> +int slim_request_val_element(struct slim_device *sb,
> +				struct slim_val_inf *msg)
> +{
> +	struct slim_controller *ctrl = sb->ctrl;
> +
> +	if (!ctrl)
> +		return -EINVAL;
> +
> +	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_VALUE);
> +}
> +EXPORT_SYMBOL_GPL(slim_request_val_element);
> +
> +/**
> + * slim_request_inf_element() - Request a info element
> + *
> + * @sb: client handle requesting elemental message reads.
> + * @msg: Input structure for start-offset, number of bytes to read
> + *	wbuf will contain information element(s) bit masks to be cleared.
> + *	rbuf will return what the information element value was
> + */
> +int slim_request_inf_element(struct slim_device *sb,
> +				struct slim_val_inf *msg)
> +{
> +	struct slim_controller *ctrl = sb->ctrl;
> +
> +	if (!ctrl)
> +		return -EINVAL;
> +
> +	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_INFORMATION);
> +}
> +EXPORT_SYMBOL_GPL(slim_request_inf_element);
> +
> +/**
> + * slim_change_val_element: change a given value element
> + *
> + * @sb: client handle requesting elemental message reads, writes.
> + * @msg: Input structure for start-offset, number of bytes to write.
> + * context: can sleep
> + *
> + * Return:
> + *	-EINVAL: Invalid parameters
> + *	-ETIMEDOUT: If transmission of this message timed out (e.g. due to
> + *	 bus lines not being clocked or driven by controller)
> + *	-ENOTCONN: If the transmitted message was not ACKed by the device.
> + */
> +int slim_change_val_element(struct slim_device *sb, struct slim_val_inf *msg)
> +{
> +	struct slim_controller *ctrl = sb->ctrl;
> +
> +	if (!ctrl)
> +		return -EINVAL;
> +
> +	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_CHANGE_VALUE);
> +}
> +EXPORT_SYMBOL_GPL(slim_change_val_element);
> +
> +/**
> + * slim_clear_inf_element() - Clear info element
> + *
> + * @sb: client handle requesting elemental message reads, writes.
> + * @msg: Input structure for start-offset, number of bytes to read
> + *	wbuf will contain information element(s) bit masks to be cleared.
> + *	rbuf will return what the information element value was
> + */
> +int slim_clear_inf_element(struct slim_device *sb, struct slim_val_inf *msg)
> +{
> +	struct slim_controller *ctrl = sb->ctrl;
> +
> +	if (!ctrl)
> +		return -EINVAL;
> +
> +	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_CLEAR_INFORMATION);
> +}
> +EXPORT_SYMBOL_GPL(slim_clear_inf_element);
> +
> +/**
> + * slim_request_val_element() - change and request a given value element
> + *
> + * @sb: client handle requesting elemental message reads, writes.
> + * @msg: Input structure for start-offset, number of bytes to write.
> + * context: can sleep
> + *
> + * Return:
> + *	-EINVAL: Invalid parameters
> + *	-ETIMEDOUT: If transmission of this message timed out (e.g. due to
> + *	 bus lines not being clocked or driven by controller)
> + *	-ENOTCONN: If the transmitted message was not ACKed by the device.
> + */
> +int slim_request_change_val_element(struct slim_device *sb,
> +					struct slim_val_inf *msg)
> +{
> +	struct slim_controller *ctrl = sb->ctrl;
> +
> +	if (!ctrl)
> +		return -EINVAL;
> +
> +	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_CHANGE_VALUE);
> +}
> +EXPORT_SYMBOL_GPL(slim_request_change_val_element);

looking at this, does it really help to have different APIs for SLIM_MSG_XXX
why not slim_xfer_msg() be an exported one..

> +int slim_write(struct slim_device *sdev, u32 addr, size_t count, u8 *val)
> +{
> +	struct slim_val_inf msg;
> +	int ret;
> +
> +	slim_fill_msg(&msg, addr, count,  val, NULL);
> +	ret = slim_change_val_element(sdev, &msg);

return slim_change_val_element()

> +
> +	return ret;
> +
> +}

...

> +/* Destination type Values */
> +#define SLIM_MSG_DEST_LOGICALADDR	0
> +#define SLIM_MSG_DEST_ENUMADDR		1
> +#define	SLIM_MSG_DEST_BROADCAST		3
	^^^
why tab here
 

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
