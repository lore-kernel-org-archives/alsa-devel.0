From: David Cullen <david.cullen@teligy.com>
Subject: Re: Call to mmap in ALSA lib 1.0.13 fails in
 src/pcm/pcm_mmap.c line 367
Date: Tue, 19 Dec 2006 10:12:54 -0500
Message-ID: <45880176.3070300@teligy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

I see that you are back from your vacation.  I hope it was an
ejoyable one.

In alsa-driver-1.0.13/acore/memalloc.c there is this section of code

/*
 *  Hacks
 */

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 5)

I am using a patched 2.6.13 kernel.  Should I change that last line
to be KERNEL_VERSION(2, 6, 13)?

Also, could you give me some pointers regarding my previous e-mails
regarding this issue:

Takashi Iwai wrote:
> At Mon, 27 Nov 2006 17:01:52 -0500,
> David Cullen wrote:
>>
>> I am trying to get ALSA version 1.0.13 working on an AMCC PowerPC
>> PPC405EP Taihu board with a Sound Blaster Live! 24-bit 7.1 PCI
>> card.  I am using a patched 2.6.13 kernel that comes with the
>> board.  I built the kernel with the sound core built in and I
>> used the cross-compiler tools to build the ALSA driver, library,
>> and utils. When I run "speaker-test", it crashes in the ALSA
>> library.  The problem is that the call to mmap in
>>
>>    alsa-lib-1.0.13/src/pcm/pcm_mmap.c line 367
>>
>> which looks like
>>
>>    ptr = mmap(NULL, size, PROT_READ|PROT_WRITE,
>> MAP_FILE|MAP_SHARED, i->u.mmap.fd, i->u.mmap.offset);
>>
>> returns a pointer that appears to be valid (0x3001E000) but
>> causes a kernel OOPS when accessed.
>>
>> Previous calls to mmap in pcm_hw.c on lines 822 and 854 both
>> succeed, and the pointers returned can be successfully accessed,
>> but they use the status and control offsets as parameters to
>> mmap.
>>
>> I haved traced the problem on the target into the ALSA library
>> using gdb and into the kernel using kgdb and everything looks
>> like it works properly.  If I disable the semaphore acquisition
>> in do_mmap2, I can print the contents of the address in kgdb
>> using
>>
>>    (gdb) print ((char *)vma->vm_start)[0]
>>
>> after the call to vm_link in do_mmap_pgoff.  However, the board
>> locks up after the print command.
>>
>> Anyone have any experience with this type of problem on PowerPC
>> systems?
>
> Possibly a memory coherency problem.  The memory allocated via
> dma_alloc_coherent() isn't simply mmappable.
>
> An essential fix would be to add dma_mmap_coherent() to all
> architectures and use it for ALSA mmap.  I made some patches quite
> ago, but left it rotten for the time being...
>

How do I "add dma_mmap_coherent() to all architectures and use it
for ALSA mmap"?

The kernel I am using has this line in the .config file

   CONFIG_NOT_COHERENT_CACHE=y

It also has

   arch\ppc\kernel\dma-mapping.c

with

/*
 * Allocate DMA-coherent memory space and return both the kernel
remapped
 * virtual and bus address for that space.
 */
void *
__dma_alloc_coherent(size_t size, dma_addr_t *handle, int gfp)

defined and

   include\asm-ppc\dma-mapping.h

with

static inline void *dma_alloc_coherent(struct device *dev, size_t size,
                       dma_addr_t * dma_handle, int gfp)
{
#ifdef CONFIG_NOT_COHERENT_CACHE
    return __dma_alloc_coherent(size, dma_handle, gfp);
#else

defined.  However, if I put a breakpoint in __dma_alloc_coherent, it
does not appear to get called.  Is there something special I have to
do to ALSA to get it to use the ppc version of dma_alloc_coherent?

-- 
Thank you,
David Cullen
Teligy


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
