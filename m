From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: alsa usb-audio sound corruption caused by cached
	vmalloc mapping
Date: Mon, 4 Feb 2013 17:50:27 +0100
Message-ID: <510FE6D3.9020904@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040502090208090006020506"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co202.xi-lite.net (co202.xi-lite.net [149.6.83.202])
 by alsa0.perex.cz (Postfix) with ESMTP id CE2E52602DC
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2013 17:50:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Takashi Iwai <tiwai@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

--------------040502090208090006020506
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

on a armv5 soc, we have audio corruption while using a usb-audio sound card.
After analysis, it comes from alsa vmalloc mapping.

in the current kernel vmalloc mapping used by alsa are cached.

This cause coherency problem on armv5 architecture because the cache are VIVT :
- alsa kernel driver map a buffer with vmalloc. The memory attribute is cached
- userspace map vmalloc buffer.  The memory attribute is cached

But because the cache are VIVT, these two mapping don't share the same cache
line and won't see the same data.
This corruption can be hidden by context switch because cache are flushed on
context switch.

On x86 or armv7, the cache are PIPT and there is no such problem.



There was a commit "pcm - Call pgprot_noncached() for vmalloc'ed buffers"
(c32d977b8157bf67cdf47729ce7dd054a26eb534), that made the userspace mapping not
cached, but this caused issues because the kernel vmalloc mapping was still cached.

Instead of revering this commit, we could have made the kernel vmalloc noncached
(see attached patch). It fix the issue on armv5.

But on some architecture (armv7 for example) you can't have mapping for the same
physical memory cached (normal cached) and noncached (device memory).
So the vmalloc and userspace mapping will conflict with the kernel direct RAM
mapping.

A workaround could be to use writecombine protection instead of noncached.
This work because writecombine is mapped on armv7 as L_PTE_MT_BUFFERABLE (normal
uncached) that is compatible with cached memory (the same trick is used for
dmacoherent).
But that's architecture specific may not work on others architectures.



What's the best way the fix this issue on all architecture ?


Matthieu

--------------040502090208090006020506
Content-Type: text/x-diff; name="vmalloc_uncached.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="vmalloc_uncached.diff"

commit f3d13b6752e20cdd193d0265cc6b8f1d814dd869
Author: Matthieu CASTET <matthieu.castet@parrot.com>
Date:   Wed Jan 30 15:27:00 2013 +0100

    make snd_pcm_lib_alloc_vmalloc_buffer memory uncached

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 69e01c4..1740d39 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -425,7 +425,7 @@ int _snd_pcm_lib_alloc_vmalloc_buffer(struct snd_pcm_substream *substream,
 			return 0; /* already large enough */
 		vfree(runtime->dma_area);
 	}
-	runtime->dma_area = __vmalloc(size, gfp_flags, PAGE_KERNEL);
+	runtime->dma_area = __vmalloc(size, gfp_flags, pgprot_noncached(PAGE_KERNEL));
 	if (!runtime->dma_area)
 		return -ENOMEM;
 	runtime->dma_bytes = size;

--------------040502090208090006020506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040502090208090006020506--
