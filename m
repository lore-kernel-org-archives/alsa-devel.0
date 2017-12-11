From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 04/15] soundwire: Add MIPI DisCo property helpers
Date: Mon, 11 Dec 2017 22:48:31 +0530
Message-ID: <20171211171831.GV18649@localhost>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <1512575231-4154-5-git-send-email-vinod.koul@intel.com>
 <s5hbmj5kzyu.wl-tiwai@suse.de>
 <20171211170022.GT18649@localhost>
 <s5hvahdjisp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hvahdjisp.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 11, 2017 at 06:06:30PM +0100, Takashi Iwai wrote:
> On Mon, 11 Dec 2017 18:00:22 +0100,
> Vinod Koul wrote:
> > 
> > On Mon, Dec 11, 2017 at 05:10:17PM +0100, Takashi Iwai wrote:
> > > On Wed, 06 Dec 2017 16:47:00 +0100,
> > > Vinod Koul wrote:
> > > > 
> > > > +		/* TODO: Read audio mode */
> > > > +
> > > > +		i++;
> > > > +	}
> > > 
> > > Don't we use count argument for a sanity check?
> > 
> > Not really as that iterator runs on each bit:
> > 
> > for_each_set_bit(bit, &addr, 32) {
> > 
> > so it will not go on endlessly and can max out when all the bits being set
> > and stop.
> 
> Yes, that shouldn't happen.  OTOH, only looking at the callee side,
> one may wonder that the possible error would be dpn[] overflows the
> given array size (=count).  Though, looking at both caller and callee,
> one realizes that it shouldn't happen, too.

Right :)

> (But then again wonders why passing count argument at all :)

So we allocate memory for dpn ports by using hweight32(), and then
fill up this memory by reading properties. Count here is used to access
dpn[i] and fill data for each port from firmware and hence incremented
every time..

-- 
~Vinod
