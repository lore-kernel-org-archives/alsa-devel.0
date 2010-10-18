From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v3 1/9] davinci: EMAC support for
	Omapl138-Hawkboard
Date: Mon, 18 Oct 2010 18:58:14 -0500
Message-ID: <AANLkTik-iF5dAuLoGkzYDo=XkzVBL0vKZ1RBXF22WMb_@mail.gmail.com>
References: <1287076899-4365-1-git-send-email-vm.rod25@gmail.com>
	<4CB73AD5.2060907@mvista.com>
	<AANLkTikaDB1Cf9T5W-ogbQgEvGpmhYjJ8YHa3UftFTjL@mail.gmail.com>
	<4CB88082.5080901@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F19EE10386E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 01:58:14 +0200 (CEST)
Received: by iwn9 with SMTP id 9so1959761iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 16:58:14 -0700 (PDT)
In-Reply-To: <4CB88082.5080901@mvista.com>
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

On Fri, Oct 15, 2010 at 11:25 AM, Sergei Shtylyov <sshtylyov@mvista.com> wr=
ote:
> Hello.
>
> On 10/15/10 01:44, Victor Rodriguez wrote:
>
>>>> From: Victor Rodriguez<vm.rod25@gmail.com>
>
>>>> This patch adds EMAC support for the Hawkboard-L138 system
>
>>>> Signed-off-by: Victor Rodriguez<victor.rodriguez@sasken.com>
>
> [...]
>
>>>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
>>>> b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>>> index c472dd8..3ae5178 100644
>>>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>>>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>>> @@ -19,6 +19,53 @@
>>>>
>>>> =A0#include<mach/cp_intc.h>
>>>> =A0#include<mach/da8xx.h>
>>>> +#include<mach/mux.h>
>>>> +
>>>> +#define HAWKBOARD_PHY_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0:07"
>>>> +
>>>> +static short omapl138_hawk_mii_pins[] __initdata =3D {
>>>> + =A0 =A0 =A0 DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MI=
I_TXD_3,
>>>> + =A0 =A0 =A0 DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0,
>>>> DA850_MII_RXER,
>>>> + =A0 =A0 =A0 DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MI=
I_RXD_3,
>>>> + =A0 =A0 =A0 DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0,
>>>> DA850_MDIO_CLK,
>>>> + =A0 =A0 =A0 DA850_MDIO_D,
>>>> + =A0 =A0 =A0 -1
>>>> +};
>>>> +
>>>> +static int __init omapl138_hawk_config_emac(void)
>>>> +{
>>>> + =A0 =A0 =A0 void __iomem *cfgchip3;
>>>> + =A0 =A0 =A0 int ret;
>>>> + =A0 =A0 =A0 u32 val;
>>>> + =A0 =A0 =A0 struct davinci_soc_info *soc_info =3D&davinci_soc_info;
>>>> +
>>>> + =A0 =A0 =A0 if (!machine_is_omapl138_hawkboard())
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>>> +
>>>> + =A0 =A0 =A0 cfgchip3 =3D DA8XSYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
>
>>> =A0 Could be initializer...
>
>> I do not understand this
>
> =A0 I mean you could assign 'cfgchip3' right when you declare it.
>
>>>> + =A0 =A0 =A0 val =3D __raw_readl(cfgchip3);
>>>> +
>>>> + =A0 =A0 =A0 val&=3D ~BIT(8);
>>>> + =A0 =A0 =A0 ret =3D davinci_cfg_reg_list(omapl138_hawk_mii_pins);
>>>> + =A0 =A0 =A0 pr_info("EMAC: MII PHY configured\n");
>
>>> =A0 I think this pr_info() should follow __raw_writel() call.
>
>> Ok
>
>>>> + =A0 =A0 =A0 if (ret)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: "
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cpgmac/mii mux setup fa=
iled: %d\n", __func__,
>>>> ret);
>
>>> =A0 You should return here.
>
>>>> +
>>>> + =A0 =A0 =A0 /* configure the CFGCHIP3 register for MII */
>>>> + =A0 =A0 =A0 __raw_writel(val, cfgchip3);
>>>> +
>>>> + =A0 =A0 =A0 soc_info->emac_pdata->phy_id =3D HAWKBOARD_PHY_ID;
>>>> +
>>>> + =A0 =A0 =A0 ret =3D da8xx_register_emac();
>>>> + =A0 =A0 =A0 if (ret)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: "
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "emac registration faile=
d: %d\n", __func__,
>>>> ret);
>>>> + =A0 =A0 =A0 return 0;
>
>>> =A0 Why this function returns anything at all if it'a always 0, and the
>>> result
>>> is ignored?
>
>>>> @@ -30,6 +77,8 @@ static __init void omapl138_hawk_init(void)
>>>>
>>>> =A0 =A0 =A0 =A0davinci_serial_init(&omapl138_hawk_uart_config);
>
>>>> + =A0 =A0 =A0 ret =3D omapl138_hawk_config_emac();
>>>
>>> =A0 Why assign 'ret', if you're ignoring the result?
>
>> Sorry my mistake I =A0forgot to check this, please check the nest patch
>> maybe it is a better implementation
>
> [...]
>
>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> index c472dd8..35bcea1 100644
>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> @@ -19,6 +19,53 @@
>>
>> =A0#include<mach/cp_intc.h>
>> =A0#include<mach/da8xx.h>
>> +#include<mach/mux.h>
>> +
>> +#define HAWKBOARD_PHY_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0:07"
>> +
>> +static short omapl138_hawk_mii_pins[] __initdata =3D {
>> + =A0 =A0 =A0 DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_=
TXD_3,
>> + =A0 =A0 =A0 DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_M=
II_RXER,
>> + =A0 =A0 =A0 DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_=
RXD_3,
>> + =A0 =A0 =A0 DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_M=
DIO_CLK,
>> + =A0 =A0 =A0 DA850_MDIO_D,
>> + =A0 =A0 =A0 -1
>> +};
>> +
>> +static __init void omapl138_hawk_config_emac(void)
>> +{
>> + =A0 =A0 =A0 void __iomem *cfgchip3;
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u32 val;
>> + =A0 =A0 =A0 struct davinci_soc_info *soc_info =3D&davinci_soc_info;
>> +
>> + =A0 =A0 =A0 if (!machine_is_omapl138_hawkboard())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 cfgchip3 =3D DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
>> +
>> + =A0 =A0 =A0 val =3D __raw_readl(cfgchip3);
>> +
>> + =A0 =A0 =A0 val&=3D ~BIT(8);
>> + =A0 =A0 =A0 ret =3D davinci_cfg_reg_list(omapl138_hawk_mii_pins);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cpgmac/mii mux setup fail=
ed: %d\n", __func__,
>> ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> =A0 Should enclose these two statements in {} and fix indentation.
>
>> +
>> + =A0 =A0 =A0 /* configure the CFGCHIP3 register for MII */
>> + =A0 =A0 =A0 __raw_writel(val, cfgchip3);
>> + =A0 =A0 =A0 pr_info("EMAC: MII PHY configured\n");
>> +
>> + =A0 =A0 =A0 soc_info->emac_pdata->phy_id =3D HAWKBOARD_PHY_ID;
>> +
>> + =A0 =A0 =A0 ret =3D da8xx_register_emac();
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "emac registration failed:=
 %d\n", __func__, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> =A0 'return' is useless here, and it should've been enclosed into {}...
>
> WBR. Sergei
>

Hi Sergei

Thanks a lot for your feed back I have already fixed

Regards

Victor Rodriguez
