From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] soundwire: fix regmap dependencies and align with other
 serial links
Date: Fri, 19 Jul 2019 11:04:43 +0200
Message-ID: <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jank@cadence.com, Srini Kandagatla <srinivas.kandagatla@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 19, 2019 at 1:02 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> The existing code has a mixed select/depend usage which makes no sense.
>
> config SOUNDWIRE_BUS
>        tristate
>        select REGMAP_SOUNDWIRE
>
> config REGMAP_SOUNDWIRE
>         tristate
>         depends on SOUNDWIRE_BUS
>
> Let's remove one layer of Kconfig definitions and align with the
> solutions used by all other serial links.
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

No issues found:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/regmap/Kconfig | 2 +-
>  drivers/soundwire/Kconfig   | 7 +------
>  drivers/soundwire/Makefile  | 2 +-
>  3 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index 6ad5ef48b61e..8cd2ac650b50 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -44,7 +44,7 @@ config REGMAP_IRQ
>
>  config REGMAP_SOUNDWIRE
>         tristate
> -       depends on SOUNDWIRE_BUS
> +       depends on SOUNDWIRE
>
>  config REGMAP_SCCB
>         tristate
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index 3a01cfd70fdc..f518273cfbe3 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -4,7 +4,7 @@
>  #
>
>  menuconfig SOUNDWIRE
> -       bool "SoundWire support"
> +       tristate "SoundWire support"
>         help
>           SoundWire is a 2-Pin interface with data and clock line ratified
>           by the MIPI Alliance. SoundWire is used for transporting data
> @@ -17,17 +17,12 @@ if SOUNDWIRE
>
>  comment "SoundWire Devices"
>
> -config SOUNDWIRE_BUS
> -       tristate
> -       select REGMAP_SOUNDWIRE
> -
>  config SOUNDWIRE_CADENCE
>         tristate
>
>  config SOUNDWIRE_INTEL
>         tristate "Intel SoundWire Master driver"
>         select SOUNDWIRE_CADENCE
> -       select SOUNDWIRE_BUS
>         depends on X86 && ACPI && SND_SOC
>         help
>           SoundWire Intel Master driver.
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index fd99a831b92a..45b7e5001653 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -5,7 +5,7 @@
>
>  #Bus Objs
>  soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> -obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
> +obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>
>  #Cadence Objs
>  soundwire-cadence-objs := cadence_master.o
> --
> 2.20.1
>
