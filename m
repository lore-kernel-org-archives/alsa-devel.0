From: "He, Bo" <bo.he@intel.com>
Subject: RE: [PATCH] ALSA: core: fix unsigned int pages overflow when
 comapred
Date: Thu, 19 Jul 2018 01:10:03 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52980D9A@SHSMSX104.ccr.corp.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52980C51@SHSMSX104.ccr.corp.intel.com>
 <s5hpnzkbu3v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hpnzkbu3v.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "perex@perex.cz" <perex@perex.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Jun" <jun.zhang@intel.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks, we will run the test with your patch, will update the test results in 24 Hours.

Current status is:
We can reproduce the issue in 3000 cycles stress S/R test, we can't reproduce the kernel panic with our patch in 6000 cycles.

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Wednesday, July 18, 2018 8:34 PM
To: He, Bo <bo.he@intel.com>
Cc: alsa-devel@alsa-project.org; perex@perex.cz; linux-kernel@vger.kernel.org; Zhang, Jun <jun.zhang@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>
Subject: Re: [PATCH] ALSA: core: fix unsigned int pages overflow when comapred

On Wed, 18 Jul 2018 13:52:45 +0200,
 He, Bo  wrote:
> 
> we see the below kernel panic on stress suspend resume test in 
> snd_malloc_sgbuf_pages(), snd_dma_alloc_pages_fallback() alloc chunk 
> maybe larger than the left pages due to the pages alignment, which 
> will cause the pages overflow.
> 
> while (pages > 0) {
> 	...
> 	pages -= chunk;
> }
> 
> the patch is change the pages from unsigned int to int to fix the issue.

Thanks for the patch.

Although the analysis is correct, the fix doesn't look ideal.  It's also possible that the returned size may over sgbuf->tblsize if we are more unlucky.

A change like below should work instead.  Could you give it a try?


Takashi

-- 8< --
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -108,7 +108,7 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 			break;
 		}
 		chunk = tmpb.bytes >> PAGE_SHIFT;
-		for (i = 0; i < chunk; i++) {
+		for (i = 0; i < chunk && pages > 0; i++) {
 			table->buf = tmpb.area;
 			table->addr = tmpb.addr;
 			if (!i)
@@ -117,9 +117,9 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 			*pgtable++ = virt_to_page(tmpb.area);
 			tmpb.area += PAGE_SIZE;
 			tmpb.addr += PAGE_SIZE;
+			sgbuf->pages++;
+			pages--;
 		}
-		sgbuf->pages += chunk;
-		pages -= chunk;
 		if (chunk < maxpages)
 			maxpages = chunk;
 	}
