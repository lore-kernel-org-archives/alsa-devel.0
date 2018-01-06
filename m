From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v6 07/14] regmap: Add SoundWire bus support
Date: Sat, 6 Jan 2018 11:43:45 +0530
Message-ID: <20180106061344.GQ18649@localhost>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
 <1513230585-13882-8-git-send-email-vinod.koul@intel.com>
 <20180105170552.GF9076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180105170552.GF9076@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 05, 2018 at 05:05:52PM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 11:19:38AM +0530, Vinod Koul wrote:
> > SoundWire bus provides sdw_read() and sdw_write() APIs for Slave
> > devices to program the registers. Provide support in regmap for
> > SoundWire bus.
> 
> I can't apply this because you've changed the soundwire Kconfig in this
> patch :(

Ah, I will resend dropiing that part. 

Thanks
-- 
~Vinod
