From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v6 9/9] davinci: USB1.1 support for Omapl138-Hawkboard
Date: Tue, 2 Nov 2010 23:50:19 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234821A8C@dbde02.ent.ti.com>
References: <1288365045-2709-1-git-send-email-vm.rod25@gmail.com>
	<1288365045-2709-10-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1288365045-2709-10-git-send-email-vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org" <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Victor,

On Fri, Oct 29, 2010 at 20:40:45, vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
>
> This patch adds USB1.1 support for the Hawkboard-L138 system
>
> Signed-off-by: Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
> ---

> +static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
> +{
> +     int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
> +     int error       = 0;
> +
> +     if (handler != NULL) {
> +             hawk_usb_ocic_handler = handler;
> +
> +             error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
> +                                     IRQF_DISABLED | IRQF_TRIGGER_RISING |
> +                                     IRQF_TRIGGER_FALLING,
> +                                     "OHCI over-current indicator", NULL);
> +             if (error)
> +                     pr_err(KERN_ERR "%s: could not request IRQ to watch "
> +                             "over-current indicator changes\n", __func__);
> +     } else
> +             free_irq(irq, NULL);

Per Documentation/CodingStyle, else should have braces too.

> +static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
> +     .set_power      = hawk_usb_set_power,
> +     .get_power      = hawk_usb_get_power,
> +     .get_oci        = hawk_usb_get_oci,
> +     .ocic_notify    = hawk_usb_ocic_notify,
> +     /* TPS2087 switch @ 5V */

Do we have this part on the hawkboard as well?

[...]

> +static __init void omapl138_hawk_usb_init(void)
> +{
> +     int ret;
> +     u32 cfgchip2;
> +
> +     ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
> +     if (ret) {
> +             pr_warning("%s: USB 1.1 PinMux setup failed: %d\n",
> +                     __func__, ret);
> +             return;
> +     }
> +
> +     /*
> +      * Setup the Ref. clock frequency for the HAWK at 24 MHz.
> +      */

No need of multi-line comment style here.

Sorry about the piecemeal review (you really generated new versions quickly).
That is all I have on this series.

Also, you are CCing a whole lot of folks on each patch. Instead, you can
automate CCing the relevant folks using --cc-cmd=<command> option  of
git-send-email

Use --cc-cmd="scripts/get_maintainer.pl --pattern-depth=2 -s" to generate
list of relevant CCs.

Example:

scripts/get_maintainer.pl -f arch/arm/mach-davinci/board-omapl138-hawk.c --pattern-depth=2 -s

gives:

Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Recently Kevin requested all patches to CC Linux ARM Kernel mailing list so this
should be OK.

scripts/get_maintainer.pl -f sound/soc/davinci/davinci-evm.c --pattern-depth=2 -s

gives:

Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org

This is as per what Liam and Mark have been asking for.

Also, use --dry-run with git-send-email before sending actual emails to make
sure the To and CC lists look good.

Thanks,
Sekhar
