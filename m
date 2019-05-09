From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
Date: Thu, 9 May 2019 20:18:12 +0200
Message-ID: <20190509181812.GA10776@kroah.com>
References: <20190507052732.GD16052@vkoul-mobl>
 <20190507055432.GB17986@kroah.com>
 <20190507110331.GL16052@vkoul-mobl>
 <20190507111956.GB1092@kroah.com>
 <10fef156-7b01-7a08-77b4-ae3153eaaabc@linux.intel.com>
 <20190508074606.GV16052@vkoul-mobl>
 <20190508091628.GB1858@kroah.com>
 <c0161db3-69d7-0a76-f4bd-d5feb3529128@linux.intel.com>
 <20190508165945.GC6157@kroah.com>
 <0b8d5238-6894-e2b4-5522-28636e40dd63@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b8d5238-6894-e2b4-5522-28636e40dd63@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 08, 2019 at 03:57:49PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 5/8/19 11:59 AM, Greg KH wrote:
> > On Wed, May 08, 2019 at 11:42:15AM -0500, Pierre-Louis Bossart wrote:
> > > 
> > > 
> > > On 5/8/19 4:16 AM, Greg KH wrote:
> > > > On Wed, May 08, 2019 at 01:16:06PM +0530, Vinod Koul wrote:
> > > > > On 07-05-19, 17:49, Pierre-Louis Bossart wrote:
> > > > > > 
> > > > > > > > The model here is that Master device is PCI or Platform device and then
> > > > > > > > creates a bus instance which has soundwire slave devices.
> > > > > > > > 
> > > > > > > > So for any attribute on Master device (which has properties as well and
> > > > > > > > representation in sysfs), device specfic struct (PCI/platfrom doesn't
> > > > > > > > help). For slave that is not a problem as sdw_slave structure takes care
> > > > > > > > if that.
> > > > > > > > 
> > > > > > > > So, the solution was to create the psedo sdw_master device for the
> > > > > > > > representation and have device-specific structure.
> > > > > > > 
> > > > > > > Ok, much like the "USB host controller" type device.  That's fine, make
> > > > > > > such a device, add it to your bus, and set the type correctly.  And keep
> > > > > > > a pointer to that structure in your device-specific structure if you
> > > > > > > really need to get to anything in it.
> > > > > > 
> > > > > > humm, you lost me on the last sentence. Did you mean using
> > > > > > set_drv/platform_data during the init and retrieving the bus information
> > > > > > with get_drv/platform_data as needed later? Or something else I badly need
> > > > > > to learn?
> > > > > 
> > > > > IIUC Greg meant we should represent a soundwire master device type and
> > > > > use that here. Just like we have soundwire slave device type. Something
> > > > > like:
> > > > > 
> > > > > struct sdw_master {
> > > > >           struct device dev;
> > > > >           struct sdw_master_prop *prop;
> > > > >           ...
> > > > > };
> > > > > 
> > > > > In show function you get master from dev (container of) and then use
> > > > > that to access the master properties. So int.sdw.0 can be of this type.
> > > > 
> > > > Yes, you need to represent the master device type if you are going to be
> > > > having an internal representation of it.
> > > 
> > > Humm, confused...In the existing code bus and master are synonyms, see e.g.
> > > following code excerpts:
> > > 
> > >   * sdw_add_bus_master() - add a bus Master instance
> > >   * @bus: bus instance
> > >   *
> > >   * Initializes the bus instance, read properties and create child
> > >   * devices.
> > > 
> > > struct sdw_bus {
> > > 	struct device *dev; <<< pointer here
> > 
> > That's the pointer to what?  The device that the bus is "attached to"
> > (i.e. parent, like a platform device or a pci device)?
> > 
> > Why isn't this a "real" device in itself?
> 
> Allow me to provide a bit of background. I am not trying to be pedantic but
> make sure we are on the same page.
> 
> The SoundWire spec only defines a Master and Slaves attached to that Master.
> 
> In real applications, there is a need to have multiple links, which can
> possibly operate in synchronized ways, so Intel came up with the concept of
> Controller, which expose multiple Master interfaces that are in sync (two
> streams can start at exactly the same clock edge of different links).
> 
> The Controller is exposed in ACPI as a child of the HDAudio controller (ACPI
> companion of a PCI device). The controller exposes a 'master-count' and a
> set of link-specific properties needed for bandwidth/clock scaling.
> 
> For some reason, our Windows friends did not want to have a device for each
> Master interface, likely because they did not want to load a driver per
> Master interface or have 'yellow bangs'.
> 
> So the net result is that we have the following hierarchy in ACPI
> 
> Device(HDAS) // HDaudio controller
>   Device(SNDW) // SoundWire Controller
>     Device(SDW0) { // Slave0
> 	_ADR(link0, vendorX, partY...)
>     }
>     Device(SDW1) { // Slave0
> 	_ADR(link0, vendorX, partY...)
>     }
>     Device(SDW2) { // Slave0
> 	_ADR(link1, vendorX, partY...)
>     }
>     Device(SDWM) { // Slave0
> 	_ADR(linkM, vendorX, partY...)
>     }
> 
> There is no master device represented in ACPI and the only way by which we
> know to which Master a Slave device is attached by looking up the _ADR which
> contains the link information.
> 
> So, coming back to the plot, when we parse the Controller properties, we
> find out how many Master interfaces we have, create a platform_device for
> each of them, then initialize all the bus stuff.

So soundwire is creating platform devices?  Ick, no!  Don't do that,
create a "real" device that is the root of your bus and attach that to
the platform/pci/whatever device that is the parent of that device's
resources.

> > I thought I asked that a long time ago when first reviewing these
> > patches...
> > 
> > > 	unsigned int link_id;
> > > 	struct list_head slaves;
> > > 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
> > > 	struct mutex bus_lock;
> > > 	struct mutex msg_lock;
> > > 	const struct sdw_master_ops *ops;
> > > 	const struct sdw_master_port_ops *port_ops;
> > > 	struct sdw_bus_params params;
> > > 	struct sdw_master_prop prop;
> > > 
> > > The existing code creates a platform_device in
> > > drivers/soundwire/intel_init.c, and it's assigned by the following code:
> > 
> > The core creates a platform device, don't assume you can "take it over"
> > :)
> > 
> > That platform device lives on the platform bus, you need a "master"
> > device that lives on your soundbus bus.
> > 
> > Again, look at how USB does this.  Or better yet, greybus, as that code
> > is a lot smaller and simpler.
> 
> The learning curve is not small here...

