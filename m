From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Tue, 10 Oct 2017 16:15:09 +0530
Message-ID: <20171010104509.GC30097@localhost>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-2-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, kheitke-hxvC4TZJLZFWk0Htik3J/w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 06, 2017 at 05:51:30PM +0200, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> developed by MIPI (Mobile Industry Processor Interface) alliance.
> SLIMbus is a 2-wire implementation, which is used to communicate with
> peripheral components like audio-codec.
> SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
> channels, and control channel. Control channel has messages to do
> device-enumeration, messages to send/receive control-data to/from
> slimbus devices, messages for port/channel management, and messages to
> do bandwidth allocation.
> The framework supports multiple instances of the bus (1 controller per
> bus), and multiple slave devices per controller.
> 
> This patch does device enumeration, logical address assignment,
> informing device when the device reports present/absent etc.
> Reporting present may need the driver to do the needful (e.g. turning
> on voltage regulators powering the device). Additionally device is
> probed when it reports present if that device doesn't need any such
> steps mentioned above.
> 
> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/slimbus/bus.txt |  57 ++
>  Documentation/slimbus/summary                     | 109 ++++
>  drivers/Kconfig                                   |   2 +
>  drivers/Makefile                                  |   1 +
>  drivers/slimbus/Kconfig                           |  11 +
>  drivers/slimbus/Makefile                          |   5 +
>  drivers/slimbus/slim-core.c                       | 695 ++++++++++++++++++++++
>  include/linux/mod_devicetable.h                   |  13 +
>  include/linux/slimbus.h                           | 299 ++++++++++
>  9 files changed, 1192 insertions(+)

thats a lot of code for review, consider splitting it up further for better
reviews

>  create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
>  create mode 100644 Documentation/slimbus/summary
>  create mode 100644 drivers/slimbus/Kconfig
>  create mode 100644 drivers/slimbus/Makefile
>  create mode 100644 drivers/slimbus/slim-core.c

how about core.c (https://lkml.org/lkml/2017/7/12/430)

> +static const struct slim_device_id *slim_match(const struct slim_device_id *id,
> +					       const struct slim_device *sbdev)
> +{
> +	while (id->manf_id != 0 || id->prod_code != 0) {
> +		if (id->manf_id == sbdev->e_addr.manf_id &&
> +		    id->prod_code == sbdev->e_addr.prod_code &&
> +		    id->dev_index == sbdev->e_addr.dev_index)
> +			return id;
> +		id++;
> +	}
> +	return NULL;
> +}
> +
> +static int slim_device_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct slim_device *sbdev = to_slim_device(dev);
> +	struct slim_driver *sbdrv = to_slim_driver(drv);
> +
> +	/* Attempt an OF style match first */
> +	if (of_driver_match_device(dev, drv))
> +		return 1;

is of_driver_match_device() a must have here? (I dont completely understand
DT so pardon my ignorance). Since we have devices with ids can we use that
alone for matching?

> +
> +	/* Then try to match against the id table */
> +	if (sbdrv->id_table)
> +		return slim_match(sbdrv->id_table, sbdev) != NULL;
> +
> +	return 0;
> +}
> +

rather than jumping now to reporting APIs, can we club all bus_type parts to
one place (patch) so that it is easier to review logically

