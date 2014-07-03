From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 2/2] ALSA: hda - restore BCLK M/N value
 as per CDCLK for HSW/BDW display HDA controller
Date: Thu, 3 Jul 2014 09:06:07 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B5903FD@SHSMSX101.ccr.corp.intel.com>
References: <1404363724-4496-1-git-send-email-mengdong.lin@intel.com>
 <s5hmwcrt0lv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 35003265893
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 11:06:12 +0200 (CEST)
In-Reply-To: <s5hmwcrt0lv.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Nikula, Jani" <jani.nikula@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, July 03, 2014 2:31 PM

> > --- a/sound/pci/hda/hda_i915.h
> > +++ b/sound/pci/hda/hda_i915.h
> > @@ -18,6 +18,7 @@
> >
> >  #ifdef CONFIG_SND_HDA_I915
> >  int hda_display_power(bool enable);
> > +void haswell_set_bclk(struct azx *chip);
> >  int hda_i915_init(void);
> >  int hda_i915_exit(void);
> >  #else
> 
> Define a dummy function for !CONFIG_SND_HDA_I915, too.
> Otherwise the build will break.
> 
> I'll be off for today and pick up the revised patch later.

I added the missing dummy function in the v3 patch, and tested the build with !CONFIG_DRM_I915 and !CONFIG_SND_HDA_I915.
Please review.

Thanks again
Mengdong
