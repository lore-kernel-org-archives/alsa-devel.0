From: Johan Hovold <johan@kernel.org>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Date: Thu, 18 Apr 2019 19:29:43 +0200
Message-ID: <20190418172943.GC28269@localhost>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <20190417093354.GL775@localhost>
 <200c8e66-4245-967b-b80e-b6f6a63f80c5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200c8e66-4245-967b-b80e-b6f6a63f80c5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 17, 2019 at 12:18:22PM -0500, Pierre-Louis Bossart wrote:
> 
> >>>> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> >>>> index 19c8efb9a5ee..84876a74874f 100644
> >>>> --- a/drivers/soundwire/Kconfig
> >>>> +++ b/drivers/soundwire/Kconfig
> >>>> @@ -4,7 +4,7 @@
> >>>>    
> >>>>    menuconfig SOUNDWIRE
> >>>>    	bool "SoundWire support"
> >>>> -	---help---
> >>>> +	help
> >>>
> >>> Not sure if this is a style issue, kernel seems to have 2990 instances
> >>> of this!
> >>
> >> this is reported by checkpatch.pl --strict.
> > 
> > Please don't run checkpatch on code that's already in the kernel, and
> > especially not with the --strict (a.k.a. --subjective) option enabled.
> > 
> > Don't try to fix what isn't broken.
> 
> I would agree in general, but this case is different: the SoundWire code 
> in the upstream kernel is missing parts left and right and isn't fully 
> functional as is. I will soon be posting what's missing, so this cleanup 
> is an opportunity to bring SoundWire to the latest coding standards 
> before adding the missing pieces which will be compliant with --strict. 
> For the record using --strict already exposed 3 major issues in the 
> yet-to-be-released code, so it's not as subjective as you describe it.

It's not just me calling it subjective; --subjective is literally
another name for the same switch which enables checks that are
specifically *not* part of the coding standard.

By all my means use it on your own patches before you submit them if
you agree with all or some of those checks, but I doubt all that
open-parenthesis re-alignment is going to expose any major issues. ;)

It does add noise, and makes code forensic and backports harder though.

Johan 
