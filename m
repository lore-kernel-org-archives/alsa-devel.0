From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 3/7] ASoC: hda - add asoc hda core bus,
 controller and stream helpers
Date: Wed, 27 May 2015 11:10:27 +0530
Message-ID: <20150527054027.GR3140@localhost>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-4-git-send-email-vinod.koul@intel.com>
 <20150526185151.GA12911@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5230D2657F3
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 07:39:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150526185151.GA12911@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2015 at 07:51:51PM +0100, Mark Brown wrote:
> On Mon, May 11, 2015 at 04:24:01PM +0530, Vinod Koul wrote:
> 
> > +#ifndef __SOUND_SOC_HDAUDIO_H
> > +#define __SOUND_SOC_HDAUDIO_H
> > +
> > +#include <sound/core.h>
> > +#include <sound/initval.h>
> > +#include <sound/hda_register.h>
> > +#include <sound/hdaudio.h>
> 
> ...
> 
> > +#include <linux/kernel.h>
> > +#include <linux/delay.h>
> > +#include <linux/export.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <sound/core.h>
> > +#include <sound/soc-hdaudio.h>
> 
> ...
> 
> > +#include <linux/kernel.h>
> > +#include <linux/delay.h>
> > +#include <linux/export.h>
> > +#include <sound/core.h>
> > +#include <sound/pcm.h>
> > +#include <sound/hdaudio.h>
> > +#include <sound/hda_register.h>
> > +#include <sound/soc-hdaudio.h>
> 
> This includes no ASoC specific headers, what is ASoC specific about it?
Hi Mark,

This patch adds the hda helpers for enhanced capability added in SKL
HDA and these are not part of base HDA specification.

So we kept it out of Intel/ dir code as these and further enhancements can
be added/used by other vendors too..

Thanks
-- 
~Vinod
