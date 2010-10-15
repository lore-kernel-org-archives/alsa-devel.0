From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 9/9] davinci: USB1.1 support for Omapl138-Hawkboard
Date: Fri, 15 Oct 2010 20:32:48 +0400
Message-ID: <4CB88230.7000501@mvista.com>
References: <1287112105-11968-1-git-send-email-vm.rod25@gmail.com>
	<1287112105-11968-10-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1287112105-11968-10-git-send-email-vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 10/15/10 07:08, vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

> This patch adds USB1.1 support for the Hawkboard-L138 system

> Signed-off-by: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
[...]

> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index 87dea28..4658498 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
[...]
> @@ -178,6 +181,109 @@ static struct davinci_mmc_config da850_mmc_config = {
>   	.version	= MMC_CTLR_VERSION_2,
>   };
>
> +static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
> +static da8xx_ocic_handler_t hawk_usb_ocic_handler;
> +
> +static const short da850_hawk_usb11_pins[] = {
> +	DA850_GPIO2_4, DA850_GPIO6_13,
> +	-1
> +};

    An empty wouldn't hurt here. Sorry if I overlooked this before...

> +static int hawk_usb_set_power(unsigned port, int on)
> +{
> +	gpio_set_value(DA850_USB1_VBUS_PIN, on);
> +	return 0;
> +}
> +
> +static int hawk_usb_get_power(unsigned port)
> +{
> +	return gpio_get_value(DA850_USB1_VBUS_PIN);
> +}
> +
> +static int hawk_usb_get_oci(unsigned port)
> +{
> +	return !gpio_get_value(DA850_USB1_OC_PIN);
> +}
> +
> +static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
> +{
> +	int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
> +	int error       = 0;
> +
> +	if (handler != NULL) {
> +		hawk_usb_ocic_handler = handler;
> +
> +		error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
> +					IRQF_DISABLED | IRQF_TRIGGER_RISING |
> +					IRQF_TRIGGER_FALLING,
> +					"OHCI over-current indicator", NULL);
> +		if (error)
> +			printk(KERN_ERR "%s: could not request IRQ to watch "
> +				"over-current indicator changes\n", __func__);

    pr_err() please.

> +	} else
> +		free_irq(irq, NULL);
> +
> +	return error;
> +}
> +
> +static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
> +	.set_power      = hawk_usb_set_power,
> +	.get_power      = hawk_usb_get_power,
> +	.get_oci        = hawk_usb_get_oci,
> +	.ocic_notify    = hawk_usb_ocic_notify,
> +	/* TPS2087 switch @ 5V */
> +	.potpgt         = (3 + 1) / 2,  /* 3 ms max */
> +};
> +
> +static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
> +{
> +	hawk_usb_ocic_handler(&omapl138_hawk_usb11_pdata, 1);
> +	return IRQ_HANDLED;
> +}
> +
> +static __init void omapl138_hawk_usb_init(void)
> +{
> +	int ret;
> +	u32 cfgchip2;
> +
> +	ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
> +	if (ret) {
> +		pr_warning("%s: USB 1.1 PinMux setup failed: %d\n",
> +			__func__, ret);
> +		return;
> +	}
> +
> +	/*
> +	 * Setup the Ref. clock frequency for the HAWK at 24 MHz.
> +	 */
> +	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +	cfgchip2 &= ~CFGCHIP2_REFFREQ;
> +	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
> +	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +
> +	ret = gpio_request(DA850_USB1_VBUS_PIN, "USB1 VBUS\n");
> +	if (ret) {
> +		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
> +			"power control: %d\n", __func__, ret);

    pr_err() please.

> +		return;
> +	}
> +	gpio_direction_output(DA850_USB1_VBUS_PIN, 0);
> +
> +	ret = gpio_request(DA850_USB1_OC_PIN, "USB1 OC");
> +	if (ret) {
> +		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
> +			"over-current indicator: %d\n", __func__, ret);

    pr_err() please.

> +		return;
> +	}
> +	gpio_direction_input(DA850_USB1_OC_PIN);
> +
> +	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
> +	if (ret) {
> +		pr_warning("%s: USB 1.1 registration failed: %d\n",
> +			__func__, ret);
> +		return;

    'return' is useless here...

> +	}
> +}
> +
>   static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
>   	.enabled_uarts = 0x7,
>   };

WBR, Sergei
