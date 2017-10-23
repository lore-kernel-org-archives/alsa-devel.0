From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 03/14] soundwire: Add Master registration
Date: Mon, 23 Oct 2017 16:49:11 +0530
Message-ID: <20171023111910.GG936@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
 <20171021091230.pwevgreloynqe7nu@sirena.org.uk>
 <20171021113513.GF30097@localhost>
 <20171023082426.77tcpq4wtd4cwi7i@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171023082426.77tcpq4wtd4cwi7i@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 23, 2017 at 09:24:26AM +0100, Mark Brown wrote:
> On Sat, Oct 21, 2017 at 05:05:13PM +0530, Vinod Koul wrote:
> > On Sat, Oct 21, 2017 at 10:12:30AM +0100, Mark Brown wrote:
> > > On Thu, Oct 19, 2017 at 08:33:19AM +0530, Vinod Koul wrote:
> 
> > > > +	mutex_lock(&bus->bus_lock);
> > > > +	if (!list_empty(&bus->slaves))
> > > > +		list_del(&slave->node);
> 
> > > Shouldn't that be a while?  Or at least warn if there's anything extra
> > > there.  The code just looks very wrong as is.
> 
> > I think you missed that it is called from sdw_delete_bus_master() which does
> > the loop by invoking device_for_each_child(), so this ones is supposed to
> > ensure one Slave is removed cleaned.
> 
> > Let me know if i misread your comment.
> 
> My point is that this code just looks so obviously wrong it doesn't
> matter if it actually works, we should refactor so people don't look at
> the code and immediately think they've spotted a bug.

Okay will check and try to refactor this part.

-- 
~Vinod
