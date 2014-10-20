From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 2/7] ASoC: Intel: mrfld - Add DSP load
 and management
Date: Mon, 20 Oct 2014 11:11:49 +0530
Message-ID: <20141020054149.GC28745@intel.com>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-3-git-send-email-vinod.koul@intel.com>
 <20141017094413.GF3771@sirena.org.uk>
 <20141017091816.GP1638@intel.com> <s5h1tq7ui47.wl-tiwai@suse.de>
 <20141017120147.GF1820@sirena.org.uk>
 <s5hy4seucfk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 256132606A5
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 08:19:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy4seucfk.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 17, 2014 at 02:07:43PM +0200, Takashi Iwai wrote:
> At Fri, 17 Oct 2014 14:01:47 +0200,
> Mark Brown wrote:
> > 
> > On Fri, Oct 17, 2014 at 12:04:56PM +0200, Takashi Iwai wrote:
> > > Vinod Koul wrote:
> > 
> > > > I will work on moving memcpy32_toio to core and move users as well :)

And I did prepare RFC for that and had to trash it :(

Turns out we already have an API for this in kernel.

While adding the new header, though it should be io.h, stumbled upon not
much used __iowrite32_copy() which seems to be the API I need.

I am testing it as we speak, will send conversion patch today.

-- 
~Vinod

> > 
> > > We can move them into sound/core/memory.c.  They are pretty small and
> > > useful.
> > 
> > It's not really anything to do with sound though, the other users are
> > MTD devices at the minute.
> 
> Yeah, we can move up again, then :)
> 
> I think it's even not bad to have it as a static inline function.
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