> +struct sb_report_wd {
> +	struct work_struct wd;
> +	struct slim_device *sbdev;
> +	bool report;
> +};
> +
> +static void slim_report(struct work_struct *work)
> +{
> +	struct slim_driver *sbdrv;
> +	struct sb_report_wd *sbw = container_of(work, struct sb_report_wd, wd);
> +	struct slim_device *sbdev = sbw->sbdev;
> +
> +	mutex_lock(&sbdev->report_lock);
> +	if (!sbdev->dev.driver)
> +		goto report_exit;
> +
> +	/* check if device-up or down needs to be called */
> +	if ((!sbdev->reported && !sbdev->notified) ||
> +	    (sbdev->reported && sbdev->notified))
> +		goto report_exit;
> +
> +	sbdrv = to_slim_driver(sbdev->dev.driver);
> +
> +	/**
> +	 * address no longer valid, means device reported absent, whereas
> +	 * address valid, means device reported present
> +	 */

I think ppl commented about this style, so lets fix those issues

> +	if (sbdev->notified && !sbdev->reported) {
> +		sbdev->notified = false;
> +		if (sbdrv->device_down)
> +			sbdrv->device_down(sbdev);
> +	} else if (!sbdev->notified && sbdev->reported) {
> +		sbdev->notified = true;
> +		if (sbdrv->device_up)
> +			sbdrv->device_up(sbdev);

what do the device_up/down calls signify here?

> +static int slim_device_probe(struct device *dev)
> +{
> +	struct slim_device	*sbdev;
> +	struct slim_driver	*sbdrv;
> +	int status = 0;
> +
> +	sbdev = to_slim_device(dev);
> +	sbdrv = to_slim_driver(dev->driver);
> +
> +	sbdev->driver = sbdrv;
> +
> +	if (sbdrv->probe)
> +		status = sbdrv->probe(sbdev);
> +
> +	if (status)
> +		sbdev->driver = NULL;
> +	else if (sbdrv->device_up)
> +		schedule_slim_report(sbdev->ctrl, sbdev, true);

can you please explain what this is trying to do?

> +int __slim_driver_register(struct slim_driver *drv, struct module *owner)
> +{
> +	drv->driver.bus = &slimbus_type;
> +	drv->driver.owner = owner;
> +	return driver_register(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(__slim_driver_register);

any reason to use __ for this API?

> +static int slim_add_device(struct slim_controller *ctrl,
> +			   struct slim_device *sbdev)
> +{
> +	sbdev->dev.bus = &slimbus_type;
> +	sbdev->dev.parent = &ctrl->dev;
> +	sbdev->dev.release = slim_dev_release;
> +	sbdev->dev.driver = NULL;
> +	sbdev->ctrl = ctrl;
> +
> +	slim_ctrl_get(ctrl);
> +	sbdev->name = kasprintf(GFP_KERNEL, "%x:%x:%x:%x",
> +					sbdev->e_addr.manf_id,
> +					sbdev->e_addr.prod_code,
> +					sbdev->e_addr.dev_index,
> +					sbdev->e_addr.instance);
> +	if (!sbdev->name)
> +		return -ENOMEM;
> +
> +	dev_set_name(&sbdev->dev, "%s", sbdev->name);
> +	mutex_init(&sbdev->report_lock);
> +
> +	/* probe slave on this controller */
> +	return device_register(&sbdev->dev);

I dont think the comment is quite correct, you register a device not probe!

> +/* OF helpers for SLIMbus */
> +static void of_register_slim_devices(struct slim_controller *ctrl)
> +{
> +	struct device *dev = &ctrl->dev;
> +	struct device_node *node;
> +
> +	if (!ctrl->dev.of_node)
> +		return;
> +
> +	for_each_child_of_node(ctrl->dev.of_node, node) {
> +		struct slim_device *slim;
> +		const char *compat = NULL;
> +		char *p, *tok;
> +		int reg[2], ret;
> +
> +		slim = kzalloc(sizeof(*slim), GFP_KERNEL);
> +		if (!slim)
> +			continue;
> +
> +		slim->dev.of_node = of_node_get(node);
> +
> +		compat = of_get_property(node, "compatible", NULL);
> +		if (!compat)
> +			continue;
> +
> +		p = kasprintf(GFP_KERNEL, "%s", compat + strlen("slim"));
> +
> +		tok = strsep(&p, ",");
> +		if (!tok) {
> +			dev_err(dev, "No valid Manufacturer ID found\n");
> +			kfree(p);
> +			continue;
> +		}
> +		slim->e_addr.manf_id = str2hex(tok);
> +
> +		tok = strsep(&p, ",");
> +		if (!tok) {
> +			dev_err(dev, "No valid Product ID found\n");
> +			kfree(p);
> +			continue;
> +		}
> +		slim->e_addr.prod_code = str2hex(tok);
> +		kfree(p);
> +
> +		ret = of_property_read_u32_array(node, "reg", reg, 2);
> +		if (ret) {
> +			dev_err(dev, "Device and Instance id not found:%d\n",
> +				ret);
> +			continue;
> +		}
> +		slim->e_addr.dev_index = reg[0];
> +		slim->e_addr.instance = reg[1];
> +
> +		ret = slim_add_device(ctrl, slim);

okay this is good stuff. So we scan the DT for slimbus devices and register
them here. Same stuff we can do with ACPI :)

then why do we need the of register stuff I commented earlier. A Slimbus
device can work irrespective of firmware type and registers using various
ids. The platform will scan firmware (dt/acpi) create devices and load
drivers against them generically.  Apart from this code we ideally should
not have any DT parts in the bus, do you agree?

> +		if (ret)
> +			dev_err(dev, "of_slim device register err:%d\n", ret);
> +	}
> +}
> +
> +/**
> + * slim_register_controller: Controller bring-up and registration.
> + * @ctrl: Controller to be registered.
> + * A controller is registered with the framework using this API.
> + * If devices on a controller were registered before controller,
> + * this will make sure that they get probed when controller is up
> + */
> +int slim_register_controller(struct slim_controller *ctrl)
> +{
> +	int id, ret = 0;
> +
> +	mutex_lock(&slim_lock);
> +	id = idr_alloc(&ctrl_idr, ctrl, ctrl->nr, -1, GFP_KERNEL);

what are these ids used for?

> +	mutex_unlock(&slim_lock);
> +
> +	if (id < 0)
> +		return id;
> +
> +	ctrl->nr = id;
> +
> +	dev_set_name(&ctrl->dev, "sb-%d", ctrl->nr);
> +	ctrl->num_dev = 0;
> +
> +	if (!ctrl->min_cg)
> +		ctrl->min_cg = SLIM_MIN_CLK_GEAR;
> +	if (!ctrl->max_cg)
> +		ctrl->max_cg = SLIM_MAX_CLK_GEAR;
> +
> +	mutex_init(&ctrl->m_ctrl);
> +	ret = device_register(&ctrl->dev);

one more device_register?? Can you explain why

> +/**
> + * struct slim_addrt: slimbus address used internally by the slimbus framework.
> + * @valid: If the device is present. Valid is set to false when device reports
> + *	absent.
> + * @eaddr: Enumeration address
> + * @laddr: It is possible that controller will set a predefined logical address
> + *	rather than the one assigned by framework. (i.e. logical address may
> + *	not be same as index into this table). This entry will store the
> + *	logical address value for this enumeration address.
> + */
> +struct slim_addrt {

addrt? why not just addr?

> +	bool			valid;
> +	struct slim_eaddr	eaddr;
> +	u8			laddr;
> +};
> +
> +/* SLIMbus message types. Related to interpretation of message code. */
> +#define SLIM_MSG_MT_CORE			0x0
> +#define SLIM_MSG_MT_DEST_REFERRED_CLASS		0x1
> +#define SLIM_MSG_MT_DEST_REFERRED_USER		0x2
> +#define SLIM_MSG_MT_SRC_REFERRED_CLASS		0x5
> +#define SLIM_MSG_MT_SRC_REFERRED_USER		0x6

BIT() GENMASK() please here and other places where they define bits in spec

> +/**
> + * struct slim_driver: Slimbus 'generic device' (slave) device driver
> + *				(similar to 'spi_device' on SPI)
> + * @probe: Binds this driver to a slimbus device.
> + * @remove: Unbinds this driver from the slimbus device.
> + * @shutdown: Standard shutdown callback used during powerdown/halt.
> + * @suspend: Standard suspend callback used during system suspend
> + * @resume: Standard resume callback used during system resume
> + * @device_up: This callback is called when the device reports present and
> + *		gets a logical address assigned to it
> + * @device_down: This callback is called when device reports absent, or the
> + *		bus goes down. Device will report present when bus is up and
> + *		device_up callback will be called again when that happens

do we need two callback, why not a status or notify callback with argument
for up/down?

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
