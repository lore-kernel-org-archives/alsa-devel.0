From: David Cullen <david.cullen@teligy.com>
Subject: Re: Call to mmap in ALSA lib 1.0.13 fails in
 src/pcm/pcm_mmap.c line 367
Date: Fri, 05 Jan 2007 13:41:01 -0500
Message-ID: <459E9BBD.9050304@teligy.com>
References: <45880176.3070300@teligy.com>	<s5hirg64f8b.wl%tiwai@suse.de>	<45898126.3060808@teligy.com>	<s5hejqu4dq8.wl%tiwai@suse.de>	<458989BD.7050005@teligy.com>
	<s5hejqtryn9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hejqtryn9.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Jason Yates <jason.yates@teligy.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear Mr. Iwai,

Takashi Iwai wrote:
> 
> The implementation depends pretty much on the architecture.
> (Also, dma_mmap() is no global function but specific only for ARM.)
> Since the vm_region struct is different between ppc and arm (the page
> pointer is missing in ppc version), it cannot be copied as it is.
> 
> A simple (but totally untested) version would be like below:
> 
> int dma_mmap_coherent(struct device *dev,
> 		struct vm_area_struct *vma, void *cpu_addr,
> 		dma_addr_t dma_addr, size_t size)
> {
> 	unsigned long pfn;
> 
> 	pfn = page_to_pfn(virt_to_page(bus_to_virt(dma_addr)));
> 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> 				vma->vm_end - vma->vm_start,
> 				vma->vm_pgprot);
> }
> 
> (This might not work for some ppc models, though...)
> 
> Then either add .mmap callback to each of snd_pcm_ops table in ca0106
> that calls dma_mmap_coherent() above, or change snd_pcm_default_mmap
> to call dma_mmap_coherent() directly instead of nopage method.
> For the former way, take a look at sound/arm/aaci.c (and devdma.c) as
> a reference.
> 

I implemented this solution but speaker-test hangs in pcm.c, line 2299:

(gdb) frame 1
#1  0x0ff1df40 in snd_pcm_wait_nocheck (pcm=0x10032830, timeout=-1)
    at pcm.c:2299
2299            err_poll = poll(pfd, npfds, timeout);

Any idea what is going wrong here?

-- 
Thank you,
David Cullen
Teligy
(864) 527-1263 Office
(864) 415-7063 Cell

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
