From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v6 2/7] slimbus: Add messaging APIs to slimbus framework
Date: Sat, 7 Oct 2017 11:24:33 +0100
Message-ID: <42030379-6dba-115b-6150-a614e72cccfc@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
 <20171007064238.odg7ju6pvqudzf6p@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171007064238.odg7ju6pvqudzf6p@latitude>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kheitke-hxvC4TZJLZFWk0Htik3J/w@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Thanks for the comments.

On 07/10/17 07:42, Jonathan Neuschäfer wrote:
> Hi,
> 
> On Fri, Oct 06, 2017 at 05:51:31PM +0200, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
> 
> s/based of/based on/
> s/coerently/coherently/
Yep.. will fix this in next version.
> 
>> mapped so that controller can utilize DMA operations for the
>> transactions without remapping every transaction buffer.
>> Statically allocated rings help to improve performance by avoiding
>> overhead of dynamically allocating transactions on need basis.
>>
>> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Tested-by: Naveen Kaje <nkaje-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
> [...]
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
>> +	txn->ec = ((sl | (1 << 3)) | ((msg->start_offset & 0xFFF) << 4));
> 
> Shouldn't this be (cur | (1 << 3)?
cur seems to be redundant TBH, the only difference between cur and sl is 
that the slim_slicesize() can give slice size to program for any lengths 
between 1-16 bytes. However the slim_slicecodefromsize() can only 
handle 1,2,3,4, 6,8,12,16 byte sizes.

So we can delete slim_slicecodefromsize() call and function together.
looks like it was a leftover from downstream.

> (Also, what does cur mean? Cursor? Current?)
No Idea!! :-) it is supposed to return slice size as per number of bytes.

> 
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
> [...]
>> +/*
>> + * slim_request_val_element: change and request a given value element

name should be fixed here..
>> + * @sb: client handle requesting elemental message reads, writes.
>> + * @msg: Input structure for start-offset, number of bytes to write.
>> + * context: can sleep
>> + * Returns:
>> + * -EINVAL: Invalid parameters
>> + * -ETIMEDOUT: If transmission of this message timed out (e.g. due to bus lines
>> + *	not being clocked or driven by controller)
>> + * -ENOTCONN: If the transmitted message was not ACKed by destination device.
> 
> Does rbuf contain the old value after this function finishes?
> 
Yep, device should send a reply value with the old value with matching tid.

>> + */
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
> [...]
>> +/**
>> + * struct slim_pending: context of pending transfers
>> + * @cb: callback for this transfer
>> + * @ctx: contex for the callback function
> 
> s/contex/context/
> 
Will fix all these instances.
>> + * @need_tid: True if this transfer need Transaction ID
>> + */
>> +struct slim_pending {
>> +	void (*cb)(void *ctx, int err);
>> +	void *ctx;
>> +	bool need_tid;
>> +};
> 
> 
> Thanks,
> Jonathan Neuschäfer
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
