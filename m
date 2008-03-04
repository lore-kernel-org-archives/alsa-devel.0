From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 4/4] Convert non-SoC PXA2xx AC97 driver to clock API
Date: Tue, 4 Mar 2008 10:18:28 +0800
Message-ID: <f17812d70803031818l6b65eb1ewe649675ca943fa0b@mail.gmail.com>
References: <20080229154826.GA4756@rakim.wolfsonmicro.main>
	<1204300555-7490-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1204300555-7490-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1204300555-7490-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1204300555-7490-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1204300555-7490-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, eric miao <eric.miao@marvell.com>, linux-arm-kernel@lists.arm.linux.org.uk, Russell King <rmk@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Acked

On Fri, Feb 29, 2008 at 11:55 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>  Acked-by: Takashi Iwai <tiwai@suse.de>
>  Cc: alsa-devel@alsa-project.org
>  ---
>   sound/arm/pxa2xx-ac97.c |   48 +++++++++++++++++++++++++++++++++++++++-------
>   1 files changed, 40 insertions(+), 8 deletions(-)
>
>  diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
>  index 5d86e68..fd7bc86 100644
>  --- a/sound/arm/pxa2xx-ac97.c
>  +++ b/sound/arm/pxa2xx-ac97.c
>  @@ -16,6 +16,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/interrupt.h>
>   #include <linux/wait.h>
>  +#include <linux/clk.h>
>   #include <linux/delay.h>
>
>   #include <sound/core.h>
>  @@ -35,6 +36,10 @@
>   static DEFINE_MUTEX(car_mutex);
>   static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
>   static volatile long gsr_bits;
>  +static struct clk *ac97_clk;
>  +#ifdef CONFIG_PXA27x
>  +static struct clk *ac97conf_clk;
>  +#endif
>
>   /*
>   * Beware PXA27x bugs:
>  @@ -112,9 +117,9 @@ static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)
>         gsr_bits = 0;
>   #ifdef CONFIG_PXA27x
>         /* PXA27x Developers Manual section 13.5.2.2.1 */
>  -       pxa_set_cken(CKEN_AC97CONF, 1);
>  +       clk_enable(ac97conf_clk);
>         udelay(5);
>  -       pxa_set_cken(CKEN_AC97CONF, 0);
>  +       clk_disable(ac97conf_clk);
>         GCR = GCR_COLD_RST;
>         udelay(50);
>   #else
>  @@ -259,7 +264,7 @@ static int pxa2xx_ac97_do_suspend(struct snd_card *card, pm_message_t state)
>         if (platform_ops && platform_ops->suspend)
>                 platform_ops->suspend(platform_ops->priv);
>         GCR |= GCR_ACLINK_OFF;
>  -       pxa_set_cken(CKEN_AC97, 0);
>  +       clk_disable(ac97_clk);
>
>         return 0;
>   }
>  @@ -268,7 +273,7 @@ static int pxa2xx_ac97_do_resume(struct snd_card *card)
>   {
>         pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
>
>  -       pxa_set_cken(CKEN_AC97, 1);
>  +       clk_enable(ac97_clk);
>         if (platform_ops && platform_ops->resume)
>                 platform_ops->resume(platform_ops->priv);
>         snd_ac97_resume(pxa2xx_ac97_ac97);
>  @@ -335,8 +340,21 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
>   #ifdef CONFIG_PXA27x
>         /* Use GPIO 113 as AC97 Reset on Bulverde */
>         pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
>  +       ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
>  +       if (IS_ERR(ac97conf_clk)) {
>  +               ret = PTR_ERR(ac97conf_clk);
>  +               ac97conf_clk = NULL;
>  +               goto err;
>  +       }
>   #endif
>  -       pxa_set_cken(CKEN_AC97, 1);
>  +
>  +       ac97_clk = clk_get(&dev->dev, "AC97CLK");
>  +       if (IS_ERR(ac97_clk)) {
>  +               ret = PTR_ERR(ac97_clk);
>  +               ac97_clk = NULL;
>  +               goto err;
>  +       }
>  +       clk_enable(ac97_clk);
>
>         ret = snd_ac97_bus(card, 0, &pxa2xx_ac97_ops, NULL, &ac97_bus);
>         if (ret)
>  @@ -361,11 +379,19 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
>   err:
>         if (card)
>                 snd_card_free(card);
>  -       if (CKEN & (1 << CKEN_AC97)) {
>  +       if (ac97_clk) {
>                 GCR |= GCR_ACLINK_OFF;
>                 free_irq(IRQ_AC97, NULL);
>  -               pxa_set_cken(CKEN_AC97, 0);
>  +               clk_disable(ac97_clk);
>  +               clk_put(ac97_clk);
>  +               ac97_clk = NULL;
>  +       }
>  +#ifdef CONFIG_PXA27x
>  +       if (ac97conf_clk) {
>  +               clk_put(ac97conf_clk);
>  +               ac97conf_clk = NULL;
>         }
>  +#endif
>         return ret;
>   }
>
>  @@ -378,7 +404,13 @@ static int __devexit pxa2xx_ac97_remove(struct platform_device *dev)
>                 platform_set_drvdata(dev, NULL);
>                 GCR |= GCR_ACLINK_OFF;
>                 free_irq(IRQ_AC97, NULL);
>  -               pxa_set_cken(CKEN_AC97, 0);
>  +               clk_disable(ac97_clk);
>  +               clk_put(ac97_clk);
>  +               ac97_clk = NULL;
>  +#ifdef CONFIG_PXA27x
>  +               clk_put(ac97conf_clk);
>  +               ac97conf_clk = NULL;
>  +#endif
>         }
>
>         return 0;
>  --
>  1.5.4.3
>
>
>  -------------------------------------------------------------------
>  List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
>  FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
>  Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>



-- 
Cheers
- eric

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
