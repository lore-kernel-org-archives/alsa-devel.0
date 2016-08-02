From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1169/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 22:29:36 +0900
Message-ID: <71bd5f16-7c69-f331-1012-c683d6133abb@sakamocchi.jp>
References: <20160802122246.28082-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160802122246.28082-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>, clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, chuansheng.liu@intel.com, aryabinin@virtuozzo.com
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
>  sound/firewire/bebob/bebob.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
> index f7e2cbd..ec67fc6 100644
> --- a/sound/firewire/bebob/bebob.c
> +++ b/sound/firewire/bebob/bebob.c
> @@ -22,11 +22,11 @@ static int index[SNDRV_CARDS]	= SNDRV_DEFAULT_IDX;
>  static char *id[SNDRV_CARDS]	= SNDRV_DEFAULT_STR;
>  static bool enable[SNDRV_CARDS]	= SNDRV_DEFAULT_ENABLE_PNP;
>  
> -module_param_array(index, int, NULL, 0444);
> +module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(index, "card index");
> -module_param_array(id, charp, NULL, 0444);
> +module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(id, "ID string");
> -module_param_array(enable, bool, NULL, 0444);
> +module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(enable, "enable BeBoB sound card");
>  
>  static DEFINE_MUTEX(devices_mutex);
