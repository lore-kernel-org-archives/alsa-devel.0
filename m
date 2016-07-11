From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ALSA - hda: Add support for GTS
	capability
Date: Mon, 11 Jul 2016 19:37:32 +0530
Message-ID: <20160711140732.GH9681@localhost>
References: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
 <1468232009-14130-2-git-send-email-vinod.koul@intel.com>
 <s5h7fcsv5ig.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D152261A3D
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 16:00:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7fcsv5ig.wl-tiwai@suse.de>
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

On Mon, Jul 11, 2016 at 12:22:15PM +0200, Takashi Iwai wrote:
> On Mon, 11 Jul 2016 12:13:27 +0200,
> Vinod Koul wrote:
> > 
> >  
> > +void azx_parse_capabilities(struct azx *chip)
> 
> Please give a bit more comments about the function.

Sure thing, will add.

> > +	/* Lets walk the linked capabilities list */
> > +	do {
> > +		cur_cap = _snd_hdac_chip_read(l, azx_bus(chip), offset);
> > +
> > +		switch ((cur_cap & CAP_HDR_ID_MASK) >> CAP_HDR_ID_OFF) {
> > +		case GTS_CAP_ID:
> > +			dev_dbg(chip->card->dev, "Found GTS capability");
> > +			chip->gts_present = 1;
> > +			break;
> > +
> > +		default:
> > +			break;
> > +		}
> > +
> > +		/* read the offset of next capabiity */
> > +		offset = cur_cap & CAP_HDR_NXT_PTR_MASK;
> > +	} while (offset);
> 
> It's be safer to have a counter not to go over the endless loop.

I do agree a broken hw can cause issues, so will add that as well.

> >  	runtime->private_data = azx_dev;
> > +
> > +	/* CPU must have ART for reporting link synchronized time */
> > +	if (chip->gts_present && boot_cpu_has(X86_FEATURE_ART))
> 
> This comes out of sudden.  It needs more explanation.

Ah, this was merged in last window. We cna check of cpu is capable of ART,
and in these cases only we cna report these timestamps

> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 9a0d1445ca5c..b4ebdde59398 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -1649,6 +1649,7 @@ static int azx_first_init(struct azx *chip)
> >  		return -ENXIO;
> >  	}
> >  
> > +	azx_parse_capabilities(chip);
> 
> Is it really safe to call the function no matter which chip?

I think so, since we read base HDA registers for capablity. For older hw the
next capablity will not be there.

But yes I will verify this on older machines.

-- 
~Vinod
