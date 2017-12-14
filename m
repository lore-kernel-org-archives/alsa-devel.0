From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 00/14] soundwire: Add a new SoundWire subsystem
Date: Thu, 14 Dec 2017 16:23:20 +0530
Message-ID: <20171214105320.GX18649@localhost>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
 <20171214073508.GA29585@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171214073508.GA29585@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Takashi <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 14, 2017 at 08:35:08AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 14, 2017 at 11:19:31AM +0530, Vinod Koul wrote:
> > Changes in v6:
> >   - Add reviewed/acked tags from Philippe, Pierre, Takashi and Greg
> >   - Fix nitpicks from Takashi
> >   - Drop the sysfs patch for now
> 
> Wait, why drop the sysfs patch entirely?  You need those attributes,
> right?  You also need to document the existing sysfs files in
> Documentation/ABI/ for the class/device files you create in this patch
> series, so that needs to be done before this patch series can be
> accepted.

Well the sysfs patch is a standalone patch which contains the attributes. So
I dropped that "for this series" and plan to submit after reworking.

The rest of the code doesn't depend on it, so is fine.

I thought it is an okay kernel practice to drop patches with issues, merge the
rest and come back after fixing the issue. This is my plan for this as well.

Thanks
-- 
~Vinod
