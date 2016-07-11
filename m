From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ALSA - hda: Add support for GTS
	capability
Date: Mon, 11 Jul 2016 19:52:15 +0530
Message-ID: <20160711142215.GL9681@localhost>
References: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
 <1468232009-14130-2-git-send-email-vinod.koul@intel.com>
 <s5h7fcsv5ig.wl-tiwai@suse.de> <20160711140732.GH9681@localhost>
 <s5ha8hotgke.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 433FB26533F
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 16:15:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ha8hotgke.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 11, 2016 at 04:06:25PM +0200, Takashi Iwai wrote:
> On Mon, 11 Jul 2016 16:07:32 +0200,
> Vinod Koul wrote:
> > 
> > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > > index 9a0d1445ca5c..b4ebdde59398 100644
> > > > --- a/sound/pci/hda/hda_intel.c
> > > > +++ b/sound/pci/hda/hda_intel.c
> > > > @@ -1649,6 +1649,7 @@ static int azx_first_init(struct azx *chip)
> > > >  		return -ENXIO;
> > > >  	}
> > > >  
> > > > +	azx_parse_capabilities(chip);
> > > 
> > > Is it really safe to call the function no matter which chip?
> > 
> > I think so, since we read base HDA registers for capablity. For older hw the
> > next capablity will not be there.
> > 
> > But yes I will verify this on older machines.
> 
> I checked the spec 1.0 and 1.0a, and there is no definition for the
> register offset 0x14.  So, it's likely unsafe to use it
> unconditionally.

Ah okay, let me check.

Worst case we cna use SKL_PLUS for this as it is defined for SKL and beyond.

-- 
~Vinod
