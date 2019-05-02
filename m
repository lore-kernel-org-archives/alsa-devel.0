From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 02/22] soundwire: fix SPDX license for header files
Date: Thu, 2 May 2019 08:31:39 +0200
Message-ID: <20190502063139.GA14347@kroah.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
 <20190502051440.GA3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190502051440.GA3845@vkoul-mobl.Dlink>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 02, 2019 at 10:46:49AM +0530, Vinod Koul wrote:
> On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> > No C++ comments in .h files
> > 
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >  drivers/soundwire/bus.h            | 4 ++--
> >  drivers/soundwire/cadence_master.h | 4 ++--
> >  drivers/soundwire/intel.h          | 4 ++--
> 
> As I said previously this touches subsystem header as well as driver
> headers which is not ideal.

What?  Who knows that?  Who cares?

This is doing "one logical thing" to all of the needed files.  Your
split of "this is a driver" vs. "this is a subsystem" split is _VERY_
arbritary.

That's just too picky and assumes a subsystem-internal-knowledge much
deeper than anyone submitting a normal cleanup patch would ever know.

I think you have swung too far to the "too picky" side, you might want
to dial it back.

thanks,

greg k-h
