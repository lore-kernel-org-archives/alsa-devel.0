From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/2] slimbus: ngd: Add qcom SLIMBus NGD
	driver
Date: Mon, 21 May 2018 12:55:51 +0100
Message-ID: <b29bf75f-4846-ef73-b1da-509b62488944@linaro.org>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-3-srinivas.kandagatla@linaro.org>
 <20180521113314.GC14654@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 65D2926738C
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 13:55:54 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id a8-v6so24831400wmg.5
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 04:55:53 -0700 (PDT)
In-Reply-To: <20180521113314.GC14654@vkoul-mobl>
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
To: Vinod <vkoul@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, girishm@quicinc.com, bgoswami@codeaurora.org, gregkh@linuxfoundation.org, broonie@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, kramasub@codeaurora.org, linux-arm-msm@vger.kernel.org, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org

Thanks Vinod for the review!

On 21/05/18 12:33, Vinod wrote:
> On 16-05-18, 17:51, Srinivas Kandagatla wrote:
>> This patch adds suppor to Qualcomm SLIMBus Non-Generic Device (NGD)
> 
> /s/suppor/support
> 
Yep, Will fix this in next version.

>> +/* NGD (Non-ported Generic Device) registers */
>> +#define	NGD_CFG			0x0
>> +#define	NGD_CFG_ENABLE		BIT(0)
>> +#define	NGD_CFG_RX_MSGQ_EN	BIT(1)
>> +#define	NGD_CFG_TX_MSGQ_EN	BIT(2)
>> +#define	NGD_STATUS		0x4
>> +#define NGD_LADDR		BIT(1)
>> +#define	NGD_RX_MSGQ_CFG		0x8
>> +#define	NGD_INT_EN		0x10
>> +#define SLIMBUS_QMI_POWER_RESP_MAX_MSG_LEN 7
>> +#define SLIMBUS_QMI_SELECT_INSTANCE_REQ_MAX_MSG_LEN 14
>> +#define SLIMBUS_QMI_SELECT_INSTANCE_RESP_MAX_MSG_LEN 7
>> +#define SLIMBUS_QMI_CHECK_FRAMER_STAT_RESP_MAX_MSG_LEN 7
>> +/* QMI response timeout of 500ms */
>> +#define SLIMBUS_QMI_RESP_TOUT 1000
> 
> Tabs or spaces, take your pick and use one, not both...
I will check for such instances once again before sending v2.

> 
>> +static void qcom_slim_qmi_power_resp_cb(struct qmi_handle *handle,
>> +					struct sockaddr_qrtr *sq,
>> +					struct qmi_txn *txn, const void *data)
>> +{
>> +	struct slimbus_power_resp_msg_v01 *resp;
>> +
>> +	resp = (struct slimbus_power_resp_msg_v01 *)data;
> 
> you dont need cast away from void
It's a const void * so the compiler keeps complaining about this without 
cast.

> 
>> +	if (resp->resp.result != QMI_RESULT_SUCCESS_V01)
>> +		pr_err("%s: QMI power request failed 0x%x\n", __func__,
>> +				resp->resp.result);
> 
> cant we use dev_err?
I will have a look!
> 
>> +static int qcom_slim_qmi_send_power_request(struct qcom_slim_ngd_ctrl *ctrl,
>> +				struct slimbus_power_req_msg_v01 *req)
>> +{
>> +	struct slimbus_power_resp_msg_v01 resp = { { 0, 0 } };
>> +	struct qmi_txn txn;
>> +	int rc;
>> +
>> +	rc = qmi_txn_init(ctrl->qmi.handle, &txn,
>> +				slimbus_power_resp_msg_v01_ei, &resp);
>> +
>> +	rc = qmi_send_request(ctrl->qmi.handle, NULL, &txn,
>> +				SLIMBUS_QMI_POWER_REQ_V01,
>> +				SLIMBUS_QMI_POWER_REQ_MAX_MSG_LEN,
>> +				slimbus_power_req_msg_v01_ei, req);
>> +	if (rc < 0) {
>> +		dev_err(ctrl->dev, "%s: QMI send req fail %d\n", __func__, rc);
>> +		qmi_txn_cancel(&txn);
>> +	}
>> +
>> +	if (rc < 0)
>> +		return rc;
> 
> why not add this is prev error check?
Yes, we should move this to previous check, Will fix this in v2.
> 
>> +static int qcom_slim_qmi_init(struct qcom_slim_ngd_ctrl *ctrl,
>> +			      bool apps_is_master)
>> +{
>> +	int rc = 0;
> 
> superfluous init
> 
>> +static u32 *qcom_slim_ngd_tx_msg_get(struct qcom_slim_ngd_ctrl *ctrl, int len,
>> +				     struct completion *comp)
>> +{
>> +	struct qcom_slim_ngd_dma_desc *desc;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ctrl->tx_buf_lock, flags);
>> +
>> +	if ((ctrl->tx_tail + 1) % QCOM_SLIM_NGD_DESC_NUM == ctrl->tx_head) {
>> +		spin_unlock_irqrestore(&ctrl->tx_buf_lock, flags);
>> +		return NULL;
>> +	}
>> +	desc  = &ctrl->txdesc[ctrl->tx_tail];
>> +	desc->base = (u32 *)((u8 *)ctrl->tx_base +
>> +				(ctrl->tx_tail * SLIM_MSGQ_BUF_LEN));
> 
> too many casts
> 
>> +static int qcom_slim_ngd_post_rx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
>> +{
>> +	struct qcom_slim_ngd_dma_desc *desc;
>> +	struct dma_slave_config conf = {
>> +		.direction = DMA_DEV_TO_MEM,
>> +	};
>> +	int ret, i;
>> +
>> +	ret = dmaengine_slave_config(ctrl->dma_rx_channel, &conf);
> 
> so you are only setting direction for conf, not any other parameters? If not why
> bother setting direction
Nice hint, I will remove this!
> 
>> +	if (ret)
>> +		dev_err(ctrl->dev, "Error Configuring rx dma\n");
>> +
>> +	for (i = 0; i < QCOM_SLIM_NGD_DESC_NUM; i++) {
>> +		desc = &ctrl->rx_desc[i];
>> +		desc->phys = ctrl->rx_phys_base + i * SLIM_MSGQ_BUF_LEN;
>> +		desc->ctrl = ctrl;
>> +		desc->base = ctrl->rx_base + i * SLIM_MSGQ_BUF_LEN;
>> +		desc->desc = dmaengine_prep_slave_single(ctrl->dma_rx_channel,
>> +						desc->phys, SLIM_MSGQ_BUF_LEN,
>> +						DMA_DEV_TO_MEM,
>> +						DMA_PREP_INTERRUPT);
> 
> why issue multiple slave_single to dmaengine, you can bundle them and issue
> dmaengine_prep_slave_sg()..
Am reusing the descriptors here, My plan is to issue multiple 
descriptors with callback for each, and in each callback queue it back.

> 
>> +static int qcom_slim_ngd_qmi_svc_event_init(struct qcom_slim_ngd_qmi *qmi)
>> +{
>> +	int ret = 0;
> 
> superfluous init here too
> 
Yep.
>> +static int qcom_slim_ngd_runtime_idle(struct device *dev)
>> +{
>> +	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +	if (ctrl->state == QCOM_SLIM_NGD_CTRL_AWAKE)
>> +		ctrl->state = QCOM_SLIM_NGD_CTRL_IDLE;
>> +	pm_request_autosuspend(dev);
>> +	return -EAGAIN;
>> +}
>> +
>> +
> 
> double empty lines, here
Sure, will fix this in v2.
> 

thanks,
srini
