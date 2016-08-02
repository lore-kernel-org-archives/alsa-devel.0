From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1170/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 22:30:44 +0900
Message-ID: <f0caef62-177d-5d16-7db8-b1ae83a3c0d3@sakamocchi.jp>
References: <20160802122252.28150-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160802122252.28150-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>, clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

On Aug 2 2016 21:22, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> ---
>  sound/firewire/fireworks/fireworks.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
> index 71a0613..3390b4e 100644
> --- a/sound/firewire/fireworks/fireworks.c
> +++ b/sound/firewire/fireworks/fireworks.c
> @@ -27,16 +27,16 @@ static bool enable[SNDRV_CARDS]	= SNDRV_DEFAULT_ENABLE_PNP;
>  unsigned int snd_efw_resp_buf_size	= 1024;
>  bool snd_efw_resp_buf_debug		= false;
>  
> -module_param_array(index, int, NULL, 0444);
> +module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(index, "card index");
> -module_param_array(id, charp, NULL, 0444);
> +module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(id, "ID string");
> -module_param_array(enable, bool, NULL, 0444);
> +module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(enable, "enable Fireworks sound card");
> -module_param_named(resp_buf_size, snd_efw_resp_buf_size, uint, 0444);
> +module_param_named(resp_buf_size, snd_efw_resp_buf_size, uint, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(resp_buf_size,
>  		 "response buffer size (max 4096, default 1024)");
> -module_param_named(resp_buf_debug, snd_efw_resp_buf_debug, bool, 0444);
> +module_param_named(resp_buf_debug, snd_efw_resp_buf_debug, bool, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(resp_buf_debug, "store all responses to buffer");
>  
>  static DEFINE_MUTEX(devices_mutex);
> 
