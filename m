From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 10/14] soundwire: Add sysfs for SoundWire DisCo properties
Date: Fri, 10 Nov 2017 10:22:19 +0530
Message-ID: <20171110045219.GK3187@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-11-git-send-email-vinod.koul@intel.com>
 <1e82021b-a721-b0a3-6586-cee0077f865a@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1e82021b-a721-b0a3-6586-cee0077f865a@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 09, 2017 at 09:14:35PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 19/10/17 04:03, Vinod Koul wrote:
> >It helps to read the properties for understanding and debug
> >SoundWire systems, so add sysfs files for SoundWire DisCo
> >properties.
> >
> >TODO: Add ABI files for sysfs
> >
> >Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> >Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> >---
> 
> >diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> >index 6c4f41b64744..e3d7aea18892 100644
> >--- a/drivers/soundwire/bus.c
> >+++ b/drivers/soundwire/bus.c
> >@@ -90,6 +90,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
> >  		}
> >  	}
> >+	sdw_sysfs_bus_init(bus);
> >+
> >  	/*
> >  	 * SDW is an enumerable bus, but devices can be powered off. So,
> >  	 * they won't be able to report as present.
> >@@ -119,6 +121,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
> >  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> >  	struct sdw_bus *bus = slave->bus;
> >+	sdw_sysfs_slave_exit(slave);
> >+
> >  	mutex_lock(&bus->bus_lock);
> >  	if (!list_empty(&bus->slaves))
> >  		list_del(&slave->node);
> >@@ -130,6 +134,7 @@ static int sdw_delete_slave(struct device *dev, void *data)
> >  void sdw_delete_bus_master(struct sdw_bus *bus)
> >  {
> >+	sdw_sysfs_bus_init(bus);
> 
> Shouldn't this be sdw_sysfs_bus_exit() here?

yes thats right, fixes in for v2

-- 
~Vinod
