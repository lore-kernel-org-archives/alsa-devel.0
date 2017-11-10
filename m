From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 03/14] soundwire: Add Master registration
Date: Fri, 10 Nov 2017 10:32:14 +0530
Message-ID: <20171110050214.GM3187@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
 <a44f40ab-bd8b-f778-6819-73ae151c97ab@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6921B2678A9
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 05:59:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a44f40ab-bd8b-f778-6819-73ae151c97ab@linaro.org>
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

On Thu, Nov 09, 2017 at 09:14:16PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 19/10/17 04:03, Vinod Koul wrote:
> 
> >+/**
> >+ * sdw_add_bus_master: add a bus Master instance
> >+ *
> >+ * @bus: bus instance
> >+ *
> >+ * Initializes the bus instance, read properties and create child
> >+ * devices.
> >+ */
> 
> Some of the exported functions are missing kerneldocs.
> Is it something you plan to add in next version of the patcheset?

I though most were, will double check to be sure.

> 
> >+int sdw_add_bus_master(struct sdw_bus *bus)
> >+{
> >+	int ret;
> >+
> >+	if (!bus->dev) {
> >+		pr_err("SoundWire bus has no device");
> >+		return -ENODEV;
> >+	}
> >+
> >+	mutex_init(&bus->bus_lock);
> >+	INIT_LIST_HEAD(&bus->slaves);
> >+
> >+	/*
> >+	 * SDW is an enumerable bus, but devices can be powered off. So,
> >+	 * they won't be able to report as present.
> >+	 *
> >+	 * Create Slave devices based on Slaves described in
> >+	 * the respective firmware (ACPI/DT)
> >+	 */
> >+
> >+	if (IS_ENABLED(CONFIG_ACPI) && bus->dev && ACPI_HANDLE(bus->dev))
> >+		ret = sdw_acpi_find_slaves(bus);
> >+	else if (IS_ENABLED(CONFIG_OF) && bus->dev && bus->dev->of_node)
> >+		ret = sdw_of_find_slaves(bus);
> >+	else
> bus->dev is already checked in the start of the function, do we need to
> check once again ?

yes already fixed, thanks

-- 
~Vinod
