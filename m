From: "Jie, Yang" <yang.jie@intel.com>
Subject: RE: [PATCH] ASoC: Intel: fix Coccinelle kfree warning
Date: Mon, 27 Apr 2015 07:23:32 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A905520746@SHSMSX101.ccr.corp.intel.com>
References: <1430062932-26668-1-git-send-email-firogm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1430062932-26668-1-git-send-email-firogm@gmail.com>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Firo Yang <firogm@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "Lu, Han" <han.lu@intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "Piskorski, Pawel" <pawel.piskorski@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Jin, Yao" <yao.jin@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Firo Yang [mailto:firogm@gmail.com]
> Sent: Sunday, April 26, 2015 11:42 PM
> To: lgirdwood@gmail.com
> Cc: kernel-janitors@vger.kernel.org; broonie@kernel.org; perex@perex.cz;
> tiwai@suse.de; Jie, Yang; Lu, Han; jarkko.nikula@linux.intel.com; Piskorski,
> Pawel; alsa-devel@alsa-project.org; Firo Yang
> Subject: [PATCH] ASoC: Intel: fix Coccinelle kfree warning
> 
> It's not necessary to use kfree() to free memory allocated with devm_kzalloc
> in a probe function and using kfree leads to a double free.
> 
> Signed-off-by: Firo Yang <firogm@gmail.com>
> ---
>  sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c
> b/sound/soc/intel/haswell/sst-haswell-ipc.c
> index 344a1e9..324eceb 100644
> --- a/sound/soc/intel/haswell/sst-haswell-ipc.c
> +++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
> @@ -2201,7 +2201,6 @@ dma_err:
>  dsp_new_err:
>  	sst_ipc_fini(ipc);
>  ipc_init_err:
> -	kfree(hsw);
 
It has been fixed by Jin Yao 2 weeks ago:
http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=ac98b4c015b50b1e452f8d55b612320be7f80825

~Keyon

>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(sst_hsw_dsp_init);
> --
> 2.1.0

