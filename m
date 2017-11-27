From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 04/14] soundwire: Add MIPI DisCo property helpers
Date: Mon, 27 Nov 2017 14:48:50 +0530
Message-ID: <20171127091849.GS3187@localhost>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-5-git-send-email-vinod.koul@intel.com>
 <20171123143812.braw737aciq4qmb7@localhost.localdomain>
 <20171124160448.GB11781@buildpc-HP-Z230>
 <20171127075940.euvjgjf6t5rimltp@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171127075940.euvjgjf6t5rimltp@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 27, 2017 at 07:59:40AM +0000, Charles Keepax wrote:

> > > Apologies for the long and slightly vague comment, but I guess my
> > > question is do you have a thought on how drivers should know when
> > > it is safe to communicate with a SoundWire device?
> > 
> > IMO it is safe to communicate with SoundWire device when the Slave
> > status is ATTACHED. In any case bus will report error if it is not able
> > to communicate with SoundWire device.
> 
> Yeah I guess my point here is that there is currently no way in
> this SoundWire framework for the slave driver to know if the
> device is attached or not, unless I am missing something?  There
> are calls by which the master can inform the framework, but
> nothing to pass that on to the slave driver.

Nope, as Sanyog pointed out there are deterministic ways for Slave
driver to find out. We can do that by:
 a) check the slave->status and communicate only if status is SDW_SLAVE_ATTACHED
 b) Implement sdw_slave_ops->update_status() which is invoked by Bus on any
    status changes.

So to summarize, for a Slave driver during the probe, if the status is not
SDW_SLAVE_ATTACHED it should not communicate and should implement
sdw_slave_ops->update_status and attempt IO when this callback gets invoked
with SDW_SLAVE_ATTACHED status.

Does that clarify and solve the problem.

-- 
~Vinod
