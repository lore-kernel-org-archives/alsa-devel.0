From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel] [RFC PATCH 2/7] soundwire: add Slave sysfs support
Date: Mon, 6 May 2019 17:19:53 +0200
Message-ID: <20190506151953.GA13178@kroah.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
 <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 06, 2019 at 09:42:35AM -0500, Pierre-Louis Bossart wrote:
> > > +
> > > +int sdw_sysfs_slave_init(struct sdw_slave *slave)
> > > +{
> > > +	struct sdw_slave_sysfs *sysfs;
> > > +	unsigned int src_dpns, sink_dpns, i, j;
> > > +	int err;
> > > +
> > > +	if (slave->sysfs) {
> > > +		dev_err(&slave->dev, "SDW Slave sysfs is already initialized\n");
> > > +		err = -EIO;
> > > +		goto err_ret;
> > > +	}
> > > +
> > > +	sysfs = kzalloc(sizeof(*sysfs), GFP_KERNEL);
> > 
> > Same question as patch 1, why a new device?
> 
> yes it's the same open. In this case, the slave devices are defined at a
> different level so it's also confusing to create a device to represent the
> slave properties. The code works but I am not sure the initial directions
> are correct.

You can just make a subdir for your attributes by using the attribute
group name, if a subdirectory is needed just to keep things a bit more
organized.

Otherwise, you need to mess with having multiple "types" of struct
device all associated with the same bus.  It is possible, and not that
hard, but I don't think you are doing that here.

thnaks,

greg k-h
