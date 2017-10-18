From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 1/7] slimbus: Device management on
	SLIMbus
Date: Wed, 18 Oct 2017 17:38:49 +0100
Message-ID: <1a1d2777-be69-98ca-afba-0ffd0e3dd80f@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171017062332.GS1165@minitux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B07A266EE0
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 18:38:53 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id l1so5677564wrc.3
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 09:38:53 -0700 (PDT)
In-Reply-To: <20171017062332.GS1165@minitux>
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
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

Thanks for the Review Bjorn,

On 17/10/17 07:23, Bjorn Andersson wrote:
> On Fri 06 Oct 08:51 PDT 2017, srinivas.kandagatla@linaro.org wrote:
> [..]
>> diff --git a/drivers/slimbus/slim-core.c b/drivers/slimbus/slim-core.c
> [..]
>> +/**
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
> 
> This is the only place where sb->name is used in this driver. If you
> instead invoke dev_*() on &sb->dev you should get prettier output and
> can drop the double storage of the device name.

Makes sense, we could get rid of sb->name storage too.

> 
>> +
>> +	sbw = kmalloc(sizeof(*sbw), GFP_KERNEL);
>> +	if (!sbw)
>> +		return;
>> +
>> +	INIT_WORK(&sbw->wd, slim_report);
>> +	sbw->sbdev = sb;
>> +	sbw->report = report;
>> +	if (!queue_work(ctrl->wq, &sbw->wd)) {
> 
> When a controller is torn down destroy_workqueue() is called after all
> child devices has been unregistered, so this work might be scheduled
> after "sb" is gone, if I get this properly.

I agree, That is possible!
We should probably flush the workqueue before we start removing the clients.

> 
>> +		dev_err(&ctrl->dev, "failed to queue report:%d slave:%s\n",
>> +				    report, sb->name);
>> +		kfree(sbw);
>> +	}
>> +}
>> +
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
> 
> So a driver can have a probe() and device_up() or just any one of them?
> 
> And probe() is called when the controller enumerates all devices
> mentioned in DT and then device_up() is called at that point in time and
> when it's advertised on the bus?
> 
> Is there a reason for this split model?
> 
yes, Some of the devices need to be powered up before they become 
usable, so probe is used to do the initial power up of the device.


>> +
>> +	if (status)
>> +		sbdev->driver = NULL;
>> +	else if (sbdrv->device_up)
>> +		schedule_slim_report(sbdev->ctrl, sbdev, true);
>> +
>> +	return status;
>> +}
>> +
>> +static int slim_device_remove(struct device *dev)
>> +{
>> +	struct slim_device *sbdev;
>> +	struct slim_driver *sbdrv;
>> +	int status = 0;
>> +
>> +	sbdev = to_slim_device(dev);
>> +	if (!dev->driver)
>> +		return 0;
>> +
>> +	sbdrv = to_slim_driver(dev->driver);
>> +	if (sbdrv->remove)
>> +		status = sbdrv->remove(sbdev);
>> +
>> +	mutex_lock(&sbdev->report_lock);
>> +	sbdev->notified = false;
>> +	if (status == 0)
>> +		sbdev->driver = NULL;
>> +	mutex_unlock(&sbdev->report_lock);
>> +	return status;
> 
> device_unregister() will call device_del() which will end up in
> __device_release_driver() which will call this function. Upon returning
> from this function the core expect the bus to have cleaned up after the
> dev (normally by calling drv->remove(dev)).
> 
> It will completely ignore the return value and continue tearing down the
> rest of the core resources, e.g. three lines down it will
> devres_release_all().
> 
> 
> So you have the option of sleeping, while waiting for stuff to be
> aborted/finished and then you need to clean things up.
> 
> The slim_device object itself will stick around until all references are
> dropped though.

So you are suggesting that we make slim_driver remove not return anything?

> 
>> +}
>> +
>> +struct bus_type slimbus_type = {
>> +	.name		= "slimbus",
>> +	.match		= slim_device_match,
>> +	.probe		= slim_device_probe,
>> +	.remove		= slim_device_remove,
>> +};
>> +EXPORT_SYMBOL_GPL(slimbus_type);
>> +
>> +/**
>> + * slim_driver_register: Client driver registration with slimbus
>> + * @drv:Client driver to be associated with client-device.
>> + * @owner: owning module/driver
>> + * This API will register the client driver with the slimbus
>> + * It is called from the driver's module-init function.
>> + */
>> +int __slim_driver_register(struct slim_driver *drv, struct module *owner)
>> +{
>> +	drv->driver.bus = &slimbus_type;
>> +	drv->driver.owner = owner;
>> +	return driver_register(&drv->driver);
>> +}
>> +EXPORT_SYMBOL_GPL(__slim_driver_register);
>> +
>> +/**
>> + * slim_driver_unregister: Undo effect of slim_driver_register
>> + * @drv: Client driver to be unregistered
>> + */
>> +void slim_driver_unregister(struct slim_driver *drv)
>> +{
>> +	if (drv)
> 
> A driver invoking slim_driver_unregister(NULL) is broken, drop this
> check and let it oops on the dereference instead.

Yep.

> 
>> +		driver_unregister(&drv->driver);
>> +}
>> +EXPORT_SYMBOL_GPL(slim_driver_unregister);
>> +
>> +static struct slim_controller *slim_ctrl_get(struct slim_controller *ctrl)
>> +{
>> +	if (!ctrl || !get_device(&ctrl->dev))
> 
> ctrl can't be NULL here. In all code paths leading here it's
> dereferenced multiple times already.

I agree.

> 
>> +		return NULL;
>> +
>> +	return ctrl;
>> +}
>> +
>> +static void slim_ctrl_put(struct slim_controller *ctrl)
>> +{
>> +	if (ctrl)
>> +		put_device(&ctrl->dev);
>> +}
>> +
>> +static void slim_dev_release(struct device *dev)
>> +{
>> +	struct slim_device *sbdev = to_slim_device(dev);
>> +
>> +	slim_ctrl_put(sbdev->ctrl);
> 
> As far as I can see there's no case where sbdev->ctrl will ever be NULL,
> so yo can just replace this with
> 	put_device(&ctrl->dev);
> 
> And drop slim_ctrl_put().


Yes..

> 
>> +	kfree(sbdev->name);
>> +	kfree(sbdev);
>> +}
>> +
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
> 
> Unfolding slim_ctrl_get(), with ctrl != NULL, gives us a container_of(),
> so this can't fail. Which is good because then an error check would have
> been nice.
> 
> But it also means that you can replace this with just:
> 	get_device(&ctrl->dev);
> 
> And drop slim_ctrl_get()
> 

