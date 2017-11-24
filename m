From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 11/13] slimbus: qcom: Add Qualcomm Slimbus controller
 driver
Date: Fri, 24 Nov 2017 14:39:59 +0000
Message-ID: <6e0b6516-c5dd-d76c-15e8-1cbe0550059f@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-12-srinivas.kandagatla@linaro.org>
 <20171123100703.gqwcdm7qij63cuwz@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171123100703.gqwcdm7qij63cuwz@localhost.localdomain>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

Thanks for your review,

On 23/11/17 10:07, Charles Keepax wrote:
>> +static irqreturn_t qcom_slim_handle_rx_irq(struct qcom_slim_ctrl *ctrl,
>> +					   u32 stat)
>> +{
>> +	u32 *rx_buf, pkt[10];
>> +	bool q_rx = false;
>> +	u8 la, *buf, mc, mt, len, *b = (u8 *)&pkt[0];
>> +	u16 ele;
>> +
> 
> This function feels pretty funky, we basically have rx_buf, pkt,
> b and buf all of which basically point to the same thing. Can we
> simplify it a little?
I will give that a try before I send next version.
> 
>> +	pkt[0] = readl_relaxed(ctrl->base + MGR_RX_MSG);
>> +	mt = SLIM_HEADER_GET_MT(b[0]);
>> +	len = SLIM_HEADER_GET_RL(b[0]);
>> +	mc = SLIM_HEADER_GET_MC(b[1]);
>> +
>> +	/*
...

>> +
>> +	puc = (u8 *)pbuf;
>> +	head = (u32 *)pbuf;
>> +
>> +	if (txn->dt == SLIM_MSG_DEST_LOGICALADDR)
>> +		*head = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt, txn->mc, 0,
>> +						la);
>> +	else
>> +		*head = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt, txn->mc, 1,
>> +						la);
>> +
>> +	if (txn->dt == SLIM_MSG_DEST_LOGICALADDR)
>> +		puc += 3;
>> +	else
>> +		puc += 2;
> 
> Combine these two if statements, makes it much clearer the actions
> are related.
I agree!!

> 
>> +
>> +	if (txn->mt == SLIM_MSG_MT_CORE && slim_tid_txn(txn->mt, txn->mc))
> 
> slim_tid_txn checks for SLIM_MSG_MT_CORE so the check here should
> be redundant.
> 
Yep, will remove this in next version.

>> +		*(puc++) = txn->tid;
>> +
>> +	if ((txn->mt == SLIM_MSG_MT_CORE) &&
>> +		((txn->mc >= SLIM_MSG_MC_REQUEST_INFORMATION &&
>> +		txn->mc <= SLIM_MSG_MC_REPORT_INFORMATION) ||
>> +		(txn->mc >= SLIM_MSG_MC_REQUEST_VALUE &&
>> +		 txn->mc <= SLIM_MSG_MC_CHANGE_VALUE))) {
>> +		*(puc++) = (txn->ec & 0xFF);
>> +		*(puc++) = (txn->ec >> 8) & 0xFF;
>> +	}
> 
> As you already have slim_tid_txn, would it be worth adding
> something like slim_ec_txn? 
I will give it a go and see how it looks like..

To state if an element code is
> required, feels like other controls will probably want to do a
> similar thing and would make the code a little more readable
> here.
> 
>> +
>> +	if (txn->msg && txn->msg->wbuf)
>> +		memcpy(puc, txn->msg->wbuf, txn->msg->num_bytes);
>> +
>> +	qcom_slim_queue_tx(ctrl, head, txn->rl, MGR_TX_MSG);
>> +	timeout = wait_for_completion_timeout(&done, msecs_to_jiffies(ms));
>> +
>> +	if (!timeout) {
>> +		dev_err(ctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
>> +					txn->mt);
>> +		ret = -ETIMEDOUT;
>> +	}
>> +
>> +	return ret;
>> +
>> +}
>> +
>> +static void qcom_slim_rxwq(struct work_struct *work)
>> +{
>> +	u8 buf[SLIM_MSGQ_BUF_LEN];
>> +	u8 mc, mt, len;
>> +	int i, ret;
>> +	struct qcom_slim_ctrl *ctrl = container_of(work, struct qcom_slim_ctrl,
>> +						 wd);
>> +
>> +	while ((slim_get_current_rxbuf(ctrl, buf)) != -ENODATA) {
>> +		len = SLIM_HEADER_GET_RL(buf[0]);
>> +		mt = SLIM_HEADER_GET_MT(buf[0]);
>> +		mc = SLIM_HEADER_GET_MC(buf[1]);
>> +		if (mt == SLIM_MSG_MT_CORE &&
>> +			mc == SLIM_MSG_MC_REPORT_PRESENT) {
>> +			u8 laddr;
>> +			struct slim_eaddr ea;
>> +			u8 e_addr[6];
>> +
>> +			for (i = 0; i < 6; i++)
>> +				e_addr[i] = buf[7-i];
>> +
>> +			ea.manf_id = (u16)(e_addr[5] << 8) | e_addr[4];
>> +			ea.prod_code = (u16)(e_addr[3] << 8) | e_addr[2];
>> +			ea.dev_index = e_addr[1];
>> +			ea.instance = e_addr[0];
> 
> If we are just bitshifting this out of the bytes does it really
> make it much more clear to reverse the byte order first? Feels
> like you might as well shift it out of buf directly.
> 
> Also we didn't bother to reverse the bytes for the element code
> above, so feels more consistent.
I will try Jonathan Neuschäfer Suggestion to simplify this area of code.
