From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 18/35] ASoC: Intel: Skylake: Remove window0
 sst_addr fields
Date: Fri, 23 Aug 2019 14:26:22 -0500
Message-ID: <f19e82aa-87bd-75ee-2b56-f7130e73bc86@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-19-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D01A6F80147
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:09 +0200 (CEST)
In-Reply-To: <20190822190425.23001-19-cezary.rojewski@intel.com>
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
> w0_stat_sz and w0_up_sz are Skylake-specific fields and should not be
> part of common sst framework. The latter is also completely unused.
> Remove both while declaring global FW register-area size, shared for all
> SKL+ platforms.
> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/common/sst-dsp-priv.h | 2 --
>   sound/soc/intel/skylake/bxt-sst.c     | 2 --
>   sound/soc/intel/skylake/cnl-sst.c     | 2 --
>   sound/soc/intel/skylake/skl-debug.c   | 2 +-
>   sound/soc/intel/skylake/skl-sst-dsp.h | 1 +
>   sound/soc/intel/skylake/skl-sst.c     | 2 --
>   6 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
> index 0fe9bebcfb38..53dcd87bab44 100644
> --- a/sound/soc/intel/common/sst-dsp-priv.h
> +++ b/sound/soc/intel/common/sst-dsp-priv.h
> @@ -71,8 +71,6 @@ struct sst_addr {
>   	u32 dsp_dram_offset;
>   	u32 sram0_base;
>   	u32 sram1_base;
> -	u32 w0_stat_sz;
> -	u32 w0_up_sz;
>   	void __iomem *lpe;
>   	void __iomem *shim;
>   	void __iomem *pci_cfg;
> diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> index c7961050c2ee..641d5cf4aeb1 100644
> --- a/sound/soc/intel/skylake/bxt-sst.c
> +++ b/sound/soc/intel/skylake/bxt-sst.c
> @@ -565,8 +565,6 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
>   	sst->addr.shim = mmio_base;
>   	sst->addr.sram0_base = BXT_ADSP_SRAM0_BASE;
>   	sst->addr.sram1_base = BXT_ADSP_SRAM1_BASE;
> -	sst->addr.w0_stat_sz = SKL_ADSP_W0_STAT_SZ;
> -	sst->addr.w0_up_sz = SKL_ADSP_W0_UP_SZ;
>   
>   	sst_dsp_mailbox_init(sst, (BXT_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
>   			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);

You are still using a SKL specific macro here...

> diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
> index 2f10076cc906..64971966af38 100644
> --- a/sound/soc/intel/skylake/cnl-sst.c
> +++ b/sound/soc/intel/skylake/cnl-sst.c
> @@ -442,8 +442,6 @@ int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
>   	sst->addr.shim = mmio_base;
>   	sst->addr.sram0_base = CNL_ADSP_SRAM0_BASE;
>   	sst->addr.sram1_base = CNL_ADSP_SRAM1_BASE;
> -	sst->addr.w0_stat_sz = CNL_ADSP_W0_STAT_SZ;
> -	sst->addr.w0_up_sz = CNL_ADSP_W0_UP_SZ;
>   
>   	sst_dsp_mailbox_init(sst, (CNL_ADSP_SRAM0_BASE + CNL_ADSP_W0_STAT_SZ),
>   			     CNL_ADSP_W0_UP_SZ, CNL_ADSP_SRAM1_BASE,

...and here...

> diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
> index 212370bf704c..6781eac13232 100644
> --- a/sound/soc/intel/skylake/skl-debug.c
> +++ b/sound/soc/intel/skylake/skl-debug.c
> @@ -173,7 +173,7 @@ static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
>   {
>   	struct skl_debug *d = file->private_data;
>   	struct sst_dsp *sst = d->skl->dsp;
> -	size_t w0_stat_sz = sst->addr.w0_stat_sz;
> +	size_t w0_stat_sz = SKL_FW_REGS_SIZE;

but here it's a different macro?

>   	void __iomem *in_base = sst->mailbox.in_base;
>   	void __iomem *fw_reg_addr;
>   	unsigned int offset;
> diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
> index 9f2dae92c1c9..5a0cb7f3d57e 100644
> --- a/sound/soc/intel/skylake/skl-sst-dsp.h
> +++ b/sound/soc/intel/skylake/skl-sst-dsp.h
> @@ -63,6 +63,7 @@ struct skl_dev;
>   
>   #define SKL_ADSP_W1_SZ			0x1000
>   
> +#define SKL_FW_REGS_SIZE		PAGE_SIZE
>   #define SKL_FW_STS_MASK			0xf
>   
>   #define SKL_FW_INIT			0x1
> diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
> index e9a7b2509b35..7e63c91cea54 100644
> --- a/sound/soc/intel/skylake/skl-sst.c
> +++ b/sound/soc/intel/skylake/skl-sst.c
> @@ -535,8 +535,6 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
>   	sst->addr.shim = mmio_base;
>   	sst->addr.sram0_base = SKL_ADSP_SRAM0_BASE;
>   	sst->addr.sram1_base = SKL_ADSP_SRAM1_BASE;
> -	sst->addr.w0_stat_sz = SKL_ADSP_W0_STAT_SZ;
> -	sst->addr.w0_up_sz = SKL_ADSP_W0_UP_SZ;
>   
>   	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
>   			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
> 
