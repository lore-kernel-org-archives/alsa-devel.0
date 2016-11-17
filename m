From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 01/14] SoundWire: Add SoundWire bus driver documentation
Date: Thu, 17 Nov 2016 10:35:52 +0530
Message-ID: <20161117050552.GA2698@localhost>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-2-git-send-email-hardik.t.shah@intel.com>
 <20161114141548.GL1575@localhost.localdomain>
 <20161115142914.GN3000@localhost>
 <20161116175929.kf7lfkcnqjdhasjk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161116175929.kf7lfkcnqjdhasjk@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Hardik Shah <hardik.t.shah@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2016 at 05:59:29PM +0000, Mark Brown wrote:
> On Tue, Nov 15, 2016 at 07:59:14PM +0530, Vinod Koul wrote:
> > On Mon, Nov 14, 2016 at 02:15:48PM +0000, Charles Keepax wrote:
> 
> > > slaves register to that. This also has the nice property that its
> > > easy to create devices that sit behind other buses, for example
> > > here we might want a SoundWire master that sits behind a SPI bus.
> > > But you seem to have gone in the other direction and have the
> > > master sitting on the same bus as the slaves.
> 
> > Since the controller on our SoC was enumerable, people went with this
> > approach. In this hindsight that may not have been the best choice.
> 
> Doing buses properly isn't an obstacle to doing enumeration, indeed I'd
> expect it to make it a lot easier - just have your driver for your
> controller do the enumeration at probe time.

Yes it is not :) This is somthing we are fixing now..

-- 
~Vinod
