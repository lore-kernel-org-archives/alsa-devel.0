From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 10 Nov 2017 14:25:37 +0530
Message-ID: <20171110085537.GQ3187@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <5fee4ccb-1030-b698-e7ef-7f4390563a76@linaro.org>
 <20171110045951.GL3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171110045951.GL3187@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 10, 2017 at 10:29:51AM +0530, Vinod Koul wrote:
> On Thu, Nov 09, 2017 at 09:14:07PM +0000, Srinivas Kandagatla wrote:
> > 
> > 
> > On 19/10/17 04:03, Vinod Koul wrote:
> > >This adds the base SoundWire bus type, bus and driver registration.
> > >along with changes to module device table for new SoundWire
> > >device type.
> > >
> > >Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> > >Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > >---
> > 
> > >+++ b/drivers/soundwire/Kconfig
> > >@@ -0,0 +1,22 @@
> > >+#
> > >+# SoundWire subsystem configuration
> > >+#
> > >+
> > >+menuconfig SOUNDWIRE
> > >+	bool "SoundWire support"
> > 
> > Any reason why this subsystem can not be build as module?
> 
> This is not subsystem symbol but the menu. The SOUNDWIRE_BUS can be module.
> 
> > 
> > >+	---help---
> > >+	  SoundWire is a 2-Pin interface with data and clock line ratified
> > >+	  by the MIPI Alliance. SoundWire is used for transporting data
> > >+	  typically related to audio functions. SoundWire interface is
> > 
> > >+#ifndef __SDW_BUS_H
> > >+#define __SDW_BUS_H
> > >+
> > >+#include <linux/init.h>
> > >+#include <linux/device.h>
> > >+#include <linux/module.h>
> > >+#include <linux/mod_devicetable.h>
> > >+#include <linux/acpi.h>
> > Do you need these headers here?
> 
> Yes :) I will double check though
> 
> 
> > 
> > >+#include <linux/soundwire/sdw.h>
> > >+
> > >+int sdw_slave_modalias(struct sdw_slave *slave, char *buf, size_t size);
> > >+
> > >+#endif /* __SDW_BUS_H */
> > >diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> > >new file mode 100644
> > >index 000000000000..a14d1de80afa
> > >--- /dev/null
> > >+++ b/drivers/soundwire/bus_type.c
> > >
> > >+#include <linux/acpi.h>
> > >+#include <linux/device.h>
> > >+#include <linux/init.h>
> > >+#include <linux/module.h>
> > >+#include <linux/mod_devicetable.h>
> > >+#include <linux/pm_domain.h>
> > >+#include <linux/pm_runtime.h>
> > >+#include <linux/soundwire/sdw.h>
> > >+#include "bus.h"
> > >+
> > >+/**
> > >+ * sdw_get_device_id: find the matching SoundWire device id
> > >+ *
> > function name should end with () - according to kernel doc.
> 
> ah thanks for pointing will add

I ran the kernel-doc script, seems to not complain about this.

Looking at it closely scripts/kernel-doc parenthesis is not expected

-- 
~Vinod
