From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: Intel: Skylake: use dev in dev_err
 rather than skl pointer
Date: Fri, 28 Apr 2017 07:38:03 +0900
Message-ID: <d89d9ed2-1526-a3fe-054a-f73be8528e5e@sakamocchi.jp>
References: <20170427151315.19731-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 055A9266C0A
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 00:38:05 +0200 (CEST)
In-Reply-To: <20170427151315.19731-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Jayachandran B <jayachandran.b@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 28 2017 00:13, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The dev_err message is dereferencing an uininitialized skl pointer
> which should be avoided. Don't use skl, use dev instead.
> 
> Detected by CoverityScan, CID#1432042 ("Uninitialized pointer read")
> 
> Fixes: 9fe9c71192832 ("ASoC: Intel: Skylake: Move sst common initialization to a helper function")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/intel/skylake/bxt-sst.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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

Thanks for posting this patch, however Vinod already posted the same
fix. Please wait for merging it and verify again:

[alsa-devel] [PATCH 1/3] ASoC: Intel: Skylake: Fix uninitialized pointer
usage
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/120214.html


Regards

Takashi Sakamoto
