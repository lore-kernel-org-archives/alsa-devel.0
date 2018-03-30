From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH v4] ASoC: AMD: Enable/Disable auxiliary
 clock via common clock framework
Date: Fri, 30 Mar 2018 15:32:26 +0530
Message-ID: <1853fd2f-940f-2ed1-5f18-7f464c9c8f92@amd.com>
References: <1522054560-31088-1-git-send-email-akshu.agrawal@amd.com>
 <CAGS+omBxh_xN790Z-bvQtkD1TZACtvEGK8ZrvVkc27nwZbVKhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0088.outbound.protection.outlook.com [104.47.40.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 442CB2671B9
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 12:02:39 +0200 (CEST)
In-Reply-To: <CAGS+omBxh_xN790Z-bvQtkD1TZACtvEGK8ZrvVkc27nwZbVKhg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 3/27/2018 9:52 AM, Daniel Kurtz wrote:
> Hi Akshu
> 
> On Mon, Mar 26, 2018 at 3:12 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
> 
>> This enables/disables and sets auxiliary clock at 25Mhz. It uses
>> common clock framework for proper ref counting. This approach will
>> save power in comparison to keeping it always On in firmware.
> 
>> V2: Correcting the pin to OSCOUT1 from OSCOUT2
>> V3: Fix error/warnings from kbuild test
>> V4: Fix build errors for platform which do not support CONFIG_COMMON_CLK
> 
>> TEST= aplay -vv <file>
>> check register to see clock enabled
>> kill aplay
>> check register to see clock disabled
> 
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>    sound/soc/amd/acp-da7219-max98357a.c | 144
> ++++++++++++++++++++++++++++++++++-
>>    1 file changed, 142 insertions(+), 2 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
> b/sound/soc/amd/acp-da7219-max98357a.c
>> index 99c6b5c..3c77803 100644
>> --- a/sound/soc/amd/acp-da7219-max98357a.c
>> +++ b/sound/soc/amd/acp-da7219-max98357a.c
>> @@ -30,10 +30,13 @@
>>    #include <sound/soc-dapm.h>
>>    #include <sound/jack.h>
>>    #include <linux/clk.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/clk-provider.h>
>>    #include <linux/gpio.h>
>>    #include <linux/module.h>
>>    #include <linux/i2c.h>
>>    #include <linux/acpi.h>
>> +#include <linux/types.h>
> 
>>    #include "../codecs/da7219.h"
>>    #include "../codecs/da7219-aad.h"
>> @@ -41,6 +44,20 @@
>>    #define CZ_PLAT_CLK 24000000
>>    #define MCLK_RATE 24576000
>>    #define DUAL_CHANNEL           2
>> +#define CLKDRVSTR2     0x28
>> +#define MISCCLKCNTL1   0x40
>> +#define OSCCLKENB      2
>> +#define OSCOUT1CLK25MHZ        16
> 
> These defines do not belong with the clocks above them, so please separate
> them.
> It might be helpful to add a comment describing what these addresses are,
> ie that they are registers of the SoC.
> 

Accepted.

>> +
>> +struct cz_clock {
>> +       const char* acp_clks_name;
> 
> Why store this in the struct?
> 

need to get res_base in clk_enable. Hence, better to keep them
in one struct

>> +#ifdef CONFIG_COMMON_CLK
>> +       struct clk_hw acp_clks_hw;
>> +#endif
>> +       struct clk_lookup *acp_clks_lookup;
> 
> Why store this in the struct?
> 
>> +       struct clk *acp_clks;
> 
> Why store this in the struct?
> 
>> +       void __iomem *res_base;
>> +};
> 
>>    static struct snd_soc_jack cz_jack;
>>    struct clk *da7219_dai_clk;
>> @@ -91,6 +108,8 @@ static int cz_da7219_hw_params(struct
> snd_pcm_substream *substream,
>>    {
>>           int ret = 0;
>>           struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +       struct snd_soc_card *card = rtd->card;
>> +       struct clk *acpd7219_clk;
> 
>>           ret = clk_prepare_enable(da7219_dai_clk);
>>           if (ret < 0) {
>> @@ -98,13 +117,27 @@ static int cz_da7219_hw_params(struct
> snd_pcm_substream *substream,
>>                   return ret;
>>           }
> 
>> +       acpd7219_clk = clk_get(card->dev, "acpd7219-clks");
>> +       ret = clk_prepare_enable(acpd7219_clk);
>> +       if (ret < 0) {
>> +               dev_err(rtd->dev, "can't enable oscillator clock %d\n",
> ret);
>> +               return ret;
>> +       }
>> +
>>           return ret;
>>    }
> 
>>    static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
>>    {
>> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +       struct snd_soc_card *card = rtd->card;
>> +       struct clk *acpd7219_clk;
>> +
>>           clk_disable_unprepare(da7219_dai_clk);
> 
>> +       acpd7219_clk = clk_get(card->dev, "acpd7219-clks");
>> +       clk_disable_unprepare(acpd7219_clk);
>> +
>>           return 0;
>>    }
> 
>> @@ -237,9 +270,113 @@ static int cz_fe_startup(struct snd_pcm_substream
> *substream)
>>           .num_controls = ARRAY_SIZE(cz_mc_controls),
>>    };
> 
>> +#ifdef CONFIG_COMMON_CLK
>> +static int acpd7219_clks_prepare(struct clk_hw *hw)
> 
> Should setting OSCCLKENB be the clock enable rather than prepare?
> 

Accepted.

>> +{
>> +       u32 reg_val;
>> +       struct cz_clock *cz_clock_obj =
>> +               container_of(hw, struct cz_clock, acp_clks_hw);
> 
> nit: just "cz_clock" should be enough for all of these.
>

build failure with just cz_clock

>> +       void __iomem *base = cz_clock_obj->res_base;
>> +
>> +       reg_val = readl(base + MISCCLKCNTL1);
>> +       reg_val &= ~(0x1 << OSCCLKENB);
>> +       writel(reg_val, base + MISCCLKCNTL1);
>> +       reg_val = readl(base + CLKDRVSTR2);
>> +       reg_val |= (0x1 << OSCOUT1CLK25MHZ);
>> +       writel(reg_val, base + CLKDRVSTR2);
> 
> Writing OSCOUT1CLK25MHZ sets the clock to 25 MHz (ie, instead of 48 MHz).
> So, technically this part should probably be in a set_rate() rather than
> prepare() [and reject other frequencies]?
>

We need to set it always at 25Mhz. We initialize sysclk and set pll on 
that frequency. Though we are setting rate of clock but parameters rate 
and parent_rate will be of no use. Its more like enabling a clock at as 
fixed rate.

>> +
>> +       return 0;
>> +}
>> +
>> +static void acpd7219_clks_unprepare(struct clk_hw *hw)
> 
> Similarly, can this be disable()?
> 

Accepted.

>> +{
>> +       u32 reg_val;
>> +       struct cz_clock *cz_clock_obj =
>> +               container_of(hw, struct cz_clock, acp_clks_hw);
>> +       void __iomem *base = cz_clock_obj->res_base;
>> +
>> +       reg_val = readl(base + MISCCLKCNTL1);
>> +       reg_val |= (0x1 << OSCCLKENB);
>> +       writel(reg_val, base + MISCCLKCNTL1);
>> +}
>> +
>> +static int acpd7219_clks_is_enabled(struct clk_hw *hw)
>> +{
>> +       u32 reg_val;
>> +       struct cz_clock *cz_clock_obj =
>> +               container_of(hw, struct cz_clock, acp_clks_hw);
>> +       void __iomem *base = cz_clock_obj->res_base;
>> +
>> +       reg_val = readl(base + MISCCLKCNTL1);
>> +
>> +       return !(reg_val & OSCCLKENB);
>> +}
>> +
>> +const struct clk_ops acpd7219_clks_ops = {
> 
> static const ...
> 

Accepted.

>> +       .prepare = acpd7219_clks_prepare,
>> +       .unprepare = acpd7219_clks_unprepare,
>> +       .is_enabled = acpd7219_clks_is_enabled,
>> +};
>> +
>> +static int register_acpd7219_clocks(struct platform_device *pdev)
> 
> Can this be:
> __init
> 

No, seems there is code calling code in this function.

>> +{
>> +       struct clk_init_data init = {};
>> +       struct clk *acp_clks;
>> +       struct clk_lookup *acp_clks_lookup;
>> +       struct cz_clock *cz_clock_obj;
>> +       struct resource *res;
>> +       struct device dev = pdev->dev;
>> +
>> +       cz_clock_obj = kzalloc(sizeof(struct cz_clock), GFP_KERNEL);
>> +       if (!cz_clock_obj)
>> +               return -ENOMEM;
>> +
>> +       cz_clock_obj->acp_clks_name = "acpd7219-clks";
>> +
>> +       init.parent_names = NULL;
>> +       init.num_parents = 0;
>> +       init.name = cz_clock_obj->acp_clks_name;
>> +       init.ops = &acpd7219_clks_ops;
> 
> I think you can just do this all during: "struct clk_init_data init = { }".
> In fact, can't this done like this instead:
> 
> static const struct clk_init_data __initconst = {
>     .name = "acpd7219-clks";
>     .ops = &acpd7219_clks_ops;
> };
>

Accepted.

>> +       cz_clock_obj->acp_clks_hw.init = &init;
>> +
>> +       acp_clks = devm_clk_register(&dev, &cz_clock_obj->acp_clks_hw);
>> +       if (IS_ERR(acp_clks))
>> +       {
>> +               dev_err(&dev, "Failed to register DAI clocks: %ld\n",
>> +                        PTR_ERR(acp_clks));
>> +               return -EINVAL;
> 
> propagate PTR_ERR(acp_clks), instead?
> 

Accepted.

>> +       }
>> +       cz_clock_obj->acp_clks = acp_clks;
>> +
>> +       acp_clks_lookup = clkdev_create(acp_clks,
> cz_clock_obj->acp_clks_name,
>> +                                       "%s", dev_name(&dev));
>> +       if (!acp_clks_lookup)
>> +               dev_warn(&dev, "Failed to create DAI clkdev");
>> +       else
>> +               cz_clock_obj->acp_clks_lookup =
> acp_clks_lookup;clkdev_create
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res) {
>> +               dev_err(&pdev->dev, "Failed to get misc io resource.\n");
>> +               return -EINVAL;
>> +       }
>> +       cz_clock_obj->res_base = devm_ioremap_nocache(&pdev->dev,
> res->start,
>> +                                       resource_size(res));
>> +       if (!cz_clock_obj->res_base)
>> +               return -ENOMEM;
>> +
>> +       return 0;
>> +}
>> +#else
>> +static int register_acpd7219_clocks(struct platform_device *pdev)
>> +{
>> +       return 0;
>> +}
>> +#endif /* CONFIG_COMMON_CLK */
>> +
>>    static int cz_probe(struct platform_device *pdev)
>>    {
>> -       int ret;
>> +       int ret = 0;
> 
> Do not initialize this before it is used.
>

Accepted.

>>           struct snd_soc_card *card;
> 
>>           card = &cz_card;
>> @@ -252,7 +389,10 @@ static int cz_probe(struct platform_device *pdev)
>>                                   cz_card.name, ret);
>>                   return ret;
>>           }
>> -       return 0;
>> +
>> +       ret = register_acpd7219_clocks(pdev);
>> +
>> +       return ret;
> 
> Just:
>     return register_acpd7219_clocks(pdev);
> 

Accepted.

> Thanks,
> -Dan
> 
>>    }
> 
>>    static const struct acpi_device_id cz_audio_acpi_match[] = {
>> --
>> 1.9.1
