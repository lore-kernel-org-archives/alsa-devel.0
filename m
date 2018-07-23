From: "He, Bo" <bo.he@intel.com>
Subject: Re: [PATCH] ALSA: core: fix unsigned int pages
 overflow when comapred
Date: Mon, 23 Jul 2018 00:47:18 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D5298169B@SHSMSX104.ccr.corp.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52980C51@SHSMSX104.ccr.corp.intel.com>
 <s5hpnzkbu3v.wl-tiwai@suse.de>
 <88DC34334CA3444C85D647DBFA962C272B0C4C34@SHSMSX104.ccr.corp.intel.com>
 <s5hmuun681l.wl-tiwai@suse.de> <s5h36wf6159.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id D26B626763C
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 02:47:29 +0200 (CEST)
In-Reply-To: <s5h36wf6159.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Zhang, Jun" <jun.zhang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Yanmin" <yanmin.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi:
	we tested for the whole weekend, your patch works, no panic issue seen. You can safe merge you patch.

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Thursday, July 19, 2018 5:11 PM
To: Zhang, Jun <jun.zhang@intel.com>
Cc: He, Bo <bo.he@intel.com>; alsa-devel@alsa-project.org; perex@perex.cz; linux-kernel@vger.kernel.org; Zhang, Yanmin <yanmin.zhang@intel.com>
Subject: Re: [PATCH] ALSA: core: fix unsigned int pages overflow when comapred

On Thu, 19 Jul 2018 08:42:14 +0200,
Takashi Iwai wrote:
> 
> On Thu, 19 Jul 2018 08:08:06 +0200,
> Zhang, Jun wrote:
> > 
> > Hello, Takashi
> > 
> > I think use our patch, it's NOT possible that the returned size is over sgbuf->tblsize.
> > 
> > In function snd_malloc_sgbuf_pages,
> > 
> > Pages is align page,
> > sgbuf->tblsize is align 32*page,
> > chunk is align 2^n*page,
> > 
> > in our panic case, pages = 123, tlbsize = 128, 1st loop trunk = 32 
> > 2nd loop trunk = 32 3rd loop trunk = 32 4th loop trunk = 16 5th loop 
> > trunk = 16 So in 5th loop pages-trunk = -5, which make dead loop.
> 
> Looking at the code again, yeah, you are right, that won't happen.
> 
> And now it becomes clear: the fundamental problem is that
> snd_dma_alloc_pages_fallback() returns a larger size than requested.
> It would be acceptable if the internal allocator aligns a larger size, 
> but it shouldn't appear in the returned size outside.  I believe this 
> was just a misunderstanding of get_order() usage there.
> (BTW, it's interesting that the allocation with a larger block worked  
> while allocation with a smaller chunk failed; it must be a rare case  
> and that's one of reasons this bug didn't hit frequently.)
> 
> That being said, what we should fix is rather the function
> snd_dma_alloc_pages_fallback() to behave as expected, and it'll be 
> like the patch below.

And we can reduce even more lines.  A proper patch is below.


thanks,

Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: memalloc: Don't exceed over the requested size

snd_dma_alloc_pages_fallback() tries to allocate pages again when the allocation fails with reduced size.  But the first try actually
*increases* the size to power-of-two, which may give back a larger chunk than the requested size.  This confuses the callers, e.g. sgbuf assumes that the size is equal or less, and it may result in a bad loop due to the underflow and eventually lead to Oops.

The code of this function seems incorrectly assuming the usage of get_order().  We need to decrease at first, then align to power-of-two.

Reported-by: he, bo <bo.he@intel.com>
Reported-by: zhang jun <jun.zhang@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c index 7f89d3c79a4b..753d5fc4b284 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -242,16 +242,12 @@ int snd_dma_alloc_pages_fallback(int type, struct device *device, size_t size,
 	int err;
 
 	while ((err = snd_dma_alloc_pages(type, device, size, dmab)) < 0) {
-		size_t aligned_size;
 		if (err != -ENOMEM)
 			return err;
 		if (size <= PAGE_SIZE)
 			return -ENOMEM;
-		aligned_size = PAGE_SIZE << get_order(size);
-		if (size != aligned_size)
-			size = aligned_size;
-		else
-			size >>= 1;
+		size >>= 1;
+		size = PAGE_SIZE << get_order(size);
 	}
 	if (! dmab->area)
 		return -ENOMEM;
--
2.18.0
