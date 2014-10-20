From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/5] ASoC: intel: use __iowrite32_copy for
 32	bit copy
Date: Mon, 20 Oct 2014 18:44:52 +0530
Message-ID: <20141020131452.GG28745@intel.com>
References: <1413799148-6368-1-git-send-email-vinod.koul@intel.com>
 <1413799148-6368-2-git-send-email-vinod.koul@intel.com>
 <s5h1tq3m12a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9698E265230
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 15:52:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1tq3m12a.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2014 at 01:29:33PM +0200, Takashi Iwai wrote:
> At Mon, 20 Oct 2014 15:29:04 +0530,
> Vinod Koul wrote:
> > 
> > The driver was using own method to do 32bit copy, turns out we have a kernel
> > API so use that instead
> > 
> > Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/intel/sst/sst_loader.c |    9 +++------
> >  1 files changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/sound/soc/intel/sst/sst_loader.c b/sound/soc/intel/sst/sst_loader.c
> > index b6d27c1..40e501b 100644
> > --- a/sound/soc/intel/sst/sst_loader.c
> > +++ b/sound/soc/intel/sst/sst_loader.c
> > @@ -41,12 +41,9 @@
> >  
> >  static void memcpy32_toio(void __iomem *dst, const void *src, int count)
> >  {
> > -	int i;
> > -	const u32 *src_32 = src;
> > -	u32 *dst_32 = dst;
> > -
> > -	for (i = 0; i < count/sizeof(u32); i++)
> > -		writel(*src_32++, dst_32++);
> > +	/* __iowrite32_copy uses 32-bit count values so dev by 4 for right
> > +	 * count in words */
> 
> s/dev/div/
> 
> Also, it's worth to make it inline, although the compiler would do it
> automatically in most cases like this.
Yes it did, although it would make sense to do so here as well

-- 
~Vinod

> 
> 
> Takashi
> 
> > +	__iowrite32_copy(dst, src, count/4);
> >  }
> >  
> >  /**
> > -- 
> > 1.7.0.4
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 

-- 
