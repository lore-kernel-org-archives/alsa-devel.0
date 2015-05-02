From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v3 3/8] mfd: arizona: Add support for WM8998 and WM1814
Date: Sat, 02 May 2015 11:58:51 +0200
Message-ID: <1430560731.2187.70.camel@x220>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
	 <1430493319-23808-4-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1430493319-23808-4-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Something I didn't notice when v2 came along.

On Fri, 2015-05-01 at 16:15 +0100, Richard Fitzgerald wrote:
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig

> +config MFD_WM8998
> +	bool "Wolfson Microelectronics WM8998"
> +	depends on MFD_ARIZONA
> +	help
> +	  Support for Wolfson Microelectronics WM8998 low power audio SoC
> +
>  config MFD_WM8400
>  	bool "Wolfson Microelectronics WM8400"
>  	select MFD_CORE

> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile

>  ifneq ($(CONFIG_MFD_WM8997),n)
>  obj-$(CONFIG_MFD_ARIZONA)	+= wm8997-tables.o
>  endif
> +ifneq ($(CONFIG_MFD_WM8998),n)
> +obj-$(CONFIG_MFD_ARIZONA)	+= wm8998-tables.o
> +endif

Playing a bit with the current version of drivers/mfd/Makefile it seems
these
    ifneq ($(CONFIG_MFD_WM[...]),n)

tests will always be true. Because, as far as I know, the Kconfig macros
used in those tests will either be "y" or the empty string, but never
"n". (I don't speak Makefilese fluent enough to know how to add simple
debugging prints for the values of the CONFIG_MFD_WM[...] macros to
actually test this, so correct me if I'm wrong here.)

So I think that, effectively, these wm[...]-tables.o objects will always
be built if CONFIG_MFD_ARIZONA is set. Is that the intention? If not,
perhaps these test should read
    ifeq ($(CONFIG_MFD_WM[...]),y)

Thanks,


Paul Bolle