ya.

>> +	sbdev->name = kasprintf(GFP_KERNEL, "%x:%x:%x:%x",
>> +					sbdev->e_addr.manf_id,
>> +					sbdev->e_addr.prod_code,
>> +					sbdev->e_addr.dev_index,
>> +					sbdev->e_addr.instance);
>> +	if (!sbdev->name)
>> +		return -ENOMEM;
>> +
>> +	dev_set_name(&sbdev->dev, "%s", sbdev->name);
> 
> This will create another copy of the same string and as noted above
> there seems to be only one consumer, which could be switched over. So
> you can drop above kasprintf() and just use dev_set_name to format the
> name.
> 
> An added benefit is that you're not leaking the device reference from
> slim_ctrl_get() on the line before.

I agree, will fix this in next version.

> 
>> +	mutex_init(&sbdev->report_lock);
>> +
>> +	/* probe slave on this controller */
>> +	return device_register(&sbdev->dev);
>> +}
>> +
>> +/* Helper to get hex Manufacturer ID and Product id from compatible */
>> +static unsigned long str2hex(unsigned char *str)
> 
> The caller of this passes char *, so you can drop the unsigned. And add
> "const" while you're at it.

I will be removing this function in next version, replacing it with 
kstrtoul()

> 
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
> 
> At the cost of one more check here you can drop the line in the
> documentation about this only working for lower-case hex digits.
> 
>> +
>> +	}
>> +
>> +	return value;
>> +}
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
> 
> This is leaked in several places below.
> 
>> +		if (!slim)
>> +			continue;
>> +
>> +		slim->dev.of_node = of_node_get(node);
> 
> Dito.
> 
>> +
>> +		compat = of_get_property(node, "compatible", NULL);
>> +		if (!compat)
>> +			continue;
>> +
>> +		p = kasprintf(GFP_KERNEL, "%s", compat + strlen("slim"));
> 
> Allocating a new string using string formatting based on an offset from
> a string we don't know the size of, just to tokenize it does not seem
> like the most efficient (nor safe) way of doing this.
> 
> 
> How about:
> 		ret = sscanf(compat, "slim%x,%x", &manf_id, &prod_code);
> 		if (ret != 2)
> 			error();
> 
Looks much better!


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
>> +		if (ret)
>> +			dev_err(dev, "of_slim device register err:%d\n", ret);
> 
> Cleanup if this fails.
Yes, we are leaking memory here, will fix this in next version.
> 
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
> The purpose of ctrl_idr is to generate unique ids for the name and to
> check that slim_del_controller() is only called on valid
> slim_controllers.
> 
> The latter is okay to just expect the controller drivers to do right and
> the prior is better done with an ida.
> 

