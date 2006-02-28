From: Falko Schmidt <kaethorn@stud.uni-stuttgart.de>
Subject: Re: trouble on ppc32?
Date: Tue, 28 Feb 2006 16:41:03 +0100
Message-ID: <20060228154103.GA2205@celes>
References: <20060220231240.GB6186@celes> <s5hmzgkkag3.wl%tiwai@suse.de> <20060222170201.GA2262@celes> <s5h7j7kvbcb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7j7kvbcb.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 24, 2006 at 07:52:04PM +0100, Takashi Iwai wrote:
> At Wed, 22 Feb 2006 18:02:01 +0100,
> Falko Schmidt wrote:
> > 
> > On Tue, Feb 21, 2006 at 04:17:48PM +0100, Takashi Iwai wrote:
> > > > -------------
> > > > Soundblaster Live 512 (PCI):
> > > > -------------
> > > > 
> > > > Feb 20 21:54:43 cyan kernel: PCI: Enabling device 0000:01:03.0 (0104 -> 0105)
> > > > Feb 20 21:54:43 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba3f000)!!
> > > > Feb 20 21:54:59 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
> > > > Feb 20 21:54:59 cyan kernel: emu: failure page = 0
> > > > Feb 20 21:54:59 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
> > > > Feb 20 21:54:59 cyan kernel: emu: failure page = 0
> > > > Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
> > > > Feb 20 21:55:13 cyan kernel: emu: failure page = 0
> > > > Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
> > > > Feb 20 21:55:13 cyan kernel: emu: failure page = 0
> > > > Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8baa1000)!!
> > > > Feb 20 21:55:13 cyan kernel: emu: failure page = 0
> > > > Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8baa1000)!!
> > > > Feb 20 21:55:13 cyan kernel: emu: failure page = 0
> > > 
> > > It's not the fault of driver but because of ppc's dma_alloc_coherent().
> > > It doesn't allocate memories in the given coherent_dma_mask.
> > 
> > That sounds interesting. Thanks for pointing it out.
> 
> Does the patch below have any influence?  It's a blind-shot, though...
> 
> 
> Takashi
> 
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 946f321..b77caa7 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -546,6 +546,7 @@ void *iommu_alloc_coherent(struct iommu_
>  		return NULL;
>  
>  	/* Alloc enough pages (and possibly more) */
> + again:
>  	ret = (void *)__get_free_pages(flag, order);
>  	if (!ret)
>  		return NULL;
> @@ -556,6 +557,15 @@ void *iommu_alloc_coherent(struct iommu_
>  	if (mapping == DMA_ERROR_CODE) {
>  		free_pages((unsigned long)ret, order);
>  		ret = NULL;
> +	} else if (dev->coherent_dma_mask &&
> +		   mapping >= dev->coherent_dma_mask) {
> +		iommu_free(tbl, mapping, npages);
> +		free_pages((unsigned long)ret, order);
> +		if (! (flag & __GFP_DMA)) {
> +			flag |= __GFP_DMA;
> +			goto again;
> +		}
> +		ret = NULL;
>  	} else
>  		*dma_handle = mapping;
>  	return ret;
>

2.6.15 kernels currently won't boot on my machine. I'll get back to you
once I solved that. Thanks a lot so far.

Falko


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
