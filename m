From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: Use the generic
 IPC/mailbox APIs in Broadwell
Date: Thu, 9 Apr 2015 00:58:07 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90550D7A5@SHSMSX101.ccr.corp.intel.com>
References: <1428370412-15155-1-git-send-email-yao.jin@linux.intel.com>
 <1428370412-15155-4-git-send-email-yao.jin@linux.intel.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A905505BA5@shsmsx102.ccr.corp.intel.com>
 <5523C879.5080401@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B4B226046B
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 02:58:14 +0200 (CEST)
In-Reply-To: <5523C879.5080401@linux.intel.com>
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
To: "Jin, Yao" <yao.jin@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Jin, Yao [mailto:yao.jin@linux.intel.com]
> Sent: Tuesday, April 07, 2015 8:07 PM
> To: Jie, Yang; broonie@kernel.org; Girdwood, Liam R
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH 3/3] ASoC: Intel: Use the generic
> IPC/mailbox APIs in Broadwell
> 
> Hi Keyon,
> 
> Yes, I removed the trace_ipc_reply and trace_ipc_error. Because this is only
> in original sst-haswell-ipc.c but not in other platforms. And for the
> trace_ipc_error we have the similar debug log ipc_shim_dbg so finally I
> decide to remove this trace ipc log.

It will only reduce some trace info(no trace_ipc_reply "completed" again) 
for Broadwell, anyway, we still have trace_ipc_reply "processing---",
so, that's fine for me.

Acked-by: Jie Yang <yang.jie@intel.com>

