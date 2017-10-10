From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 1/7] slimbus: Device management on
	SLIMbus
Date: Tue, 10 Oct 2017 13:34:48 +0100
Message-ID: <6dc24d42-7c40-9ffe-6be5-bf38d712222b@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171010100534.zyv3b5m6fmgmceim@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 41299266B38
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 14:34:53 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id u138so4686025wmu.5
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 05:34:53 -0700 (PDT)
In-Reply-To: <20171010100534.zyv3b5m6fmgmceim@localhost.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, gregkh@linuxfoundation.org, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

Thanks for the review comments.

On 10/10/17 11:05, Charles Keepax wrote:
> On Fri, Oct 06, 2017 at 05:51:30PM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Sagar Dharia <sdharia@codeaurora.org>
>>
>> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
>> developed by MIPI (Mobile Industry Processor Interface) alliance.
>> SLIMbus is a 2-wire implementation, which is used to communicate with
>> peripheral components like audio-codec.
>> SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
>> channels, and control channel. Control channel has messages to do
>> device-enumeration, messages to send/receive control-data to/from
>> slimbus devices, messages for port/channel management, and messages to
>> do bandwidth allocation.
>> The framework supports multiple instances of the bus (1 controller per
>> bus), and multiple slave devices per controller.
>>
>> This patch does device enumeration, logical address assignment,
>> informing device when the device reports present/absent etc.
>> Reporting present may need the driver to do the needful (e.g. turning
>> on voltage regulators powering the device). Additionally device is
>> probed when it reports present if that device doesn't need any such
>> steps mentioned above.
>>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/slimbus/bus.txt |  57 ++
>>   Documentation/slimbus/summary                     | 109 ++++
>>   drivers/Kconfig                                   |   2 +
>>   drivers/Makefile                                  |   1 +
>>   drivers/slimbus/Kconfig                           |  11 +
>>   drivers/slimbus/Makefile                          |   5 +
>>   drivers/slimbus/slim-core.c                       | 695 ++++++++++++++++++++++
>>   include/linux/mod_devicetable.h                   |  13 +
>>   include/linux/slimbus.h                           | 299 ++++++++++
>>   9 files changed, 1192 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
>>   create mode 100644 Documentation/slimbus/summary
>>   create mode 100644 drivers/slimbus/Kconfig
>>   create mode 100644 drivers/slimbus/Makefile
>>   create mode 100644 drivers/slimbus/slim-core.c
>>   create mode 100644 include/linux/slimbus.h
>>
>> diff --git a/Documentation/devicetree/bindings/slimbus/bus.txt b/Documentation/devicetree/bindings/slimbus/bus.txt
>> new file mode 100644
>> index 0000000..cb658bb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/slimbus/bus.txt
>> @@ -0,0 +1,57 @@
>> +SLIM(Serial Low Power Interchip Media Bus) bus
>> +
>> +SLIMbus is a 2-wire bus, and is used to communicate with peripheral
>> +components like audio-codec.
>> +
>> +Controller is a normal device using binding for whatever bus it is
>> +on (e.g. platform bus).
>> +Required property for SLIMbus controller node:
>> +- compatible	- name of SLIMbus controller following generic names
>> +		recommended practice.
>> +- #address-cells - should be 2
>> +- #size-cells	- should be 0
>> +
>> +No other properties are required in the SLIMbus controller bus node.
>> +
>> +Child nodes:
>> +Every SLIMbus controller node can contain zero or more child nodes
>> +representing slave devices on the bus. Every SLIMbus slave device is
>> +uniquely determined by the enumeration address containing 4 fields:
>> +Manufacturer ID, Product code, Device index, and Instance value for
>> +the device.
>> +If child node is not present and it is instantiated after device
>> +discovery (slave device reporting itself present).
>> +
>> +In some cases it may be necessary to describe non-probeable device
>> +details such as non-standard ways of powering up a device. In
>> +such cases, child nodes for those devices will be present as
>> +slaves of the slimbus-controller, as detailed below.
>> +
>> +Required property for SLIMbus child node if it is present:
>> +- reg		- Is Duplex (Device index, Instance ID) from Enumeration
>> +		  Address.
>> +		  Device Index Uniquely identifies multiple Devices within
>> +		  a single Component.
>> +		  Instance ID Is for the cases where multiple Devices of the
>> +		  same type or Class are attached to the bus.
>> +
>> +- compatible	-"slimMID,PID". The textual representation of Manufacturer ID,
>> +	 	  Product Code, shall be in lower case hexadecimal with leading
>> +		  zeroes suppressed
> 
> This does sort of make sense but kinda makes the code a bit ugly
> parsing the MID and PID. Some parts will support SLIMBus and also
> other control interfaces, which means they would need to add an
> additional compatible string just for SLIMBus. It also breaks
> the normal conventions of vendor,part and finally it makes the
> compatible strings really unreadable which will be a bit annoying
> when looking at DTs.
> 
This change was made inline to the comments provided in previous version 
of the patch https://lkml.org/lkml/2016/5/3/576

