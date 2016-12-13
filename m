From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 3/3] platform/x86: Enable Atom PMC platform clocks
Date: Tue, 13 Dec 2016 02:01:06 +0200
Message-ID: <CAHp75VeEVvTSyT2jcr8u53pm52Jq0WmPLAVKdKn=ts3M5474YA@mail.gmail.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com> <1481306510-7471-4-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1481306510-7471-4-git-send-email-irina.tirdea@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 9, 2016 at 8:01 PM, Irina Tirdea <irina.tirdea@intel.com> wrote:
> The BayTrail and CherryTrail platforms provide platform clocks
> through their Power Management Controller (PMC).
>
> The SoC supports up to 6 clocks (PMC_PLT_CLK[5:0]) with a
> frequency of either 19.2 MHz (PLL) or 25 MHz (XTAL) for BayTrail
> an a frequency of 19.2 MHz (XTAL) for CherryTrail. These clocks
> are available for general system use, where appropriate. For example,
> the usage for platform clocks suggested in the datasheet is the
> following:
>   PLT_CLK[2:0] - Camera
>   PLT_CLK[3] - Audio Codec
>   PLT_CLK[4] -
>   PLT_CLK[5] - COMMs
>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Same comments as per patch 1/3.

> ---
>  drivers/platform/x86/Kconfig               |  1 +
>  drivers/platform/x86/pmc_atom.c            | 78 ++++++++++++++++++++++++++++--

>  include/linux/platform_data/x86/pmc_atom.h |  3 ++

Same.

>  3 files changed, 79 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 21dce1e..c1b07ed 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1032,3 +1032,4 @@ endif # X86_PLATFORM_DEVICES
>  config PMC_ATOM
>         def_bool y
>          depends on PCI
> +       select COMMON_CLK
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index b53fbc1..324c44f 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -22,6 +22,8 @@
>  #include <linux/seq_file.h>
>  #include <linux/io.h>
>  #include <linux/platform_data/x86/pmc_atom.h>

> +#include <linux/platform_device.h>

It should go after (e comes after a).

> +#include <linux/platform_data/x86/clk-byt-plt.h>
>
>  struct pmc_bit_map {
>         const char *name;
> @@ -36,6 +38,11 @@ struct pmc_reg_map {
>         const struct pmc_bit_map *pss;
>  };
>
> +struct pmc_data {
> +       const struct pmc_reg_map *map;
> +       const struct pmc_clk *clks;

clks -> clocks

> +};
> +
>  struct pmc_dev {
>         u32 base_addr;
>         void __iomem *regmap;
> @@ -49,6 +56,29 @@ struct pmc_dev {
>  static struct pmc_dev pmc_device;
>  static u32 acpi_base_addr;
>
> +static const struct pmc_clk byt_clks[] = {
> +       {
> +               .name = "xtal",
> +               .freq = 25000000,
> +               .parent_name = NULL,
> +       },
> +       {
> +               .name = "pll",
> +               .freq = 19200000,
> +               .parent_name = "xtal",
> +       },
> +       {},
> +};
> +
> +static const struct pmc_clk cht_clks[] = {
> +       {
> +               .name = "xtal",
> +               .freq = 19200000,
> +               .parent_name = NULL,
> +       },
> +       {},
> +};
> +

Okay, this is definition of clock trees. It means that clk-x86-pmc can
be used basically on any of PMC that provides similar clock tree,
right?

>  static const struct pmc_bit_map d3_sts_0_map[] = {
>         {"LPSS1_F0_DMA",        BIT_LPSS1_F0_DMA},
>         {"LPSS1_F1_PWM1",       BIT_LPSS1_F1_PWM1},
> @@ -168,6 +198,16 @@ struct pmc_dev {
>         .pss            = cht_pss_map,
>  };
>
> +static const struct pmc_data byt_data = {
> +       .map = &byt_reg_map,
> +       .clks = byt_clks,
> +};
> +
> +static const struct pmc_data cht_data = {
> +       .map = &cht_reg_map,
> +       .clks = cht_clks,
> +};
> +
>  static inline u32 pmc_reg_read(struct pmc_dev *pmc, int reg_offset)
>  {
>         return readl(pmc->regmap + reg_offset);
> @@ -381,10 +421,36 @@ static int pmc_dbgfs_register(struct pmc_dev *pmc)
>  }
>  #endif /* CONFIG_DEBUG_FS */
>
> +static int pmc_setup_clks(struct pci_dev *pdev, void __iomem *pmc_regmap,

_clks -> _clocks

> +                         const struct pmc_data *pmc_data)
> +{
> +       struct platform_device *clkdev;
> +       struct pmc_clk_data *clk_data;
> +
> +       clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);

Can we just use stack for that?

> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       clk_data->base = pmc_regmap + PMC_CLK_CTL_0;
> +       clk_data->clks = pmc_data->clks;
> +
> +       clkdev = platform_device_register_data(&pdev->dev, "clk-byt-plt", -1,

-1 has a definition in this case. AUTO smth... or NONE, I don't
remember which one.

> +                                              clk_data, sizeof(*clk_data));
> +       if (IS_ERR(clkdev)) {
> +               kfree(clk_data);
> +               return PTR_ERR(clkdev);
> +       }
> +
> +       kfree(clk_data);
> +
> +       return 0;
> +}
> +
>  static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>         struct pmc_dev *pmc = &pmc_device;
> -       const struct pmc_reg_map *map = (struct pmc_reg_map *)ent->driver_data;
> +       const struct pmc_data *data = (struct pmc_data *)ent->driver_data;
> +       const struct pmc_reg_map *map = data->map;
>         int ret;
>
>         /* Obtain ACPI base address */
> @@ -413,6 +479,12 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
>         if (ret)
>                 dev_warn(&pdev->dev, "debugfs register failed\n");
>
> +       /* Register platform clocks - PMC_PLT_CLK [5:0] */
> +       ret = pmc_setup_clks(pdev, pmc->regmap, data);
> +       if (ret)
> +               dev_warn(&pdev->dev, "platform clocks register failed: %d\n",
> +                        ret);
> +
>         pmc->init = true;
>         return ret;
>  }
> @@ -423,8 +495,8 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
>   * used by pci_match_id() call below.
>   */
>  static const struct pci_device_id pmc_pci_ids[] = {
> -       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_VLV_PMC), (kernel_ulong_t)&byt_reg_map },
> -       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_CHT_PMC), (kernel_ulong_t)&cht_reg_map },
> +       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_VLV_PMC), (kernel_ulong_t)&byt_data },
> +       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_CHT_PMC), (kernel_ulong_t)&cht_data },
>         { 0, },
>  };
>
> diff --git a/include/linux/platform_data/x86/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
> index aa8744c..2d310cf 100644
> --- a/include/linux/platform_data/x86/pmc_atom.h
> +++ b/include/linux/platform_data/x86/pmc_atom.h
> @@ -50,6 +50,9 @@
>                                 BIT_ORED_DEDICATED_IRQ_GPSC | \
>                                 BIT_SHARED_IRQ_GPSS)
>
> +/* Platform clock control registers */
> +#define PMC_CLK_CTL_0          0x60
> +
>  /* The timers acumulate time spent in sleep state */

Typo:
accumulate

>  #define        PMC_S0IR_TMR            0x80
>  #define        PMC_S0I1_TMR            0x84

-- 
With Best Regards,
Andy Shevchenko
