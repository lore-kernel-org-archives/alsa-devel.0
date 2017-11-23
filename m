From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v7 11/13] slimbus: qcom: Add Qualcomm
 Slimbus controller driver
Date: Thu, 23 Nov 2017 10:07:03 +0000
Message-ID: <20171123100703.gqwcdm7qij63cuwz@localhost.localdomain>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-12-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A0C2B267295
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 11:07:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171115141043.29202-12-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 02:10:41PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Sagar Dharia <sdharia@codeaurora.org>
> 
> This controller driver programs manager, interface, and framer
> devices for Qualcomm's slimbus HW block.
> Manager component currently implements logical address setting,
> and messaging interface.
> Interface device reports bus synchronization information, and framer
> device clocks the bus from the time it's woken up, until clock-pause
> is executed by the manager device.
> 
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> +
> +static irqreturn_t qcom_slim_handle_rx_irq(struct qcom_slim_ctrl *ctrl,
> +					   u32 stat)
> +{
> +	u32 *rx_buf, pkt[10];
> +	bool q_rx = false;
> +	u8 la, *buf, mc, mt, len, *b = (u8 *)&pkt[0];
> +	u16 ele;
> +

This function feels pretty funky, we basically have rx_buf, pkt,
b and buf all of which basically point to the same thing. Can we
simplify it a little?

> +	pkt[0] = readl_relaxed(ctrl->base + MGR_RX_MSG);
> +	mt = SLIM_HEADER_GET_MT(b[0]);
> +	len = SLIM_HEADER_GET_RL(b[0]);
> +	mc = SLIM_HEADER_GET_MC(b[1]);
> +
> +	/*
> +	 * this message cannot be handled by ISR, so
> +	 * let work-queue handle it
> +	 */
> +	if (mt == SLIM_MSG_MT_CORE &&
> +		mc == SLIM_MSG_MC_REPORT_PRESENT)
> +		rx_buf = (u32 *)slim_alloc_rxbuf(ctrl);
> +	else
> +		rx_buf = pkt;
> +
> +	if (rx_buf == NULL) {
> +		dev_err(ctrl->dev, "dropping RX:0x%x due to RX full\n",
> +					pkt[0]);
> +		goto rx_ret_irq;
> +	}
> +
> +	rx_buf[0] = pkt[0];

This is the only time that rx_buf is used without being cast to a
u8* would there be any milage in combining b and buf, and getting
rid of rx_buf?

> +	__ioread32_copy(rx_buf + 1, ctrl->base + MGR_RX_MSG + 4,
> +			DIV_ROUND_UP(len, 4));
> +
> +	switch (mc) {
> +
> +	case SLIM_MSG_MC_REPORT_PRESENT:
> +		q_rx = true;
> +		break;
> +	case SLIM_MSG_MC_REPLY_INFORMATION:
> +	case SLIM_MSG_MC_REPLY_VALUE:
> +		slim_msg_response(&ctrl->ctrl, (u8 *)(rx_buf + 1),
> +				  (u8)(*rx_buf >> 24), (len - 4));
> +		break;
> +	case SLIM_MSG_MC_REPORT_INFORMATION:
> +		buf = (u8 *)rx_buf;
> +		la = buf[2];
> +		ele = (u16)buf[4] << 4;
> +
> +		ele |= ((buf[3] & 0xf0) >> 4);
> +		/*
> +		 * report information is most likely loss of
> +		 * sync or collision detected in data slots
> +		 */
> +		dev_info(ctrl->dev, "LA:%d report inf ele:0x%x\n",
> +			 la, ele);
> +		break;
> +	default:
> +		dev_err(ctrl->dev, "unsupported MC,%x MT:%x\n",
> +			mc, mt);
> +		break;
> +	}
> +rx_ret_irq:
> +	writel(MGR_INT_RX_MSG_RCVD, ctrl->base +
> +		       MGR_INT_CLR);
> +	if (q_rx)
> +		queue_work(ctrl->rxwq, &ctrl->wd);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int qcom_xfer_msg(struct slim_controller *sctrl,
> +			 struct slim_msg_txn *txn)
> +{
> +	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(sctrl->dev);
> +	DECLARE_COMPLETION_ONSTACK(done);
> +	void *pbuf = slim_alloc_txbuf(ctrl, txn, &done);
> +	unsigned long ms = txn->rl + HZ;
> +	u8 *puc;
> +	int ret = 0, timeout, retries = QCOM_BUF_ALLOC_RETRIES;
> +	u8 la = txn->la;
> +	u32 *head;
> +	/* HW expects length field to be excluded */
> +	txn->rl--;
> +
> +	/* spin till buffer is made available */
> +	if (!pbuf) {
> +		while (retries--) {
> +			usleep_range(10000, 15000);
> +			pbuf = slim_alloc_txbuf(ctrl, txn, &done);
> +			if (pbuf)
> +				break;
> +		}
> +	}
> +
> +	if (!retries && !pbuf)
> +		return -ENOMEM;
> +
> +	puc = (u8 *)pbuf;
> +	head = (u32 *)pbuf;
> +
> +	if (txn->dt == SLIM_MSG_DEST_LOGICALADDR)
> +		*head = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt, txn->mc, 0,
> +						la);
> +	else
> +		*head = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt, txn->mc, 1,
> +						la);
> +
> +	if (txn->dt == SLIM_MSG_DEST_LOGICALADDR)
> +		puc += 3;
> +	else
> +		puc += 2;

