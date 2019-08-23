From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 19/35] ASoC: Intel: Skylake: Remove
 redundant W0 and W1 macros
Date: Fri, 23 Aug 2019 14:28:41 -0500
Message-ID: <c19706cc-25d2-1d45-698d-6f69d41e9237@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-20-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4807F802FB
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:11 +0200 (CEST)
In-Reply-To: <20190822190425.23001-20-cezary.rojewski@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 8/22/19 2:04 PM, Cezary Rojewski wrote:
> The existing upling, downling and FW register size macros are

uplink and downlink?

> duplicates. Remove these and replace by global mailbox size macro - FW
> register-area size is represented by SKL_FW_REGS_SIZE added in
> precedding change.

preceding

use checkpatch.pl --codespell to check for typos.

> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/skylake/bxt-sst.c     |  5 +++--
>   sound/soc/intel/skylake/cnl-sst-dsp.h |  6 ------
>   sound/soc/intel/skylake/cnl-sst.c     | 10 +++++-----
>   sound/soc/intel/skylake/skl-sst-dsp.h |  7 +------
>   sound/soc/intel/skylake/skl-sst-ipc.c | 12 ++++++------
>   sound/soc/intel/skylake/skl-sst.c     |  5 +++--
>   6 files changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> index 641d5cf4aeb1..fdd94711c3b4 100644
> --- a/sound/soc/intel/skylake/bxt-sst.c
> +++ b/sound/soc/intel/skylake/bxt-sst.c
> @@ -566,8 +566,9 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
>   	sst->addr.sram0_base = BXT_ADSP_SRAM0_BASE;
>   	sst->addr.sram1_base = BXT_ADSP_SRAM1_BASE;
>   
> -	sst_dsp_mailbox_init(sst, (BXT_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
> -			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
> +	sst_dsp_mailbox_init(sst,
> +		(BXT_ADSP_SRAM0_BASE + SKL_FW_REGS_SIZE), SKL_MAILBOX_SIZE,
> +		BXT_ADSP_SRAM1_BASE, SKL_MAILBOX_SIZE);
>   
>   	ret = skl_ipc_init(dev, skl);
>   	if (ret) {
> diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.h b/sound/soc/intel/skylake/cnl-sst-dsp.h
> index 70da4f312f53..a465cc42b7e8 100644
> --- a/sound/soc/intel/skylake/cnl-sst-dsp.h
> +++ b/sound/soc/intel/skylake/cnl-sst-dsp.h
> @@ -52,12 +52,6 @@ struct sst_generic_ipc;
>   
>   #define CNL_ADSP_MMIO_LEN		0x10000
>   
> -#define CNL_ADSP_W0_STAT_SZ		0x1000
> -
> -#define CNL_ADSP_W0_UP_SZ		0x1000
> -
> -#define CNL_ADSP_W1_SZ			0x1000
> -
>   #define CNL_FW_STS_MASK			0xf
>   
>   #define CNL_ADSPIC_IPC			0x1
> diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
> index 64971966af38..d3da23e0ef05 100644
> --- a/sound/soc/intel/skylake/cnl-sst.c
> +++ b/sound/soc/intel/skylake/cnl-sst.c
> @@ -390,8 +390,8 @@ static int cnl_ipc_init(struct device *dev, struct skl_dev *cnl)
>   	ipc->dsp = cnl->dsp;
>   	ipc->dev = dev;
>   
> -	ipc->tx_data_max_size = CNL_ADSP_W1_SZ;
> -	ipc->rx_data_max_size = CNL_ADSP_W0_UP_SZ;
> +	ipc->tx_data_max_size = SKL_MAILBOX_SIZE;
> +	ipc->rx_data_max_size = SKL_MAILBOX_SIZE;
>   
>   	err = sst_ipc_init(ipc);
>   	if (err)
> @@ -443,9 +443,9 @@ int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
>   	sst->addr.sram0_base = CNL_ADSP_SRAM0_BASE;
>   	sst->addr.sram1_base = CNL_ADSP_SRAM1_BASE;
>   
> -	sst_dsp_mailbox_init(sst, (CNL_ADSP_SRAM0_BASE + CNL_ADSP_W0_STAT_SZ),
> -			     CNL_ADSP_W0_UP_SZ, CNL_ADSP_SRAM1_BASE,
> -			     CNL_ADSP_W1_SZ);
> +	sst_dsp_mailbox_init(sst,
> +		(CNL_ADSP_SRAM0_BASE + SKL_FW_REGS_SIZE), SKL_MAILBOX_SIZE,
> +		CNL_ADSP_SRAM1_BASE, SKL_MAILBOX_SIZE);
>   
>   	ret = cnl_ipc_init(dev, cnl);
>   	if (ret) {
> diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
> index 5a0cb7f3d57e..3c92b1d849e4 100644
> --- a/sound/soc/intel/skylake/skl-sst-dsp.h
> +++ b/sound/soc/intel/skylake/skl-sst-dsp.h
> @@ -57,12 +57,7 @@ struct skl_dev;
>   
>   #define SKL_ADSP_MMIO_LEN		0x10000
>   
> -#define SKL_ADSP_W0_STAT_SZ		0x1000
> -
> -#define SKL_ADSP_W0_UP_SZ		0x1000
> -
> -#define SKL_ADSP_W1_SZ			0x1000
> -
> +#define SKL_MAILBOX_SIZE		PAGE_SIZE
>   #define SKL_FW_REGS_SIZE		PAGE_SIZE
>   #define SKL_FW_STS_MASK			0xf
>   
> diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
> index 2700f882103d..72d7284d2fff 100644
> --- a/sound/soc/intel/skylake/skl-sst-ipc.c
> +++ b/sound/soc/intel/skylake/skl-sst-ipc.c
> @@ -606,8 +606,8 @@ int skl_ipc_init(struct device *dev, struct skl_dev *skl)
>   	ipc->dsp = skl->dsp;
>   	ipc->dev = dev;
>   
> -	ipc->tx_data_max_size = SKL_ADSP_W1_SZ;
> -	ipc->rx_data_max_size = SKL_ADSP_W0_UP_SZ;
> +	ipc->tx_data_max_size = SKL_MAILBOX_SIZE;
> +	ipc->rx_data_max_size = SKL_MAILBOX_SIZE;
>   
>   	err = sst_ipc_init(ipc);
>   	if (err)
> @@ -922,8 +922,8 @@ int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
>   	sz_remaining = msg->param_data_size;
>   	data_offset = 0;
>   	while (sz_remaining != 0) {
> -		tx_size = sz_remaining > SKL_ADSP_W1_SZ
> -				? SKL_ADSP_W1_SZ : sz_remaining;
> +		tx_size = sz_remaining > SKL_MAILBOX_SIZE
> +				? SKL_MAILBOX_SIZE : sz_remaining;
>   		if (tx_size == sz_remaining)
>   			header.extension |= IPC_FINAL_BLOCK(1);
>   
> @@ -965,7 +965,7 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
>   	unsigned int *buf;
>   	int ret;
>   
> -	reply.data = kzalloc(SKL_ADSP_W1_SZ, GFP_KERNEL);
> +	reply.data = kzalloc(SKL_MAILBOX_SIZE, GFP_KERNEL);
>   	if (!reply.data)
>   		return -ENOMEM;
>   
> @@ -983,7 +983,7 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
>   	request.header = *(u64 *)&header;
>   	request.data = *payload;
>   	request.size = *bytes;
> -	reply.size = SKL_ADSP_W1_SZ;
> +	reply.size = SKL_MAILBOX_SIZE;
>   
>   	ret = sst_ipc_tx_message_wait(ipc, request, &reply);
>   	if (ret < 0)
> diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
> index 7e63c91cea54..191931578fd2 100644
> --- a/sound/soc/intel/skylake/skl-sst.c
> +++ b/sound/soc/intel/skylake/skl-sst.c
> @@ -536,8 +536,9 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
>   	sst->addr.sram0_base = SKL_ADSP_SRAM0_BASE;
>   	sst->addr.sram1_base = SKL_ADSP_SRAM1_BASE;
>   
> -	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
> -			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
> +	sst_dsp_mailbox_init(sst,
> +		(SKL_ADSP_SRAM0_BASE + SKL_FW_REGS_SIZE), SKL_MAILBOX_SIZE,
> +		SKL_ADSP_SRAM1_BASE, SKL_MAILBOX_SIZE);
>   
>   	ret = skl_ipc_init(dev, skl);
>   	if (ret) {
> 