I agree, IDA seems to be better fit here.

> 
> Also, the lower boundary should be 0, not ctrl->nr.
> 
>> +	mutex_unlock(&slim_lock);
>> +
>> +	if (id < 0)
>> +		return id;
>> +
>> +	ctrl->nr = id;
>> +
>> +	dev_set_name(&ctrl->dev, "sb-%d", ctrl->nr);
> 
> This name is used in a lot of debug prints, can we do better?
> 
In some of the previous discussions with Vinod, it was suggested that 
slim_register_controller should not create an additional device here, 
which is redundant to the actual controller device itself.

So this name would actually come from the controller driver in next 
version of patches.

>> +	ctrl->num_dev = 0;
>> +
>> +	if (!ctrl->min_cg)
>> +		ctrl->min_cg = SLIM_MIN_CLK_GEAR;
>> +	if (!ctrl->max_cg)
>> +		ctrl->max_cg = SLIM_MAX_CLK_GEAR;
>> +
>> +	mutex_init(&ctrl->m_ctrl);
>> +	ret = device_register(&ctrl->dev);
>> +	if (ret)
>> +		goto dev_reg_failed;
>> +
>> +	dev_dbg(&ctrl->dev, "Bus [%s] registered:dev:%p\n",
>> +		ctrl->name, &ctrl->dev);
> 
> This is the only place ctrl->name is used. Perhaps it would make more
> sense to base the dev_name off this string, to make all these dev_*()
> more useful.

