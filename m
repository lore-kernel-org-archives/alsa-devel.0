From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH 1149/1285] Replace numeric parameter like
	0444 with macro
Date: Tue, 16 Aug 2016 11:08:45 +0000
Message-ID: <20160816110845.GA21629@osadl.at>
References: <20160802122044.26724-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.osadl.at (mail.osadl.at [92.243.35.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 6ABA9265CC5
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 13:09:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160802122044.26724-1-baolex.ni@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baole Ni <baolex.ni@intel.com>
Cc: k.kozlowski@samsung.com, chuansheng.liu@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, hofrat@osadl.org, tiwai@suse.com, kyungmin.park@samsung.com, kadlec@blackhole.kfki.hu, aryabinin@virtuozzo.com, m.szyprowski@samsung.com, davem@davemloft.net, serge@hallyn.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 02, 2016 at 08:20:44PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.

this is actually a quite common issue - taking your example and generalizing
it into a simple coccinelle scanner shows aproximately 1400 cases for 
module_param, module_param_array and module_param_named.

> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  sound/core/oss/pcm_oss.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
> index ebc9fdf..0ff0dd8 100644
> --- a/sound/core/oss/pcm_oss.c
> +++ b/sound/core/oss/pcm_oss.c
> @@ -53,11 +53,11 @@ static bool nonblock_open = 1;
>  MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Abramo Bagnara <abramo@alsa-project.org>");
>  MODULE_DESCRIPTION("PCM OSS emulation for ALSA.");
>  MODULE_LICENSE("GPL");
> -module_param_array(dsp_map, int, NULL, 0444);
> +module_param_array(dsp_map, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);

as S_IRUSR | S_IRGRP | S_IROTH == S_IRUGO  this (and the others below
could be simplfied 

+module_param_array(dsp_map, int, NULL, S_IRUGO);

>  MODULE_PARM_DESC(dsp_map, "PCM device number assigned to 1st OSS device.");
> -module_param_array(adsp_map, int, NULL, 0444);
> +module_param_array(adsp_map, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(adsp_map, "PCM device number assigned to 2nd OSS device.");
> -module_param(nonblock_open, bool, 0644);
> +module_param(nonblock_open, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

for 0644 one could also use S_IWUSR | S_IRUGO which might be more redaable
here as well.

>  MODULE_PARM_DESC(nonblock_open, "Don't block opening busy PCM devices.");
>  MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_PCM);
>  MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_PCM1);

thx!
hofrat
