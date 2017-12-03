From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v4 03/15] soundwire: Add Master registration
Date: Sun, 3 Dec 2017 22:11:20 +0530
Message-ID: <20171203164119.GL32417@localhost>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-4-git-send-email-vinod.koul@intel.com>
 <435d9db4-eb3c-f4b4-d978-e5d10b921f71@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <435d9db4-eb3c-f4b4-d978-e5d10b921f71@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 01, 2017 at 04:10:55PM -0600, Pierre-Louis Bossart wrote:
> On 12/1/17 3:56 AM, Vinod Koul wrote:
> >A Master registers with SoundWire bus and scans the firmware provided
> 
> nitpick: is the 'register' correct? You create a bus instance for each
> hardware master interface. Or is my brain fried?

naah, thankfully it is not :)

I will reword this, I see it can cause ambguity :)

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
> >+	 * Device numbers in SoundWire are 0 thru 15 with 0 being
> >+	 * Enumeration device number and 15 broadcast device number. So
> >+	 * they are not used for assignment so mask these and other
> >+	 * higher bits
> 
> device 14 is used for the master and is not supported by these patches.
> While allowed, if you use device 12 and 13 (groups) you can't get the status
> information in a PING command so the recommendation is to avoid them.
> Those device numbers should never be used really (on top of 0 and 15 as
> explained above)

Yeah we should also exclude 12 thru 14 here. The group alllocation when done
need to do differently that this one, so will mask those too.

> >+void sdw_extract_slave_id(struct sdw_bus *bus,
> >+			u64 addr, struct sdw_slave_id *id)
> >+{
> >+	dev_dbg(bus->dev, "SDW Slave Addr: %llx", addr);
> >+
> >+	/*
> >+	 * Spec definition
> >+	 *   Register		Bit	Contents
> >+	 *   DevId_0 [7:4]	47:44	sdw_version
> >+	 *   DevId_0 [3:0]	43:40	unique_id
> >+	 *   DevId_1		39:32	mfg_id [15:8]
> >+	 *   DevId_2		31:24	mfg_id [7:0]
> 
> Add a reference to mid.mipi.org (here or in the summary) ?

Will add in summary, makes sense on that page

> >+int sdw_acpi_find_slaves(struct sdw_bus *bus)
> >+{
> >+	struct acpi_device *adev, *parent;
> >+
> >+	parent = ACPI_COMPANION(bus->dev);
> >+	if (!parent) {
> >+		dev_err(bus->dev, "Can't find parent for acpi bind\n");
> >+		return -ENODEV;
> >+	}
> >+
> >+	list_for_each_entry(adev, &parent->children, node) {
> >+		unsigned long long addr;
> >+		struct sdw_slave_id id;
> >+		unsigned int link_id;
> >+		acpi_status status;
> >+
> >+		status = acpi_evaluate_integer(adev->handle,
> >+					METHOD_NAME__ADR, NULL, &addr);
> >+
> >+		if (ACPI_FAILURE(status)) {
> >+			dev_err(bus->dev, "_ADR resolution failed: %x\n",
> >+							status);
> >+			return status;
> >+		}
> >+
> >+		/* Extract link id from ADR, it is from 48 to 51 bits */
> 
> nitpick: in bits 51..48 as defined in the MIPI SoundWire DisCo spec.

ok

> >+/* SDW Enumeration Device Number */
> >+#define SDW_ENUM_DEV_NUM		0
> 
> add
> SDW_GROUP12_DEV_NUM		12
> SDW_GROUP12_DEV_NUM		13

you mean SDW_GROUP13_DEV_NUM :D

> SDW_MASTER_DEV_NUM		14 /* not supported in these patches */

These dont help now as we dont support, so kind of dead code.
Lets add them when we really support it

-- 
~Vinod
