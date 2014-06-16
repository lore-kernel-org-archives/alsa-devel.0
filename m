From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] mfd: arizona: Export function to control subsystem
	DVFS
Date: Mon, 16 Jun 2014 18:09:36 +0100
Message-ID: <20140616170936.GC26741@opensource.wolfsonmicro.com>
References: <20140609150013.GA5229@opensource.wolfsonmicro.com> <20140609150226.GB5229@opensource.wolfsonmicro.com> <20140616164242.GB14323@lee--X1> <20140616164858.GI5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140616164858.GI5099@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, sameo@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 16, 2014 at 05:48:58PM +0100, Mark Brown wrote:
> On Mon, Jun 16, 2014 at 05:42:42PM +0100, Lee Jones wrote:
> > On Mon, 09 Jun 2014, Richard Fitzgerald wrote:
> 
> > > +	if (arizona->subsys_max_rq != new_flags) {
> 
> > I don't really get this.  What's the point in passing the mask
> > parameter - I don't see it being used for anything in this routine? No
> > matter what is passed in you always just turn on the same regulator.
> 
> > What am I missing?
> 
> AFAICT it's a bunch of different independently selectable requests for
> the voltage to ramped with any one of them causing it to happen.
> 
> I did wonder why this wasn't just done by refcounting, that's the more
> normal pattern in the kernel, though I guess it's possible some of them
> need different ramps on different devices.

Currently this is not the case, although it is certainly not
unthinkable that it would occur in future devices.

Thanks,
Charles
