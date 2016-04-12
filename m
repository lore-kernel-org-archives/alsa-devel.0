From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: fsl: imx-pcm-fiq: use correct
	format specifier
Date: Tue, 12 Apr 2016 15:52:32 -0700
Message-ID: <20160412225232.GA30229@Asurada-Nvidia>
References: <1460494263-14805-1-git-send-email-xypron.glpk@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id A43BA2650CC
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 00:52:07 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id d184so2410253pfc.1
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 15:52:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460494263-14805-1-git-send-email-xypron.glpk@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 12, 2016 at 10:51:03PM +0200, Heinrich Schuchardt wrote:
> Documentation/printk-formats.txt has
> size_t: use %zu or %zx
> 
> runtime->dma_bytes is of type size_t.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-pcm-fiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
> index e63cd5e..dac6688 100644
> --- a/sound/soc/fsl/imx-pcm-fiq.c
> +++ b/sound/soc/fsl/imx-pcm-fiq.c
> @@ -220,7 +220,7 @@ static int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
>  	ret = dma_mmap_wc(substream->pcm->card->dev, vma, runtime->dma_area,
>  			  runtime->dma_addr, runtime->dma_bytes);
>  
> -	pr_debug("%s: ret: %d %p %pad 0x%08x\n", __func__, ret,
> +	pr_debug("%s: ret: %d %p %pad 0x%08zx\n", __func__, ret,
>  			runtime->dma_area,
>  			&runtime->dma_addr,
>  			runtime->dma_bytes);
> -- 
> 2.1.4
> 
