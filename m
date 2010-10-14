From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 9/9] davinci: USB-OHCI support for Omapl138-Hawkboard
Date: Thu, 14 Oct 2010 21:47:22 +0400
Message-ID: <4CB7422A.6020904@mvista.com>
References: <1287077018-4550-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1287077018-4550-1-git-send-email-vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

On 10/14/10 21:23, vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

> This patch adds USB-OHCI support for the Hawkboard-L138 system

> Signed-off-by: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
[,,,]
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index 723ac03..bac29fc 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
[...]
> @@ -177,6 +180,94 @@ static struct davinci_mmc_config da850_mmc_config = {
[...]
> +static __init void omapl138_hawk_usb_init(void)
> +{
> +	int ret;
> +	u32 cfgchip2;

   Empty line is needed here...

> +	/*
> +	 * Setup the Ref. clock frequency for the HAWK at 24 MHz.
> +	 */
> +	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +	cfgchip2&= ~CFGCHIP2_REFFREQ;
> +	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
> +	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
> +
> +	ret = gpio_request(DA850_USB1_VBUS_PIN, "USB1 VBUS\n");
> +	if (ret) {
> +		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
> +			"power control: %d\n", __func__, ret);
> +		return;
> +	}
> +	gpio_direction_output(DA850_USB1_VBUS_PIN, 0);
> +
> +	ret = gpio_request(DA850_USB1_OC_PIN, "USB1 OC");
> +	if (ret) {
> +		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
> +			"over-current indicator: %d\n", __func__, ret);
> +		return;
> +	}
> +	gpio_direction_input(DA850_USB1_OC_PIN);
> +}
> +
>   static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
>   	.enabled_uarts = 0x7,
>   };
> @@ -229,6 +320,16 @@ static __init void omapl138_hawk_init(void)
>   		pr_warning("%s: MMC/SD0 registration failed: %d\n",
>   			__func__, ret);
>
> +	ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
> +	if (ret)
> +		pr_warning("%s: USB 1.1 PinMux setup failed: %d\n",
> +			   __func__, ret);

    Why are you requesting pins outside omapl138_hawk_usb_init() I wonder?

> +	omapl138_hawk_usb_init();
> +	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
> +	if (ret)
> +		pr_warning("%s: USB 1.1 registration failed: %d\n",
> +			   __func__, ret);

    Same question...

WBR, Sergei
