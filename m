From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 07/15] regmap: Add SoundWire bus support
Date: Thu, 30 Nov 2017 22:56:08 +0530
Message-ID: <20171130172607.GF32417@localhost>
References: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
 <1512035830-29161-8-git-send-email-vinod.koul@intel.com>
 <20171130171726.gx5j67i4bi6vvyjn@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130171726.gx5j67i4bi6vvyjn@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 30, 2017 at 05:17:26PM +0000, Mark Brown wrote:
> On Thu, Nov 30, 2017 at 03:27:02PM +0530, Vinod Koul wrote:
> 
> > +EXPORT_SYMBOL_GPL(__regmap_init_sdw);
> 
> Thanks for fixing this, this looks good now.  We'll need to work out how
> this winds up getting merged in whenever that happens.

Thanks, I was hoping Greg would ACK the subsystem part and you for regmap we
can go thru usual adding the subsystem to linux-next and merging to Linus
for v4.16...

Of course, more ACKs/reviewed are welcome :)

Thanks
-- 
~Vinod
