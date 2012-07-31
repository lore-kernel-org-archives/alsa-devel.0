From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] ARM: ux500: Ensure probing of Audio devices when Device Tree is enabled
Date: Tue, 31 Jul 2012 20:54:13 +0000
Message-ID: <201207312054.13818.arnd@arndb.de>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org> <1343741493-17671-11-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343741493-17671-11-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tuesday 31 July 2012, Lee Jones wrote:
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index e641003..87a5cd7 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -794,6 +794,7 @@ static void __init u8500_init_machine(void)
>                                 ARRAY_SIZE(mop500_platform_devs));
>  
>                 mop500_sdi_init(parent);
> +               mop500_msp_init(parent);
>                 i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
>                 i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
>                 i2c_register_board_info(2, mop500_i2c2_devices,
> @@ -801,6 +802,8 @@ static void __init u8500_init_machine(void)
>  
>                 mop500_uib_init();
>  
> +       } else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
> +               mop500_of_msp_init(parent);
>         } else if (of_machine_is_compatible("st-ericsson,hrefv60+")) {
>                 /*
>                  * The HREFv60 board removed a GPIO expander and routed
> @@ -812,6 +815,7 @@ static void __init u8500_init_machine(void)
>                                 ARRAY_SIZE(mop500_platform_devs));
>  
>                 hrefv60_sdi_init(parent);
> +               mop500_msp_init(parent);
>  
>                 i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
>                 i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;


Looks like you're adding the same call to each of the three cases:
mop500, snowball and hrefv60+. How about moving it before or after
the if/elseif block?

	Arnd
