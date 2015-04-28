From: Peter Zubaj <pzubaj@marticonet.sk>
Subject: Re: Emu10k2 - support for 32 bit DMA mode
Date: Tue, 28 Apr 2015 22:06:08 +0200
Message-ID: <1430251568.3543.2.camel@marticonet.sk>
References: <1430072870.2386.11.camel@marticonet.sk>
 <s5hiochzr5u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Pvh9K8gn59BOx+7V+N1e"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.marticonet.sk (mailgw.marticonet.sk [217.119.122.17])
 by alsa0.perex.cz (Postfix) with ESMTP id BB6C5260427
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 22:06:11 +0200 (CEST)
In-Reply-To: <s5hiochzr5u.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-Pvh9K8gn59BOx+7V+N1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

I am not sure, if this is what you want.

Regards,
Peter

On Mon, 2015-04-27 at 14:34 +0200, Takashi Iwai wrote:
> At Sun, 26 Apr 2015 20:27:50 +0200,
> Peter Zubaj wrote:
> > 
> > Hi,
> > 
> > Looks like audigy emu10k2 (probably emu10k1 - sb live too) support two
> > modes for DMA. Second mode is useful for 64 bit os with more then 2 GB
> > of ram (fixes problems with big soundfont loading)
> > 
> > 1) 32MB from 2 GB address space using 8192 pages (used now as default)
> > 2) 16MB from 4 GB address space using 4096 pages
> > 
> > Mode is set using HCFG_EXPANDED_MEM flag in HCFG register.
> > Also format of emu10k2 page table is then different.
> > 
> > If someone wants to play with it, attached is patch to enable this mode
> > for audigy. It is tested only on audigy rx (8 GB ram, 64 bit os). 
> 
> Great, thanks for spotting out this.
> I quickly tested an old board and confirmed to work.
> 
> The patch looks mostly OK for merge.  Could you give your sign-off
> tag?
> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > Regards,
> > Peter
> > diff -ur linux-4.0_orig/include/sound/emu10k1.h linux-4.0/include/sound/emu10k1.h
> > --- linux-4.0_orig/include/sound/emu10k1.h	2015-04-13 00:12:50.000000000 +0200
> > +++ linux-4.0/include/sound/emu10k1.h	2015-04-25 22:57:39.984002932 +0200
> > @@ -41,7 +41,8 @@
> >  
> >  #define EMUPAGESIZE     4096
> >  #define MAXREQVOICES    8
> > -#define MAXPAGES        8192
> > +#define MAXPAGES0       4096	/* 32 bit mode */
> > +#define MAXPAGES1       8192	/* 31 bit mode */
> >  #define RESERVED        0
> >  #define NUM_MIDI        16
> >  #define NUM_G           64              /* use all channels */
> > @@ -50,8 +51,7 @@
> >  
> >  /* FIXME? - according to the OSS driver the EMU10K1 needs a 29 bit DMA mask */
> >  #define EMU10K1_DMA_MASK	0x7fffffffUL	/* 31bit */
> > -#define AUDIGY_DMA_MASK		0x7fffffffUL	/* 31bit FIXME - 32 should work? */
> > -						/* See ALSA bug #1276 - rlrevell */
> > +#define AUDIGY_DMA_MASK		0xffffffffUL	/* 32bit mode */
> >  
> >  #define TMEMSIZE        256*1024
> >  #define TMEMSIZEREG     4
> > @@ -466,8 +466,11 @@
> >  
> >  #define MAPB			0x0d		/* Cache map B						*/
> >  
> > -#define MAP_PTE_MASK		0xffffe000	/* The 19 MSBs of the PTE indexed by the PTI		*/
> > -#define MAP_PTI_MASK		0x00001fff	/* The 13 bit index to one of the 8192 PTE dwords      	*/
> > +#define MAP_PTE_MASK0		0xfffff000	/* The 20 MSBs of the PTE indexed by the PTI		*/
> > +#define MAP_PTI_MASK0		0x00000fff	/* The 12 bit index to one of the 4096 PTE dwords      	*/
> > +
> > +#define MAP_PTE_MASK1		0xffffe000	/* The 19 MSBs of the PTE indexed by the PTI		*/
> > +#define MAP_PTI_MASK1		0x00001fff	/* The 13 bit index to one of the 8192 PTE dwords      	*/
> >  
> >  /* 0x0e, 0x0f: Not used */
> >  
> > @@ -1704,6 +1707,7 @@
> >  	unsigned short model;			/* subsystem id */
> >  	unsigned int card_type;			/* EMU10K1_CARD_* */
> >  	unsigned int ecard_ctrl;		/* ecard control bits */
> > +	unsigned int address_mode;		/* address mode */
> >  	unsigned long dma_mask;			/* PCI DMA mask */
> >  	unsigned int delay_pcm_irq;		/* in samples */
> >  	int max_cache_pages;			/* max memory size / PAGE_SIZE */
> > diff -ur linux-4.0_orig/sound/pci/emu10k1/emu10k1_callback.c linux-4.0/sound/pci/emu10k1/emu10k1_callback.c
> > --- linux-4.0_orig/sound/pci/emu10k1/emu10k1_callback.c	2015-04-13 00:12:50.000000000 +0200
> > +++ linux-4.0/sound/pci/emu10k1/emu10k1_callback.c	2015-04-25 22:12:20.301949674 +0200
> > @@ -415,7 +415,7 @@
> >  	snd_emu10k1_ptr_write(hw, Z2, ch, 0);
> >  
> >  	/* invalidate maps */
> > -	temp = (hw->silent_page.addr << 1) | MAP_PTI_MASK;
> > +	temp = (hw->silent_page.addr << hw->address_mode) | (hw->address_mode ? MAP_PTI_MASK1 : MAP_PTI_MASK0);
> >  	snd_emu10k1_ptr_write(hw, MAPA, ch, temp);
> >  	snd_emu10k1_ptr_write(hw, MAPB, ch, temp);
> >  #if 0
> > @@ -436,7 +436,7 @@
> >  		snd_emu10k1_ptr_write(hw, CDF, ch, sample);
> >  
> >  		/* invalidate maps */
> > -		temp = ((unsigned int)hw->silent_page.addr << 1) | MAP_PTI_MASK;
> > +		temp = ((unsigned int)hw->silent_page.addr << hw_address_mode) | (hw->address_mode ? MAP_PTI_MASK1 : MAP_PTI_MASK0);
> >  		snd_emu10k1_ptr_write(hw, MAPA, ch, temp);
> >  		snd_emu10k1_ptr_write(hw, MAPB, ch, temp);
> >  		
> > diff -ur linux-4.0_orig/sound/pci/emu10k1/emu10k1_main.c linux-4.0/sound/pci/emu10k1/emu10k1_main.c
> > --- linux-4.0_orig/sound/pci/emu10k1/emu10k1_main.c	2015-04-13 00:12:50.000000000 +0200
> > +++ linux-4.0/sound/pci/emu10k1/emu10k1_main.c	2015-04-25 23:25:48.695837022 +0200
> > @@ -160,7 +160,7 @@
> >  	unsigned int silent_page;
> >  	int ch;
> >  	u32 tmp;
> > -
> > +	
> >  	/* disable audio and lock cache */
> >  	outl(HCFG_LOCKSOUNDCACHE | HCFG_LOCKTANKCACHE_MASK |
> >  		HCFG_MUTEBUTTONENABLE, emu->port + HCFG);
> > @@ -282,7 +282,7 @@
> >  	snd_emu10k1_ptr_write(emu, TCB, 0, 0);	/* taken from original driver */
> >  	snd_emu10k1_ptr_write(emu, TCBS, 0, 4);	/* taken from original driver */
> >  
> > -	silent_page = (emu->silent_page.addr << 1) | MAP_PTI_MASK;
> > +	silent_page = (emu->silent_page.addr << emu->address_mode) | (emu->address_mode ? MAP_PTI_MASK1 : MAP_PTI_MASK0);
> >  	for (ch = 0; ch < NUM_G; ch++) {
> >  		snd_emu10k1_ptr_write(emu, MAPA, ch, silent_page);
> >  		snd_emu10k1_ptr_write(emu, MAPB, ch, silent_page);
> > @@ -348,6 +348,11 @@
> >  		outl(reg | A_IOCFG_GPOUT0, emu->port + A_IOCFG);
> >  	}
> >  
> > +	if (emu->address_mode == 0) {
> > +		/* use 16M in 4G */
> > +		outl(inl(emu->port + HCFG) | HCFG_EXPANDED_MEM, emu->port + HCFG);
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1877,8 +1882,10 @@
> >  
> >  	is_audigy = emu->audigy = c->emu10k2_chip;
> >  
> > +	/* set addressing mode */
> > +	emu->address_mode = is_audigy ? 0 : 1;
> >  	/* set the DMA transfer mask */
> > -	emu->dma_mask = is_audigy ? AUDIGY_DMA_MASK : EMU10K1_DMA_MASK;
> > +	emu->dma_mask = emu->address_mode ? EMU10K1_DMA_MASK : AUDIGY_DMA_MASK;
> >  	if (pci_set_dma_mask(pci, emu->dma_mask) < 0 ||
> >  	    pci_set_consistent_dma_mask(pci, emu->dma_mask) < 0) {
> >  		dev_err(card->dev,
> > @@ -1903,7 +1910,7 @@
> >  
> >  	emu->max_cache_pages = max_cache_bytes >> PAGE_SHIFT;
> >  	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
> > -				32 * 1024, &emu->ptb_pages) < 0) {
> > +				(emu->address_mode ? 32 : 16) * 1024, &emu->ptb_pages) < 0) {
> >  		err = -ENOMEM;
> >  		goto error;
> >  	}
> > @@ -2002,8 +2009,8 @@
> >  
> >  	/* Clear silent pages and set up pointers */
> >  	memset(emu->silent_page.area, 0, PAGE_SIZE);
> > -	silent_page = emu->silent_page.addr << 1;
> > -	for (idx = 0; idx < MAXPAGES; idx++)
> > +	silent_page = emu->silent_page.addr << emu->address_mode;
> > +	for (idx = 0; idx < (emu->address_mode ? MAXPAGES1 : MAXPAGES0); idx++)
> >  		((u32 *)emu->ptb_pages.area)[idx] = cpu_to_le32(silent_page | idx);
> >  
> >  	/* set up voice indices */
> > diff -ur linux-4.0_orig/sound/pci/emu10k1/emupcm.c linux-4.0/sound/pci/emu10k1/emupcm.c
> > --- linux-4.0_orig/sound/pci/emu10k1/emupcm.c	2015-04-13 00:12:50.000000000 +0200
> > +++ linux-4.0/sound/pci/emu10k1/emupcm.c	2015-04-25 22:48:39.794353213 +0200
> > @@ -380,7 +380,7 @@
> >  	snd_emu10k1_ptr_write(emu, Z1, voice, 0);
> >  	snd_emu10k1_ptr_write(emu, Z2, voice, 0);
> >  	/* invalidate maps */
> > -	silent_page = ((unsigned int)emu->silent_page.addr << 1) | MAP_PTI_MASK;
> > +	silent_page = ((unsigned int)emu->silent_page.addr << emu->address_mode) | (emu->address_mode ? MAP_PTI_MASK1 : MAP_PTI_MASK0);
> >  	snd_emu10k1_ptr_write(emu, MAPA, voice, silent_page);
> >  	snd_emu10k1_ptr_write(emu, MAPB, voice, silent_page);
> >  	/* modulation envelope */
> > diff -ur linux-4.0_orig/sound/pci/emu10k1/memory.c linux-4.0/sound/pci/emu10k1/memory.c
> > --- linux-4.0_orig/sound/pci/emu10k1/memory.c	2015-04-13 00:12:50.000000000 +0200
> > +++ linux-4.0/sound/pci/emu10k1/memory.c	2015-04-25 22:55:56.865308462 +0200
> > @@ -34,10 +34,11 @@
> >   * aligned pages in others
> >   */
> >  #define __set_ptb_entry(emu,page,addr) \
> > -	(((u32 *)(emu)->ptb_pages.area)[page] = cpu_to_le32(((addr) << 1) | (page)))
> > +	(((u32 *)(emu)->ptb_pages.area)[page] = cpu_to_le32(((addr) << (emu->address_mode)) | (page)))
> >  
> >  #define UNIT_PAGES		(PAGE_SIZE / EMUPAGESIZE)
> > -#define MAX_ALIGN_PAGES		(MAXPAGES / UNIT_PAGES)
> > +#define MAX_ALIGN_PAGES0		(MAXPAGES0 / UNIT_PAGES)
> > +#define MAX_ALIGN_PAGES1		(MAXPAGES1 / UNIT_PAGES)
> >  /* get aligned page from offset address */
> >  #define get_aligned_page(offset)	((offset) >> PAGE_SHIFT)
> >  /* get offset address from aligned page */
> > @@ -124,7 +125,7 @@
> >  		}
> >  		page = blk->mapped_page + blk->pages;
> >  	}
> > -	size = MAX_ALIGN_PAGES - page;
> > +	size = (emu->address_mode ? MAX_ALIGN_PAGES1 : MAX_ALIGN_PAGES0) - page;
> >  	if (size >= max_size) {
> >  		*nextp = pos;
> >  		return page;
> > @@ -181,7 +182,7 @@
> >  		q = get_emu10k1_memblk(p, mapped_link);
> >  		end_page = q->mapped_page;
> >  	} else
> > -		end_page = MAX_ALIGN_PAGES;
> > +		end_page = (emu->address_mode ? MAX_ALIGN_PAGES1 : MAX_ALIGN_PAGES0);
> >  
> >  	/* remove links */
> >  	list_del(&blk->mapped_link);
> > @@ -307,7 +308,7 @@
> >  	if (snd_BUG_ON(!emu))
> >  		return NULL;
> >  	if (snd_BUG_ON(runtime->dma_bytes <= 0 ||
> > -		       runtime->dma_bytes >= MAXPAGES * EMUPAGESIZE))
> > +		       runtime->dma_bytes >= (emu->address_mode ? MAXPAGES1 : MAXPAGES0) * EMUPAGESIZE))
> >  		return NULL;
> >  	hdr = emu->memhdr;
> >  	if (snd_BUG_ON(!hdr))
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


