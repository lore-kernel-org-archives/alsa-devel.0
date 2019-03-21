From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: wm_adsp: Make some variables static
Date: Thu, 21 Mar 2019 09:45:42 +0800
Message-ID: <85d44c6a-896d-43f4-973a-8b275eb52769@huawei.com>
References: <20190321014314.17960-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321014314.17960-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

Pls ignore this, sorry.

On 2019/3/21 9:43, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> sound/soc/codecs/wm_adsp.c:309:20: warning: symbol 'wm_adsp1_ops' was not declared. Should it be static?
> sound/soc/codecs/wm_adsp.c:310:20: warning: symbol 'wm_adsp2_ops' was not declared. Should it be static?
> sound/soc/codecs/wm_adsp.c:311:20: warning: symbol 'wm_halo_ops' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/codecs/wm_adsp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 644aaf1..4ed587f 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -306,9 +306,9 @@
>  #define HALO_MPU_VIO_ERR_SRC_MASK           0x00007fff
>  #define HALO_MPU_VIO_ERR_SRC_SHIFT                   0
>  
> -struct wm_adsp_ops wm_adsp1_ops;
> -struct wm_adsp_ops wm_adsp2_ops[];
> -struct wm_adsp_ops wm_halo_ops;
> +static struct wm_adsp_ops wm_adsp1_ops;
> +static struct wm_adsp_ops wm_adsp2_ops[];
> +static struct wm_adsp_ops wm_halo_ops;
>  
>  struct wm_adsp_buf {
>  	struct list_head list;
> 
