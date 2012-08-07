From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 4/4] fbdev: sh_mobile_lcdc: use
	dma_mmap_coherent if available
Date: Tue, 07 Aug 2012 14:01:43 +0200
Message-ID: <1854100.yBXTHaXkcr@avalon>
References: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
 <1344246924-32620-5-git-send-email-hdk@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [95.142.166.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E530265EC7
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 13:31:47 +0200 (CEST)
In-Reply-To: <1344246924-32620-5-git-send-email-hdk@igel.co.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hideki EIRAKU <hdk@igel.co.jp>
Cc: alsa-devel@alsa-project.org, Katsuya MATSUBARA <matsu@igel.co.jp>, linux-fbdev@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-media@vger.kernel.org, Pawel Osciak <pawel@osciak.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi Eiraku-san,

On Monday 06 August 2012 18:55:24 Hideki EIRAKU wrote:
> fb_mmap() implemented in fbmem.c uses smem_start as the physical
> address of the frame buffer.  In the sh_mobile_lcdc driver, the
> smem_start is a dma_addr_t that is not a physical address when IOMMU is
> enabled.  dma_mmap_coherent() maps the address correctly.  It is
> available on ARM platforms.
> 
> Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>

Acked-by: Hideki EIRAKU <hdk@igel.co.jp>

As this patch doesn't depend on any other patch in your series 
(ARCH_HAS_DMA_MMAP_COHERENT will not be defined without 1/4, so this patch 
will be a no-op until then), I've applied it to my tree and will push it to 
avoid merge conflicts, unless you would prefer to push it yourself.

> ---
>  drivers/video/sh_mobile_lcdcfb.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/sh_mobile_lcdcfb.c
> b/drivers/video/sh_mobile_lcdcfb.c index 8cb653b..c8cba7a 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -1614,6 +1614,17 @@ static int sh_mobile_lcdc_overlay_blank(int blank,
> struct fb_info *info) return 1;
>  }
> 
> +#ifdef ARCH_HAS_DMA_MMAP_COHERENT
> +static int
> +sh_mobile_lcdc_overlay_mmap(struct fb_info *info, struct vm_area_struct
> *vma) +{
> +	struct sh_mobile_lcdc_overlay *ovl = info->par;
> +
> +	return dma_mmap_coherent(ovl->channel->lcdc->dev, vma, ovl->fb_mem,
> +				 ovl->dma_handle, ovl->fb_size);
> +}
> +#endif
> +
>  static struct fb_ops sh_mobile_lcdc_overlay_ops = {
>  	.owner          = THIS_MODULE,
>  	.fb_read        = fb_sys_read,
> @@ -1626,6 +1637,9 @@ static struct fb_ops sh_mobile_lcdc_overlay_ops = {
>  	.fb_ioctl       = sh_mobile_lcdc_overlay_ioctl,
>  	.fb_check_var	= sh_mobile_lcdc_overlay_check_var,
>  	.fb_set_par	= sh_mobile_lcdc_overlay_set_par,
> +#ifdef ARCH_HAS_DMA_MMAP_COHERENT
> +	.fb_mmap	= sh_mobile_lcdc_overlay_mmap,
> +#endif
>  };
> 
>  static void
> @@ -2093,6 +2107,17 @@ static int sh_mobile_lcdc_blank(int blank, struct
> fb_info *info) return 0;
>  }
> 
> +#ifdef ARCH_HAS_DMA_MMAP_COHERENT
> +static int
> +sh_mobile_lcdc_mmap(struct fb_info *info, struct vm_area_struct *vma)
> +{
> +	struct sh_mobile_lcdc_chan *ch = info->par;
> +
> +	return dma_mmap_coherent(ch->lcdc->dev, vma, ch->fb_mem,
> +				 ch->dma_handle, ch->fb_size);
> +}
> +#endif
> +
>  static struct fb_ops sh_mobile_lcdc_ops = {
>  	.owner          = THIS_MODULE,
>  	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
> @@ -2108,6 +2133,9 @@ static struct fb_ops sh_mobile_lcdc_ops = {
>  	.fb_release	= sh_mobile_lcdc_release,
>  	.fb_check_var	= sh_mobile_lcdc_check_var,
>  	.fb_set_par	= sh_mobile_lcdc_set_par,
> +#ifdef ARCH_HAS_DMA_MMAP_COHERENT
> +	.fb_mmap	= sh_mobile_lcdc_mmap,
> +#endif
>  };
> 
>  static void

-- 
Regards,

Laurent Pinchart