> I think the MID and PID should just be included in the reg field
> and just leave this as a standard compatible.

AFAIK, reg field should only contain index and instance, which was also 
discussed  at https://lkml.org/lkml/2016/5/3/747

> 
>> +/**
> 
> This doesn't appear to be a kernel doc comment, so only /*.

Yep, I got similar comments from other reviewers too, so I will fix all 
such instances in next version.

> 
>> + * Report callbacks(device_up, device_down) are implemented by slimbus-devices.
>> + * The calls are scheduled into a workqueue to avoid holding up controller
>> + * initialization/tear-down.
>> + */
>> +static void schedule_slim_report(struct slim_controller *ctrl,
>> +				 struct slim_device *sb, bool report)
>> +{
>> +	struct sb_report_wd *sbw;
>> +
>> +	dev_dbg(&ctrl->dev, "report:%d for slave:%s\n", report, sb->name);
>> +
>> +	sbw = kmalloc(sizeof(*sbw), GFP_KERNEL);
>> +	if (!sbw)
>> +		return;
>> +
>> +	INIT_WORK(&sbw->wd, slim_report);
>> +	sbw->sbdev = sb;
>> +	sbw->report = report;
>> +	if (!queue_work(ctrl->wq, &sbw->wd)) {
>> +		dev_err(&ctrl->dev, "failed to queue report:%d slave:%s\n",
>> +				    report, sb->name);
>> +		kfree(sbw);
>> +	}
>> +}
>> +
>> +/**
>> + * slim_driver_register: Client driver registration with slimbus
> 
> A - after the function name usually works better, I think
> kernel-doc doesn't support a colon after the function name.

Will fix this in next version too.

> 
>> + * @drv:Client driver to be associated with client-device.
>> + * @owner: owning module/driver
>> + * This API will register the client driver with the slimbus
>> + * It is called from the driver's module-init function.
> 
> If you don't put a blank line after the arguments kernel doc will
> treat this as a run on for the description of owner rather than
> the long description for the function you intended it to be.

okay, I will fix such instances in the patchset in next version.

> 
>> +
>> +/* Helper to get hex Manufacturer ID and Product id from compatible */
>> +static unsigned long str2hex(unsigned char *str)
>> +{
>> +	int value = 0;
>> +
>> +	while (*str) {
>> +		char c = *str++;
>> +
>> +		value = value << 4;
>> +		if (c >= '0' && c <= '9')
>> +			value |= (c - '0');
>> +		if (c >= 'a' && c <= 'f')
>> +			value |= (c - 'a' + 10);
>> +
>> +	}
>> +
>> +	return value;
>> +}
> 
> Isn't this just reimplementing kstrtoul?
> 
I would say partly, I think kstrtoul will only parse string as hex if 
its prefixed with "0x" But the compatible does not have 0x prefix..
we could probably do some prefixing before passing to kstrtoul to remove 
above function.. I will try that and see!

