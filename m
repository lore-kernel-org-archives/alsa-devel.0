From: Hardik Shah <hardik.t.shah@intel.com>
Subject: Re: [RFC 12/14] regmap: SoundWire: Add regmap support for SoundWire
 bus
Date: Wed, 2 Nov 2016 13:41:31 +0530
Message-ID: <20161102081131.GA31046@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-13-git-send-email-hardik.t.shah@intel.com>
 <20161028180355.o7byx4llwurfpnut@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161028180355.o7byx4llwurfpnut@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 28, 2016 at 07:03:55PM +0100, Mark Brown wrote:
> On Fri, Oct 21, 2016 at 06:11:10PM +0530, Hardik Shah wrote:
> 
> > +static inline void get_t_size(size_t *t_val_size, size_t *t_size,
> > +						int *reg_addr,
> > +						int *offset,
> > +						size_t *val_size)
> > +{
> > +
> > +		*t_val_size += *t_size;
> > +		*offset += *t_size;
> 
> So, I started by taking a look at this patch to get a sense of what the
> API would look like and I see that we're not following CodingStyle with
> everything indented twice :(
> 

Sorry Mark for delayed response, there was festival holidays in India, so I
was not able to reply. 

Regarding two tabs, it got missed for this function somehow, I will fix it
in next patchset.

> > +static int regmap_sdw_gather_write(void *context,
> > +			   const void *reg, size_t reg_size,
> > +			   const void *val, size_t val_size)
> > +{
> 
> > +	if (!sdw)
> > +		return 0;
> 
> Silently ignoring errors :(
> 

This should never happen ideally. This was extra check to make sure there is
not kernel crash. I can remove it as well.

> > +	if (val_size > SDW_MAX_REG_ADDR)
> > +		t_size = SDW_MAX_REG_ADDR - reg_command;
> > +	else
> > +		t_size = val_size;
> 
> This needs at least some kind of comment?


I will add few comments here.


-- 
