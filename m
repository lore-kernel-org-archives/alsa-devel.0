From: David Cullen <david.cullen@teligy.com>
Subject: Re: Call to mmap in ALSA lib 1.0.13 fails in
 src/pcm/pcm_mmap.c line 367
Date: Wed, 20 Dec 2006 14:06:37 -0500
Message-ID: <458989BD.7050005@teligy.com>
References: <45880176.3070300@teligy.com>	<s5hirg64f8b.wl%tiwai@suse.de>	<45898126.3060808@teligy.com>
	<s5hejqu4dq8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hejqu4dq8.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear Mr. Iwai,

1000 thank yous for your help so far.  I have a few more questions
to ask.

Takashi Iwai wrote:
> At Wed, 20 Dec 2006 13:29:58 -0500,
> David Cullen wrote:
>> 
>> Takashi Iwai wrote:
>> > At Tue, 19 Dec 2006 10:12:54 -0500,
>> > David Cullen wrote:
>> >> In alsa-driver-1.0.13/acore/memalloc.c there is this section of code
>> >> 
>> >> /*
>> >>  *  Hacks
>> >>  */
>> >> 
>> >> #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
>> >> #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 5)
>> >> 
>> >> I am using a patched 2.6.13 kernel.  Should I change that last line
>> >> to be KERNEL_VERSION(2, 6, 13)?
>> > 
>> > That part is a workaround only for the old 2.6 kernels which cause
>> > Oops when NULL is passed to device pointer.  So, it should be
>> > irrelevant.
>> > 
>> 
>> OK.  After more closely examining that code, I see that for my
>> kernel, this code is used
>> 
>> #else
>> 
>> /* for 2.2/2.4 kernels */
>> #if defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(__i386__)
>> #define dma_alloc_coherent(dev,size,addr,flags)
>> pci_alloc_consistent((struct pci_dev *)(dev),size,addr)
>> #define dma_free_coherent(dev,size,ptr,addr)
>> pci_free_consistent((struct pci_dev *)(dev),size,ptr,addr)
>> #elif CONFIG_SBUS
>> #define dma_alloc_coherent(dev,size,addr,flags)
>> sbus_alloc_consistent((struct sbus_dev *)(dev),size,addr)
>> #define dma_free_coherent(dev,size,ptr,addr)
>> sbus_free_consistent((struct sbus_dev *)(dev),size,ptr,addr)
>> #else
>> #error "Need a bus for dma_alloc_coherent()"
>> #endif
>> 
>> Which means pci_alloc_consistent is called instead of
>> __dma_alloc_coherent.
> 
> pci_alloc_consistent() is used only on 2.2/2.4 kernels.
> All 2.6.x kernels are using dma_alloc_coherent().
> 
> 

That does not appear to be the case in this kernel.  Once again, by
examining the #if statements, I am left with this code being
included for 2.6.13:

#endif /* < 2.6.5 */

#else

/* for 2.2/2.4 kernels */
#if defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(__i386__)
#define dma_alloc_coherent(dev,size,addr,flags)
pci_alloc_consistent((struct pci_dev *)(dev),size,addr)
#define dma_free_coherent(dev,size,ptr,addr)
pci_free_consistent((struct pci_dev *)(dev),size,ptr,addr)
#elif CONFIG_SBUS
#define dma_alloc_coherent(dev,size,addr,flags)
sbus_alloc_consistent((struct sbus_dev *)(dev),size,addr)
#define dma_free_coherent(dev,size,ptr,addr)
sbus_free_consistent((struct sbus_dev *)(dev),size,ptr,addr)
#else
#error "Need a bus for dma_alloc_coherent()"
#endif

#endif /* >= 2.6.0 */

NOTE: If the lines

#endif /* < 2.6.5 */

#else

were replaced with something like this

#else
static void *snd_dma_alloc_coherent1(struct device *dev,
    size_t size, dma_addr_t *dma_handle, int flags)
{
    /* No need to check dev on 2.6.5 and greater... */
    return dma_alloc_coherent(dev, size, dma_handle, flags);
}

static void snd_dma_free_coherent1(struct device *dev, size_t size,
    void *dma_addr, dma_addr_t dma_handle)
{
    /* No need to check dev on 2.6.5 and greater... */
    return dma_free_coherent(dev, size, dma_addr, dma_handle);
}
#endif /* < 2.6.5 */

#else

then what you are asserting would make sense to me.

