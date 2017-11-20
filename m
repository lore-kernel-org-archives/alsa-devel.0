From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 06/13] slimbus: Add messaging APIs to slimbus framework
Date: Mon, 20 Nov 2017 06:47:52 +0000
Message-ID: <d58b8cca-7b28-75be-8081-dad6595f499d@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-7-srinivas.kandagatla@linaro.org>
 <20171117074834.GM3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171117074834.GM3187@localhost>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

thanks for the comments,

On 17/11/17 07:48, Vinod Koul wrote:
> On Wed, Nov 15, 2017 at 02:10:36PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>> +void slim_msg_response(struct slim_controller *ctrl, u8 *reply, u8 tid, u8 len)
>> +{
>> +	struct slim_msg_txn *txn;
>> +	struct slim_val_inf *msg;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ctrl->txn_lock, flags);
> 
> Do you need this to be a _irqsave variant? What is the context of io
> transfers in this case
Yes, On Qcom controller driver it is called in Interrupt context, but it 
depends on caller (controller driver) which could be in process context too.

> 
>> +/**
>> + * slim_do_transfer() - Process a slimbus-messaging transaction
>> + *
>> + * @ctrl: Controller handle
>> + * @txn: Transaction to be sent over SLIMbus
>> + *
>> + * Called by controller to transmit messaging transactions not dealing with
>> + * Interface/Value elements. (e.g. transmittting a message to assign logical
>> + * address to a slave device
>> + *
>> + * Return: -ETIMEDOUT: If transmission of this message timed out
>> + *	(e.g. due to bus lines not being clocked or driven by controller)
>> + *	-ENOTCONN: If the transmitted message was not ACKed by destination
>> + *	device.
> 
> I am preferring ENODATA in SDW for this case, as Slaves didnt respond or
> ACK.
Isn't that a timeout error then.

ENODATA is for "No data available", reporting ENODATA would be misleading.

> 
> ENOTCONN is defined as /* Transport endpoint is not connected */ which is
> not the case here, connected yes but not responded.

Code as it is would not return this, so i will be deleting ENOTCONN from 
kernel doc.

> 
>> +static int slim_val_inf_sanity(struct slim_controller *ctrl,
>> +			       struct slim_val_inf *msg, u8 mc)
>> +{
>> +	if (!msg || msg->num_bytes > 16 ||
>> +	    (msg->start_offset + msg->num_bytes) > 0xC00)
>> +		goto reterr;
>> +	switch (mc) {
>> +	case SLIM_MSG_MC_REQUEST_VALUE:
>> +	case SLIM_MSG_MC_REQUEST_INFORMATION:
>> +		if (msg->rbuf != NULL)
>> +			return 0;
>> +		break;
> 
> empty line here and after each break make it look better
Yep, will remove this in next version.
> 
>> +	case SLIM_MSG_MC_CHANGE_VALUE:
>> +	case SLIM_MSG_MC_CLEAR_INFORMATION:
>> +		if (msg->wbuf != NULL)
>> +			return 0;
>> +		break;
>> +	case SLIM_MSG_MC_REQUEST_CHANGE_VALUE:
>> +	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
>> +		if (msg->rbuf != NULL && msg->wbuf != NULL)
>> +			return 0;
>> +		break;
>> +	default:
>> +		break;
> 
> this seems superflous and we can just fall thru to error below.
> 
Agree..
will fix it in next version.
>> +	}
>> +reterr:
>> +	dev_err(ctrl->dev, "Sanity check failed:msg:offset:0x%x, mc:%d\n",
>> +		msg->start_offset, mc);
>> +	return -EINVAL;
> 
> ...
> 
>> +static int slim_xfer_msg(struct slim_controller *ctrl,
>> +			 struct slim_device *sbdev,
>> +			 struct slim_val_inf *msg, u8 mc)
>> +{
>> +	DEFINE_SLIM_LDEST_TXN(txn_stack, mc, 6, sbdev->laddr, msg);
>> +	struct slim_msg_txn *txn = &txn_stack;
>> +	int ret;
>> +	u16 sl;
>> +
>> +	ret = slim_val_inf_sanity(ctrl, msg, mc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	sl = slim_slicesize(msg->num_bytes);
>> +
>> +	dev_dbg(ctrl->dev, "SB xfer msg:os:%x, len:%d, MC:%x, sl:%x\n",
>> +		msg->start_offset, msg->num_bytes, mc, sl);
> 
> better to add tracing support for these debug prints
> 
Will explore tracing side of it..
>> +
>> +	txn->ec = ((sl | (1 << 3)) | ((msg->start_offset & 0xFFF) << 4));
>> +
>> +	switch (mc) {
>> +	case SLIM_MSG_MC_REQUEST_CHANGE_VALUE:
>> +	case SLIM_MSG_MC_CHANGE_VALUE:
>> +	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
>> +int slim_request_change_val_element(struct slim_device *sb,
>> +					struct slim_val_inf *msg)
>> +{
>> +	struct slim_controller *ctrl = sb->ctrl;
>> +
>> +	if (!ctrl)
>> +		return -EINVAL;
>> +
>> +	return slim_xfer_msg(ctrl, sb, msg, SLIM_MSG_MC_REQUEST_CHANGE_VALUE);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_request_change_val_element);
> 
> looking at this, does it really help to have different APIs for SLIM_MSG_XXX
> why not slim_xfer_msg() be an exported one..

I did think about this cleanup, and it makes sense.

I will have a go at removing this and just leaving slim_readb/writeb() 
slim_read/write() and slim_xfer_msg() API's in next version.

We can discuss to add this in future incase its required.


> 
>> +int slim_write(struct slim_device *sdev, u32 addr, size_t count, u8 *val)
>> +{
>> +	struct slim_val_inf msg;
>> +	int ret;
>> +
>> +	slim_fill_msg(&msg, addr, count,  val, NULL);
>> +	ret = slim_change_val_element(sdev, &msg);
> 
> return slim_change_val_element()
Makes sense.

> 
>> +
>> +	return ret;
>> +
>> +}
> 
> ...
> 
>> +/* Destination type Values */
>> +#define SLIM_MSG_DEST_LOGICALADDR	0
>> +#define SLIM_MSG_DEST_ENUMADDR		1
>> +#define	SLIM_MSG_DEST_BROADCAST		3
> 	^^^
> why tab here
Will fix it in next version.
>   
> 
