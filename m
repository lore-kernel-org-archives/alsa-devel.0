From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000460]: Oops on loading the es18xx module
Date: Fri,  3 Sep 2004 14:10:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040903121047.CC9292D0C0@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2DD36289
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 14:10:48 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000460
======================================================================
Reported By:                twhitehead
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     460
Category:                   ISA - es18xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Debian SID
Kernel Version:             2.6.8.1 (from kernel.org)
Resolution:                 won't fix
======================================================================
Date Submitted:             08-21-2004 21:48 CEST
Last Modified:              09-03-2004 14:10 CEST
======================================================================
Summary:                    Oops on loading the es18xx module
Description: 
Loading the es18xx module immediately (and always) results in an "Unable to
handle kernel paging request at virtual address 00000000000000b0" message.
 The usage count then sticks at one and applications are not able to open
the device files.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-01-2004 23:05 CEST 
----------------------------------------------------------------------
Tried 1.0.6a?  How about compiling with CONFIG_SND_DEBUG?

----------------------------------------------------------------------
 twhitehead - 09-03-2004 06:43 CEST 
----------------------------------------------------------------------
-That was 1.0.6a (view advanced -> product version -- was that the correct
field for that?).
-Enabling all the debug defines (CONFIG_SND_DEBUG,
CONFIG_SND_DEBUG_MEMORY, and CONFIG_SND_DEBUG_DETECT) produces the
following additional line of output before the crash:

ALSA /usr/src/alsa-driver-1.0.6a/alsa-kernel/isa/es18xx.c:1530: [0x220]
ESS1888 chip found

edited on: 09-03-04 06:43

----------------------------------------------------------------------
 twhitehead - 09-03-2004 05:29 CEST 
----------------------------------------------------------------------
I hacked in a function call tracer with the GCC profiling hooks and
recompiled with line number debugging info.  The results is (line numbers
are for the alsa-driver 1.0.6a and stock kernel 2.6.8.1 packages -- I
threw the lines in just to make sure *grin*):

Sep  2 19:57:09 whitehead kernel: TRACE+5 fffffffc007ce2d0
fffffffc00694628
Sep  2 19:57:09 whitehead kernel: TRACE+6 fffffffc007ce21c
fffffffc007ce354
Sep  2 19:57:09 whitehead kernel: TRACE+7 fffffffc007ce0e4
fffffffc007ce28c
Sep  2 19:57:09 whitehead kernel: TRACE+8 fffffffc007cdb48
fffffffc007ce154
Sep  2 19:57:09 whitehead kernel: TRACE+9 fffffffc0056e9a8
fffffffc007cdbdc
Sep  2 19:57:09 whitehead kernel: TRACE-9 fffffffc0056e9a8
fffffffc007cdbdc
Sep  2 19:57:09 whitehead kernel: TRACE+9 fffffffc0056e608
fffffffc007cdc30
Sep  2 19:57:09 whitehead kernel: TRACE+10 fffffffc0056e378
fffffffc0056e6f4

// snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
//           snd_dma_isa_data(),
//           64*1024,
//           chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);
 es18xx:1600 (snd_es18xx_pcm)                             ->
pcm_memory.c:260 (snd_pcm_lib_preallocate_pages_for_all)
//   if ((err = snd_pcm_lib_preallocate_pages(substream, type, data, size,
max)) < 0)
 pcm_memory.c:266 (snd_pcm_lib_preallocate_pages_for_all) ->
pcm_memory.c:238 (snd_pcm_lib_preallocate_pages)
// return snd_pcm_lib_preallocate_pages1(substream, size, max);
 pcm_memory.c:241 (snd_pcm_lib_preallocate_pages)         ->
pcm_memory.c:193 (snd_pcm_lib_preallocate_pages1)
//  preallocate_pcm_pages(substream, size);
 pcm_memory.c:197 (snd_pcm_lib_preallocate_pages1)        ->
pcm_memory.c:50 (preallocate_pcm_pages)
// if (snd_dma_get_reserved_buf(dmab, substream->dma_buf_id) > 0) {
 pcm_memory.c:57 (preallocate_pcm_pages)                  ->
memalloc.c:508 (snd_dma_get_reserved_buf)
 pcm_memory.c:57 (preallocate_pcm_pages)                  <-
memalloc.c:508 (snd_dma_get_reserved_buf)
//  if ((err = snd_dma_alloc_pages(dmab->dev.type, dmab->dev.dev,
//            size, dmab)) < 0) {
 pcm_memory.c:66 (preallocate_pcm_pages)                  ->
memalloc.c:397 (snd_dma_alloc_pages)
//  dmab->area = snd_malloc_dev_pages(device, size, &dmab->addr);
 memalloc.c:415 (snd_dma_alloc_pages)                     ->
memalloc.c:304 (snd_malloc_dev_pages)
// res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
 memalloc.c:315 (snd_malloc_dev_pages)                    ->
dma-mapping.h:39 (dma_alloc_coherent)
// BUG_ON(dev->bus != &pci_bus_type);
*crash at* dma-mapping.h:40 (from looking at the assembler it looks like
dev is a NULL pointer -- register s4)