>> +
>> +/* OF helpers for SLIMbus */
>> +static void of_register_slim_devices(struct slim_controller *ctrl)
>> +{
>> +	struct device *dev = &ctrl->dev;
>> +	struct device_node *node;
>> +
>> +	if (!ctrl->dev.of_node)
>> +		return;
>> +
>> +	for_each_child_of_node(ctrl->dev.of_node, node) {
>> +		struct slim_device *slim;
>> +		const char *compat = NULL;
>> +		char *p, *tok;
>> +		int reg[2], ret;
>> +
>> +		slim = kzalloc(sizeof(*slim), GFP_KERNEL);
>> +		if (!slim)
>> +			continue;
>> +
>> +		slim->dev.of_node = of_node_get(node);
>> +
>> +		compat = of_get_property(node, "compatible", NULL);
>> +		if (!compat)
>> +			continue;
>> +
>> +		p = kasprintf(GFP_KERNEL, "%s", compat + strlen("slim"));
>> +
>> +		tok = strsep(&p, ",");
>> +		if (!tok) {
>> +			dev_err(dev, "No valid Manufacturer ID found\n");
>> +			kfree(p);
>> +			continue;
>> +		}
>> +		slim->e_addr.manf_id = str2hex(tok);
>> +
>> +		tok = strsep(&p, ",");
>> +		if (!tok) {
>> +			dev_err(dev, "No valid Product ID found\n");
>> +			kfree(p);
>> +			continue;
>> +		}
>> +		slim->e_addr.prod_code = str2hex(tok);
>> +		kfree(p);
>> +
>> +		ret = of_property_read_u32_array(node, "reg", reg, 2);
>> +		if (ret) {
>> +			dev_err(dev, "Device and Instance id not found:%d\n",
>> +				ret);
>> +			continue;
>> +		}
>> +		slim->e_addr.dev_index = reg[0];
>> +		slim->e_addr.instance = reg[1];
> 
> As I said above, this feels a bit complex compared to just
> reading the e_addr from reg.

I agree, but as I said, its done as part of the review comments on v5 
patchset.
https://lkml.org/lkml/2016/5/3/747

> 
>> +
>> +		ret = slim_add_device(ctrl, slim);
>> +		if (ret)
>> +			dev_err(dev, "of_slim device register err:%d\n", ret);
>> +	}
>> +}
> 
>> +
>> +static int slim_boot_child(struct device *dev, void *unused)
>> +{
>> +	struct slim_driver *sbdrv;
>> +	struct slim_device *sbdev = to_slim_device(dev);
>> +
>> +	if (sbdev && sbdev->dev.driver) {
>> +		sbdrv = to_slim_driver(sbdev->dev.driver);
>> +		if (sbdrv->boot_device)
>> +			sbdrv->boot_device(sbdev);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int slim_match_dev(struct device *dev, void *data)
>> +{
>> +	struct slim_eaddr *e_addr = data;
>> +	struct slim_device *slim = to_slim_device(dev);
>> +
>> +	return slim_eaddr_equal(&slim->e_addr, e_addr);
>> +}
> 
> Would it make sense to move this down to above slim_query_device,
> that way all the related code is next to itself?
> slim_boot_child/slim_framer_booted and
> slim_match_dev/slim_query_device.
> 
Okay, Will give that a go.
>> +
>> +/**
>> + * slim_framer_booted: This function is called by controller after the active
>> + * framer has booted (using Bus Reset sequence, or after it has shutdown and has
>> + * come back up).
>> + * @ctrl: Controller associated with this framer
>> + * Components, devices on the bus may be in undefined state,
>> + * and this function triggers their drivers to do the needful
>> + * to bring them back in Reset state so that they can acquire sync, report
>> + * present and be operational again.
>> + */
>> +void slim_framer_booted(struct slim_controller *ctrl)
>> +{
>> +	if (!ctrl)
>> +		return;
>> +
>> +	device_for_each_child(&ctrl->dev, NULL, slim_boot_child);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_framer_booted);
>> +
>> +/**
>> + * slim_query_device: Query and get handle to a device.
>> + * @ctrl: Controller on which this device will be added/queried
>> + * @e_addr: Enumeration address of the device to be queried
>> + * Returns pointer to a device if it has already reported. Creates a new
>> + * device and returns pointer to it if the device has not yet enumerated.
>> + */
>> +struct slim_device *slim_query_device(struct slim_controller *ctrl,
>> +				      struct slim_eaddr *e_addr)
>> +{
>> +	struct device *dev;
>> +	struct slim_device *slim = NULL;
>> +
>> +	dev = device_find_child(&ctrl->dev, e_addr, slim_match_dev);
>> +	if (dev) {
>> +		slim = to_slim_device(dev);
>> +		return slim;
>> +	}
>> +
>> +	slim = kzalloc(sizeof(struct slim_device), GFP_KERNEL);
>> +	if (IS_ERR(slim))
>> +		return NULL;
>> +
>> +	slim->e_addr = *e_addr;
>> +	if (slim_add_device(ctrl, slim) != 0) {
>> +		kfree(slim);
>> +		return NULL;
>> +	}
>> +	return slim;
>> +}
>> +EXPORT_SYMBOL_GPL(slim_query_device);
>> +
>> +static int ctrl_getaddr_entry(struct slim_controller *ctrl,
>> +			      struct slim_eaddr *eaddr, u8 *entry)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ctrl->num_dev; i++) {
>> +		if (ctrl->addrt[i].valid &&
>> +		    slim_eaddr_equal(&ctrl->addrt[i].eaddr, eaddr)) {
>> +			*entry = i;
>> +			return 0;
>> +		}
>> +	}
>> +	return -ENXIO;
>> +}
>> +
>> +/**
>> + * slim_assign_laddr: Assign logical address to a device enumerated.
>> + * @ctrl: Controller with which device is enumerated.
>> + * @e_addr: Enumeration address of the device.
>> + * @laddr: Return logical address (if valid flag is false)
>> + * @valid: true if laddr holds a valid address that controller wants to
>> + *	set for this enumeration address. Otherwise framework sets index into
>> + *	address table as logical address.
>> + * Called by controller in response to REPORT_PRESENT. Framework will assign
>> + * a logical address to this enumeration address.
>> + * Function returns -EXFULL to indicate that all logical addresses are already
>> + * taken.
>> + */
>> +int slim_assign_laddr(struct slim_controller *ctrl, struct slim_eaddr *e_addr,
>> +		      u8 *laddr, bool valid)
> 
> I would be inclined to remove the valid parameter and just
> use get_laddr in here.  Feels weird to have two mechanisms
> for specify the laddr and presumably if the controller wants
> to specify the laddr it will need to support get_laddr.
> Additionally, I would make get_laddr optional which feels more
> sensible, indeed the code appears otherwise implements with that
> assumption.
Yep makes sense, I will give it a go in next version.

