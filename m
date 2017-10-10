From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [Patch v6 1/7] slimbus: Device management on
	SLIMbus
Date: Tue, 10 Oct 2017 22:19:30 +0530
Message-ID: <20171010164930.GD30097@localhost>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171010104509.GC30097@localhost>
 <fd966acd-a86c-5021-8a8b-ddf1508ab63e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BA58266B38
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 18:45:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fd966acd-a86c-5021-8a8b-ddf1508ab63e@linaro.org>
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
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, gregkh@linuxfoundation.org, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 10, 2017 at 01:34:55PM +0100, Srinivas Kandagatla wrote:
> >>  9 files changed, 1192 insertions(+)
> >
> >thats a lot of code for review, consider splitting it up further for better
> >reviews
> 
> Its was suggested that parts of dtbindings and of_* wrapper merged into this
> patch.  In V5 review comments. https://lkml.org/lkml/2016/4/28/175

yes but it can still be split :)


> >>+static const struct slim_device_id *slim_match(const struct slim_device_id *id,
> >>+					       const struct slim_device *sbdev)
> >>+{
> >>+	while (id->manf_id != 0 || id->prod_code != 0) {
> >>+		if (id->manf_id == sbdev->e_addr.manf_id &&
> >>+		    id->prod_code == sbdev->e_addr.prod_code &&
> >>+		    id->dev_index == sbdev->e_addr.dev_index)
> >>+			return id;
> >>+		id++;
> >>+	}
> >>+	return NULL;
> >>+}
> >>+
> >>+static int slim_device_match(struct device *dev, struct device_driver *drv)
> >>+{
> >>+	struct slim_device *sbdev = to_slim_device(dev);
> >>+	struct slim_driver *sbdrv = to_slim_driver(drv);
> >>+
> >>+	/* Attempt an OF style match first */
> >>+	if (of_driver_match_device(dev, drv))
> >>+		return 1;
> >
> >is of_driver_match_device() a must have here? (I dont completely understand
> Yes, we need this to match the compatible string from device tree vs driver
> itself, most of the bus driver do this in bus match functions.
> 
> 
> >DT so pardon my ignorance). Since we have devices with ids can we use that
> >alone for matching?
> 
> Two cases to consider here,
> 1> If the device is up and discoverable.
> 2> Device is not discoverable yet, as it needs some power up sequence.
> 
> 
> In first case comparing with ID table makes sense.
> 
> But second case we would want to probe the device(for power sequencing)
> before we can discover the device on bus.
> 
> 
> This code as it is supports both DT and id_table.

Why not only id_table, see below:

> >>+	if (sbdev->notified && !sbdev->reported) {
> >>+		sbdev->notified = false;
> >>+		if (sbdrv->device_down)
> >>+			sbdrv->device_down(sbdev);
> >>+	} else if (!sbdev->notified && sbdev->reported) {
> >>+		sbdev->notified = true;
> >>+		if (sbdrv->device_up)
> >>+			sbdrv->device_up(sbdev);
> >
> >what do the device_up/down calls signify here?
> >
> up would be called when a device is discovered on the bus, and down on when
> the device disappeared on slimbus.
> 
> >>+static int slim_device_probe(struct device *dev)
> >>+{
> >>+	struct slim_device	*sbdev;
> >>+	struct slim_driver	*sbdrv;
> >>+	int status = 0;
> >>+
> >>+	sbdev = to_slim_device(dev);
> >>+	sbdrv = to_slim_driver(dev->driver);
> >>+
> >>+	sbdev->driver = sbdrv;
> >>+
> >>+	if (sbdrv->probe)
> >>+		status = sbdrv->probe(sbdev);
> >>+
> >>+	if (status)
> >>+		sbdev->driver = NULL;
> >>+	else if (sbdrv->device_up)
> >>+		schedule_slim_report(sbdev->ctrl, sbdev, true);
> >
> >can you please explain what this is trying to do?
> 
> It is scheduling a device_up() callback in workqueue for reporting
> discovered device.

any reason for that? Would the device not announce itself on the bus and
then you can synchronously update the device.

> >>+int __slim_driver_register(struct slim_driver *drv, struct module *owner)
> >>+{
> >>+	drv->driver.bus = &slimbus_type;
> >>+	drv->driver.owner = owner;
> >>+	return driver_register(&drv->driver);
> >>+}
> >>+EXPORT_SYMBOL_GPL(__slim_driver_register);
> >
> >any reason to use __ for this API?
> 
> This is made inline with __platfrom_driver_register() suggested in v5
> review.

I guess Greg is best person to make this call :)

> >>+static void of_register_slim_devices(struct slim_controller *ctrl)
> >>+{
> >>+	struct device *dev = &ctrl->dev;
> >>+	struct device_node *node;
> >>+
> >>+	if (!ctrl->dev.of_node)
> >>+		return;
> >>+
> >>+	for_each_child_of_node(ctrl->dev.of_node, node) {
> >>+		struct slim_device *slim;
> >>+		const char *compat = NULL;
> >>+		char *p, *tok;
> >>+		int reg[2], ret;
> >>+
> >>+		slim = kzalloc(sizeof(*slim), GFP_KERNEL);
> >>+		if (!slim)
> >>+			continue;
> >>+
> >>+		slim->dev.of_node = of_node_get(node);
> >>+
> >>+		compat = of_get_property(node, "compatible", NULL);
> >>+		if (!compat)
> >>+			continue;
> >>+
> >>+		p = kasprintf(GFP_KERNEL, "%s", compat + strlen("slim"));
> >>+
> >>+		tok = strsep(&p, ",");
> >>+		if (!tok) {
> >>+			dev_err(dev, "No valid Manufacturer ID found\n");
> >>+			kfree(p);
> >>+			continue;
> >>+		}
> >>+		slim->e_addr.manf_id = str2hex(tok);
> >>+
> >>+		tok = strsep(&p, ",");
> >>+		if (!tok) {
> >>+			dev_err(dev, "No valid Product ID found\n");
> >>+			kfree(p);
> >>+			continue;
> >>+		}
> >>+		slim->e_addr.prod_code = str2hex(tok);
> >>+		kfree(p);
> >>+
> >>+		ret = of_property_read_u32_array(node, "reg", reg, 2);
> >>+		if (ret) {
> >>+			dev_err(dev, "Device and Instance id not found:%d\n",
> >>+				ret);
> >>+			continue;
> >>+		}
> >>+		slim->e_addr.dev_index = reg[0];
> >>+		slim->e_addr.instance = reg[1];
> >>+
> >>+		ret = slim_add_device(ctrl, slim);
> >
> >okay this is good stuff. So we scan the DT for slimbus devices and register
> >them here. Same stuff we can do with ACPI :)
> >
> >then why do we need the of register stuff I commented earlier. A Slimbus
> >device can work irrespective of firmware type and registers using various
> >ids. The platform will scan firmware (dt/acpi) create devices and load
> >drivers against them generically.  Apart from this code we ideally should
> >not have any DT parts in the bus, do you agree?
> 
> I partly agree with you, as all the devices on slimbus might not be in a
> discoverable state. Such devices would need some sort of power up sequence
> which what the of_wrapper and the match function are trying to achieve.
> Driver probe will be called based on the compatible match which would then
> power up/reset the device so that it can announce itself and the device_up()
> would be called at that point.
> 
> Your comment is 100% true, If the devices are in discoverable state, in such
> case we would not need any DT entires as you said.

Yes you are right. Since the device need to be powered up thru side band we
cannot live without using firmware (acpi/dt)

Now consider the below scheme:
 - The Bus scans device node of the controller (acpi/dt), as
   above and find the slim devices and adds them. The ID needs to be
   extracted from firmware (acpi/dt), we sure need to set the right firmware
   node for the device
 - Drivers register based on ID, no need to make it DT/ACPI aware
 - Match function is invoked and driver probed
 - Sideband mechanism kick in and power up device and it announces on the
   bus

In case it is already powered up, it can announce being up earlier.

FWIW i am using above method with ACPI on SoundWire.

> 
> >
> >>+		if (ret)
> >>+			dev_err(dev, "of_slim device register err:%d\n", ret);
> >>+	}
> >>+}
> >>+
> >>+/**
> >>+ * slim_register_controller: Controller bring-up and registration.
> >>+ * @ctrl: Controller to be registered.
> >>+ * A controller is registered with the framework using this API.
> >>+ * If devices on a controller were registered before controller,
> >>+ * this will make sure that they get probed when controller is up
> >>+ */
> >>+int slim_register_controller(struct slim_controller *ctrl)
> >>+{
> >>+	int id, ret = 0;
> >>+
> >>+	mutex_lock(&slim_lock);
> >>+	id = idr_alloc(&ctrl_idr, ctrl, ctrl->nr, -1, GFP_KERNEL);
> >
> >what are these ids used for?
> 
> I think these are the controller ids, just to create a proper name space for
> each controller.
> 
> >
> >>+	mutex_unlock(&slim_lock);
> >>+
> >>+	if (id < 0)
> >>+		return id;
> >>+
> >>+	ctrl->nr = id;
> >>+
> >>+	dev_set_name(&ctrl->dev, "sb-%d", ctrl->nr);
> >>+	ctrl->num_dev = 0;
> >>+
> >>+	if (!ctrl->min_cg)
> >>+		ctrl->min_cg = SLIM_MIN_CLK_GEAR;
> >>+	if (!ctrl->max_cg)
> >>+		ctrl->max_cg = SLIM_MAX_CLK_GEAR;
> >>+
> >>+	mutex_init(&ctrl->m_ctrl);
> >>+	ret = device_register(&ctrl->dev);
> >
> >one more device_register?? Can you explain why
> >
> 
> This is a device for each controller.

wont the controller have its own platform_device?

-- 
~Vinod
