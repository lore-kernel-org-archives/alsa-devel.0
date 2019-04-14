From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/2] regmap: soundwire: fix Kconfig
 select/depend issue
Date: Sun, 14 Apr 2019 15:50:07 +0530
Message-ID: <20190414102007.GK28103@vkoul-mobl>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190411192814.10663-2-pierre-louis.bossart@linux.intel.com>
 <s5ho95bpqis.wl-tiwai@suse.de>
 <bd9a5c75-8519-b6ac-ca16-7fa93c706ead@linux.intel.com>
 <20190412141841.GA6235@sirena.org.uk>
 <s5hv9zjl2ya.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hv9zjl2ya.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12-04-19, 16:21, Takashi Iwai wrote:
> On Fri, 12 Apr 2019 16:18:41 +0200,
> Mark Brown wrote:
> > 
> > On Fri, Apr 12, 2019 at 09:07:41AM -0500, Pierre-Louis Bossart wrote:
> > 
> > >  config CODEC_XYX_SDW
> > > 	 tristate "XYZ SDW Codec"
> > >          depends on SOUNDWIRE
> > >          select REGMAP_SOUNDWIRE
> > 
> > That looks good.
> > 
> > >  config REGMAP_SOUNDWIRE
> > >          select SOUNDWIRE_BUS
> > 
> > > it'd follow the typical pattern seen in sound/soc/codecs/Kconfig:
> > 
> > IIRC the select here won't actually do anything.
> 
> I thought it'd do select SOUNDWIRE_BUS.  The depends-on here would be
> ignored instead.

yeah this all is bit complicated and should not be so. As Srini pointed
out, we have two symbols, SOUNDWIRE as a menuconfig item which enables
the subsystem and then SOUNDWIRE_BUS which compiles in the code.

Unfortunately I dont seem to recall the advantages of this approach so
it might be easier to drop SOUNDWIRE_BUS and then let codecs do select
REGMAP_SOUNDWIRE and depends on SOUNDWIRE

Thanks
-- 
~Vinod