kernel programming is hard.  Writing a new bus subsystem is even harder :(

> > > static int intel_probe(struct platform_device *pdev)
> > > {
> > > 	struct sdw_cdns_stream_config config;
> > > 	struct sdw_intel *sdw;
> > > 	int ret;
> > > 
> > > 	sdw = devm_kzalloc(&pdev->dev, sizeof(*sdw), GFP_KERNEL);
> > > [snip]
> > > 	sdw->cdns.dev = &pdev->dev;
> > > 	sdw->cdns.bus.dev = &pdev->dev;
> > 
> > Gotta love the lack of reference counting :(
> > 
> > > I really don't see what you are hinting at, sorry, unless we are talking
> > > about major surgery in the code.
> > 
> > It sounds like you need a device on your bus that represents the master,
> > as you have attributes associated with it, and other things.  You can't
> > put attributes on a random pci or platform device, as you do not "own"
> > that device.
> > 
> > does that help?
> 
> Looks like we are doing things wrong at multiple levels.
> 
> It might be better to have a more 'self-contained' solution where the bus
> initialization creates/registers a master device instead of having this
> proxy platform_device. That would avoid all these refcount issues and make
> the translation from device to bus straightforward.

Yes, that sounds better.  Don't mess with a platform device unless you
really have no other possible choice.  And even then, don't do it and
try to do something else.  Platform devices are really abused, don't
perpetuate it.

thanks,

greg k-h
