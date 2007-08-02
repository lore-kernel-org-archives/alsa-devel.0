From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: ALSA on MIPS platform
Date: Thu, 02 Aug 2007 23:56:06 +0900 (JST)
Message-ID: <20070802.235606.122255120.anemo@mba.ocn.ne.jp>
References: <46B03CC0.3090000@lemote.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <46B03CC0.3090000@lemote.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: tiansm@lemote.com
Cc: alsa-devel@alsa-project.org, linux-mips@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Wed, 01 Aug 2007 15:56:48 +0800, Songmao Tian <tiansm@lemote.com> wrote:
>     The problem is clear:
> 1. dma_alloc_noncoherent() return a non-cached address, and 
> virt_to_page() need a cached logical addr (Have I named it right?)
> 2. mmaped dam buffer should be non-cached.
> 
> We have a ugly patch, but we want to solve the problem cleanly, so can 
> anyone show me the way?

virt_to_page() is used in many place in mm so making it robust might
affect performance.  IMHO virt_to_page() seems too low-level as DMA
API.

If something like dma_virt_to_page(dev, cpu_addr) which can take a cpu
address returned by dma_xxx APIs was defined, MIPS can implement it
appropriately.

And then pgprot_noncached issues still exist...

---
Atsushi Nemoto
