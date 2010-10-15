From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/9] davinci: EMAC support for Omapl138-Hawkboard
Date: Fri, 15 Oct 2010 20:25:38 +0400
Message-ID: <4CB88082.5080901@mvista.com>
References: <1287076899-4365-1-git-send-email-vm.rod25@gmail.com>	<4CB73AD5.2060907@mvista.com>
	<AANLkTikaDB1Cf9T5W-ogbQgEvGpmhYjJ8YHa3UftFTjL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <AANLkTikaDB1Cf9T5W-ogbQgEvGpmhYjJ8YHa3UftFTjL-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Victor Rodriguez <vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 10/15/10 01:44, Victor Rodriguez wrote:

>>> From: Victor Rodriguez<vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>>> This patch adds EMAC support for the Hawkboard-L138 system

>>> Signed-off-by: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
[...]

>>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> index c472dd8..3ae5178 100644
>>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> @@ -19,6 +19,53 @@
>>>
>>>   #include<mach/cp_intc.h>
>>>   #include<mach/da8xx.h>
>>> +#include<mach/mux.h>
>>> +
>>> +#define HAWKBOARD_PHY_ID               "0:07"
>>> +
>>> +static short omapl138_hawk_mii_pins[] __initdata = {
>>> +       DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
>>> +       DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
>>> +       DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
>>> +       DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
>>> +       DA850_MDIO_D,
>>> +       -1
>>> +};
>>> +
>>> +static int __init omapl138_hawk_config_emac(void)
>>> +{
>>> +       void __iomem *cfgchip3;
>>> +       int ret;
>>> +       u32 val;
>>> +       struct davinci_soc_info *soc_info =&davinci_soc_info;
>>> +
>>> +       if (!machine_is_omapl138_hawkboard())
>>> +               return 0;
>>> +
>>> +       cfgchip3 = DA8XSYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);

>>    Could be initializer...

> I do not understand this

    I mean you could assign 'cfgchip3' right when you declare it.

>>> +       val = __raw_readl(cfgchip3);
>>> +
>>> +       val&= ~BIT(8);
>>> +       ret = davinci_cfg_reg_list(omapl138_hawk_mii_pins);
>>> +       pr_info("EMAC: MII PHY configured\n");

>>    I think this pr_info() should follow __raw_writel() call.

> Ok

>>> +       if (ret)
>>> +               pr_warning("%s: "
>>> +                       "cpgmac/mii mux setup failed: %d\n", __func__,
>>> ret);

>>    You should return here.

>>> +
>>> +       /* configure the CFGCHIP3 register for MII */
>>> +       __raw_writel(val, cfgchip3);
>>> +
>>> +       soc_info->emac_pdata->phy_id = HAWKBOARD_PHY_ID;
>>> +
>>> +       ret = da8xx_register_emac();
>>> +       if (ret)
>>> +               pr_warning("%s: "
>>> +                       "emac registration failed: %d\n", __func__, ret);
>>> +       return 0;

>>    Why this function returns anything at all if it'a always 0, and the result
>> is ignored?

>>> @@ -30,6 +77,8 @@ static __init void omapl138_hawk_init(void)
>>>
>>>         davinci_serial_init(&omapl138_hawk_uart_config);

>>> +       ret = omapl138_hawk_config_emac();
>>
>>    Why assign 'ret', if you're ignoring the result?

> Sorry my mistake I  forgot to check this, please check the nest patch
> maybe it is a better implementation

[...]

> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
> b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index c472dd8..35bcea1 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -19,6 +19,53 @@
>
>  #include<mach/cp_intc.h>
>  #include<mach/da8xx.h>
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
> +			return;
> +
> +	cfgchip3 = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
> +
> +	val = __raw_readl(cfgchip3);
> +
> +	val&= ~BIT(8);
> +	ret = davinci_cfg_reg_list(omapl138_hawk_mii_pins);
> +	if (ret)
> +		pr_warning("%s: "
> +			"cpgmac/mii mux setup failed: %d\n", __func__, ret);
> +			return;

    Should enclose these two statements in {} and fix indentation.

> +
> +	/* configure the CFGCHIP3 register for MII */
> +	__raw_writel(val, cfgchip3);
> +	pr_info("EMAC: MII PHY configured\n");
> +
> +	soc_info->emac_pdata->phy_id = HAWKBOARD_PHY_ID;
> +
> +	ret = da8xx_register_emac();
> +	if (ret)
> +		pr_warning("%s: "
> +			"emac registration failed: %d\n", __func__, ret);
> +			return;

    'return' is useless here, and it should've been enclosed into {}...

WBR. Sergei
