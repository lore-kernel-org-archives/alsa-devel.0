From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: Intel: Skylake: fix uninitialized pointer use
Date: Thu, 27 Apr 2017 20:13:04 +0900
Message-ID: <7732b5a1-965d-7056-f4ef-ff4b58ae15f7@sakamocchi.jp>
References: <20170427110014.2316664-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170427110014.2316664-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Jayachandran B <jayachandran.b@intel.com>, linux-kernel@vger.kernel.org, Ramesh Babu <ramesh.babu@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Apr 27 2017 19:59, Arnd Bergmann wrote:
> The error handling in bxt_sst_dsp_init() got changed in a way that
> it now derefences an uninitialized pointer when printing a warning
> about the device not being found:
>
> sound/soc/intel/skylake/bxt-sst.c: In function 'bxt_sst_dsp_init':
> sound/soc/intel/skylake/bxt-sst.c:567:14: error: 'skl' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> As we do have a valid device pointer available at the call site,
> let's use that instead.
>
> Fixes: 9fe9c7119283 ("ASoC: Intel: Skylake: Move sst common initialization to a helper function")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/intel/skylake/bxt-sst.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

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