Agreed.
> 
>> +
>> +	ctrl->wq = create_singlethread_workqueue(dev_name(&ctrl->dev));
>> +	if (!ctrl->wq)
>> +		goto err_workq_failed;
>> +
>> +	of_register_slim_devices(ctrl);
>> +
>> +	return 0;
>> +
>> +err_workq_failed:
>> +	device_unregister(&ctrl->dev);
>> +dev_reg_failed:
>> +	mutex_lock(&slim_lock);
>> +	idr_remove(&ctrl_idr, ctrl->nr);
>> +	mutex_unlock(&slim_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(slim_register_controller);
>> +
>> +/* slim_remove_device: Remove the effect of slim_add_device() */
>> +static void slim_remove_device(struct slim_device *sbdev)
>> +{
>> +	device_unregister(&sbdev->dev);
>> +}
>> +
>> +static int slim_ctrl_remove_device(struct device *dev, void *null)
>> +{
>> +	slim_remove_device(to_slim_device(dev));
>> +	return 0;
>> +}
>> +
>> +/**
>> + * slim_del_controller: Controller tear-down.
>> + * @ctrl: Controller to tear-down.
>> + */
>> +int slim_del_controller(struct slim_controller *ctrl)
> 
> This is the opposite of slim_register_controller() so should it perhaps
> be called slim_unregister_controller() ?

makes sense..
> 
>> +{
>> +	struct slim_controller *found;
>> +
>> +	/* First make sure that this bus was added */
>> +	mutex_lock(&slim_lock);
>> +	found = idr_find(&ctrl_idr, ctrl->nr);
>> +	mutex_unlock(&slim_lock);
>> +	if (found != ctrl)
>> +		return -EINVAL;
> 
> Just rely on the caller doing the right thing and just
> 	ida_remove(&ctrl_ida, ctrl->nr);

Moving to ida is best

> 
>> +
>> +	/* Remove all clients */
>> +	device_for_each_child(&ctrl->dev, NULL, slim_ctrl_remove_device);
>> +
> 
> As stated above there might be work items left in flight here, after the
> slim_devices are released.
> 
We should flush the workqueue before we remove the devices.

>> 
>> +	destroy_workqueue(ctrl->wq);
>> +
>> +	/* free bus id */
>> +	mutex_lock(&slim_lock);
>> +	idr_remove(&ctrl_idr, ctrl->nr);
>> +	mutex_unlock(&slim_lock);
>> +
>> +	device_unregister(&ctrl->dev);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(slim_del_controller);
> [..]
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
> 
> This will be written before read, so please don't initialize.
> 
yep.

>> +
>> +	dev = device_find_child(&ctrl->dev, e_addr, slim_match_dev);
>> +	if (dev) {
>> +		slim = to_slim_device(dev);
>> +		return slim;
>> +	}
>> +
>> +	slim = kzalloc(sizeof(struct slim_device), GFP_KERNEL);
>> +	if (IS_ERR(slim))
> 
> !slim
yep.

> 
>> +		return NULL;
>> +
>> +	slim->e_addr = *e_addr;
>> +	if (slim_add_device(ctrl, slim) != 0) {
> 
> The idiomatic way is:
> 
> ret = fn();
> if (ret) {
> 	failure...
> }
> 
okay
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
> 
> i will be >= 0, so it can easily be distinguished from -ENXIO. So you
> could return that directly instead of passing "i" as a reference and to
> get the value.
> 
> On the other hand the return value is only used as an offset in addrt[]
> to read out addrt[i].laddr, so perhaps you should just return that
> instead (as an int).
> 
sounds sensible!

>> +			return 0;
>> +		}
>> +	}
>> +	return -ENXIO;
>> +}
>> +
>> +/**
>> + * slim_assign_laddr: Assign logical address to a device enumerated.
> 
> So I presume this will either report a new (not seen before) e_addr
> which should cause a new device to be spawned (although it might be
> already mentioned in DT) or it might be called for an existing device to
> update the logical address.
> 
> Can you describe when the latter is the case? Or is this a side effect
> of the code, rather than slimbus?

If this function is called for an existing device with logical address, 
it would give the same logical address, if it finds a vaild one in the 
table.
Other case is when it does not find a valid on then a new address is 
assigned depending on the valid flag passed to the function.
This case is more to do with the Qualcomm B family Slim controller, 
where linux side can not assign logical address, As DSP would only be 
able to assign this address.

>> + * @ctrl: Controller with which device is enumerated.
>> + * @e_addr: Enumeration address of the device.
>> + * @laddr: Return logical address (if valid flag is false)
>> + * @valid: true if laddr holds a valid address that controller wants to
>> + *	set for this enumeration address. Otherwise framework sets index into
>> + *	address table as logical address.
> 
> How do you ensure this laddr is unique?
Its index into a table which is based on unique enumeration address.

> 
>> + * Called by controller in response to REPORT_PRESENT. Framework will assign
>> + * a logical address to this enumeration address.
>> + * Function returns -EXFULL to indicate that all logical addresses are already
>> + * taken.
>> + */
>> +int slim_assign_laddr(struct slim_controller *ctrl, struct slim_eaddr *e_addr,
>> +		      u8 *laddr, bool valid)
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
> 
> So I presume this updates an existing e_addr -> laddr mapping. But this
> should imply that there is an associated slim_device with this e_addr
> and laddr. Shouldn't said slim_device have its laddr updated then?

If we find a vaild an matching entry in the list, we assume that the 
slim device is already aware of this laddr.


