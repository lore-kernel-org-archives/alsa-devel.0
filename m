From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ALSA - hda: Add support for parsing
 new HDA capabilities
Date: Thu, 21 Jul 2016 09:54:26 +0530
Message-ID: <20160721042426.GK9681@localhost>
References: <1468925202-29445-1-git-send-email-vinod.koul@intel.com>
 <1468925202-29445-2-git-send-email-vinod.koul@intel.com>
 <s5hlh0w98pm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 23F68265873
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2016 06:17:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hlh0w98pm.wl-tiwai@suse.de>
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

On Wed, Jul 20, 2016 at 07:31:17AM +0200, Takashi Iwai wrote:

> > +	unsigned int offset; unsigned int counter = 0;
> 
> Need a line break.

arghh, will fix..

> > +	offset = azx_readl(chip, LLCH);
> > +
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
> > +		counter++;
> > +
> > +		if (counter > AZX_MAX_CAPS) {
> > +			dev_err(chip->card->dev, "We exceeded azx capabilities!!!\n");
> > +			break;
> > +		}
> > +
> > +		/* read the offset of next capabiity */
> > +		offset = cur_cap & CAP_HDR_NXT_PTR_MASK;
> > +
> > +	} while (offset);
> 
> Wouldn't it be safer to use a normal while () {} loop?
> The first LLCH read might be zero, in theory.

Then in that case first read will give error. But yes I see the benifits.

Btw this is same as snd_hdac_ext_bus_parse_capabilities()

Should we move this to hdac and use for both. Ofcourse many new capablities
do not make sense to legacy driver, so we would have to ignore them.

> > +	if (!(chip->gts_present && boot_cpu_has(X86_FEATURE_ART)))
> > +		chip->gts_present = false;
> 
> Need #ifdef CONFIG_X86 guard here, too.
> Also, the inclusion of <asm/cpufeature.h> isn't needed?  (Again
> X86-only.)

This is intel.c :) I did compile it for ARM before sending.

-- 
~Vinod
