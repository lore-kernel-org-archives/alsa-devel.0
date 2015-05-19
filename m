From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 8/8] ASoC: Intel: Allocate for the mailbox
	with max size
Date: Tue, 19 May 2015 14:56:11 +0530
Message-ID: <20150519092611.GK3140@localhost>
References: <1431948361-12756-1-git-send-email-vinod.koul@intel.com>
 <1431948361-12756-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F26362606A7
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 11:25:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1431948361-12756-9-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 18, 2015 at 04:56:01PM +0530, Vinod Koul wrote:
> From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
> 
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  sound/soc/intel/common/sst-ipc.c | 15 +++++++++++++++
>  sound/soc/intel/common/sst-ipc.h |  4 ++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
> index a7699f35a8d2..137bdfc35063 100644
> --- a/sound/soc/intel/common/sst-ipc.c
> +++ b/sound/soc/intel/common/sst-ipc.c
> @@ -128,6 +128,21 @@ static int msg_empty_list_init(struct sst_generic_ipc *ipc)
>  	if (ipc->msg == NULL)
>  		return -ENOMEM;
>  
> +	ipc->msg->tx_data = devm_kzalloc(ipc->dev,
> +			sizeof(ipc->tx_data_max_size), GFP_KERNEL);
> +	if (ipc->msg->tx_data == NULL) {
> +		kfree(ipc->msg);
> +		return -ENOMEM;
> +	}
> +
> +	ipc->msg->rx_data = devm_kzalloc(ipc->dev,
> +			sizeof(ipc->rx_data_max_size), GFP_KERNEL);
> +	if (ipc->msg->rx_data == NULL) {
> +		kfree(ipc->msg->tx_data);
> +		kfree(ipc->msg);
> +		return -ENOMEM;
> +	}
> +
>  	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
we need to allocate the memory for each message in the queue, i will send
updated series now

-- 
~Vinod

>  		init_waitqueue_head(&ipc->msg[i].waitq);
>  		list_add(&ipc->msg[i].list, &ipc->empty_list);
> diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
> index 7139afd2547f..ceb7e468a3fa 100644
> --- a/sound/soc/intel/common/sst-ipc.h
> +++ b/sound/soc/intel/common/sst-ipc.h
> @@ -32,9 +32,9 @@ struct ipc_message {
>  	u64 header;
>  
>  	/* direction wrt host CPU */
> -	char tx_data[IPC_MAX_MAILBOX_BYTES];
> +	char *tx_data;
>  	size_t tx_size;
> -	char rx_data[IPC_MAX_MAILBOX_BYTES];
> +	char *rx_data;
>  	size_t rx_size;
>  
>  	wait_queue_head_t waitq;
> -- 
> 1.9.1
> 

-- 
