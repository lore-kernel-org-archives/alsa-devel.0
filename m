From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 7/9] davinci: MMC/SD support for Omapl138-Hawkboar
Date: Fri, 15 Oct 2010 20:25:28 +0400
Message-ID: <4CB88078.7050504@mvista.com>
References: <1287112105-11968-1-git-send-email-vm.rod25@gmail.com>
	<1287112105-11968-8-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1287112105-11968-8-git-send-email-vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

> This patch adds MMC/SD support for the Hawkboard-L138 system

> Signed-off-by: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
[...]

> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index 6f76220..87dea28 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
[...]
> @@ -180,6 +208,28 @@ static __init void omapl138_hawk_init(void)
>   		pr_warning("%s: mcasp mux setup failed: %d\n", __func__, ret);
>   	da8xx_register_mcasp(0,&omapl138_hawk_snd_data);

    I'd put all the following into a sperate function.

> +	ret = davinci_cfg_reg_list(hawk_mmcsd0_pins);
> +	if (ret)
> +		pr_warning("%s: MMC/SD0 mux setup failed: %d\n",
> +			__func__, ret);
> +
> +	ret = gpio_request(DA850_HAWK_MMCSD_CD_PIN, "MMC CD\n");
> +	if (ret)
> +		pr_warning("%s: can not open GPIO %d\n",
> +			__func__, DA850_HAWK_MMCSD_CD_PIN);
> +	gpio_direction_input(DA850_HAWK_MMCSD_CD_PIN);

    You cannot call that if gpio_request{} failed.

> +	ret = gpio_request(DA850_HAWK_MMCSD_WP_PIN, "MMC WP\n");
> +	if (ret)
> +		pr_warning("%s: can not open GPIO %d\n",
> +			__func__, DA850_HAWK_MMCSD_WP_PIN);
> +	gpio_direction_input(DA850_HAWK_MMCSD_WP_PIN);

    You cannot call that if gpio_request{} failed.

> +	ret = da8xx_register_mmcsd0(&da850_mmc_config);
> +	if (ret)
> +		pr_warning("%s: MMC/SD0 registration failed: %d\n",
> +			__func__, ret);
> +
>   	ret = da8xx_register_watchdog();
>   	if (ret)
>   		pr_warning("omapl138_hawk_init: "

WBR, Sergei
