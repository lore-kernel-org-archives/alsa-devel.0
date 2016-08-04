From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 4/5] ALSA - hda: Add support for parsing
 new HDA capabilities
Date: Thu, 4 Aug 2016 07:30:59 +0530
Message-ID: <20160804020059.GA9681@localhost>
References: <1470240374-20018-1-git-send-email-vinod.koul@intel.com>
 <1470240374-20018-5-git-send-email-vinod.koul@intel.com>
 <s5hinvh96j3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E803026581E
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 03:53:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hinvh96j3.wl-tiwai@suse.de>
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

On Wed, Aug 03, 2016 at 06:11:28PM +0200, Takashi Iwai wrote:
> On Wed, 03 Aug 2016 18:06:13 +0200,
> Vinod Koul wrote:
> > 
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -1655,6 +1655,22 @@ static int azx_first_init(struct azx *chip)
> >  		return -ENXIO;
> >  	}
> >  
> > +	if (IS_SKL_PLUS(pci))
> > +		snd_hdac_bus_parse_capabilities(bus);
> > +
> > +	/*
> > +	 * Some Intel CPUs has always running timer (ART) feature and
> > +	 * controller may have Global time sync reporting capability, so
> > +	 * check both of these before declaring synchronized time reporting
> > +	 * capability SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME
> > +	 */
> > +	chip->gts_present = false;
> > +
> > +#ifdef CONFIG_X86
> > +	if ((bus->ppcap && boot_cpu_has(X86_FEATURE_ART)))
> 
> Superfluous parentheses.
> Also, don't we need to include asm/cpufeature.h?

Its somehow included, I will check that part as well

-- 
~Vinod
