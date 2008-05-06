From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: ALSA vs. non coherent DMA
Date: Tue, 06 May 2008 10:08:28 +1000
Message-ID: <1210032508.21644.129.camel@pasglop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763110AbYEFAJA@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi !

I'm bringing up an old thread as I'm just discovering that the problem
still hasn't been fixed.

There seem to be a few issues with ALSA current usage of mmap vs. non
cache coherent architecture, such as embedded PowerPC's.

I can see at least two with a quick look to pcm-native.c, one I don't
understand and one I think I do:

 - The control/status mapping. Can you elaborate a bit on what this is
actually doing and why it shouldn't be done on "non coherent"
architectures ? Currently this -is- done on all powerpc's, whether they
are coherent or not and I want to understand what the underlying issue
is.

 - The mmap of DMA pages. Here, the problem appears two fold:

	* Use of virt_to_page() on virtual addresses returned by
dma_alloc_coherent().

	* No using the appropriate page protection for a DMA coherent mapping
to userspace.

It seems like you have solved that in part with implementing a generic
dma_mmap_coherent() in the past that for some reason you never merged
upstream (I can track that to about 2 years ago). Is there a reason ?

I think we need to at least apply a band-aid today as it's becoming a
nasty issue for several non-coherent powerpc platforms. It could be in
the form of implementing dma_mmap_coherent() and changing Alsa to use it
with the appropriate ifdef, or just adding an ifdef CONFIG_PPC with the
right code in there for now until a better solution is found.

It should be trivial though. Getting the PFN from the DMA address is
easy if we have the dma handle and the virtual address, though that -is-
definitely platform specific. I can implement a function for that if you
need. As for the pgprot, we can come up with something like
pgprot_mmap_dma(). Either that or I can fold it all in a powerpc wide
implementation of a dma_mmap_coherent() like we envisioned initially.

Let me know what approach is preferred here and I'll come up with
patches ASAP. As far as I'm concerned, this is a bug and thus must be
fixed now for .26 and possibly backported to stable even if we can come
up with a non invasive solution). I'm annoyed because it represents a
trivial amount of code, this problem should have been fixed a long time
ago.

Cheers,
Ben.