> 
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
> 
> This seems better handled by a list than an array that we realloc. But
> better yet, this array seems to mirror the list of registered devices.
> 
> So why doesn't this function just try to resolve the slim_device with
> e_addr and if not allocate a new slim_device with a free laddr. Using an
> ida to keep track of used logical addresses would make this much
> cleaner.
> 
> Or a idr keyed by the laddr, it would still be O(n) to scan based on
> e_addr, but this logic as well as lookups by laddr would be cleaner.
> 
I will give this a try before sending next version and see how it looks!

>> +		ctrl->addrt[i].eaddr = *e_addr;
>> +		ctrl->addrt[i].valid = true;
>> +
>> +		/* Preferred address is index into table */
>> +		if (!valid)
>> +			*laddr = i;
> 
> Is this laddr available?
this is the new index or first instance of invalid entry in the table, 
so it should be available.
> 
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
> 
> I can't help feeling that this is the one and only point where you
> should call probe() on the slim_device. Are there some funky
> dependencies or protocol issues that makes this infeasible?

The reason probe is called earlier because the slim device needs 
power-up or reset sequence to make it discoverable on the bus.

> 
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
> 
> In what case would e_addr != sb->e_addr and why can't this function just
> be return sb->laddr?
> 
I don't think e_addr and sb->eaddr should be different in this case.

In usecase like B family Qualcomm SOCs, where linux cannot assign 
logical address, It needs to get logical address from ADSP and then use 
that. Current model of get_logical_addr provides abstraction so that 
this ADSP communication to get logical addr is hidden from client.


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
> [..]
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_VERSION("0.1");
> 
> Who will ever update this version number? It's probably better to just
> omit it.
>
Yep.

>> +MODULE_DESCRIPTION("Slimbus module");
> 
> Rather than "Slimbus module", this is actually the "Slimbus core".
> 
Yep.
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> [..]
>> +extern struct bus_type slimbus_type;
> 
> The device struct has a "struct device_type *type", which causes this
> name to be confusing. Please rename it slimbus_bus instead.
> 
> Why does this bus_type have to be known to the world?
May be not. can be removed.
> 
>> +
>> +/* Standard values per SLIMbus spec needed by controllers and devices */
>> +#define SLIM_CL_PER_SUPERFRAME		6144
>> +#define SLIM_CL_PER_SUPERFRAME_DIV8	(SLIM_CL_PER_SUPERFRAME >> 3)
>> +#define SLIM_MAX_CLK_GEAR		10
>> +#define SLIM_MIN_CLK_GEAR		1
>> +#define SLIM_CL_PER_SL			4
>> +#define SLIM_SL_PER_SUPERFRAME		(SLIM_CL_PER_SUPERFRAME >> 2)
>> +#define SLIM_FRM_SLOTS_PER_SUPERFRAME	16
>> +#define SLIM_GDE_SLOTS_PER_SUPERFRAME	2
> 
> Keep the min/max here and move the rest to the patches that introduce
> consumers of them.

makes sense!

> 
> [..]
>> +/* SLIMbus message types. Related to interpretation of message code. */
>> +#define SLIM_MSG_MT_CORE			0x0
>> +#define SLIM_MSG_MT_DEST_REFERRED_CLASS		0x1
>> +#define SLIM_MSG_MT_DEST_REFERRED_USER		0x2
>> +#define SLIM_MSG_MT_SRC_REFERRED_CLASS		0x5
>> +#define SLIM_MSG_MT_SRC_REFERRED_USER		0x6
> 
> These are not currently used, move them to the patch that actually use
> them.
> 
>> +
>> +/* SLIMbus core type Message Codes. */
>> +/* Device management messages used by this framework */
>> +#define SLIM_MSG_MC_REPORT_PRESENT               0x1
>> +#define SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS       0x2
>> +#define SLIM_MSG_MC_REPORT_ABSENT                0xF
> 
> Dito
> 
>> +
>> +/* Destination type Values */
>> +#define SLIM_MSG_DEST_LOGICALADDR	0
>> +#define SLIM_MSG_DEST_ENUMADDR		1
>> +#define	SLIM_MSG_DEST_BROADCAST		3
> 
> Dito

will do it in next version.


