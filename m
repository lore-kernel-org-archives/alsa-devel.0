From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: sun4i-i2s: Add quirks for newer SoCs
Date: Tue, 20 Dec 2016 20:40:18 +0100
Message-ID: <CAEKpxBmGmG_6yuJ2eddSYE3_QUjGkMh1oXyzaJ_PEBK5PD=OaQ@mail.gmail.com>
References: <20161220145524.31047-1-codekipper@gmail.com> <20161220191656.xrmovtlslwcofsts@lukather>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBI4S43BAKGQEKERDEZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161220191656.xrmovtlslwcofsts@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 20 December 2016 at 20:16, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hi,
>
> On Tue, Dec 20, 2016 at 03:55:24PM +0100, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Newer SoCs have additional functionality so a quirks structure
>> has been added to handle them. So far we've seen the use of a
>> reset controller, a different address for the TXFIFO and varying
>> register changes.
>>
>> This patch prepares the driver for these changes and adds the
>> reset specifier.
>>
>> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  2 +
>>  sound/soc/sunxi/sun4i-i2s.c                        | 47 ++++++++++++++++++++--
>>  2 files changed, 45 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> index 7a2c0945fd22..494a881ccd21 100644
>> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
>> @@ -18,6 +18,8 @@ Required properties:
>>     - "apb" : clock for the I2S bus interface
>>     - "mod" : module clock for the I2S controller
>>  - #sound-dai-cells : Must be equal to 0
>> +- resets: reset specifier for the ahb reset (A31 and newer only)
>> +
>>
>>  Example:
>>
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index f24d19526603..80fe4f1d6e3b 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -14,9 +14,11 @@
>>  #include <linux/clk.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/module.h>
>> +#include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regmap.h>
>> +#include <linux/reset.h>
>>
>>  #include <sound/dmaengine_pcm.h>
>>  #include <sound/pcm_params.h>
>> @@ -92,6 +94,7 @@ struct sun4i_i2s {
>>       struct clk      *bus_clk;
>>       struct clk      *mod_clk;
>>       struct regmap   *regmap;
>> +     struct reset_control *rst;
>>
>>       unsigned int    mclk_freq;
>>
>> @@ -104,6 +107,13 @@ struct sun4i_i2s_clk_div {
>>       u8      val;
>>  };
>>
>> +struct sun4i_i2s_quirks {
>> +     unsigned int    reg_dac_txdata; /* TX FIFO offset for DMA config */
>> +     bool            has_reset;
>> +     const struct regmap_config      *sun4i_i2s_regmap;
>> +     const struct snd_soc_dai_ops    *ops;
>> +};
>> +
>
> This is quite hard to review without actual example of what you'll put
> in there.
Fair enough...I have a patch for the A31 but haven't got any hardware
that I can verify it on. I've confirmed on the H3 but I feel like that
patch needs some tidying up. That being said...I'll push it as a patch
set and we can talk about the setup.

>
>>  static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
>>       { .div = 2, .val = 0 },
>>       { .div = 4, .val = 1 },
>> @@ -541,7 +551,6 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
>>               .rates = SNDRV_PCM_RATE_8000_192000,
>>               .formats = SNDRV_PCM_FMTBIT_S16_LE,
>>       },
>> -     .ops = &sun4i_i2s_dai_ops,
>>       .symmetric_rates = 1,
>>  };
>>
>> @@ -655,6 +664,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>>  {
>>       struct sun4i_i2s *i2s;
>>       struct resource *res;
>> +     const struct sun4i_i2s_quirks *quirks;
>>       void __iomem *regs;
>>       int irq, ret;
>>
>> @@ -680,8 +690,14 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>>               return PTR_ERR(i2s->bus_clk);
>>       }
>>
>> +     quirks = of_device_get_match_data(&pdev->dev);
>> +     if (quirks == NULL) {
>> +             dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
>> +             return -ENODEV;
>> +     }
>> +
>>       i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
>> -                                         &sun4i_i2s_regmap_config);
>> +                                         quirks->sun4i_i2s_regmap);
>>       if (IS_ERR(i2s->regmap)) {
>>               dev_err(&pdev->dev, "Regmap initialisation failed\n");
>>               return PTR_ERR(i2s->regmap);
>> @@ -692,13 +708,25 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>>               dev_err(&pdev->dev, "Can't get our mod clock\n");
>>               return PTR_ERR(i2s->mod_clk);
>>       }
>> +
>
> Spurious change?
ACK
>
>>
>> -     i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
>> +     i2s->playback_dma_data.addr = res->start + quirks->reg_dac_txdata;
>>       i2s->playback_dma_data.maxburst = 4;
>>
>>       i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
>>       i2s->capture_dma_data.maxburst = 4;
>>
>> +     if (quirks->has_reset) {
>> +             i2s->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
>> +             if (IS_ERR(i2s->rst) && PTR_ERR(i2s->rst) == -EPROBE_DEFER) {
>> +                     ret = -EPROBE_DEFER;
>> +                     dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
>> +                     goto err_pm_disable;
>> +             }
>> +             if (!IS_ERR(i2s->rst))
>> +                     reset_control_deassert(i2s->rst);
>> +     }
>> +
>
> That reset line is not optional. The <A31 SoCs don't need it, and you
> cover that case already, but it is definitely mandatory for the A31.
OK..I'll search for a better function call. Thanks for this and the
other reviews.
CK
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
