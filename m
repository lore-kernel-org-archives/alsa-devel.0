From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 10 Nov 2017 16:28:48 +0530
Message-ID: <20171110105847.GR3187@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <5fee4ccb-1030-b698-e7ef-7f4390563a76@linaro.org>
 <20171110045951.GL3187@localhost>
 <fc897871-3ed6-5c19-98bf-51a95d4ac313@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fc897871-3ed6-5c19-98bf-51a95d4ac313@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 10, 2017 at 10:42:06AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 10/11/17 04:59, Vinod Koul wrote:
> >On Thu, Nov 09, 2017 at 09:14:07PM +0000, Srinivas Kandagatla wrote:
> >>
> >>
> >>On 19/10/17 04:03, Vinod Koul wrote:
> >>>This adds the base SoundWire bus type, bus and driver registration.
> >>>along with changes to module device table for new SoundWire
> >>>device type.
> >>>
> >>>Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> >>>Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> >>>---
> >>
> >>>+++ b/drivers/soundwire/Kconfig
> >>>@@ -0,0 +1,22 @@
> >>>+#
> >>>+# SoundWire subsystem configuration
> >>>+#
> >>>+
> >>>+menuconfig SOUNDWIRE
> >>>+	bool "SoundWire support"
> >>
> >>Any reason why this subsystem can not be build as module?
> >
> >This is not subsystem symbol but the menu. The SOUNDWIRE_BUS can be module.
> I Noticed that.
> 
> Are you able to be build SOUNDWIRE_BUS as moudles?
> 
> I think the issue is that SOUNDWIRE_BUS default is set to SOUNDWIRE
> This would never allow SOUNDWIRE_BUS to set as module if SOUNDWIRE is bool.
> 
> May be that is the issue.
> 
> config SOUNDWIRE_BUS
>         tristate
>         default SOUNDWIRE

removing this makes it build as module, sorry I assumed you have already
seen Takashi's comment. I have fixed it in v2. Posting anytime now :)

> >
> >>
> >>>+ * @slave: SoundWire Slave device
> >>>+ * @drv: SoundWire Slave Driver
> >>>+ *
> >>>+ * The match is done by comparing the mfg_id and part_id from the
> >>>+ * struct sdw_device_id. class_id is unused, as it is a placeholder
> >>>+ * in MIPI Spec.
> >>>+ */
> >>
> >>BTW, This is a static private function, why are we adding kernel doc for
> >>this?
> >
> >the match is an important routine and helps people understand the logic
> >hence documentation. More doc is better right :)
> >
> I agree, more doc is better.
> 
> >>>+struct bus_type sdw_bus_type = {
> >>>+	.name = "soundwire",
> >>>+	.match = sdw_bus_match,
> >>>+	.uevent = sdw_uevent,
> >>>+};
> >>>+EXPORT_SYMBOL(sdw_bus_type);
> >>>+
> >>>+static int sdw_drv_probe(struct device *dev)
> >>>+{
> >>>+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> >>>+	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> >>>+	const struct sdw_device_id *id;
> >>>+	int ret;
> >>>+
> >>>+	id = sdw_get_device_id(slave, drv);
> >>
> >>By this time we must have already matched dev and driver by the ID,
> >>shouldn't it be just slave->id  here?
> >
> >I don't think so we do not have slave->id, we pass the id in probe as an
> >argument
> >
> Which probe function are you referening too ?
> 
> Not sure I get it, Only way to get to this probe is that id_table from
> driver matches slave id which is done as part of sdw_bus_match().
> So the id should be valid and calling sdw_get_device_id() is redundant here?

we dont store in id so we have to lookup again. I see the point
in doing so, let me check that

> >>>+	if (!id)
> >>>+		return -ENODEV;
> >>>+
> >>>+	/*
> >>>+	 * attach to power domain but don't turn on (last arg)
> >>>+	 */
> >>>+	ret = dev_pm_domain_attach(dev, false);
> >>>+	if (ret) {
> >>Shouldn't it just handle the EPROBE_DEFER case and ignore it for other
> >>errors.
> >
> >why should we ignore other errors and continue?
> >
> 
> If you are making power domain as mandatory for all the devices, then it
> makes sense to err out. But not all the devices might have pm domains
> associated, so continuing on other errors makes sense.. All of the bus
> drivers in the kernel do that ex: ./drivers/base/platform.c,
> ./drivers/mmc/core/sdio_bus.c, ./drivers/spi/spi.c...

Ah thanks for pointing, let me check that

> >>>+		dev_err(dev, "Failed to attach PM domain: %d\n", ret);
> >>>+		return ret;
> >>>+	}
> >>>+
> >>>+	ret = drv->probe(slave, id);
> >>>+	if (ret) {
> >>>+		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
> >>>+		return ret;
> >>>+	}
> >>
> >>
> >>What happens if the slave driver is built as module and loaded after the
> >>slave device is attached to the bus. How does the slave driver get updated
> >>status in this case?
> >>
> >>We have similar usecase in slimbus too.
> >
> >So we create devices based on firmware description, then the Slave may
> >report as present and we mark it as present. Once a driver is loaded, the
> >driver is probed here, the slave->status clearly tells the driver that slave
> >has already reported present.
> 
> Yep, that solution makes sense, Looks like I can do the same for slimbus
> too.

yup!

-- 
~Vinod