Sep  2 19:57:09 whitehead kernel: Unable to handle kernel paging request
at virtual address 00000000000000b0
Sep  2 19:57:09 whitehead kernel: modprobe(752): Oops 0
Sep  2 19:57:09 whitehead kernel: pc = [<fffffffc0056e424>]  ra =
[<fffffffc0056e3bc>]  ps = 0000    Not tainted
Sep  2 19:57:09 whitehead kernel: v0 = 000000000000002b  t0 =
0000000000000000  t1 = 0000000000002000
Sep  2 19:57:09 whitehead kernel: t2 = 0000000000000001  t3 =
000000010018ef70  t4 = 00000000001c1fff
Sep  2 19:57:09 whitehead kernel: t5 = 0000000000000001  t6 =
00000000fffccf71  t7 = fffffc0010840000
Sep  2 19:57:09 whitehead kernel: s0 = 0000000000010000  s1 =
fffffc0017fb4448  s2 = fffffffc0056e6f4
Sep  2 19:57:09 whitehead kernel: s3 = 0000000000000003  s4 =
0000000000000000  s5 = fffffffc007ce354
Sep  2 19:57:09 whitehead kernel: s6 = 0000000000010000
Sep  2 19:57:09 whitehead kernel: a0 = fffffffc0056f588  a1 =
fffffffc0056f5b3  a2 = ffffffffffffffff
Sep  2 19:57:09 whitehead kernel: a3 = 0000000000000001  a4 =
0000000000000001  a5 = 000000000000000f
Sep  2 19:57:09 whitehead kernel: t8 = 0000000000000000  t9 =
fffffc0000411dd8  t10= 0000000000000000
Sep  2 19:57:09 whitehead kernel: t11= 0000000000000010  pv =
fffffc000033945c  at = 0000000000000000
Sep  2 19:57:09 whitehead kernel: gp = fffffffc00569f08  sp =
fffffc0010843c38
Sep  2 19:57:09 whitehead kernel: Trace:
Sep  2 19:57:09 whitehead kernel: [sys_init_module+496/932]
sys_init_module+0x1f0/0x3a4
Sep  2 19:57:09 whitehead kernel: [sys_init_module+496/932]
sys_init_module+0x1f0/0x3a4
Sep  2 19:57:09 whitehead kernel: [entSys+164/192] entSys+0xa4/0xc0
Sep  2 19:57:09 whitehead kernel: 
Sep  2 19:57:09 whitehead kernel: Code: 23bdbb00  c3e00025  48203681 
4180300c  f43ffffd  205f2000 <a42d00b0> 484c0731 

>>PC;  fffffffc0056e424 <[snd_page_alloc]snd_malloc_dev_pages+ac/16c>  
<=====

Code;  fffffffc0056e40c <[snd_page_alloc]snd_malloc_dev_pages+94/16c>
0000000000000000 <_PC>:
Code;  fffffffc0056e40c <[snd_page_alloc]snd_malloc_dev_pages+94/16c>
   0:   00 bb bd 23       lda  gp,-17664(gp)
Code;  fffffffc0056e410 <[snd_page_alloc]snd_malloc_dev_pages+98/16c>
   4:   25 00 e0 c3       br   9c <_PC+0x9c>
Code;  fffffffc0056e414 <[snd_page_alloc]snd_malloc_dev_pages+9c/16c>
   8:   81 36 20 48       srl  t0,0x1,t0
Code;  fffffffc0056e418 <[snd_page_alloc]snd_malloc_dev_pages+a0/16c>
   c:   0c 30 80 41       addl s3,0x1,s3
Code;  fffffffc0056e41c <[snd_page_alloc]snd_malloc_dev_pages+a4/16c>
  10:   fd ff 3f f4       bne  t0,8 <_PC+0x8>
Code;  fffffffc0056e420 <[snd_page_alloc]snd_malloc_dev_pages+a8/16c>
  14:   00 20 5f 20       lda  t1,8192
Code;  fffffffc0056e424 <[snd_page_alloc]snd_malloc_dev_pages+ac/16c>  
<=====
  18:   b0 00 2d a4       ldq  t0,176(s4)   <=====
Code;  fffffffc0056e428 <[snd_page_alloc]snd_malloc_dev_pages+b0/16c>
  1c:   31 07 4c 48       sll  t1,s3,a1

----------------------------------------------------------------------
 tiwai - 09-03-2004 14:10 CEST 
----------------------------------------------------------------------
Ok, it's a bug of alpha kernel, which has been fixed for long time
on mm tree.
A simple solution is to remove all BUG_ON() from
include/asm-generic/dma-mapping.h.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-21-04 21:48 twhitehead     New Bug                                      
08-21-04 21:48 twhitehead     Distribution              => Debian SID      
08-21-04 21:48 twhitehead     Kernel Version            => 2.6.8.1 (from kernel.org)
08-21-04 21:51 twhitehead     Bug Monitored: twhitehead                    
09-01-04 23:05 tiwai          Bugnote Added: 0001679                       
09-03-04 05:12 twhitehead     Bugnote Added: 0001686                       
09-03-04 05:29 twhitehead     Bugnote Added: 0001687                       
09-03-04 06:42 twhitehead     Bugnote Edited: 0001686                      
09-03-04 06:43 twhitehead     Bugnote Edited: 0001686                      
09-03-04 14:10 tiwai          Bugnote Added: 0001690                       
09-03-04 14:10 tiwai          Assigned To               => tiwai           
09-03-04 14:10 tiwai          Resolution               open => won't fix   
09-03-04 14:10 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
