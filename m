From: Songmao Tian <tiansm@lemote.com>
Subject: Re: ALSA on MIPS platform
Date: Fri, 03 Aug 2007 21:50:36 +0800
Message-ID: <46B332AC.8020403@lemote.com>
References: <46B03CC0.3090000@lemote.com>
	<20070802.235606.122255120.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lemote.com (unknown [222.92.8.141])
	by alsa0.perex.cz (Postfix) with SMTP id EFAF810382D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Aug 2007 15:50:45 +0200 (CEST)
In-Reply-To: <20070802.235606.122255120.anemo@mba.ocn.ne.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Dajie Tan <jiankemeng@gmail.com>, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Atsushi Nemoto wrote:
> On Wed, 01 Aug 2007 15:56:48 +0800, Songmao Tian <tiansm@lemote.com> wrote:
>   
>>     The problem is clear:
>> 1. dma_alloc_noncoherent() return a non-cached address, and 
>> virt_to_page() need a cached logical addr (Have I named it right?)
>> 2. mmaped dam buffer should be non-cached.
>>
>> We have a ugly patch, but we want to solve the problem cleanly, so can 
>> anyone show me the way?
>>     
>
> virt_to_page() is used in many place in mm so making it robust might
> affect performance.  IMHO virt_to_page() seems too low-level as DMA
> API.
>
> If something like dma_virt_to_page(dev, cpu_addr) which can take a cpu
> address returned by dma_xxx APIs was defined, MIPS can implement it
> appropriately.
>
> And then pgprot_noncached issues still exist...
>
> ---
> Atsushi Nemoto
>
>
>
>   

I agree, and I am investigating to implement a dma_map_coherent, but It 
seems dma_map_coherent doesn't solve all the problem and will change a 
lot of code:(


dma_virt_to_page can be something like this.

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index b92dd8c..d2ead8a 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -181,6 +181,8 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define virt_to_page(kaddr)    pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
 #define virt_addr_valid(kaddr)    pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
 
+#define dma_virt_to_page(dma_addr) 
pfn_to_page(PFN_DOWN(virt_to_phys(CAC_ADDR(kaddr))))
+
 #define VM_DATA_DEFAULT_FLAGS    (VM_READ | VM_WRITE | VM_EXEC | \
                  VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 655094d..5e694dd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,6 +39,10 @@ extern int sysctl_legacy_va_layout;
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 
+#ifndef dma_virt_to_page
+#define dma_virt_to_page virt_to_page
+#endif
+
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 /*
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index cefd228..8b29bfd 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -91,7 +91,7 @@ void *snd_malloc_sgbuf_pages(struct device *device,
         }
         sgbuf->table[i].buf = tmpb.area;
         sgbuf->table[i].addr = tmpb.addr;
-        sgbuf->page_table[i] = virt_to_page(tmpb.area);
+        sgbuf->page_table[i] = dma_virt_to_page(tmpb.area);
         sgbuf->pages++;
     }
