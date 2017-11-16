From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 02/14] soundwire: Add SoundWire bus type
Date: Thu, 16 Nov 2017 22:32:21 +0530
Message-ID: <20171116170221.GD3187@localhost>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-3-git-send-email-vinod.koul@intel.com>
 <cb4fbc87-7857-5ab3-a2cd-413ee57c463e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 52DE3266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 17:59:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cb4fbc87-7857-5ab3-a2cd-413ee57c463e@linaro.org>
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

On Thu, Nov 16, 2017 at 04:05:17PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 10/11/17 11:49, Vinod Koul wrote:
> >index 000000000000..9b3dca95a098
> >--- /dev/null
> >+++ b/drivers/soundwire/bus.h
> >+
> >+#ifndef __SDW_BUS_H
> >+#define __SDW_BUS_H
> >+
> >+#include <linux/init.h>
> >+#include <linux/device.h>
> >+#include <linux/module.h>
> >+#include <linux/mod_devicetable.h>
> >+#include <linux/acpi.h>
> 
> Do you need all these headers as part of this patch?

I think so. One thing we need to keep in mind that bus is compiled on
different archs where we may not have things availble explictly as they are
on x86 or others. I think couple of them complained last time. I will check
once more though..

> 
> >+#include <linux/soundwire/sdw.h>
> >+
> >+int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
> >+
> >+#endif /* __SDW_BUS_H */
> >diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> >new file mode 100644
> >index 000000000000..3e97a8284871
> >--- /dev/null
> >+++ b/drivers/soundwire/bus_type.c
> >@@ -0,0 +1,227 @@
> ...
> 
> >+static const struct sdw_device_id *
> >+sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
> Indentation looks Odd here,

not really, the return type in preceding line is a perfect way to define
things...

> >+static int sdw_drv_probe(struct device *dev)
> >+{
> >+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> >+	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> >+	const struct sdw_device_id *id;
> >+	int ret;
> ...
> >+	/*
> >+	 * attach to power domain but don't turn on (last arg)
> >+	 */
> >+	ret = dev_pm_domain_attach(dev, false);
> >+	if (ret) {
> 
> I think we discussed this in v1, but erring out here means that all the
> devices need to have pm domain  attached, which might not be true all the
> time.

oh yes, sorry i missed this one. will fix

> >+
> >+/**
> >+ * struct sdw_slave_id: Slave ID
> >+ *
> Do we need an empty line Here?? same thing for all the kernel doc comments.
> 
> Also looking at examples in Documentation/doc-guide/kernel-doc.rst
> 
> struct should follow with  - instead of :
> same for functions..

Kernel seems to have both. But yes - is more predominant by an order of
magnitude and Documented so will fix it up.

-- 
~Vinod