>> >> Also, could you give me some pointers regarding my previous e-mails
>> >> regarding this issue:
>> >> 
>> >> Takashi Iwai wrote:
>> >> > At Mon, 27 Nov 2006 17:01:52 -0500,
>> >> > David Cullen wrote:
>> >> >>
>> >> >> I am trying to get ALSA version 1.0.13 working on an AMCC PowerPC
>> >> >> PPC405EP Taihu board with a Sound Blaster Live! 24-bit 7.1 PCI
>> >> >> card.  I am using a patched 2.6.13 kernel that comes with the
>> >> >> board.  I built the kernel with the sound core built in and I
>> >> >> used the cross-compiler tools to build the ALSA driver, library,
>> >> >> and utils. When I run "speaker-test", it crashes in the ALSA
>> >> >> library.  The problem is that the call to mmap in
>> >> >>
>> >> >>    alsa-lib-1.0.13/src/pcm/pcm_mmap.c line 367
>> >> >>
>> >> >> which looks like
>> >> >>
>> >> >>    ptr = mmap(NULL, size, PROT_READ|PROT_WRITE,
>> >> >> MAP_FILE|MAP_SHARED, i->u.mmap.fd, i->u.mmap.offset);
>> >> >>
>> >> >> returns a pointer that appears to be valid (0x3001E000) but
>> >> >> causes a kernel OOPS when accessed.
>> >> >>
>> >> >> Previous calls to mmap in pcm_hw.c on lines 822 and 854 both
>> >> >> succeed, and the pointers returned can be successfully accessed,
>> >> >> but they use the status and control offsets as parameters to
>> >> >> mmap.
>> >> >>
>> >> >> I haved traced the problem on the target into the ALSA library
>> >> >> using gdb and into the kernel using kgdb and everything looks
>> >> >> like it works properly.  If I disable the semaphore acquisition
>> >> >> in do_mmap2, I can print the contents of the address in kgdb
>> >> >> using
>> >> >>
>> >> >>    (gdb) print ((char *)vma->vm_start)[0]
>> >> >>
>> >> >> after the call to vm_link in do_mmap_pgoff.  However, the board
>> >> >> locks up after the print command.
>> >> >>
>> >> >> Anyone have any experience with this type of problem on PowerPC
>> >> >> systems?
>> >> >
>> >> > Possibly a memory coherency problem.  The memory allocated via
>> >> > dma_alloc_coherent() isn't simply mmappable.
>> >> >
>> >> > An essential fix would be to add dma_mmap_coherent() to all
>> >> > architectures and use it for ALSA mmap.  I made some patches quite
>> >> > ago, but left it rotten for the time being...
>> >> >
>> >> 
>> >> How do I "add dma_mmap_coherent() to all architectures and use it
>> >> for ALSA mmap"?
>> > 
>> > Well, for that, we need to patch the kernel itself and add
>> > dma_mmap_coherent() call.  The problem is that the memory returned
>> > from dma_alloc_coherent() isn't the address of the really allocated
>> > pages in your case.  Since the ALSA mmap mode obtains the page via
>> > virt_to_page(), this doesn't work.  Thus, a new function,
>> > dma_mmap_coherent() is required to calculate the real page address and
>> > do the rest of low-level mmap jobs.
>> 
>> Where would dma_mmap_coherent be placed?  Which specific file?
> 
> It's somewhere in arch/*/* directory.
> 
>> Would I replace all calls to mmap with dma_mmap_coherent?  I can
>> probably figure out how to implement it if you can give me an
>> example for another architecture.  I tried looking at old patches on
>> the web, but I had difficulty understanding them.  I think they were
>> for the ARM architecture.
> 
> Yes, ARM has already it.
>

In arch/arm/mm/consistent.c I find the following lines:

int dma_mmap_coherent(struct device *dev,
    struct vm_area_struct *vma, void *cpu_addr,
    dma_addr_t dma_addr, size_t size)
{
    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
    return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
}
EXPORT_SYMBOL(dma_mmap_coherent);

Can I add this code verbatim to a file in arch/ppc/mm?  For example,
could I add it to 4xx_mmu.c?  Or do I need to make a copy of
consistent.c in arch/ppc/mm?  I apologize for all the questions, but
when I look at this code I am reminded of the quote from ADVENT:
"You are in a maze of twisty little passages, all alike."

>> > A simple solution would be simply disable mmap.
>> > In pci/ca0106/ca0106_main.c, remove SNDRV_PCM_INFO_MMAP and
>> > SNDRV_PCM_INFO_MMAP_VALID from snd_ca0106_playback_hw and
>> > snd_ca0106_capture_hw structs.
>> > 
>> > Also, disable #if defined(CONFIG_PPC) around
>> > snd_pcm_mmap_status_*() in core/pcm_native.c.
>> > 
>> > This will reduce the sound system functionality (e.g. no dmix is
>> > available), though.
>> 
>> At this point, if we can get speaker-test to work, we will be happy.
>>  So dmix is not necessary (I believe...).  However, I do not know
>> the complete details of the end user's application, so dmix may be
>> needed eventually.  If you can give me a few pointers on how to
>> implement dma_mmap_coherent and sew it into ALSA, that would really
>> help.
> 
> When mmap is disabled in the driver, change the default alsa-lib
> configuration, too.  Either edit alsa-lib/src/conf/cards/CA0106.conf
> or override the default PCM configuration in /etc/asound.conf, such as
> 	pcm.!default plughw
> 
> 

Currently, /etc/asound.conf is

pcm.ca0106 {
    type hw
    card 0
}

ctl.ca0106 {
    type hw
    card 0
}

I am confused about where is the right place to put

    pcm.!default plughw

Do I just add another section that looks like this

pcm.!default {
    type plughw
    card 0
}

or do I just add the line to asound.conf?

>> > BTW, any chance to try a newer version of kernel?
>> > I don't want to debug the issues of old kernels but rather fix the
>> > latest kernel...
>> 
>> Unfortunately, we're stuck with the 2.6.13 kernel.  We are working
>> with the AMCC Taihu evaluation board, and the kernel source that
>> comes with it has been heavily patched to work with that board.
>> Upgrading the patches to work with a newer kernel is outside the
>> scope of what we agreed to do.  If you cannot help us as long as we
>> use the older kernel, I will pass along the information to my manager.
> 
> OK, that's what I was afraid of...

Yes, sorry.  Again, 1000 thank yous for the help you have already
given me.  While I can write device drivers and applications, I am
not used to delving into the details of memory management for such
complicated software as the ALSA drivers and library, especially on
an esoteric architecture.

I will stab forward with the no-mmap approach first after reviewing
your responses with my manager.

-- 
Thank you,
David Cullen
Teligy


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