> 
> Thanks
> Jin Yao
> 
> On 2015/4/7 17:06, Jie, Yang wrote:
> >> -----Original Message-----
> >> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> >> bounces@alsa-project.org] On Behalf Of Jin Yao
> >> Sent: Tuesday, April 07, 2015 9:34 AM
> >> To: broonie@kernel.org; Girdwood, Liam R
> >> Cc: alsa-devel@alsa-project.org; Jin Yao
> >> Subject: [alsa-devel] [PATCH 3/3] ASoC: Intel: Use the generic
> >> IPC/mailbox APIs in Broadwell
> >>
> >> Use the generic IPC/mailbox APIs to replace the original processing
> >> code for Broadwell platform.
> >>
> >> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> >> ---
> >>  sound/soc/intel/haswell/sst-haswell-ipc.c | 382
> >> +++++++-----------------------
> >>  1 file changed, 87 insertions(+), 295 deletions(-)
> >>
> >> diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c
> >> b/sound/soc/intel/haswell/sst-haswell-ipc.c
> >> index 28667d8..d75f09e 100644
> >> --- a/sound/soc/intel/haswell/sst-haswell-ipc.c
> >> +++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
> >> @@ -36,6 +36,7 @@
> >>  #include "sst-haswell-ipc.h"
> >>  #include "../common/sst-dsp.h"
> >>  #include "../common/sst-dsp-priv.h"
> >> +#include "../common/sst-ipc.h"
> >>
> >>  /* Global Message - Generic */
> >>  #define IPC_GLB_TYPE_SHIFT	24
> >> @@ -210,23 +211,6 @@ struct sst_hsw_ipc_fw_ready {
> >>  	u8 fw_info[IPC_MAX_MAILBOX_BYTES - 5 * sizeof(u32)];  }
> >> __attribute__((packed));
> >>
> >> -struct ipc_message {
> >> -	struct list_head list;
> >> -	u32 header;
> >> -
> >> -	/* direction wrt host CPU */
> >> -	char tx_data[IPC_MAX_MAILBOX_BYTES];
> >> -	size_t tx_size;
> >> -	char rx_data[IPC_MAX_MAILBOX_BYTES];
> >> -	size_t rx_size;
> >> -
> >> -	wait_queue_head_t waitq;
> >> -	bool pending;
> >> -	bool complete;
> >> -	bool wait;
> >> -	int errno;
> >> -};
> >> -
> >>  struct sst_hsw_stream;
> >>  struct sst_hsw;
> >>
> >> @@ -325,15 +309,7 @@ struct sst_hsw {
> >>  	bool shutdown;
> >>
> >>  	/* IPC messaging */
> >> -	struct list_head tx_list;
> >> -	struct list_head rx_list;
> >> -	struct list_head empty_list;
> >> -	wait_queue_head_t wait_txq;
> >> -	struct task_struct *tx_thread;
> >> -	struct kthread_worker kworker;
> >> -	struct kthread_work kwork;
> >> -	bool pending;
> >> -	struct ipc_message *msg;
> >> +	struct sst_generic_ipc ipc;
> >>
> >>  	/* FW log stream */
> >>  	struct sst_hsw_log_stream log_stream; @@ -456,159 +432,6 @@
> static
> >> struct sst_hsw_stream *get_stream_by_id(struct sst_hsw *hsw,
> >>  	return NULL;
> >>  }
> >>
> >> -static void ipc_shim_dbg(struct sst_hsw *hsw, const char *text) -{
> >> -	struct sst_dsp *sst = hsw->dsp;
> >> -	u32 isr, ipcd, imrx, ipcx;
> >> -
> >> -	ipcx = sst_dsp_shim_read_unlocked(sst, SST_IPCX);
> >> -	isr = sst_dsp_shim_read_unlocked(sst, SST_ISRX);
> >> -	ipcd = sst_dsp_shim_read_unlocked(sst, SST_IPCD);
> >> -	imrx = sst_dsp_shim_read_unlocked(sst, SST_IMRX);
> >> -
> >> -	dev_err(hsw->dev, "ipc: --%s-- ipcx 0x%8.8x isr 0x%8.8x ipcd 0x%8.8x
> >> imrx 0x%8.8x\n",
> >> -		text, ipcx, isr, ipcd, imrx);
> >> -}
> >> -
> >> -/* locks held by caller */
> >> -static struct ipc_message *msg_get_empty(struct sst_hsw *hsw) -{
> >> -	struct ipc_message *msg = NULL;
> >> -
> >> -	if (!list_empty(&hsw->empty_list)) {
> >> -		msg = list_first_entry(&hsw->empty_list, struct ipc_message,
> >> -			list);
> >> -		list_del(&msg->list);
> >> -	}
> >> -
> >> -	return msg;
> >> -}
> >> -
> >> -static void ipc_tx_msgs(struct kthread_work *work) -{
> >> -	struct sst_hsw *hsw =
> >> -		container_of(work, struct sst_hsw, kwork);
> >> -	struct ipc_message *msg;
> >> -	unsigned long flags;
> >> -	u32 ipcx;
> >> -
> >> -	spin_lock_irqsave(&hsw->dsp->spinlock, flags);
> >> -
> >> -	if (list_empty(&hsw->tx_list) || hsw->pending) {
> >> -		spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
> >> -		return;
> >> -	}
> >> -
> >> -	/* if the DSP is busy, we will TX messages after IRQ.
> >> -	 * also postpone if we are in the middle of procesing completion irq*/
> >> -	ipcx = sst_dsp_shim_read_unlocked(hsw->dsp, SST_IPCX);
> >> -	if (ipcx & (SST_IPCX_BUSY | SST_IPCX_DONE)) {
> >> -		spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
> >> -		return;
> >> -	}
> >> -
> >> -	msg = list_first_entry(&hsw->tx_list, struct ipc_message, list);
> >> -
> >> -	list_move(&msg->list, &hsw->rx_list);
> >> -
> >> -	/* send the message */
> >> -	sst_dsp_outbox_write(hsw->dsp, msg->tx_data, msg->tx_size);
> >> -	sst_dsp_ipc_msg_tx(hsw->dsp, msg->header | SST_IPCX_BUSY);
> >> -
> >> -	spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
> >> -}
> >> -
> >> -/* locks held by caller */
> >> -static void tx_msg_reply_complete(struct sst_hsw *hsw, struct
> >> ipc_message *msg) -{
> >> -	msg->complete = true;
> >> -	trace_ipc_reply("completed", msg->header);
> > [Keyon] these trace ipc logs will be removed with your patches applied?
> >> -
> >> -	if (!msg->wait)
> >> -		list_add_tail(&msg->list, &hsw->empty_list);
> >> -	else
> >> -		wake_up(&msg->waitq);
> >> -}
> >> -
> >> -static int tx_wait_done(struct sst_hsw *hsw, struct ipc_message *msg,
> >> -	void *rx_data)
> >> -{
> >> -	unsigned long flags;
> >> -	int ret;
> >> -
> >> -	/* wait for DSP completion (in all cases atm inc pending) */
> >> -	ret = wait_event_timeout(msg->waitq, msg->complete,
> >> -		msecs_to_jiffies(IPC_TIMEOUT_MSECS));
> >> -
> >> -	spin_lock_irqsave(&hsw->dsp->spinlock, flags);
> >> -	if (ret == 0) {
> >> -		ipc_shim_dbg(hsw, "message timeout");
> >> -
> >> -		trace_ipc_error("error message timeout for", msg->header);
> > [Keyon] ditto.
> >> -		list_del(&msg->list);
> >> -		ret = -ETIMEDOUT;
> >> -	} else {
> >> -
> >> -		/* copy the data returned from DSP */
> >> -		if (msg->rx_size)
> >> -			memcpy(rx_data, msg->rx_data, msg->rx_size);
> >> -		ret = msg->errno;
> >> -	}
> >> -
> >> -	list_add_tail(&msg->list, &hsw->empty_list);
> >> -	spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
> >> -	return ret;
> >> -}
> >> -
> >> -static int ipc_tx_message(struct sst_hsw *hsw, u32 header, void
> *tx_data,
> >> -	size_t tx_bytes, void *rx_data, size_t rx_bytes, int wait)
> >> -{
> >> -	struct ipc_message *msg;
> >> -	unsigned long flags;
> >> -
> >> -	spin_lock_irqsave(&hsw->dsp->spinlock, flags);
> >> -
> >> -	msg = msg_get_empty(hsw);
> >> -	if (msg == NULL) {
> >> -		spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
> >> -		return -EBUSY;
> >> -	}
> >> -
> >> -	if (tx_bytes)
> >> -		memcpy(msg->tx_data, tx_data, tx_bytes);
> >> -
> >> -	msg->header = header;
> >> -	msg->tx_size = tx_bytes;
> >> -	msg->rx_size = rx_bytes;
> >> -	msg->wait = wait;
> >> -	msg->errno = 0;
> >> -	msg->pending = false;
> >> -	msg->complete = false;
> >> -
> >> -	list_add_tail(&msg->list, &hsw->tx_list);
> >> -	spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
> >> -
> >> -	queue_kthread_work(&hsw->kworker, &hsw->kwork);
> >> -
> >> -	if (wait)
> >> -		return tx_wait_done(hsw, msg, rx_data);
> >> -	else
> >> -		return 0;
> >> -}
> >> -
> >> -static inline int ipc_tx_message_wait(struct sst_hsw *hsw, u32 header,
> >> -	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes)
> >> -{
> >> -	return ipc_tx_message(hsw, header, tx_data, tx_bytes, rx_data,
> >> -		rx_bytes, 1);
> >> -}
> >> -
> >> -static inline int ipc_tx_message_nowait(struct sst_hsw *hsw, u32 header,
> >> -	void *tx_data, size_t tx_bytes)
> >> -{
> >> -	return ipc_tx_message(hsw, header, tx_data, tx_bytes, NULL, 0, 0);
> >> -}
> >> -
> >>  static void hsw_fw_ready(struct sst_hsw *hsw, u32 header)  {
> >>  	struct sst_hsw_ipc_fw_ready fw_ready; @@ -696,27 +519,6 @@
> static
> >> void hsw_notification_work(struct work_struct
> >> *work)
> >>  	sst_dsp_shim_update_bits(hsw->dsp, SST_IMRX, SST_IMRX_BUSY,
> 0);  }
> >>
> >> -static struct ipc_message *reply_find_msg(struct sst_hsw *hsw, u32
> >> header) -{
> >> -	struct ipc_message *msg;
> >> -
> >> -	/* clear reply bits & status bits */
> >> -	header &= ~(IPC_STATUS_MASK | IPC_GLB_REPLY_MASK);
> >> -
> >> -	if (list_empty(&hsw->rx_list)) {
> >> -		dev_err(hsw->dev, "error: rx list empty but received
> >> 0x%x\n",
> >> -			header);
> >> -		return NULL;
> >> -	}
> >> -
> >> -	list_for_each_entry(msg, &hsw->rx_list, list) {
> >> -		if (msg->header == header)
> >> -			return msg;
> >> -	}
> >> -
> >> -	return NULL;
> >> -}
> >> -
> >>  static void hsw_stream_update(struct sst_hsw *hsw, struct
> >> ipc_message
> >> *msg)  {
> >>  	struct sst_hsw_stream *stream;
> >> @@ -755,7 +557,7 @@ static int hsw_process_reply(struct sst_hsw *hsw,
> >> u32 header)
> >>
> >>  	trace_ipc_reply("processing -->", header);
> >>
> >> -	msg = reply_find_msg(hsw, header);
> >> +	msg = sst_ipc_reply_find_msg(&hsw->ipc, header);
> >>  	if (msg == NULL) {
> >>  		trace_ipc_error("error: can't find message header", header);
> >>  		return -EIO;
> >> @@ -766,14 +568,14 @@ static int hsw_process_reply(struct sst_hsw
> >> *hsw,
> >> u32 header)
> >>  	case IPC_GLB_REPLY_PENDING:
> >>  		trace_ipc_pending_reply("received", header);
> >>  		msg->pending = true;
> >> -		hsw->pending = true;
> >> +		hsw->ipc.pending = true;
> >>  		return 1;
> >>  	case IPC_GLB_REPLY_SUCCESS:
> >>  		if (msg->pending) {
> >>  			trace_ipc_pending_reply("completed", header);
> >>  			sst_dsp_inbox_read(hsw->dsp, msg->rx_data,
> >>  				msg->rx_size);
> >> -			hsw->pending = false;
> >> +			hsw->ipc.pending = false;
> >>  		} else {
> >>  			/* copy data from the DSP */
> >>  			sst_dsp_outbox_read(hsw->dsp, msg->rx_data, @@
> >> -829,7 +631,7 @@ static int hsw_process_reply(struct sst_hsw *hsw,
> >> u32
> >> header)
> >>
> >>  	/* wake up and return the error if we have waiters on this message ?
> >> */
> >>  	list_del(&msg->list);
> >> -	tx_msg_reply_complete(hsw, msg);
> >> +	sst_ipc_tx_msg_reply_complete(&hsw->ipc, msg);
> >>
> >>  	return 1;
> >>  }
> >> @@ -970,6 +772,7 @@ static irqreturn_t hsw_irq_thread(int irq, void
> >> *context)  {
> >>  	struct sst_dsp *sst = (struct sst_dsp *) context;
> >>  	struct sst_hsw *hsw = sst_dsp_get_thread_context(sst);
> >> +	struct sst_generic_ipc *ipc = &hsw->ipc;
> >>  	u32 ipcx, ipcd;
> >>  	int handled;
> >>  	unsigned long flags;
> >> @@ -1016,7 +819,7 @@ static irqreturn_t hsw_irq_thread(int irq, void
> >> *context)
> >>  	spin_unlock_irqrestore(&sst->spinlock, flags);
> >>
> >>  	/* continue to send any remaining messages... */
> >> -	queue_kthread_work(&hsw->kworker, &hsw->kwork);
> >> +	queue_kthread_work(&ipc->kworker, &ipc->kwork);
> >>
> >>  	return IRQ_HANDLED;
> >>  }
> >> @@ -1026,7 +829,8 @@ int sst_hsw_fw_get_version(struct sst_hsw *hsw,
> {
> >>  	int ret;
> >>
> >> -	ret = ipc_tx_message_wait(hsw,
> >> IPC_GLB_TYPE(IPC_GLB_GET_FW_VERSION),
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc,
> >> +		IPC_GLB_TYPE(IPC_GLB_GET_FW_VERSION),
> >>  		NULL, 0, version, sizeof(*version));
> >>  	if (ret < 0)
> >>  		dev_err(hsw->dev, "error: get version failed\n"); @@ -
> >> 1090,7 +894,8 @@ int sst_hsw_stream_set_volume(struct sst_hsw *hsw,
> >>  		req->channel = channel;
> >>  	}
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header, req, sizeof(*req), NULL, 0);
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header, req,
> >> +		sizeof(*req), NULL, 0);
> >>  	if (ret < 0) {
> >>  		dev_err(hsw->dev, "error: set stream volume failed\n");
> >>  		return ret;
> >> @@ -1155,7 +960,8 @@ int sst_hsw_mixer_set_volume(struct sst_hsw
> >> *hsw,
> >> u32 stage_id, u32 channel,
> >>  	req.curve_type = hsw->curve_type;
> >>  	req.target_volume = volume;
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header, &req, sizeof(req), NULL, 0);
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header, &req,
> >> +		sizeof(req), NULL, 0);
> >>  	if (ret < 0) {
> >>  		dev_err(hsw->dev, "error: set mixer volume failed\n");
> >>  		return ret;
> >> @@ -1213,7 +1019,7 @@ int sst_hsw_stream_free(struct sst_hsw *hsw,
> >> struct sst_hsw_stream *stream)
> >>  	stream->free_req.stream_id = stream->reply.stream_hw_id;
> >>  	header = IPC_GLB_TYPE(IPC_GLB_FREE_STREAM);
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header, &stream->free_req,
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header, &stream-
> >>> free_req,
> >>  		sizeof(stream->free_req), NULL, 0);
> >>  	if (ret < 0) {
> >>  		dev_err(hsw->dev, "error: free stream %d failed\n", @@ -
> >> 1405,8 +1211,8 @@ int sst_hsw_stream_commit(struct sst_hsw *hsw,
> >> struct sst_hsw_stream *stream)
> >>
> >>  	header = IPC_GLB_TYPE(IPC_GLB_ALLOCATE_STREAM);
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header, str_req, sizeof(*str_req),
> >> -		reply, sizeof(*reply));
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header, str_req,
> >> +		sizeof(*str_req), reply, sizeof(*reply));
> >>  	if (ret < 0) {
> >>  		dev_err(hsw->dev, "error: stream commit failed\n");
> >>  		return ret;
> >> @@ -1455,7 +1261,8 @@ int sst_hsw_mixer_get_info(struct sst_hsw
> *hsw)
> >>
> >>  	trace_ipc_request("get global mixer info", 0);
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header, NULL, 0, reply,
> >> sizeof(*reply));
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header, NULL, 0,
> >> +		reply, sizeof(*reply));
> >>  	if (ret < 0) {
> >>  		dev_err(hsw->dev, "error: get stream info failed\n");
> >>  		return ret;
> >> @@ -1476,9 +1283,10 @@ static int sst_hsw_stream_operations(struct
> >> sst_hsw *hsw, int type,
> >>  	header |= (stream_id << IPC_STR_ID_SHIFT);
> >>
> >>  	if (wait)
> >> -		return ipc_tx_message_wait(hsw, header, NULL, 0, NULL, 0);
> >> +		return sst_ipc_tx_message_wait(&hsw->ipc, header,
> >> +			NULL, 0, NULL, 0);
> >>  	else
> >> -		return ipc_tx_message_nowait(hsw, header, NULL, 0);
> >> +		return sst_ipc_tx_message_nowait(&hsw->ipc, header,
> >> NULL, 0);
> >>  }
> >>
> >>  /* Stream ALSA trigger operations */ @@ -1605,8 +1413,8 @@ int
> >> sst_hsw_device_set_config(struct sst_hsw *hsw,
> >>
> >>  	header = IPC_GLB_TYPE(IPC_GLB_SET_DEVICE_FORMATS);
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header, &config, sizeof(config),
> >> -		NULL, 0);
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header, &config,
> >> +		sizeof(config), NULL, 0);
> >>  	if (ret < 0)
> >>  		dev_err(hsw->dev, "error: set device formats failed\n");
> >>
> >> @@ -1626,8 +1434,8 @@ int sst_hsw_dx_set_state(struct sst_hsw *hsw,
> >>
> >>  	trace_ipc_request("PM enter Dx state", state);
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header, &state_, sizeof(state_),
> >> -		dx, sizeof(*dx));
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header, &state_,
> >> +		sizeof(state_), dx, sizeof(*dx));
> >>  	if (ret < 0) {
> >>  		dev_err(hsw->dev, "ipc: error set dx state %d failed\n",
> state);
> >>  		return ret;
> >> @@ -1770,32 +1578,6 @@ static int sst_hsw_dx_state_restore(struct
> >> sst_hsw *hsw)
> >>  	return 0;
> >>  }
> >>
> >> -static void sst_hsw_drop_all(struct sst_hsw *hsw) -{
> >> -	struct ipc_message *msg, *tmp;
> >> -	unsigned long flags;
> >> -	int tx_drop_cnt = 0, rx_drop_cnt = 0;
> >> -
> >> -	/* drop all TX and Rx messages before we stall + reset DSP */
> >> -	spin_lock_irqsave(&hsw->dsp->spinlock, flags);
> >> -
> >> -	list_for_each_entry_safe(msg, tmp, &hsw->tx_list, list) {
> >> -		list_move(&msg->list, &hsw->empty_list);
> >> -		tx_drop_cnt++;
> >> -	}
> >> -
> >> -	list_for_each_entry_safe(msg, tmp, &hsw->rx_list, list) {
> >> -		list_move(&msg->list, &hsw->empty_list);
> >> -		rx_drop_cnt++;
> >> -	}
> >> -
> >> -	spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
> >> -
> >> -	if (tx_drop_cnt || rx_drop_cnt)
> >> -		dev_err(hsw->dev, "dropped IPC msg RX=%d, TX=%d\n",
> >> -			tx_drop_cnt, rx_drop_cnt);
> >> -}
> >> -
> >>  int sst_hsw_dsp_load(struct sst_hsw *hsw)  {
> >>  	struct sst_dsp *dsp = hsw->dsp;
> >> @@ -1875,7 +1657,7 @@ int sst_hsw_dsp_runtime_suspend(struct
> sst_hsw
> >> *hsw)
> >>  	if (ret < 0)
> >>  		return ret;
> >>
> >> -	sst_hsw_drop_all(hsw);
> >> +	sst_ipc_drop_all(&hsw->ipc);
> >>
> >>  	return 0;
> >>  }
> >> @@ -1933,23 +1715,6 @@ int sst_hsw_dsp_runtime_resume(struct
> sst_hsw
> >> *hsw)  }  #endif
> >>
> >> -static int msg_empty_list_init(struct sst_hsw *hsw) -{
> >> -	int i;
> >> -
> >> -	hsw->msg = kzalloc(sizeof(struct ipc_message) *
> >> -		IPC_EMPTY_LIST_SIZE, GFP_KERNEL);
> >> -	if (hsw->msg == NULL)
> >> -		return -ENOMEM;
> >> -
> >> -	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
> >> -		init_waitqueue_head(&hsw->msg[i].waitq);
> >> -		list_add(&hsw->msg[i].list, &hsw->empty_list);
> >> -	}
> >> -
> >> -	return 0;
> >> -}
> >> -
> >>  struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw)  {
> >>  	return hsw->dsp;
> >> @@ -2184,7 +1949,7 @@ int sst_hsw_module_enable(struct sst_hsw
> *hsw,
> >>  		config.scratch_mem.size, config.scratch_mem.offset,
> >>  		config.map.module_entries[0].entry_point);
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header,
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header,
> >>  			&config, sizeof(config), NULL, 0);
> >>  	if (ret < 0)
> >>  		dev_err(dev, "ipc: module enable failed - %d\n", ret); @@ -
> >> 2223,7 +1988,7 @@ int sst_hsw_module_disable(struct sst_hsw *hsw,
> >>  			IPC_MODULE_OPERATION(IPC_MODULE_DISABLE) |
> >>  			IPC_MODULE_ID(module_id);
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header,  NULL, 0, NULL, 0);
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header,  NULL, 0, NULL,
> >> 0);
> >>  	if (ret < 0)
> >>  		dev_err(dev, "module disable failed - %d\n", ret);
> >>  	else
> >> @@ -2277,7 +2042,7 @@ int sst_hsw_module_set_param(struct sst_hsw
> >> *hsw,
> >>  	parameter->parameter_id = parameter_id;
> >>  	parameter->data_size = param_size;
> >>
> >> -	ret = ipc_tx_message_wait(hsw, header,
> >> +	ret = sst_ipc_tx_message_wait(&hsw->ipc, header,
> >>  		parameter, transfer_parameter_size , NULL, 0);
> >>  	if (ret < 0)
> >>  		dev_err(dev, "ipc: module set parameter failed - %d\n", ret);
> @@
> >> -2296,10 +2061,48 @@ static struct sst_dsp_device hsw_dev = {
> >>  	.ops = &haswell_ops,
> >>  };
> >>
> >> +static void hsw_tx_msg(struct sst_generic_ipc *ipc, struct
> >> +ipc_message
> >> +*msg) {
> >> +	/* send the message */
> >> +	sst_dsp_outbox_write(ipc->dsp, msg->tx_data, msg->tx_size);
> >> +	sst_dsp_ipc_msg_tx(ipc->dsp, msg->header); }
> >> +
> >> +static void hsw_shim_dbg(struct sst_generic_ipc *ipc, const char
> >> +*text) {
> >> +	struct sst_dsp *sst = ipc->dsp;
> >> +	u32 isr, ipcd, imrx, ipcx;
> >> +
> >> +	ipcx = sst_dsp_shim_read_unlocked(sst, SST_IPCX);
> >> +	isr = sst_dsp_shim_read_unlocked(sst, SST_ISRX);
> >> +	ipcd = sst_dsp_shim_read_unlocked(sst, SST_IPCD);
> >> +	imrx = sst_dsp_shim_read_unlocked(sst, SST_IMRX);
> >> +
> >> +	dev_err(ipc->dev,
> >> +		"ipc: --%s-- ipcx 0x%8.8x isr 0x%8.8x ipcd 0x%8.8x imrx
> >> 0x%8.8x\n",
> >> +		text, ipcx, isr, ipcd, imrx);
> >> +}
> >> +
> >> +static void hsw_tx_data_copy(struct ipc_message *msg, char *tx_data,
> >> +	size_t tx_size)
> >> +{
> >> +	memcpy(msg->tx_data, tx_data, tx_size); }
> >> +
> >> +static u64 hsw_reply_msg_match(u64 header, u64 *mask) {
> >> +	/* clear reply bits & status bits */
> >> +	header &= ~(IPC_STATUS_MASK | IPC_GLB_REPLY_MASK);
> >> +	*mask = (u64)-1;
> >> +
> >> +	return header;
> >> +}
> >> +
> >>  int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)  {
> >>  	struct sst_hsw_ipc_fw_version version;
> >>  	struct sst_hsw *hsw;
> >> +	struct sst_generic_ipc *ipc;
> >>  	int ret;
> >>
> >>  	dev_dbg(dev, "initialising Audio DSP IPC\n"); @@ -2308,39 +2111,30
> >> @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
> >>  	if (hsw == NULL)
> >>  		return -ENOMEM;
> >>
> >> -	hsw->dev = dev;
> >> -	INIT_LIST_HEAD(&hsw->stream_list);
> >> -	INIT_LIST_HEAD(&hsw->tx_list);
> >> -	INIT_LIST_HEAD(&hsw->rx_list);
> >> -	INIT_LIST_HEAD(&hsw->empty_list);
> >> -	init_waitqueue_head(&hsw->boot_wait);
> >> -	init_waitqueue_head(&hsw->wait_txq);
> >> +	ipc = &hsw->ipc;
> >> +	ipc->dev = dev;
> >> +	ipc->ops.tx_msg = hsw_tx_msg;
> >> +	ipc->ops.shim_dbg = hsw_shim_dbg;
> >> +	ipc->ops.tx_data_copy = hsw_tx_data_copy;
> >> +	ipc->ops.reply_msg_match = hsw_reply_msg_match;
> >>
> >> -	ret = msg_empty_list_init(hsw);
> >> -	if (ret < 0)
> >> -		return -ENOMEM;
> >> -
> >> -	/* start the IPC message thread */
> >> -	init_kthread_worker(&hsw->kworker);
> >> -	hsw->tx_thread = kthread_run(kthread_worker_fn,
> >> -					   &hsw->kworker, "%s",
> >> -					   dev_name(hsw->dev));
> >> -	if (IS_ERR(hsw->tx_thread)) {
> >> -		ret = PTR_ERR(hsw->tx_thread);
> >> -		dev_err(hsw->dev, "error: failed to create message TX
> >> task\n");
> >> -		goto err_free_msg;
> >> -	}
> >> -	init_kthread_work(&hsw->kwork, ipc_tx_msgs);
> >> +	ret = sst_ipc_init(ipc);
> >> +	if (ret != 0)
> >> +		goto ipc_init_err;
> >>
> >> +	INIT_LIST_HEAD(&hsw->stream_list);
> >> +	init_waitqueue_head(&hsw->boot_wait);
> >>  	hsw_dev.thread_context = hsw;
> >>
> >>  	/* init SST shim */
> >>  	hsw->dsp = sst_dsp_new(dev, &hsw_dev, pdata);
> >>  	if (hsw->dsp == NULL) {
> >>  		ret = -ENODEV;
> >> -		goto dsp_err;
> >> +		goto dsp_new_err;
> >>  	}
> >>
> >> +	ipc->dsp = hsw->dsp;
> >> +
> >>  	/* allocate DMA buffer for context storage */
> >>  	hsw->dx_context = dma_alloc_coherent(hsw->dsp->dma_dev,
> >>  		SST_HSW_DX_CONTEXT_SIZE, &hsw->dx_context_paddr,
> GFP_KERNEL); @@
> >> -2404,11 +2198,10 @@ fw_err:
> >>  			hsw->dx_context, hsw->dx_context_paddr);
> >>  dma_err:
> >>  	sst_dsp_free(hsw->dsp);
> >> -dsp_err:
> >> -	kthread_stop(hsw->tx_thread);
> >> -err_free_msg:
> >> -	kfree(hsw->msg);
> >> -
> >> +dsp_new_err:
> >> +	sst_ipc_fini(ipc);
> >> +ipc_init_err:
> >> +	kfree(hsw);
> >>  	return ret;
> >>  }
> >>  EXPORT_SYMBOL_GPL(sst_hsw_dsp_init);
> >> @@ -2422,7 +2215,6 @@ void sst_hsw_dsp_free(struct device *dev,
> >> struct sst_pdata *pdata)
> >>  	dma_free_coherent(hsw->dsp->dma_dev,
> >> SST_HSW_DX_CONTEXT_SIZE,
> >>  			hsw->dx_context, hsw->dx_context_paddr);
> >>  	sst_dsp_free(hsw->dsp);
> >> -	kthread_stop(hsw->tx_thread);
> >> -	kfree(hsw->msg);
> >> +	sst_ipc_fini(&hsw->ipc);
> >>  }
> >>  EXPORT_SYMBOL_GPL(sst_hsw_dsp_free);
> >> --
> >> 1.9.1
> >>
> >> _______________________________________________
> >> Alsa-devel mailing list
> >> Alsa-devel@alsa-project.org
> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
