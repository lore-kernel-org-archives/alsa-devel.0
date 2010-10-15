From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 1/9] davinci: EMAC support for Omapl138-Hawkboard
Date: Fri, 15 Oct 2010 20:14:05 +0400
Message-ID: <4CB87DCD.9070107@mvista.com>
References: <1287112105-11968-1-git-send-email-vm.rod25@gmail.com>
	<1287112105-11968-2-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1287112105-11968-2-git-send-email-vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 10/15/10 07:08, vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

> This patch adds EMAC support for the Hawkboard-L138 system

> Signed-off-by: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
> ---
>   arch/arm/mach-davinci/board-omapl138-hawk.c |   50 +++++++++++++++++++++++++++
>   1 files changed, 50 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index c472dd8..2220105 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -19,6 +19,54 @@
>
>   #include<mach/cp_intc.h>
>   #include<mach/da8xx.h>
> +#include<mach/mux.h>
> +
> +#define HAWKBOARD_PHY_ID		"0:07"
> +
> +static short omapl138_hawk_mii_pins[] __initdata = {
> +	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
> +	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
> +	DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
> +	DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
> +	DA850_MDIO_D,
> +	-1
> +};
> +
> +static __init void omapl138_hawk_config_emac(void)
> +{
> +	void __iomem *cfgchip3;
> +	int ret;
> +	u32 val;
> +	struct davinci_soc_info *soc_info =&davinci_soc_info;
> +
> +	if (!machine_is_omapl138_hawkboard())
> +		return;
> +
> +	cfgchip3 = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
> +
> +	val = __raw_readl(cfgchip3);
> +
> +	val&= ~BIT(8);
> +	ret = davinci_cfg_reg_list(omapl138_hawk_mii_pins);
> +	if (ret) {
> +		pr_warning("%s: "
> +			"cpgmac/mii mux setup failed: %d\n", __func__, ret);
> +		return;
> +	}
> +
> +	pr_info("EMAC: MII PHY configured\n");

    I said this should *follow* __raw_writel(), not precede it...

> +	/* configure the CFGCHIP3 register for MII */
> +	__raw_writel(val, cfgchip3);
> +
> +	soc_info->emac_pdata->phy_id = HAWKBOARD_PHY_ID;
> +
> +	ret = da8xx_register_emac();
> +	if (ret)
> +		pr_warning("%s: "
> +			"emac registration failed: %d\n", __func__, ret);
> +		return;

    'return' not needed here. And you've forgotten to enclose it in {} anyway. :-)

WBR. Sergei