--=-Pvh9K8gn59BOx+7V+N1e
Content-Disposition: attachment; filename="0001-ALSA-Emu10k2-32-bit-DMA-mode.patch"
Content-Type: text/x-patch; name="0001-ALSA-Emu10k2-32-bit-DMA-mode.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA3NGM2NzExZmI5MGYyMzVhNTU3OGQ1ZDMzNDJmMTRlZWFjODM2N2E5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQZXRlciBadWJhaiA8cHp1YmFqQG1hcnRpY29uZXQuc2s+CkRh
dGU6IFR1ZSwgMjggQXByIDIwMTUgMjE6NTc6MjkgKzAyMDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBFbXUxMGsyIDMyIGJpdCBETUEgbW9kZQoKTG9va3MgbGlrZSBhdWRpZ3kgZW11MTBrMiAocHJv
YmFibHkgZW11MTBrMSAtIHNiIGxpdmUgdG9vKSBzdXBwb3J0IHR3bwptb2RlcyBmb3IgRE1BLiBT
ZWNvbmQgbW9kZSBpcyB1c2VmdWwgZm9yIDY0IGJpdCBvcyB3aXRoIG1vcmUgdGhlbiAyIEdCCm9m
IHJhbSAoZml4ZXMgcHJvYmxlbXMgd2l0aCBiaWcgc291bmRmb250IGxvYWRpbmcpCgoxKSAzMk1C
IGZyb20gMiBHQiBhZGRyZXNzIHNwYWNlIHVzaW5nIDgxOTIgcGFnZXMgKHVzZWQgbm93IGFzIGRl
ZmF1bHQpCjIpIDE2TUIgZnJvbSA0IEdCIGFkZHJlc3Mgc3BhY2UgdXNpbmcgNDA5NiBwYWdlcwoK
TW9kZSBpcyBzZXQgdXNpbmcgSENGR19FWFBBTkRFRF9NRU0gZmxhZyBpbiBIQ0ZHIHJlZ2lzdGVy
LgpBbHNvIGZvcm1hdCBvZiBlbXUxMGsyIHBhZ2UgdGFibGUgaXMgdGhlbiBkaWZmZXJlbnQuCgpT
aWduZWQtb2ZmLWJ5OiBQZXRlciBadWJhaiA8cHp1YmFqQG1hcnRpY29uZXQuc2s+Ci0tLQogaW5j
bHVkZS9zb3VuZC9lbXUxMGsxLmggICAgICAgICAgICAgIHwgMTQgKysrKysrKysrLS0tLS0KIHNv
dW5kL3BjaS9lbXUxMGsxL2VtdTEwazFfY2FsbGJhY2suYyB8ICA0ICsrLS0KIHNvdW5kL3BjaS9l
bXUxMGsxL2VtdTEwazFfbWFpbi5jICAgICB8IDE5ICsrKysrKysrKysrKystLS0tLS0KIHNvdW5k
L3BjaS9lbXUxMGsxL2VtdXBjbS5jICAgICAgICAgICB8ICAyICstCiBzb3VuZC9wY2kvZW11MTBr
MS9tZW1vcnkuYyAgICAgICAgICAgfCAxMSArKysrKystLS0tLQogNSBmaWxlcyBjaGFuZ2VkLCAz
MSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3Nv
dW5kL2VtdTEwazEuaCBiL2luY2x1ZGUvc291bmQvZW11MTBrMS5oCmluZGV4IDBkZTk1Y2MuLjVi
ZDEzNDYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvc291bmQvZW11MTBrMS5oCisrKyBiL2luY2x1ZGUv
c291bmQvZW11MTBrMS5oCkBAIC00MSw3ICs0MSw4IEBACiAKICNkZWZpbmUgRU1VUEFHRVNJWkUg
ICAgIDQwOTYKICNkZWZpbmUgTUFYUkVRVk9JQ0VTICAgIDgKLSNkZWZpbmUgTUFYUEFHRVMgICAg
ICAgIDgxOTIKKyNkZWZpbmUgTUFYUEFHRVMwICAgICAgIDQwOTYJLyogMzIgYml0IG1vZGUgKi8K
KyNkZWZpbmUgTUFYUEFHRVMxICAgICAgIDgxOTIJLyogMzEgYml0IG1vZGUgKi8KICNkZWZpbmUg
UkVTRVJWRUQgICAgICAgIDAKICNkZWZpbmUgTlVNX01JREkgICAgICAgIDE2CiAjZGVmaW5lIE5V
TV9HICAgICAgICAgICA2NCAgICAgICAgICAgICAgLyogdXNlIGFsbCBjaGFubmVscyAqLwpAQCAt
NTAsOCArNTEsNyBAQAogCiAvKiBGSVhNRT8gLSBhY2NvcmRpbmcgdG8gdGhlIE9TUyBkcml2ZXIg
dGhlIEVNVTEwSzEgbmVlZHMgYSAyOSBiaXQgRE1BIG1hc2sgKi8KICNkZWZpbmUgRU1VMTBLMV9E
TUFfTUFTSwkweDdmZmZmZmZmVUwJLyogMzFiaXQgKi8KLSNkZWZpbmUgQVVESUdZX0RNQV9NQVNL
CQkweDdmZmZmZmZmVUwJLyogMzFiaXQgRklYTUUgLSAzMiBzaG91bGQgd29yaz8gKi8KLQkJCQkJ
CS8qIFNlZSBBTFNBIGJ1ZyAjMTI3NiAtIHJscmV2ZWxsICovCisjZGVmaW5lIEFVRElHWV9ETUFf
TUFTSwkJMHhmZmZmZmZmZlVMCS8qIDMyYml0IG1vZGUgKi8KIAogI2RlZmluZSBUTUVNU0laRSAg
ICAgICAgMjU2KjEwMjQKICNkZWZpbmUgVE1FTVNJWkVSRUcgICAgIDQKQEAgLTQ2Niw4ICs0NjYs
MTEgQEAKIAogI2RlZmluZSBNQVBCCQkJMHgwZAkJLyogQ2FjaGUgbWFwIEIJCQkJCQkqLwogCi0j
ZGVmaW5lIE1BUF9QVEVfTUFTSwkJMHhmZmZmZTAwMAkvKiBUaGUgMTkgTVNCcyBvZiB0aGUgUFRF
IGluZGV4ZWQgYnkgdGhlIFBUSQkJKi8KLSNkZWZpbmUgTUFQX1BUSV9NQVNLCQkweDAwMDAxZmZm
CS8qIFRoZSAxMyBiaXQgaW5kZXggdG8gb25lIG9mIHRoZSA4MTkyIFBURSBkd29yZHMgICAgICAJ
Ki8KKyNkZWZpbmUgTUFQX1BURV9NQVNLMAkJMHhmZmZmZjAwMAkvKiBUaGUgMjAgTVNCcyBvZiB0
aGUgUFRFIGluZGV4ZWQgYnkgdGhlIFBUSQkJKi8KKyNkZWZpbmUgTUFQX1BUSV9NQVNLMAkJMHgw
MDAwMGZmZgkvKiBUaGUgMTIgYml0IGluZGV4IHRvIG9uZSBvZiB0aGUgNDA5NiBQVEUgZHdvcmRz
ICAgICAgCSovCisKKyNkZWZpbmUgTUFQX1BURV9NQVNLMQkJMHhmZmZmZTAwMAkvKiBUaGUgMTkg
TVNCcyBvZiB0aGUgUFRFIGluZGV4ZWQgYnkgdGhlIFBUSQkJKi8KKyNkZWZpbmUgTUFQX1BUSV9N
QVNLMQkJMHgwMDAwMWZmZgkvKiBUaGUgMTMgYml0IGluZGV4IHRvIG9uZSBvZiB0aGUgODE5MiBQ
VEUgZHdvcmRzICAgICAgCSovCiAKIC8qIDB4MGUsIDB4MGY6IE5vdCB1c2VkICovCiAKQEAgLTE3
MDQsNiArMTcwNyw3IEBAIHN0cnVjdCBzbmRfZW11MTBrMSB7CiAJdW5zaWduZWQgc2hvcnQgbW9k
ZWw7CQkJLyogc3Vic3lzdGVtIGlkICovCiAJdW5zaWduZWQgaW50IGNhcmRfdHlwZTsJCQkvKiBF
TVUxMEsxX0NBUkRfKiAqLwogCXVuc2lnbmVkIGludCBlY2FyZF9jdHJsOwkJLyogZWNhcmQgY29u
dHJvbCBiaXRzICovCisJdW5zaWduZWQgaW50IGFkZHJlc3NfbW9kZTsJCS8qIGFkZHJlc3MgbW9k
ZSAqLwogCXVuc2lnbmVkIGxvbmcgZG1hX21hc2s7CQkJLyogUENJIERNQSBtYXNrICovCiAJdW5z
aWduZWQgaW50IGRlbGF5X3BjbV9pcnE7CQkvKiBpbiBzYW1wbGVzICovCiAJaW50IG1heF9jYWNo
ZV9wYWdlczsJCQkvKiBtYXggbWVtb3J5IHNpemUgLyBQQUdFX1NJWkUgKi8KZGlmZiAtLWdpdCBh
L3NvdW5kL3BjaS9lbXUxMGsxL2VtdTEwazFfY2FsbGJhY2suYyBiL3NvdW5kL3BjaS9lbXUxMGsx
L2VtdTEwazFfY2FsbGJhY2suYwppbmRleCA4NzRjZDc2Li5kMmM3ZWEzIDEwMDY0NAotLS0gYS9z
b3VuZC9wY2kvZW11MTBrMS9lbXUxMGsxX2NhbGxiYWNrLmMKKysrIGIvc291bmQvcGNpL2VtdTEw
azEvZW11MTBrMV9jYWxsYmFjay5jCkBAIC00MTUsNyArNDE1LDcgQEAgc3RhcnRfdm9pY2Uoc3Ry
dWN0IHNuZF9lbXV4X3ZvaWNlICp2cCkKIAlzbmRfZW11MTBrMV9wdHJfd3JpdGUoaHcsIFoyLCBj
aCwgMCk7CiAKIAkvKiBpbnZhbGlkYXRlIG1hcHMgKi8KLQl0ZW1wID0gKGh3LT5zaWxlbnRfcGFn
ZS5hZGRyIDw8IDEpIHwgTUFQX1BUSV9NQVNLOworCXRlbXAgPSAoaHctPnNpbGVudF9wYWdlLmFk
ZHIgPDwgaHctPmFkZHJlc3NfbW9kZSkgfCAoaHctPmFkZHJlc3NfbW9kZSA/IE1BUF9QVElfTUFT
SzEgOiBNQVBfUFRJX01BU0swKTsKIAlzbmRfZW11MTBrMV9wdHJfd3JpdGUoaHcsIE1BUEEsIGNo
LCB0ZW1wKTsKIAlzbmRfZW11MTBrMV9wdHJfd3JpdGUoaHcsIE1BUEIsIGNoLCB0ZW1wKTsKICNp
ZiAwCkBAIC00MzYsNyArNDM2LDcgQEAgc3RhcnRfdm9pY2Uoc3RydWN0IHNuZF9lbXV4X3ZvaWNl
ICp2cCkKIAkJc25kX2VtdTEwazFfcHRyX3dyaXRlKGh3LCBDREYsIGNoLCBzYW1wbGUpOwogCiAJ
CS8qIGludmFsaWRhdGUgbWFwcyAqLwotCQl0ZW1wID0gKCh1bnNpZ25lZCBpbnQpaHctPnNpbGVu
dF9wYWdlLmFkZHIgPDwgMSkgfCBNQVBfUFRJX01BU0s7CisJCXRlbXAgPSAoKHVuc2lnbmVkIGlu
dClody0+c2lsZW50X3BhZ2UuYWRkciA8PCBod19hZGRyZXNzX21vZGUpIHwgKGh3LT5hZGRyZXNz
X21vZGUgPyBNQVBfUFRJX01BU0sxIDogTUFQX1BUSV9NQVNLMCk7CiAJCXNuZF9lbXUxMGsxX3B0
cl93cml0ZShodywgTUFQQSwgY2gsIHRlbXApOwogCQlzbmRfZW11MTBrMV9wdHJfd3JpdGUoaHcs
IE1BUEIsIGNoLCB0ZW1wKTsKIAkJCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvZW11MTBrMS9lbXUx
MGsxX21haW4uYyBiL3NvdW5kL3BjaS9lbXUxMGsxL2VtdTEwazFfbWFpbi5jCmluZGV4IDU0MDc5
ZjUuLmI0ZjdmM2UgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9lbXUxMGsxL2VtdTEwazFfbWFpbi5j
CisrKyBiL3NvdW5kL3BjaS9lbXUxMGsxL2VtdTEwazFfbWFpbi5jCkBAIC0xNjAsNyArMTYwLDcg
QEAgc3RhdGljIGludCBzbmRfZW11MTBrMV9pbml0KHN0cnVjdCBzbmRfZW11MTBrMSAqZW11LCBp
bnQgZW5hYmxlX2lyLCBpbnQgcmVzdW1lKQogCXVuc2lnbmVkIGludCBzaWxlbnRfcGFnZTsKIAlp
bnQgY2g7CiAJdTMyIHRtcDsKLQorCQogCS8qIGRpc2FibGUgYXVkaW8gYW5kIGxvY2sgY2FjaGUg
Ki8KIAlvdXRsKEhDRkdfTE9DS1NPVU5EQ0FDSEUgfCBIQ0ZHX0xPQ0tUQU5LQ0FDSEVfTUFTSyB8
CiAJCUhDRkdfTVVURUJVVFRPTkVOQUJMRSwgZW11LT5wb3J0ICsgSENGRyk7CkBAIC0yODIsNyAr
MjgyLDcgQEAgc3RhdGljIGludCBzbmRfZW11MTBrMV9pbml0KHN0cnVjdCBzbmRfZW11MTBrMSAq
ZW11LCBpbnQgZW5hYmxlX2lyLCBpbnQgcmVzdW1lKQogCXNuZF9lbXUxMGsxX3B0cl93cml0ZShl
bXUsIFRDQiwgMCwgMCk7CS8qIHRha2VuIGZyb20gb3JpZ2luYWwgZHJpdmVyICovCiAJc25kX2Vt
dTEwazFfcHRyX3dyaXRlKGVtdSwgVENCUywgMCwgNCk7CS8qIHRha2VuIGZyb20gb3JpZ2luYWwg
ZHJpdmVyICovCiAKLQlzaWxlbnRfcGFnZSA9IChlbXUtPnNpbGVudF9wYWdlLmFkZHIgPDwgMSkg
fCBNQVBfUFRJX01BU0s7CisJc2lsZW50X3BhZ2UgPSAoZW11LT5zaWxlbnRfcGFnZS5hZGRyIDw8
IGVtdS0+YWRkcmVzc19tb2RlKSB8IChlbXUtPmFkZHJlc3NfbW9kZSA/IE1BUF9QVElfTUFTSzEg
OiBNQVBfUFRJX01BU0swKTsKIAlmb3IgKGNoID0gMDsgY2ggPCBOVU1fRzsgY2grKykgewogCQlz
bmRfZW11MTBrMV9wdHJfd3JpdGUoZW11LCBNQVBBLCBjaCwgc2lsZW50X3BhZ2UpOwogCQlzbmRf
ZW11MTBrMV9wdHJfd3JpdGUoZW11LCBNQVBCLCBjaCwgc2lsZW50X3BhZ2UpOwpAQCAtMzQ4LDYg
KzM0OCwxMSBAQCBzdGF0aWMgaW50IHNuZF9lbXUxMGsxX2luaXQoc3RydWN0IHNuZF9lbXUxMGsx
ICplbXUsIGludCBlbmFibGVfaXIsIGludCByZXN1bWUpCiAJCW91dGwocmVnIHwgQV9JT0NGR19H
UE9VVDAsIGVtdS0+cG9ydCArIEFfSU9DRkcpOwogCX0KIAorCWlmIChlbXUtPmFkZHJlc3NfbW9k
ZSA9PSAwKSB7CisJCS8qIHVzZSAxNk0gaW4gNEcgKi8KKwkJb3V0bChpbmwoZW11LT5wb3J0ICsg
SENGRykgfCBIQ0ZHX0VYUEFOREVEX01FTSwgZW11LT5wb3J0ICsgSENGRyk7CisJfQorCiAJcmV0
dXJuIDA7CiB9CiAKQEAgLTE5MDIsOCArMTkwNywxMCBAQCBpbnQgc25kX2VtdTEwazFfY3JlYXRl
KHN0cnVjdCBzbmRfY2FyZCAqY2FyZCwKIAogCWlzX2F1ZGlneSA9IGVtdS0+YXVkaWd5ID0gYy0+
ZW11MTBrMl9jaGlwOwogCisJLyogc2V0IGFkZHJlc3NpbmcgbW9kZSAqLworCWVtdS0+YWRkcmVz
c19tb2RlID0gaXNfYXVkaWd5ID8gMCA6IDE7CiAJLyogc2V0IHRoZSBETUEgdHJhbnNmZXIgbWFz
ayAqLwotCWVtdS0+ZG1hX21hc2sgPSBpc19hdWRpZ3kgPyBBVURJR1lfRE1BX01BU0sgOiBFTVUx
MEsxX0RNQV9NQVNLOworCWVtdS0+ZG1hX21hc2sgPSBlbXUtPmFkZHJlc3NfbW9kZSA/IEVNVTEw
SzFfRE1BX01BU0sgOiBBVURJR1lfRE1BX01BU0s7CiAJaWYgKHBjaV9zZXRfZG1hX21hc2socGNp
LCBlbXUtPmRtYV9tYXNrKSA8IDAgfHwKIAkgICAgcGNpX3NldF9jb25zaXN0ZW50X2RtYV9tYXNr
KHBjaSwgZW11LT5kbWFfbWFzaykgPCAwKSB7CiAJCWRldl9lcnIoY2FyZC0+ZGV2LApAQCAtMTky
OCw3ICsxOTM1LDcgQEAgaW50IHNuZF9lbXUxMGsxX2NyZWF0ZShzdHJ1Y3Qgc25kX2NhcmQgKmNh
cmQsCiAKIAllbXUtPm1heF9jYWNoZV9wYWdlcyA9IG1heF9jYWNoZV9ieXRlcyA+PiBQQUdFX1NI
SUZUOwogCWlmIChzbmRfZG1hX2FsbG9jX3BhZ2VzKFNORFJWX0RNQV9UWVBFX0RFViwgc25kX2Rt
YV9wY2lfZGF0YShwY2kpLAotCQkJCTMyICogMTAyNCwgJmVtdS0+cHRiX3BhZ2VzKSA8IDApIHsK
KwkJCQkoZW11LT5hZGRyZXNzX21vZGUgPyAzMiA6IDE2KSAqIDEwMjQsICZlbXUtPnB0Yl9wYWdl
cykgPCAwKSB7CiAJCWVyciA9IC1FTk9NRU07CiAJCWdvdG8gZXJyb3I7CiAJfQpAQCAtMjAyNyw4
ICsyMDM0LDggQEAgaW50IHNuZF9lbXUxMGsxX2NyZWF0ZShzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQs
CiAKIAkvKiBDbGVhciBzaWxlbnQgcGFnZXMgYW5kIHNldCB1cCBwb2ludGVycyAqLwogCW1lbXNl
dChlbXUtPnNpbGVudF9wYWdlLmFyZWEsIDAsIFBBR0VfU0laRSk7Ci0Jc2lsZW50X3BhZ2UgPSBl
bXUtPnNpbGVudF9wYWdlLmFkZHIgPDwgMTsKLQlmb3IgKGlkeCA9IDA7IGlkeCA8IE1BWFBBR0VT
OyBpZHgrKykKKwlzaWxlbnRfcGFnZSA9IGVtdS0+c2lsZW50X3BhZ2UuYWRkciA8PCBlbXUtPmFk
ZHJlc3NfbW9kZTsKKwlmb3IgKGlkeCA9IDA7IGlkeCA8IChlbXUtPmFkZHJlc3NfbW9kZSA/IE1B
WFBBR0VTMSA6IE1BWFBBR0VTMCk7IGlkeCsrKQogCQkoKHUzMiAqKWVtdS0+cHRiX3BhZ2VzLmFy
ZWEpW2lkeF0gPSBjcHVfdG9fbGUzMihzaWxlbnRfcGFnZSB8IGlkeCk7CiAKIAkvKiBzZXQgdXAg
dm9pY2UgaW5kaWNlcyAqLwpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2VtdTEwazEvZW11cGNtLmMg
Yi9zb3VuZC9wY2kvZW11MTBrMS9lbXVwY20uYwppbmRleCAwZGMwNzM4Li4xNGEzMDViIDEwMDY0
NAotLS0gYS9zb3VuZC9wY2kvZW11MTBrMS9lbXVwY20uYworKysgYi9zb3VuZC9wY2kvZW11MTBr
MS9lbXVwY20uYwpAQCAtMzgwLDcgKzM4MCw3IEBAIHN0YXRpYyB2b2lkIHNuZF9lbXUxMGsxX3Bj
bV9pbml0X3ZvaWNlKHN0cnVjdCBzbmRfZW11MTBrMSAqZW11LAogCXNuZF9lbXUxMGsxX3B0cl93
cml0ZShlbXUsIFoxLCB2b2ljZSwgMCk7CiAJc25kX2VtdTEwazFfcHRyX3dyaXRlKGVtdSwgWjIs
IHZvaWNlLCAwKTsKIAkvKiBpbnZhbGlkYXRlIG1hcHMgKi8KLQlzaWxlbnRfcGFnZSA9ICgodW5z
aWduZWQgaW50KWVtdS0+c2lsZW50X3BhZ2UuYWRkciA8PCAxKSB8IE1BUF9QVElfTUFTSzsKKwlz
aWxlbnRfcGFnZSA9ICgodW5zaWduZWQgaW50KWVtdS0+c2lsZW50X3BhZ2UuYWRkciA8PCBlbXUt
PmFkZHJlc3NfbW9kZSkgfCAoZW11LT5hZGRyZXNzX21vZGUgPyBNQVBfUFRJX01BU0sxIDogTUFQ
X1BUSV9NQVNLMCk7CiAJc25kX2VtdTEwazFfcHRyX3dyaXRlKGVtdSwgTUFQQSwgdm9pY2UsIHNp
bGVudF9wYWdlKTsKIAlzbmRfZW11MTBrMV9wdHJfd3JpdGUoZW11LCBNQVBCLCB2b2ljZSwgc2ls
ZW50X3BhZ2UpOwogCS8qIG1vZHVsYXRpb24gZW52ZWxvcGUgKi8KZGlmZiAtLWdpdCBhL3NvdW5k
L3BjaS9lbXUxMGsxL21lbW9yeS5jIGIvc291bmQvcGNpL2VtdTEwazEvbWVtb3J5LmMKaW5kZXgg
YzY4ZTZkZC4uNGYxZjY5YiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2VtdTEwazEvbWVtb3J5LmMK
KysrIGIvc291bmQvcGNpL2VtdTEwazEvbWVtb3J5LmMKQEAgLTM0LDEwICszNCwxMSBAQAogICog
YWxpZ25lZCBwYWdlcyBpbiBvdGhlcnMKICAqLwogI2RlZmluZSBfX3NldF9wdGJfZW50cnkoZW11
LHBhZ2UsYWRkcikgXAotCSgoKHUzMiAqKShlbXUpLT5wdGJfcGFnZXMuYXJlYSlbcGFnZV0gPSBj
cHVfdG9fbGUzMigoKGFkZHIpIDw8IDEpIHwgKHBhZ2UpKSkKKwkoKCh1MzIgKikoZW11KS0+cHRi
X3BhZ2VzLmFyZWEpW3BhZ2VdID0gY3B1X3RvX2xlMzIoKChhZGRyKSA8PCAoZW11LT5hZGRyZXNz
X21vZGUpKSB8IChwYWdlKSkpCiAKICNkZWZpbmUgVU5JVF9QQUdFUwkJKFBBR0VfU0laRSAvIEVN
VVBBR0VTSVpFKQotI2RlZmluZSBNQVhfQUxJR05fUEFHRVMJCShNQVhQQUdFUyAvIFVOSVRfUEFH
RVMpCisjZGVmaW5lIE1BWF9BTElHTl9QQUdFUzAJCShNQVhQQUdFUzAgLyBVTklUX1BBR0VTKQor
I2RlZmluZSBNQVhfQUxJR05fUEFHRVMxCQkoTUFYUEFHRVMxIC8gVU5JVF9QQUdFUykKIC8qIGdl
dCBhbGlnbmVkIHBhZ2UgZnJvbSBvZmZzZXQgYWRkcmVzcyAqLwogI2RlZmluZSBnZXRfYWxpZ25l
ZF9wYWdlKG9mZnNldCkJKChvZmZzZXQpID4+IFBBR0VfU0hJRlQpCiAvKiBnZXQgb2Zmc2V0IGFk
ZHJlc3MgZnJvbSBhbGlnbmVkIHBhZ2UgKi8KQEAgLTEyNCw3ICsxMjUsNyBAQCBzdGF0aWMgaW50
IHNlYXJjaF9lbXB0eV9tYXBfYXJlYShzdHJ1Y3Qgc25kX2VtdTEwazEgKmVtdSwgaW50IG5wYWdl
cywgc3RydWN0IGxpcwogCQl9CiAJCXBhZ2UgPSBibGstPm1hcHBlZF9wYWdlICsgYmxrLT5wYWdl
czsKIAl9Ci0Jc2l6ZSA9IE1BWF9BTElHTl9QQUdFUyAtIHBhZ2U7CisJc2l6ZSA9IChlbXUtPmFk
ZHJlc3NfbW9kZSA/IE1BWF9BTElHTl9QQUdFUzEgOiBNQVhfQUxJR05fUEFHRVMwKSAtIHBhZ2U7
CiAJaWYgKHNpemUgPj0gbWF4X3NpemUpIHsKIAkJKm5leHRwID0gcG9zOwogCQlyZXR1cm4gcGFn
ZTsKQEAgLTE4MSw3ICsxODIsNyBAQCBzdGF0aWMgaW50IHVubWFwX21lbWJsayhzdHJ1Y3Qgc25k
X2VtdTEwazEgKmVtdSwgc3RydWN0IHNuZF9lbXUxMGsxX21lbWJsayAqYmxrKQogCQlxID0gZ2V0
X2VtdTEwazFfbWVtYmxrKHAsIG1hcHBlZF9saW5rKTsKIAkJZW5kX3BhZ2UgPSBxLT5tYXBwZWRf
cGFnZTsKIAl9IGVsc2UKLQkJZW5kX3BhZ2UgPSBNQVhfQUxJR05fUEFHRVM7CisJCWVuZF9wYWdl
ID0gKGVtdS0+YWRkcmVzc19tb2RlID8gTUFYX0FMSUdOX1BBR0VTMSA6IE1BWF9BTElHTl9QQUdF
UzApOwogCiAJLyogcmVtb3ZlIGxpbmtzICovCiAJbGlzdF9kZWwoJmJsay0+bWFwcGVkX2xpbmsp
OwpAQCAtMzA3LDcgKzMwOCw3IEBAIHNuZF9lbXUxMGsxX2FsbG9jX3BhZ2VzKHN0cnVjdCBzbmRf
ZW11MTBrMSAqZW11LCBzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0CiAJaWYgKHNuZF9C
VUdfT04oIWVtdSkpCiAJCXJldHVybiBOVUxMOwogCWlmIChzbmRfQlVHX09OKHJ1bnRpbWUtPmRt
YV9ieXRlcyA8PSAwIHx8Ci0JCSAgICAgICBydW50aW1lLT5kbWFfYnl0ZXMgPj0gTUFYUEFHRVMg
KiBFTVVQQUdFU0laRSkpCisJCSAgICAgICBydW50aW1lLT5kbWFfYnl0ZXMgPj0gKGVtdS0+YWRk
cmVzc19tb2RlID8gTUFYUEFHRVMxIDogTUFYUEFHRVMwKSAqIEVNVVBBR0VTSVpFKSkKIAkJcmV0
dXJuIE5VTEw7CiAJaGRyID0gZW11LT5tZW1oZHI7CiAJaWYgKHNuZF9CVUdfT04oIWhkcikpCi0t
IAoyLjEuMAoK


--=-Pvh9K8gn59BOx+7V+N1e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-Pvh9K8gn59BOx+7V+N1e--
