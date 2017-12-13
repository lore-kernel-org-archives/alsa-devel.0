From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 00/15] soundwire: Add a new SoundWire subsystem
Date: Wed, 13 Dec 2017 15:27:46 +0530
Message-ID: <20171213095746.GP18649@localhost>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <20171213091822.GD6269@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171213091822.GD6269@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 10:18:22AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 06, 2017 at 09:16:56PM +0530, Vinod Koul wrote:
> > This patch series adds a new SoundWire subsystem which implements a
> > new MIPI bus protocol 'SoundWire'.
> > 
> > The SoundWire protocol is a robust, scalable, low complexity, low
> > power, low latency, two-pin (clock and data) multi-drop bus that
> > allows for the transfer of multiple audio streams and embedded
> > control/commands.  SoundWire provides synchronization capabilities
> > and supports both PCM and PDM, multichannel data, isochronous and
> > asynchronous modes.
> > 
> > This series adds SoundWire Bus, IO transfers, DisCo (Discovery and
> > Configuration) sysfs interface, regmap and Documentation summary
> > 
> > This patch series is also available on
> > git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git topic/patch_v5
> > 
> > v4: https://lkml.org/lkml/2017/12/1/205
> > v3: https://lkml.org/lkml/2017/11/30/160
> > v2: https://lkml.org/lkml/2017/11/10/216
> > v1: https://lkml.org/lkml/2017/10/18/1030
> > RFC: https://lkml.org/lkml/2016/10/21/395
> 
> I don't think patch 5 is right, how you are using kobjects.
> 
> Also, you have to have some documentation on your userspace API here for
> it to be reviewable.  To hide sysfs trees and files in code comments is
> not good.

Ah I meant to do that but never got to it, sorry for that. I think I can
drop that patch for now, and we can merge rest of the stuff.

I will come back with sysfs files along with ABI documentation and fix it
per the discussion.

Thanks for the review and Acks

-- 
~Vinod
