From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v4 9/9] davinci: USB1.1 support for
	Omapl138-Hawkboard
Date: Mon, 18 Oct 2010 09:59:26 -0500
Message-ID: <AANLkTin1QcX8E0LBWxQXx4c3461s8FBpnTW773sPk=Jo@mail.gmail.com>
References: <1287112105-11968-1-git-send-email-vm.rod25@gmail.com>
	<1287112105-11968-10-git-send-email-vm.rod25@gmail.com>
	<4CB88230.7000501@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 51058103820
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 16:59:31 +0200 (CEST)
Received: by gyg10 with SMTP id 10so547549gyg.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 07:59:28 -0700 (PDT)
In-Reply-To: <4CB88230.7000501@mvista.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, khasim@ti.com, alsa-devel@alsa-project.org, caglarakyuz@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 15, 2010 at 11:32 AM, Sergei Shtylyov <sshtylyov@mvista.com> wr=
ote:
> Hello.
>
> On 10/15/10 07:08, vm.rod25@gmail.com wrote:
>
>> From: Victor Rodriguez<victor.rodriguez@sasken.com>
>
>> This patch adds USB1.1 support for the Hawkboard-L138 system
>
>> Signed-off-by: Victor Rodriguez<victor.rodriguez@sasken.com>
>
> [...]
>
>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> index 87dea28..4658498 100644
>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>
> [...]
>>
>> @@ -178,6 +181,109 @@ static struct davinci_mmc_config da850_mmc_config =
=3D
>> {
>> =A0 =A0 =A0 =A0.version =A0 =A0 =A0 =A0=3D MMC_CTLR_VERSION_2,
>> =A0};
>>
>> +static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
>> +static da8xx_ocic_handler_t hawk_usb_ocic_handler;
>> +
>> +static const short da850_hawk_usb11_pins[] =3D {
>> + =A0 =A0 =A0 DA850_GPIO2_4, DA850_GPIO6_13,
>> + =A0 =A0 =A0 -1
>> +};
>
> =A0 An empty wouldn't hurt here. Sorry if I overlooked this before...
>
>> +static int hawk_usb_set_power(unsigned port, int on)
>> +{
>> + =A0 =A0 =A0 gpio_set_value(DA850_USB1_VBUS_PIN, on);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int hawk_usb_get_power(unsigned port)
>> +{
>> + =A0 =A0 =A0 return gpio_get_value(DA850_USB1_VBUS_PIN);
>> +}
>> +
>> +static int hawk_usb_get_oci(unsigned port)
>> +{
>> + =A0 =A0 =A0 return !gpio_get_value(DA850_USB1_OC_PIN);
>> +}
>> +
>> +static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
>> +{
>> + =A0 =A0 =A0 int irq =A0 =A0 =A0 =A0 =3D gpio_to_irq(DA850_USB1_OC_PIN);
>> + =A0 =A0 =A0 int error =A0 =A0 =A0 =3D 0;
>> +
>> + =A0 =A0 =A0 if (handler !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hawk_usb_ocic_handler =3D handler;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D request_irq(irq, omapl138_hawk_u=
sb_ocic_irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 IRQF_DISABLED |
>> IRQF_TRIGGER_RISING |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 IRQF_TRIGGER_FALLING,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "OHCI over-current indicator",
>> NULL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: could=
 not request IRQ to
>> watch "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "over-curr=
ent indicator changes\n",
>> __func__);
>
> =A0 pr_err() please.
>
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(irq, NULL);
>> +
>> + =A0 =A0 =A0 return error;
>> +}
>> +
>> +static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata =3D {
>> + =A0 =A0 =A0 .set_power =A0 =A0 =A0=3D hawk_usb_set_power,
>> + =A0 =A0 =A0 .get_power =A0 =A0 =A0=3D hawk_usb_get_power,
>> + =A0 =A0 =A0 .get_oci =A0 =A0 =A0 =A0=3D hawk_usb_get_oci,
>> + =A0 =A0 =A0 .ocic_notify =A0 =A0=3D hawk_usb_ocic_notify,
>> + =A0 =A0 =A0 /* TPS2087 switch @ 5V */
>> + =A0 =A0 =A0 .potpgt =A0 =A0 =A0 =A0 =3D (3 + 1) / 2, =A0/* 3 ms max */
>> +};
>> +
>> +static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
>> +{
>> + =A0 =A0 =A0 hawk_usb_ocic_handler(&omapl138_hawk_usb11_pdata, 1);
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static __init void omapl138_hawk_usb_init(void)
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u32 cfgchip2;
>> +
>> + =A0 =A0 =A0 ret =3D davinci_cfg_reg_list(da850_hawk_usb11_pins);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: USB 1.1 PinMux setup faile=
d: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Setup the Ref. clock frequency for the HAWK at 24 MHz.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 cfgchip2 =3D __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2=
_REG));
>> + =A0 =A0 =A0 cfgchip2 &=3D ~CFGCHIP2_REFFREQ;
>> + =A0 =A0 =A0 cfgchip2 |=3D =A0CFGCHIP2_REFFREQ_24MHZ;
>> + =A0 =A0 =A0 __raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_R=
EG));
>> +
>> + =A0 =A0 =A0 ret =3D gpio_request(DA850_USB1_VBUS_PIN, "USB1 VBUS\n");
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: failed to request GPI=
O for USB 1.1
>> port "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "power control: %d\n", __f=
unc__, ret);
>
> =A0 pr_err() please.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 gpio_direction_output(DA850_USB1_VBUS_PIN, 0);
>> +
>> + =A0 =A0 =A0 ret =3D gpio_request(DA850_USB1_OC_PIN, "USB1 OC");
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: failed to request GPI=
O for USB 1.1
>> port "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "over-current indicator: %=
d\n", __func__, ret);
>
> =A0 pr_err() please.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 gpio_direction_input(DA850_USB1_OC_PIN);
>> +
>> + =A0 =A0 =A0 ret =3D da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: USB 1.1 registration faile=
d: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> =A0 'return' is useless here...

Thanks for the feedback if I erase the return here I think I also have
to erase the {  ...} am I right ?


Regards

Victor Rodriguez

>> + =A0 =A0 =A0 }
>> +}
>> +
>> =A0static struct davinci_uart_config omapl138_hawk_uart_config __initdat=
a =3D
>> {
>> =A0 =A0 =A0 =A0.enabled_uarts =3D 0x7,
>> =A0};
>
> WBR, Sergei
>
