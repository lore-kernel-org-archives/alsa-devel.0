From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/2] ASoC: AMD: Enable/Disable auxiliary
 clock via common clock framework
Date: Tue, 03 Apr 2018 18:57:51 +0000
Message-ID: <CAGS+omDqWEjEm0b3H5-pwd2Nrf_pEbQTAU_dPKVmXi5vsDxKLw@mail.gmail.com>
References: <1522404297-7555-1-git-send-email-akshu.agrawal@amd.com>
 <1522404297-7555-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f195.google.com (mail-ua0-f195.google.com
 [209.85.217.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E7AF2675CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Apr 2018 20:58:05 +0200 (CEST)
Received: by mail-ua0-f195.google.com with SMTP id o34so11676262uae.9
 for <alsa-devel@alsa-project.org>; Tue, 03 Apr 2018 11:58:04 -0700 (PDT)
In-Reply-To: <1522404297-7555-2-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Akshu,

On Fri, Mar 30, 2018 at 4:05 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:

> This enables/disables and sets auxiliary clock at 25Mhz. It uses
> common clock framework for proper ref counting. This approach will
> save power in comparison to keeping it always On in firmware.

I have some general concern with the approach in this patch:

(1) The 25 MHz clock being created here is a general system clock
resource.  I think it should be created in an SoC clock driver, rather than
here in an audio machine driver.   This has several advantages:
   (a) the clock resource would be available for other boards that use it but
don't use this particular audio machine driver
   (b) the clock would be instantiated at boot, rather than at machine driver
load.
   (c) the machine driver would not then need the additional clkdev code

(2) The oscout1 clock is a pretty standard clk_gate with a clk_mux.  We can
use some standard helpers to better model the clock tree rather than
rewriting them:

static struct clk *clk_48m;
static struct clk *clk_25m;
static struct clk *clk_oscout1_mux;
static struct clk *clk_oscout1;

static const char *clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };

{
    clk_48m = clk_register_fixed_rate(dev, "clk48MHz", NULL, 0, 48000000);
    clk_25m = clk_register_fixed_rate(dev, "clk25MHz", NULL, 0, 25000000);

    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    res_base = devm_ioremap_nocache(dev, res->start, resource_size(res));

    clk_oscout1_mux = clk_register_mux(dev, "oscout1_mux",
        clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
        0, res_base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);

    clk_set_parent(clk_oscout1_mux, clk_25m);

    clk_oscout1 = clk_register_gate(dev, "oscout1", "oscout1_mux", 0,
          res_base + MISCCLKCNTL1, OSCCLKENB, 0, NULL);


(3) IIUC, the 25 MHz clock (oscout1) is actually the da7219's mclk.  The
da7219 already
has infrastructure to enable/disable its mclk as needed.  Once we establish
the system clock,
we can then wire this clock up to the da7219 via ACPI / devicetree
properties.


(4) Instead of a adding inline "#ifdef CONFIG_COMMON_CLK", can we just make
this driver select COMMON_CLK in its Kconfig instead?   When would you use
this machine driver without COMMON_CLK?


Below are additional code review comments on the current version of the
patch, which may be obsolete if we change approach...


> TEST= aplay -vv <file>
> check register to see clock enabled
> kill aplay
> check register to see clock disabled

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> V2: Correcting the pin to OSCOUT1 from OSCOUT2
> V3: Fix error/warnings from kbuild test
> V4: Fix build errors for platform which do not support CONFIG_COMMON_CLK
> V5: Review comments by Dan and Sriram

>    sound/soc/amd/acp-da7219-max98357a.c | 159
++++++++++++++++++++++++++++++++++-
>    1 file changed, 157 insertions(+), 2 deletions(-)

> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
b/sound/soc/amd/acp-da7219-max98357a.c
> index d9491e1..9e649c3 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -30,19 +30,41 @@
>    #include <sound/soc-dapm.h>
>    #include <sound/jack.h>
>    #include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>    #include <linux/gpio.h>
>    #include <linux/module.h>
>    #include <linux/i2c.h>
>    #include <linux/input.h>
>    #include <linux/acpi.h>
> +#include <linux/types.h>

>    #include "../codecs/da7219.h"
>    #include "../codecs/da7219-aad.h"

> -#define CZ_PLAT_CLK 24000000
> +#define CZ_PLAT_CLK 25000000
>    #define MCLK_RATE 24576000

IIUC, "MCLK_RATE" here is misnamed.  "MCLK" is the input clock to the
DA7219, that is, it is the 25 MHz "CZ_PLAT_CLK" being generated on OSCOUT1
and sent to the mclk pin of the da7219.  The rate here (24.576 MHz) is
actually the clock rate of the DA7219's internal VCO (FVCO), which will be
then be divided down by the DA7219's PLL to give the output BCLK.

>    #define DUAL_CHANNEL           2

> +/* Clock Driving Strength 2 register */
> +#define CLKDRVSTR2     0x28
> +/* Clock Control 1 register */
> +#define MISCCLKCNTL1   0x40
> +/* Auxiliary clock1 enable bit */
> +#define OSCCLKENB      2
> +/* 25Mhz auxiliary output clock freq bit */
> +#define OSCOUT1CLK25MHZ        16
> +
> +struct cz_clock {
> +       const char* acp_clks_name;

I still think you should remove acp_clks_name, acp_clks_lookup and acp_clks
from the struct since they are used locally during
register_acpd7219_clocks, and, afaict, never referenced again.

Also why the 's' in "clks"?  It looks like there is just one clock, so just
use the singular, acp_clk.

> +#ifdef CONFIG_COMMON_CLK
> +       struct clk_hw acp_clks_hw;
> +#endif
> +       struct clk_lookup *acp_clks_lookup;
> +       struct clk *acp_clks;
> +       void __iomem *res_base;
> +};
> +
>    static struct snd_soc_jack cz_jack;
>    struct clk *da7219_dai_clk;

> @@ -98,6 +120,8 @@ static int cz_da7219_hw_params(struct
snd_pcm_substream *substream,
>    {
>           int ret = 0;
>           struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_card *card = rtd->card;
> +       struct clk *acpd7219_clk;

>           ret = clk_prepare_enable(da7219_dai_clk);
>           if (ret < 0) {
> @@ -105,13 +129,37 @@ static int cz_da7219_hw_params(struct
snd_pcm_substream *substream,
>                   return ret;
>           }

> +       acpd7219_clk = clk_get(card->dev, "acpd7219-clks");

Does clk_get take a reference?  Should there be a corresponding clk_put?
Can we instead avoid doing this on every hw_params/hw_free and rather do a
single devm_clk_get() during probe?

> +       if (IS_ERR(acpd7219_clk)) {
> +               dev_err(rtd->dev, "failed to get clock: %ld\n",
> +                       PTR_ERR(acpd7219_clk));
> +               return PTR_ERR(acpd7219_clk);
> +       }
> +
> +       ret = clk_prepare_enable(acpd7219_clk);
> +       if (ret < 0)
> +               dev_err(rtd->dev, "can't enable oscillator clock %d\n",
ret);

Enable on hw_params() and disable on hw_free() doesn't sound balanced?
Will there always be exactly one hw_free() for every hw_params()?

>           return ret;
>    }

>    static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
>    {
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_card *card = rtd->card;
> +       struct clk *acpd7219_clk;
> +
>           clk_disable_unprepare(da7219_dai_clk);

> +       acpd7219_clk = clk_get(card->dev, "acpd7219-clks");
> +       if (IS_ERR(acpd7219_clk)) {
> +               dev_err(rtd->dev, "failed to get clock: %ld\n",
> +                       PTR_ERR(acpd7219_clk));
> +               return PTR_ERR(acpd7219_clk);
> +       }
> +
> +       clk_disable_unprepare(acpd7219_clk);
> +
>           return 0;
>    }

> @@ -244,6 +292,112 @@ static int cz_fe_startup(struct snd_pcm_substream
*substream)
>           .num_controls = ARRAY_SIZE(cz_mc_controls),
>    };

> +#ifdef CONFIG_COMMON_CLK
> +static int acpd7219_clks_enable(struct clk_hw *hw)
> +{
> +       u32 reg_val;
> +       struct cz_clock *cz_clock_obj =
> +               container_of(hw, struct cz_clock, acp_clks_hw);

What compile failure does the following cause?
    struct cz_clock *cz_clock = container_of(hw, struct cz_clock,
acp_clks_hw);

> +       void __iomem *base = cz_clock_obj->res_base;
> +
> +       reg_val = readl(base + MISCCLKCNTL1);
> +       reg_val &= ~(0x1 << OSCCLKENB);
> +       writel(reg_val, base + MISCCLKCNTL1);
> +       reg_val = readl(base + CLKDRVSTR2);
> +       reg_val |= (0x1 << OSCOUT1CLK25MHZ);
> +       writel(reg_val, base + CLKDRVSTR2);
> +
> +       return 0;
> +}
> +
> +static void acpd7219_clks_disable(struct clk_hw *hw)
> +{
> +       u32 reg_val;
> +       struct cz_clock *cz_clock_obj =
> +               container_of(hw, struct cz_clock, acp_clks_hw);
> +       void __iomem *base = cz_clock_obj->res_base;
> +
> +       reg_val = readl(base + MISCCLKCNTL1);
> +       reg_val |= (0x1 << OSCCLKENB);
> +       writel(reg_val, base + MISCCLKCNTL1);
> +}
> +
> +static int acpd7219_clks_is_enabled(struct clk_hw *hw)
> +{
> +       u32 reg_val;
> +       struct cz_clock *cz_clock_obj =
> +               container_of(hw, struct cz_clock, acp_clks_hw);
> +       void __iomem *base = cz_clock_obj->res_base;
> +
> +       reg_val = readl(base + MISCCLKCNTL1);
> +
> +       return !(reg_val & OSCCLKENB);
> +}
> +
> +static const struct clk_ops acpd7219_clks_ops = {
> +       .enable = acpd7219_clks_enable,
> +       .disable = acpd7219_clks_disable,
> +       .is_enabled = acpd7219_clks_is_enabled,
> +};
> +
> +static int register_acpd7219_clocks(struct platform_device *pdev)

Where is the corresponding unregister?  Isn't this a module that can be
unloaded?

> +{
> +       struct clk *acp_clks;
> +       struct clk_lookup *acp_clks_lookup;
> +       struct cz_clock *cz_clock_obj;
> +       struct resource *res;
> +       struct device dev = pdev->dev;

struct device *dev = &pdev->dev;

Thanks,
-Dan