Combine these two if statements, makes it much clearer the actions
are related.

> +
> +	if (txn->mt == SLIM_MSG_MT_CORE && slim_tid_txn(txn->mt, txn->mc))

slim_tid_txn checks for SLIM_MSG_MT_CORE so the check here should
be redundant.

> +		*(puc++) = txn->tid;
> +
> +	if ((txn->mt == SLIM_MSG_MT_CORE) &&
> +		((txn->mc >= SLIM_MSG_MC_REQUEST_INFORMATION &&
> +		txn->mc <= SLIM_MSG_MC_REPORT_INFORMATION) ||
> +		(txn->mc >= SLIM_MSG_MC_REQUEST_VALUE &&
> +		 txn->mc <= SLIM_MSG_MC_CHANGE_VALUE))) {
> +		*(puc++) = (txn->ec & 0xFF);
> +		*(puc++) = (txn->ec >> 8) & 0xFF;
> +	}

As you already have slim_tid_txn, would it be worth adding
something like slim_ec_txn? To state if an element code is
required, feels like other controls will probably want to do a
similar thing and would make the code a little more readable
here.

> +
> +	if (txn->msg && txn->msg->wbuf)
> +		memcpy(puc, txn->msg->wbuf, txn->msg->num_bytes);
> +
> +	qcom_slim_queue_tx(ctrl, head, txn->rl, MGR_TX_MSG);
> +	timeout = wait_for_completion_timeout(&done, msecs_to_jiffies(ms));
> +
> +	if (!timeout) {
> +		dev_err(ctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
> +					txn->mt);
> +		ret = -ETIMEDOUT;
> +	}
> +
> +	return ret;
> +
> +}
> +
> +static void qcom_slim_rxwq(struct work_struct *work)
> +{
> +	u8 buf[SLIM_MSGQ_BUF_LEN];
> +	u8 mc, mt, len;
> +	int i, ret;
> +	struct qcom_slim_ctrl *ctrl = container_of(work, struct qcom_slim_ctrl,
> +						 wd);
> +
> +	while ((slim_get_current_rxbuf(ctrl, buf)) != -ENODATA) {
> +		len = SLIM_HEADER_GET_RL(buf[0]);
> +		mt = SLIM_HEADER_GET_MT(buf[0]);
> +		mc = SLIM_HEADER_GET_MC(buf[1]);
> +		if (mt == SLIM_MSG_MT_CORE &&
> +			mc == SLIM_MSG_MC_REPORT_PRESENT) {
> +			u8 laddr;
> +			struct slim_eaddr ea;
> +			u8 e_addr[6];
> +
> +			for (i = 0; i < 6; i++)
> +				e_addr[i] = buf[7-i];
> +
> +			ea.manf_id = (u16)(e_addr[5] << 8) | e_addr[4];
> +			ea.prod_code = (u16)(e_addr[3] << 8) | e_addr[2];
> +			ea.dev_index = e_addr[1];
> +			ea.instance = e_addr[0];

If we are just bitshifting this out of the bytes does it really
make it much more clear to reverse the byte order first? Feels
like you might as well shift it out of buf directly.

Also we didn't bother to reverse the bytes for the element code
above, so feels more consistent.

> +			ret = slim_device_report_present(&ctrl->ctrl,
> +							 &ea, &laddr);
> +			if (ret < 0)
> +				dev_err(ctrl->dev, "assign laddr failed:%d\n",
> +					ret);
> +		} else {
> +			dev_err(ctrl->dev, "unexpected message:mc:%x, mt:%x\n",
> +				mc, mt);
> +		}
> +	}
> +}

Thanks,
Charles