> 
>> +
>> +/**
>> + * struct slim_controller: Controls every instance of SLIMbus
>> + *				(similar to 'master' on SPI)
>> + *	'Manager device' is responsible for  device management, bandwidth
>> + *	allocation, channel setup, and port associations per channel.
>> + *	Device management means Logical address assignment/removal based on
>> + *	enumeration (report-present, report-absent) if a device.
>> + *	Bandwidth allocation is done dynamically by the manager based on active
>> + *	channels on the bus, message-bandwidth requests made by slimbus devices.
>> + *	Based on current bandwidth usage, manager chooses a frequency to run
>> + *	the bus at (in steps of 'clock-gear', 1 through 10, each clock gear
>> + *	representing twice the frequency than the previous gear).
>> + *	Manager is also responsible for entering (and exiting) low-power-mode
>> + *	(known as 'clock pause').
>> + *	Manager can do handover of framer if there are multiple framers on the
>> + *	bus and a certain usecase warrants using certain framer to avoid keeping
>> + *	previous framer being powered-on.
>> + *
>> + *	Controller here performs duties of the manager device, and 'interface
>> + *	device'. Interface device is responsible for monitoring the bus and
>> + *	reporting information such as loss-of-synchronization, data
>> + *	slot-collision.
>> + * @dev: Device interface to this driver
>> + * @nr: Board-specific number identifier for this controller/bus
>> + * @list: Link with other slimbus controllers
>> + * @name: Name for this controller
>> + * @min_cg: Minimum clock gear supported by this controller (default value: 1)
>> + * @max_cg: Maximum clock gear supported by this controller (default value: 10)
>> + * @clkgear: Current clock gear in which this bus is running
>> + * @a_framer: Active framer which is clocking the bus managed by this controller
>> + * @m_ctrl: Mutex protecting controller data structures
> 
> This mutex protects operations on the addrt array, so both name and
> documentation can be improved.
Agreed, will address this in next version.

> 
>> + * @addrt: Logical address table
> 
> Consider replacing with a idr, keyed by laddr. If there's actually a
> point in having this list...
> 
>> + * @num_dev: Number of active slimbus slaves on this bus
> 
> This is not so much "number of devices", but rather the length of @addrt.

lenght of addrt might be more than active devices as some of the entries 
in addrt are not valid after the device goes down.


> 
>> + * @wq: Workqueue per controller used to notify devices when they report present
>> + * @xfer_msg: Transfer a message on this controller (this can be a broadcast
>> + *	control/status message like data channel setup, or a unicast message
>> + *	like value element read/write.
>> + * @set_laddr: Setup logical address at laddr for the slave with elemental
>> + *	address e_addr. Drivers implementing controller will be expected to
>> + *	send unicast message to this device with its logical address.
>> + * @get_laddr: It is possible that controller needs to set fixed logical
>> + *	address table and get_laddr can be used in that case so that controller
>> + *	can do this assignment.
> 
> Can you describe the use case for get_laddr() a little bit more?

Usecase is  for  B family Qualcomm SOCs, where linux cannot assign 
logical address, It needs to get logical address from ADSP and then use 
that. Current model of get_logical_addr provides abstraction so that 
this ADSP communication to get logical addr is hidden from client.

> 
>> + */
>> +struct slim_controller {
>> +	struct device		dev;
>> +	unsigned int		nr;
>> +	char			name[SLIMBUS_NAME_SIZE];
>> +	int			min_cg;
>> +	int			max_cg;
>> +	int			clkgear;
>> +	struct slim_framer	*a_framer;
>> +	struct mutex		m_ctrl;
>> +	struct slim_addrt	*addrt;
>> +	u8			num_dev;
>> +	struct workqueue_struct *wq;
>> +	int			(*set_laddr)(struct slim_controller *ctrl,
>> +					     struct slim_eaddr *ea, u8 laddr);
>> +	int			(*get_laddr)(struct slim_controller *ctrl,
>> +					     struct slim_eaddr *ea, u8 *laddr);
> 
> If nothing else I think this should return the laddr, rather than pass
> it back into the referenced u8.

I will give it a go and see how it fits with every thing around it.

> 
>> +};
>> +
> 
> Regards,
> Bjorn
> 
