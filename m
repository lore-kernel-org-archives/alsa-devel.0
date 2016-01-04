From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ALSA: hdac: drop unused dev_to_hdac macro
Date: Mon, 4 Jan 2016 13:53:47 +0530
Message-ID: <20160104082347.GG2940@localhost>
References: <00c81b79d57196a8a72ce9c4a0e8ca5d3ec2eba7.1451312334.git.geliangtang@163.com>
 <b86ede48c70d4f57bb72d52045e4f2afe12a88ae.1451312334.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b86ede48c70d4f57bb72d52045e4f2afe12a88ae.1451312334.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 28, 2015 at 10:47:11PM +0800, Geliang Tang wrote:
> dev_to_hdac is not used anymore so drop it.

No harm in keeping this for now as the systems using these will be coming
up and more users will be upstreamed...

> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  sound/hda/ext/hdac_ext_bus.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
> index 2433f7c..58f6b98 100644
> --- a/sound/hda/ext/hdac_ext_bus.c
> +++ b/sound/hda/ext/hdac_ext_bus.c
> @@ -197,8 +197,6 @@ void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_remove);
> -#define dev_to_hdac(dev) (container_of((dev), \
> -			struct hdac_device, dev))
>  
>  static inline struct hdac_ext_driver *get_edrv(struct device *dev)
>  {
> -- 
> 2.5.0
> 
> 

-- 
~Vinod
