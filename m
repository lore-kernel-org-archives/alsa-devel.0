From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Tue, 10 Oct 2017 13:34:55 +0100
Message-ID: <fd966acd-a86c-5021-8a8b-ddf1508ab63e@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171010104509.GC30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010104509.GC30097@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

Thanks for your review comments,

On 10/10/17 11:45, Vinod Koul wrote:
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
> 
> thats a lot of code for review, consider splitting it up further for better
> reviews

Its was suggested that parts of dtbindings and of_* wrapper merged into 
this patch.  In V5 review comments. https://lkml.org/lkml/2016/4/28/175


> 
>>   create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
>>   create mode 100644 Documentation/slimbus/summary
>>   create mode 100644 drivers/slimbus/Kconfig
>>   create mode 100644 drivers/slimbus/Makefile
>>   create mode 100644 drivers/slimbus/slim-core.c
> 
> how about core.c (https://lkml.org/lkml/2017/7/12/430)
> 
Makes sense, will do that in next version.

>> +static const struct slim_device_id *slim_match(const struct slim_device_id *id,
>> +					       const struct slim_device *sbdev)
>> +{
>> +	while (id->manf_id != 0 || id->prod_code != 0) {
>> +		if (id->manf_id == sbdev->e_addr.manf_id &&
>> +		    id->prod_code == sbdev->e_addr.prod_code &&
>> +		    id->dev_index == sbdev->e_addr.dev_index)
>> +			return id;
>> +		id++;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static int slim_device_match(struct device *dev, struct device_driver *drv)
>> +{
>> +	struct slim_device *sbdev = to_slim_device(dev);
>> +	struct slim_driver *sbdrv = to_slim_driver(drv);
>> +
>> +	/* Attempt an OF style match first */
>> +	if (of_driver_match_device(dev, drv))
>> +		return 1;
> 
> is of_driver_match_device() a must have here? (I dont completely understand
Yes, we need this to match the compatible string from device tree vs 
driver itself, most of the bus driver do this in bus match functions.


> DT so pardon my ignorance). Since we have devices with ids can we use that
> alone for matching?

Two cases to consider here,
1> If the device is up and discoverable.
2> Device is not discoverable yet, as it needs some power up sequence.


In first case comparing with ID table makes sense.

But second case we would want to probe the device(for power sequencing) 
before we can discover the device on bus.


This code as it is supports both DT and id_table.

>> +
>> +	/* Then try to match against the id table */
>> +	if (sbdrv->id_table)
>> +		return slim_match(sbdrv->id_table, sbdev) != NULL;
>> +
>> +	return 0;
>> +}
>> +
> 
> rather than jumping now to reporting APIs, can we club all bus_type parts to
> one place (patch) so that it is easier to review logically
> 
Let me try that in next version.

>> +struct sb_report_wd {
>> +	struct work_struct wd;
>> +	struct slim_device *sbdev;
>> +	bool report;
>> +};
>> +
>> +static void slim_report(struct work_struct *work)
>> +{
>> +	struct slim_driver *sbdrv;
>> +	struct sb_report_wd *sbw = container_of(work, struct sb_report_wd, wd);
>> +	struct slim_device *sbdev = sbw->sbdev;
>> +
>> +	mutex_lock(&sbdev->report_lock);
>> +	if (!sbdev->dev.driver)
>> +		goto report_exit;
>> +
>> +	/* check if device-up or down needs to be called */
>> +	if ((!sbdev->reported && !sbdev->notified) ||
>> +	    (sbdev->reported && sbdev->notified))
>> +		goto report_exit;
>> +
>> +	sbdrv = to_slim_driver(sbdev->dev.driver);
>> +
>> +	/**
>> +	 * address no longer valid, means device reported absent, whereas
>> +	 * address valid, means device reported present
>> +	 */
> 
> I think ppl commented about this style, so lets fix those issues
> 

sure.

>> +	if (sbdev->notified && !sbdev->reported) {
>> +		sbdev->notified = false;
>> +		if (sbdrv->device_down)
>> +			sbdrv->device_down(sbdev);
>> +	} else if (!sbdev->notified && sbdev->reported) {
>> +		sbdev->notified = true;
>> +		if (sbdrv->device_up)
>> +			sbdrv->device_up(sbdev);
> 
> what do the device_up/down calls signify here?
> 
up would be called when a device is discovered on the bus, and down on 
when the device disappeared on slimbus.

>> +static int slim_device_probe(struct device *dev)
>> +{
>> +	struct slim_device	*sbdev;
>> +	struct slim_driver	*sbdrv;
>> +	int status = 0;
>> +
>> +	sbdev = to_slim_device(dev);
>> +	sbdrv = to_slim_driver(dev->driver);
>> +
>> +	sbdev->driver = sbdrv;
>> +
>> +	if (sbdrv->probe)
>> +		status = sbdrv->probe(sbdev);
>> +
>> +	if (status)
>> +		sbdev->driver = NULL;
>> +	else if (sbdrv->device_up)
>> +		schedule_slim_report(sbdev->ctrl, sbdev, true);
> 
> can you please explain what this is trying to do?

It is scheduling a device_up() callback in workqueue for reporting 
discovered device.


> 
>> +int __slim_driver_register(struct slim_driver *drv, struct module *owner)
>> +{
>> +	drv->driver.bus = &slimbus_type;
>> +	drv->driver.owner = owner;
>> +	return driver_register(&drv->driver);
>> +}
>> +EXPORT_SYMBOL_GPL(__slim_driver_register);
> 
> any reason to use __ for this API?

This is made inline with __platfrom_driver_register() suggested in v5 
review.

> 
>> +static int slim_add_device(struct slim_controller *ctrl,
>> +			   struct slim_device *sbdev)
>> +{
>> +	sbdev->dev.bus = &slimbus_type;
>> +	sbdev->dev.parent = &ctrl->dev;
>> +	sbdev->dev.release = slim_dev_release;
>> +	sbdev->dev.driver = NULL;
>> +	sbdev->ctrl = ctrl;
>> +
>> +	slim_ctrl_get(ctrl);
>> +	sbdev->name = kasprintf(GFP_KERNEL, "%x:%x:%x:%x",
>> +					sbdev->e_addr.manf_id,
>> +					sbdev->e_addr.prod_code,
>> +					sbdev->e_addr.dev_index,
>> +					sbdev->e_addr.instance);
>> +	if (!sbdev->name)
>> +		return -ENOMEM;
>> +
>> +	dev_set_name(&sbdev->dev, "%s", sbdev->name);
>> +	mutex_init(&sbdev->report_lock);
>> +
>> +	/* probe slave on this controller */
>> +	return device_register(&sbdev->dev);
> 
> I dont think the comment is quite correct, you register a device not probe!
> 
Will fix this in next version.

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
>> +
>> +		ret = slim_add_device(ctrl, slim);
> 
> okay this is good stuff. So we scan the DT for slimbus devices and register
> them here. Same stuff we can do with ACPI :)
> 
> then why do we need the of register stuff I commented earlier. A Slimbus
> device can work irrespective of firmware type and registers using various
> ids. The platform will scan firmware (dt/acpi) create devices and load
> drivers against them generically.  Apart from this code we ideally should
> not have any DT parts in the bus, do you agree?

I partly agree with you, as all the devices on slimbus might not be in a 
discoverable state. Such devices would need some sort of power up 
sequence which what the of_wrapper and the match function are trying to 
achieve. Driver probe will be called based on the compatible match which 
would then power up/reset the device so that it can announce itself and 
the device_up() would be called at that point.

Your comment is 100% true, If the devices are in discoverable state, in 
such case we would not need any DT entires as you said.

> 
>> +		if (ret)
>> +			dev_err(dev, "of_slim device register err:%d\n", ret);
>> +	}
>> +}
>> +
>> +/**
>> + * slim_register_controller: Controller bring-up and registration.
>> + * @ctrl: Controller to be registered.
>> + * A controller is registered with the framework using this API.
>> + * If devices on a controller were registered before controller,
>> + * this will make sure that they get probed when controller is up
>> + */
>> +int slim_register_controller(struct slim_controller *ctrl)
>> +{
>> +	int id, ret = 0;
>> +
>> +	mutex_lock(&slim_lock);
>> +	id = idr_alloc(&ctrl_idr, ctrl, ctrl->nr, -1, GFP_KERNEL);
> 
> what are these ids used for?

I think these are the controller ids, just to create a proper name space 
for each controller.

> 
>> +	mutex_unlock(&slim_lock);
>> +
>> +	if (id < 0)
>> +		return id;
>> +
>> +	ctrl->nr = id;
>> +
>> +	dev_set_name(&ctrl->dev, "sb-%d", ctrl->nr);
>> +	ctrl->num_dev = 0;
>> +
>> +	if (!ctrl->min_cg)
>> +		ctrl->min_cg = SLIM_MIN_CLK_GEAR;
>> +	if (!ctrl->max_cg)
>> +		ctrl->max_cg = SLIM_MAX_CLK_GEAR;
>> +
>> +	mutex_init(&ctrl->m_ctrl);
>> +	ret = device_register(&ctrl->dev);
> 
> one more device_register?? Can you explain why
> 

This is a device for each controller.

>> +/**
>> + * struct slim_addrt: slimbus address used internally by the slimbus framework.
>> + * @valid: If the device is present. Valid is set to false when device reports
>> + *	absent.
>> + * @eaddr: Enumeration address
>> + * @laddr: It is possible that controller will set a predefined logical address
>> + *	rather than the one assigned by framework. (i.e. logical address may
>> + *	not be same as index into this table). This entry will store the
>> + *	logical address value for this enumeration address.
>> + */
>> +struct slim_addrt {
> 
> addrt? why not just addr?
yes, it can be done! will fix this in next version.
> 
>> +	bool			valid;
>> +	struct slim_eaddr	eaddr;
>> +	u8			laddr;
>> +};
>> +
>> +/* SLIMbus message types. Related to interpretation of message code. */
>> +#define SLIM_MSG_MT_CORE			0x0
>> +#define SLIM_MSG_MT_DEST_REFERRED_CLASS		0x1
>> +#define SLIM_MSG_MT_DEST_REFERRED_USER		0x2
>> +#define SLIM_MSG_MT_SRC_REFERRED_CLASS		0x5
>> +#define SLIM_MSG_MT_SRC_REFERRED_USER		0x6
> 
> BIT() GENMASK() please here and other places where they define bits in spec
> 
>> +/**
>> + * struct slim_driver: Slimbus 'generic device' (slave) device driver
>> + *				(similar to 'spi_device' on SPI)
>> + * @probe: Binds this driver to a slimbus device.
>> + * @remove: Unbinds this driver from the slimbus device.
>> + * @shutdown: Standard shutdown callback used during powerdown/halt.
>> + * @suspend: Standard suspend callback used during system suspend
>> + * @resume: Standard resume callback used during system resume
>> + * @device_up: This callback is called when the device reports present and
>> + *		gets a logical address assigned to it
>> + * @device_down: This callback is called when device reports absent, or the
>> + *		bus goes down. Device will report present when bus is up and
>> + *		device_up callback will be called again when that happens
> 
> do we need two callback, why not a status or notify callback with argument
> for up/down?

I will give it a try and see how it looks!

> 
