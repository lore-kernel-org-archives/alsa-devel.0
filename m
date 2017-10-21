From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 04/14] soundwire: Add MIPI DisCo property helpers
Date: Sat, 21 Oct 2017 17:07:18 +0530
Message-ID: <20171021113718.GG30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-5-git-send-email-vinod.koul@intel.com>
 <20171021092046.p6wsssjkonjjdidt@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171021092046.p6wsssjkonjjdidt@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 21, 2017 at 10:20:46AM +0100, Mark Brown wrote:
> On Thu, Oct 19, 2017 at 08:33:20AM +0530, Vinod Koul wrote:
> 
> > +	/* device is probed so let's read the properties now */
> > +	if (slave->ops && slave->ops->read_prop)
> > +		slave->ops->read_prop(slave);
> 
> Is it valid for us to not be able to read the properties?

Practically no. Without the values bus wont work

> 
> > +		fwnode_property_read_u32(node, "mipi-sdw-port-max-wordlength",
> > +						&dpn[i].max_word);
> > +		fwnode_property_read_u32(node, "mipi-sdw-port-min-wordlength",
> > +						&dpn[i].min_word);
> 
> Don't we know this stuff simply by virtue of knowing what device we're
> talking to (given that there aren't class devices)?

Well I think the spec is midway to device class so they added it to make it
generic :)

-- 
~Vinod
