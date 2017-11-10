From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 10 Nov 2017 10:29:51 +0530
Message-ID: <20171110045951.GL3187@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <5fee4ccb-1030-b698-e7ef-7f4390563a76@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DAC02678A9
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 05:56:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5fee4ccb-1030-b698-e7ef-7f4390563a76@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, Sudheer Papothi <spapothi@codeaurora.org>, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 09, 2017 at 09:14:07PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 19/10/17 04:03, Vinod Koul wrote:
> >This adds the base SoundWire bus type, bus and driver registration.
> >along with changes to module device table for new SoundWire
> >device type.
> >
> >Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> >Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> >---
> 
> >+++ b/drivers/soundwire/Kconfig
> >@@ -0,0 +1,22 @@
> >+#
> >+# SoundWire subsystem configuration
> >+#
> >+
> >+menuconfig SOUNDWIRE
> >+	bool "SoundWire support"
> 
> Any reason why this subsystem can not be build as module?

This is not subsystem symbol but the menu. The SOUNDWIRE_BUS can be module.

> 
> >+	---help---
> >+	  SoundWire is a 2-Pin interface with data and clock line ratified
> >+	  by the MIPI Alliance. SoundWire is used for transporting data
> >+	  typically related to audio functions. SoundWire interface is
> 
> >+#ifndef __SDW_BUS_H
> >+#define __SDW_BUS_H
> >+
> >+#include <linux/init.h>
> >+#include <linux/device.h>
> >+#include <linux/module.h>
> >+#include <linux/mod_devicetable.h>
> >+#include <linux/acpi.h>
> Do you need these headers here?

Yes :) I will double check though


> 
> >+#include <linux/soundwire/sdw.h>
> >+
> >+int sdw_slave_modalias(struct sdw_slave *slave, char *buf, size_t size);
> >+
> >+#endif /* __SDW_BUS_H */
> >diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> >new file mode 100644
> >index 000000000000..a14d1de80afa
> >--- /dev/null
> >+++ b/drivers/soundwire/bus_type.c
> >
> >+#include <linux/acpi.h>
> >+#include <linux/device.h>
> >+#include <linux/init.h>
> >+#include <linux/module.h>
> >+#include <linux/mod_devicetable.h>
> >+#include <linux/pm_domain.h>
> >+#include <linux/pm_runtime.h>
> >+#include <linux/soundwire/sdw.h>
> >+#include "bus.h"
> >+
> >+/**
> >+ * sdw_get_device_id: find the matching SoundWire device id
> >+ *
> function name should end with () - according to kernel doc.

ah thanks for pointing will add

> 
> >+ * @slave: SoundWire Slave device
> >+ * @drv: SoundWire Slave Driver
> >+ *
> >+ * The match is done by comparing the mfg_id and part_id from the
> >+ * struct sdw_device_id. class_id is unused, as it is a placeholder
> >+ * in MIPI Spec.
> >+ */
> 
> BTW, This is a static private function, why are we adding kernel doc for
> this?

the match is an important routine and helps people understand the logic
hence documentation. More doc is better right :)

> 
> >+static const struct sdw_device_id *
> >+sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
> >+{
> >+	const struct sdw_device_id *id = drv->id_table;
> >+
> >+	while (id && id->mfg_id) {
> >+		if (slave->id.mfg_id == id->mfg_id &&
> >+				slave->id.part_id == id->part_id) {
> >+			return id;
> >+		}
> >+		id++;
> >+	}
> >+
> >+	return NULL;
> >+}
> >+
> >+static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
> >+{
> >+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> >+	struct sdw_driver *drv = drv_to_sdw_driver(ddrv);
> >+
> >+	return !!sdw_get_device_id(slave, drv);
> >+}
> >+
> >+int sdw_slave_modalias(struct sdw_slave *slave, char *buf, size_t size)
> >+{
> >+	/* modalias is sdw:m<mfg_id>p<part_id> */
> >+
> >+	return snprintf(buf, size, "sdw:m%04Xp%04X\n",
> >+			slave->id.mfg_id, slave->id.part_id);
> >+}
> >+
> >+static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
> >+{
> >+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> >+	char modalias[32];
> >+
> >+	sdw_slave_modalias(slave, modalias, sizeof(modalias));
> >+
> >+	if (add_uevent_var(env, "MODALIAS=%s", modalias))
> >+		return -ENOMEM;
> >+
> >+	return 0;
> >+}
> >+
> >+struct bus_type sdw_bus_type = {
> >+	.name = "soundwire",
> >+	.match = sdw_bus_match,
> >+	.uevent = sdw_uevent,
> >+};
> >+EXPORT_SYMBOL(sdw_bus_type);
> >+
> >+static int sdw_drv_probe(struct device *dev)
> >+{
> >+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> >+	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> >+	const struct sdw_device_id *id;
> >+	int ret;
> >+
> >+	id = sdw_get_device_id(slave, drv);
> 
> By this time we must have already matched dev and driver by the ID,
> shouldn't it be just slave->id  here?

I don't think so we do not have slave->id, we pass the id in probe as an
argument

> >+	if (!id)
> >+		return -ENODEV;
> >+
> >+	/*
> >+	 * attach to power domain but don't turn on (last arg)
> >+	 */
> >+	ret = dev_pm_domain_attach(dev, false);
> >+	if (ret) {
> Shouldn't it just handle the EPROBE_DEFER case and ignore it for other
> errors.

why should we ignore other errors and continue?

> 
> 
> >+		dev_err(dev, "Failed to attach PM domain: %d\n", ret);
> >+		return ret;
> >+	}
> >+
> >+	ret = drv->probe(slave, id);
> >+	if (ret) {
> >+		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
> >+		return ret;
> >+	}
> 
> 
> What happens if the slave driver is built as module and loaded after the
> slave device is attached to the bus. How does the slave driver get updated
> status in this case?
> 
> We have similar usecase in slimbus too.

So we create devices based on firmware description, then the Slave may
report as present and we mark it as present. Once a driver is loaded, the
driver is probed here, the slave->status clearly tells the driver that slave
has already reported present.

-- 
~Vinod