> 
>> +{
>> +	int ret;
>> +	u8 i = 0;
>> +	bool exists = false;
>> +	struct slim_device *slim;
>> +	struct slim_addrt *temp;
>> +
>> +	mutex_lock(&ctrl->m_ctrl);
>> +	/* already assigned */
>> +	if (ctrl_getaddr_entry(ctrl, e_addr, &i) == 0) {
>> +		*laddr = ctrl->addrt[i].laddr;
>> +		exists = true;
>> +	} else {
>> +		if (ctrl->num_dev >= (SLIM_LA_MANAGER - 1)) {
>> +			ret = -EXFULL;
>> +			goto ret_assigned_laddr;
>> +		}
>> +		for (i = 0; i < ctrl->num_dev; i++) {
>> +			if (ctrl->addrt[i].valid == false)
>> +				break;
>> +		}
>> +		if (i == ctrl->num_dev) {
>> +			temp = krealloc(ctrl->addrt,
>> +					(ctrl->num_dev + 1) *
>> +					sizeof(struct slim_addrt),
>> +					GFP_KERNEL);
>> +			if (!temp) {
>> +				ret = -ENOMEM;
>> +				goto ret_assigned_laddr;
>> +			}
>> +			ctrl->addrt = temp;
>> +			ctrl->num_dev++;
>> +		}
>> +		ctrl->addrt[i].eaddr = *e_addr;
>> +		ctrl->addrt[i].valid = true;
>> +
>> +		/* Preferred address is index into table */
>> +		if (!valid)
>> +			*laddr = i;
>> +	}
>> +
>> +	ret = ctrl->set_laddr(ctrl, &ctrl->addrt[i].eaddr, *laddr);
>> +	if (ret) {
>> +		ctrl->addrt[i].valid = false;
>> +		goto ret_assigned_laddr;
>> +	}
>> +	ctrl->addrt[i].laddr = *laddr;
>> +
>> +ret_assigned_laddr:
>> +	mutex_unlock(&ctrl->m_ctrl);
>> +	if (exists || ret)
>> +		return ret;
>> +
>> +	dev_info(&ctrl->dev, "setting slimbus l-addr:%x, ea:%x,%x,%x,%x\n",
>> +		*laddr, e_addr->manf_id, e_addr->prod_code,
>> +		e_addr->dev_index, e_addr->instance);
>> +
>> +	/**
>> +	 * Add this device to list of devices on this controller if it's
>> +	 * not already present
>> +	 */
>> +	slim = slim_query_device(ctrl, e_addr);
>> +	if (!slim) {
>> +		ret = -ENODEV;
>> +	} else {
>> +		struct slim_driver *sbdrv;
>> +
>> +		slim->laddr = *laddr;
>> +		mutex_lock(&slim->report_lock);
>> +		slim->reported = true;
>> +		if (slim->dev.driver) {
>> +			sbdrv = to_slim_driver(slim->dev.driver);
>> +			if (sbdrv->device_up)
>> +				schedule_slim_report(ctrl, slim, true);
>> +		}
>> +		mutex_unlock(&slim->report_lock);
>> +	}
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(slim_assign_laddr);
>> +
>> +/**
>> + * slim_get_logical_addr: Return the logical address of a slimbus device.
>> + * @sb: client handle requesting the address.
>> + * @e_addr: Enumeration address of the device.
>> + * @laddr: output buffer to store the address
>> + * context: can sleep
>> + * -EINVAL is returned in case of invalid parameters, and -ENXIO is returned if
>> + *  the device with this enumeration address is not found.
>> + */
>> +int slim_get_logical_addr(struct slim_device *sb, struct slim_eaddr *e_addr,
>> +			  u8 *laddr)
>> +{
>> +	int ret;
>> +	u8 entry;
>> +	struct slim_controller *ctrl = sb->ctrl;
>> +
>> +	if (!ctrl || !laddr || !e_addr)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&ctrl->m_ctrl);
>> +	ret = ctrl_getaddr_entry(ctrl, e_addr, &entry);
>> +	if (!ret)
>> +		*laddr = ctrl->addrt[entry].laddr;
>> +	mutex_unlock(&ctrl->m_ctrl);
>> +
>> +	if (ret == -ENXIO && ctrl->get_laddr) {
>> +		ret = ctrl->get_laddr(ctrl, e_addr, laddr);
>> +		if (!ret)
>> +			ret = slim_assign_laddr(ctrl, e_addr, laddr, true);
>> +	}
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(slim_get_logical_addr);
> 
> I find the interface across these two functions
> (assign_laddr/get_logical_addr) a little odd. Since
> get_logical_addr calls assign_laddr if it couldn't find the
> laddr and then assign_laddr actually does another search for the
> laddr. Would it perhaps make sense to combine these into one
> function?
Yes these two functions can be combined, Will fix this in next version.
> 
> Thanks,
> Charles
> 
