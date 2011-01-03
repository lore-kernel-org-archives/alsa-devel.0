From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 2/3] ECI: introducing ECI bus driver
Date: Mon, 03 Jan 2011 10:42:20 +0200
Message-ID: <4D218BEC.7010503@nokia.com>
References: <1293716219-26089-1-git-send-email-tapio.vihuri@nokia.com>	<1293716219-26089-2-git-send-email-tapio.vihuri@nokia.com>
	<1293716219-26089-3-git-send-email-tapio.vihuri@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 54A9C103870
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 09:42:33 +0100 (CET)
In-Reply-To: <1293716219-26089-3-git-send-email-tapio.vihuri@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext tapio.vihuri@nokia.com" <tapio.vihuri@nokia.com>
Cc: randy.dunlap@oracle.com, alsa-devel@alsa-project.org, samu.p.onkalo@nokia.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 12/30/10 15:36, ext tapio.vihuri@nokia.com wrote:
> From: Tapio Vihuri <tapio.vihuri@nokia.com>
> =

> ECI bus controller is kind of bridge between host CPU I2C and ECI accesso=
ry
> ECI communication.

It is kind of misleading to call this driver as a bus driver IMHO.
For what I gathered, this is a driver for a micro-controller, which
implements the ECI communication.
This could be a generic driver for the micro-controller, but two lines
makes it x86 specific...

...

> +#include <asm/intel_scu_ipc.h>

...

> +static int __init ecibus_probe(struct platform_device *pdev)
> +{
> +       struct ecibus_data *ed;
> +       struct ecibus_platform_data *pdata =3D pdev->dev.platform_data;
> +       struct i2c_adapter *adapter;
> +       int ret;
> +
> +       if (!pdata) {
> +               dev_err(&pdev->dev, "platform_data not available: %d\n",
> +                               __LINE__);
> +               return -EINVAL;
> +       }
> +
> +       ed =3D kzalloc(sizeof(*ed), GFP_KERNEL);
> +       if (!ed)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, ed);
> +       ed->dev =3D &pdev->dev;
> +       ed->ecibus_rst_gpio =3D pdata->ecibus_rst_gpio;
> +       ed->ecibus_sw_ctrl_gpio =3D pdata->ecibus_sw_ctrl_gpio;
> +       ed->ecibus_int_gpio =3D pdata->ecibus_int_gpio;
> +
> +       if (ed->ecibus_rst_gpio =3D=3D 0 || ed->ecibus_sw_ctrl_gpio =3D=
=3D 0 ||
> +                       ed->ecibus_int_gpio =3D=3D 0) {
> +               ret =3D -ENXIO;
> +               goto gpio_err;
> +       }
> +
> +       the_ed =3D ed;
> +
> +       adapter =3D i2c_get_adapter(1);

What happens if the mc is on another bus?
Shall you have platform data for this?
Or even better, use i2c device/driver probing for this driver?

> +       if (adapter)
> +               ed->client =3D i2c_new_device(adapter, &ecibus_i2c);
> +       if (!ed->client) {
> +               dev_err(ed->dev, "could not get i2c device %s at 0x%02x: =
%d\n",
> +                               ecibus_i2c.type, ecibus_i2c.addr, __LINE_=
_);
> +               kfree(ed);
> +
> +               return -ENODEV;
> +       }
> +
> +       ret =3D ecibus_initialize_debugfs(ed);
> +       if (ret)
> +               dev_err(ed->dev, "could not create debugfs entries: %d\n",
> +                               __LINE__);
> +
> +       ret =3D gpio_request(ed->ecibus_rst_gpio, "ECI_RSTn");
> +       if (ret) {
> +               dev_err(ed->dev, "could not request ECI_RSTn gpio %d: %d\=
n",
> +                               ed->ecibus_rst_gpio, __LINE__);
> +               goto rst_gpio_err;
> +       }
> +
> +       gpio_direction_output(ed->ecibus_rst_gpio, 0);
> +       gpio_set_value(ed->ecibus_rst_gpio, 1);
> +
> +       ret =3D gpio_request(ed->ecibus_sw_ctrl_gpio, "ECI_SW_CTRL");
> +       if (ret) {
> +               dev_err(ed->dev, "could not request ECI_SW_CTRL gpio %d: =
%d\n",
> +                               ed->ecibus_sw_ctrl_gpio, __LINE__);
> +               goto sw_ctrl_gpio_err;
> +       }
> +
> +       gpio_direction_input(ed->ecibus_sw_ctrl_gpio);
> +
> +       ret =3D gpio_request(ed->ecibus_int_gpio, "ECI_INT");
> +       if (ret) {
> +               dev_err(ed->dev, "could not request ECI_INT gpio %d: %d\n=
",
> +                               ed->ecibus_int_gpio, __LINE__);
> +               goto int_gpio_err;
> +       }
> +
> +       gpio_direction_input(ed->ecibus_int_gpio);
> +
> +       ret =3D request_threaded_irq(gpio_to_irq(ed->ecibus_int_gpio), NU=
LL,
> +                       ecibus_irq_handler, IRQF_TRIGGER_RISING, "ECI_INT=
", ed);
> +       if (ret) {
> +               dev_err(ed->dev, "could not request irq %d: %d\n",
> +                               gpio_to_irq(ed->ecibus_int_gpio), __LINE_=
_);
> +               goto int_irq_err;
> +       }
> +
> +       /* Register itself to the ECI accessory driver */
> +       ed->eci_callback =3D eci_register(&ecibus_hw_ops);
> +       if (IS_ERR(ed->eci_callback)) {
> +               ret =3D PTR_ERR(ed->eci_callback);
> +               goto eci_register_err;
> +
> +       }
> +
> +       /*
> +        * Turn on vprog2
> +        * Some decent power ctrl interface, please
> +        */
> +       intel_scu_ipc_iowrite8(AvP_MSIC_VPROG2, AvP_MSIC_VPROG2_2V5_ON);

Is this some sort of power enable for the controller itself?
If it is, why not use a callback from the platform to enable/disable the
power, so the driver will be platform independent, and you do this intel
specific thing in arch/ platform code.
If this is not related to the mc itself, then this shall not be part of
this driver.

...

> +static int __exit ecibus_remove(struct platform_device *pdev)
> +{
> +       struct ecibus_data *ed =3D platform_get_drvdata(pdev);
> +
> +       gpio_set_value(ed->ecibus_rst_gpio, 0);
> +       gpio_free(ed->ecibus_rst_gpio);
> +
> +       gpio_free(ed->ecibus_sw_ctrl_gpio);
> +
> +       free_irq(gpio_to_irq(ed->ecibus_int_gpio), ed);
> +       gpio_free(ed->ecibus_int_gpio);
> +
> +       ecibus_uninitialize_debugfs();
> +       i2c_unregister_device(ed->client);
> +
> +       /*
> +        * Turn off vprog2
> +        * Some decent power ctrl interface, please
> +        */
> +       intel_scu_ipc_iowrite8(AvP_MSIC_VPROG2, AvP_MSIC_VPROG2_2V5_OFF);

Same applies here for the intel dependency.

-- =

P=E9ter
