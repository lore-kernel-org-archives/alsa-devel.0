From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: Fix
	uninitialized pointer usage
Date: Fri, 28 Apr 2017 07:46:27 +0900
Message-ID: <e9ad51bf-2292-3cde-beca-4dd76cfe235b@sakamocchi.jp>
References: <1493275882-27708-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id A31CC266C0A
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 00:46:30 +0200 (CEST)
In-Reply-To: <1493275882-27708-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Colin King <colin.king@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Apr 27 2017 15:51, Vinod Koul wrote:
> Due to recent code move, one instance dev_err() was passed a wrong
> uninitialized pointer for the device, so fix it.
> 
> sound/soc/intel/skylake/bxt-sst.c: In function 'bxt_sst_dsp_init':
> sound/soc/intel/skylake/bxt-sst.c:567:14: warning: 'skl' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    dev_err(skl->dev, "%s: no device\n", __func__);
>               ^
> 
> Fixes: 9fe9c7119283 ("ASoC: Intel: Skylake: Move sst common initialization to a helper function")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  sound/soc/intel/skylake/bxt-sst.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Dan and Colin were also going to fix this apparent bug. It's nice to add
their contribution, I think.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Colin King <colin.king@canonical.com>

http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/120225.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/120242.html

> diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> index fde4bc0f35b0..f5e7dbb1ba39 100644
> --- a/sound/soc/intel/skylake/bxt-sst.c
> +++ b/sound/soc/intel/skylake/bxt-sst.c
> @@ -564,7 +564,7 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
>  
>  	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &skl_dev);
>  	if (ret < 0) {
> -		dev_err(skl->dev, "%s: no device\n", __func__);
> +		dev_err(dev, "%s: no device\n", __func__);
>  		return ret;
>  	}


Regards

Takashi Sakamoto
