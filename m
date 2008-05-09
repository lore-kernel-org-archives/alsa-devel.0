From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Fri, 9 May 2008 10:20:22 -0700
Message-ID: <200805091020.22541.jbarnes@virtuousgeek.org>
References: <4823AAF2.7070102@keyaccess.nl> <20080509085511.GE2592@elte.hu> <20080509085824.GF2592@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763691AbYEIRVG@vger.kernel.org>
In-Reply-To: <20080509085824.GF2592@elte.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Glauber Costa <gcosta@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Pete Clements <clem@clem.clem-digital.net>, Linux Kernel <linux-kernel@vger.kernel.org>, ALSA devel <alsa-devel@alsa-project.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: alsa-devel@alsa-project.org

On Friday, May 09, 2008 1:58 am Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > good catch! Queued it up for testing. Jesse, do you concur?
>
> here's the patch below, tidied up.

Yeah, that looks like a clear problem. :)

> ------------------------------->
> Subject: x86/pci: fix broken ISA DMA
> From: Takashi Iwai <tiwai@suse.de>
> Date: Fri, 09 May 2008 08:06:55 +0200
>
> Rene Herman reported:
> > commit 8779f2fc3b84ebb6c5181fb13d702e9944c16069
> >
> > "x86: don't try to allocate from DMA zone at first"
> >
> > breaks all of ISA DMA. Or all of ALSA ISA DMA at least. All
> > ISA soundcards are silent following that commit -- no error
> > messages, everything appears fine, just silence.
>
> That patch is buggy. We had an implicit assumption that
> dev = NULL for ISA devices that require 24bit DMA.
>
> The recent work on x86 dma_alloc_coherent() breaks the ISA DMA buffer
> allocation, which is represented by "dev = NULL" and requires 24bit
> DMA implicitly.

Patch looks good, applied to my 'for-linus' tree.

Thanks,
Jesse
