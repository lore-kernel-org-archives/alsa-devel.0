From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
Date: Wed, 8 May 2019 13:16:06 +0530
Message-ID: <20190508074606.GV16052@vkoul-mobl>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-2-pierre-louis.bossart@linux.intel.com>
 <20190504065242.GA9770@kroah.com>
 <b0059709-027e-26c4-25a1-bd55df7c507f@linux.intel.com>
 <20190507052732.GD16052@vkoul-mobl>
 <20190507055432.GB17986@kroah.com>
 <20190507110331.GL16052@vkoul-mobl>
 <20190507111956.GB1092@kroah.com>
 <10fef156-7b01-7a08-77b4-ae3153eaaabc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10fef156-7b01-7a08-77b4-ae3153eaaabc@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 07-05-19, 17:49, Pierre-Louis Bossart wrote:
> 
> > > The model here is that Master device is PCI or Platform device and then
> > > creates a bus instance which has soundwire slave devices.
> > > 
> > > So for any attribute on Master device (which has properties as well and
> > > representation in sysfs), device specfic struct (PCI/platfrom doesn't
> > > help). For slave that is not a problem as sdw_slave structure takes care
> > > if that.
> > > 
> > > So, the solution was to create the psedo sdw_master device for the
> > > representation and have device-specific structure.
> > 
> > Ok, much like the "USB host controller" type device.  That's fine, make
> > such a device, add it to your bus, and set the type correctly.  And keep
> > a pointer to that structure in your device-specific structure if you
> > really need to get to anything in it.
> 
> humm, you lost me on the last sentence. Did you mean using
> set_drv/platform_data during the init and retrieving the bus information
> with get_drv/platform_data as needed later? Or something else I badly need
> to learn?

IIUC Greg meant we should represent a soundwire master device type and
use that here. Just like we have soundwire slave device type. Something
like:

struct sdw_master {
        struct device dev;
        struct sdw_master_prop *prop;
        ...
};

In show function you get master from dev (container of) and then use
that to access the master properties. So int.sdw.0 can be of this type.

Thanks
-- 
~Vinod
