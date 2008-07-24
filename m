From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Thu, 24 Jul 2008 19:19:15 +0200
Message-ID: <4888B993.2040101@keyaccess.nl>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>	<4883632A.8090106@keyaccess.nl>	<4887A28F.90506@keyaccess.nl>
	<20080724072620.4197510c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 75CEC249A3
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 19:16:56 +0200 (CEST)
In-Reply-To: <20080724072620.4197510c.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

*** 0001-wss_lib-move-cs4231_lib-into-wss_lib.patch

Reviewed-by: Rene Herman <rene.herman@gmail.ccom>


*** 0002-wss_lib-rename-cs4231.h-into-wss.h.patch

Reviewed-by: Rene Herman <rene.herman@gmail.ccom>


*** 0003-wss-rename-cs4321_foo-to-wss_foo.patch

Outstanding comments.


*** 0004-wss-use-stuct-snd_wss-instead-of-snd_ad1848.patch

> +++ b/include/sound/ad1848.h
> 
> [ ... ]
> 
> +#include "wss.h"

Bad (not at top and "") but given that it's going anyway...


*** 0005-wss_lib-use-wss-constants-instead-of-ad1848-ones.patch

> --- a/sound/isa/ad1848/ad1848_lib.c
> +++ b/sound/isa/ad1848/ad1848_lib.c
> @@ -283,14 +283,12 @@ static int snd_ad1848_trigger(struct snd_wss *chip, unsigned char what,
>                         return 0;
>                 }
>                 snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL] |= what);
> -               chip->mode |= AD1848_MODE_RUNNING;

Is this now done in generic code? Not necessary anymore? Was no comment 
in the changelog.

>  static const char *snd_ad1848_chip_id(struct snd_wss *chip)
>  {
>         switch (chip->hardware) {
> -       case AD1848_HW_AD1847:  return "AD1847";
> -       case AD1848_HW_AD1848:  return "AD1848";
> -       case AD1848_HW_CS4248:  return "CS4248";
> -       case AD1848_HW_CMI8330: return "CMI8330/C3D";
> -       default:                return "???";
> +       case WSS_HW_AD1847:
> +               return "AD1847";
> +       case WSS_HW_AD1848:
> +               return "AD1848";
> +       case WSS_HW_CS4248:
> +               return "CS4248";
> +       case WSS_HW_CMI8330:
> +               return "CMI8330/C3D";
> +       default:
> +               return "???";
>         }
>  }

These kinds of switches are just about the only time you get to 
knowingly ignore coding style and you forego the opportunity? Tsssk...

> --- a/sound/isa/opti9xx/opti92x-ad1848.c
> +++ b/sound/isa/opti9xx/opti92x-ad1848.c
> @@ -775,7 +775,7 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
>  #else
>         if ((error = snd_ad1848_create(card, chip->wss_base + 4,
>                                        chip->irq, chip->dma1,
> -                                      AD1848_HW_DETECT, &codec)) < 0)
> +                                      WSS_HW_DETECT, &codec)) < 0)
>                 return error;
>         if ((error = snd_ad1848_pcm(codec, 0, &pcm)) < 0)
>                 return error;

and

> --- a/sound/isa/sgalaxy.c
> +++ b/sound/isa/sgalaxy.c
> @@ -265,7 +265,7 @@ static int __devinit snd_sgalaxy_probe(struct device *devptr, unsigned int dev)
>  
>         if ((err = snd_ad1848_create(card, wssport[dev] + 4,
>                                      xirq, xdma1,
> -                                    AD1848_HW_DETECT, &chip)) < 0)
> +                                    WSS_HW_DETECT, &chip)) < 0)
>                 goto _err;
>         card->private_data = chip;

For those that come after -- those error ifs are split when they are 
turned into snd_wss_create() later.


*** 0006-wss_lib-replace-ad1848-mixer-element-macros-with-ws.patch

>  #define AD1848_SINGLE_TLV(xname, xindex, reg, shift, mask, invert, xtlv) \
> -{ .name = xname, \
> -  .index = xindex, \
> -  .type = AD1848_MIX_SINGLE, \
> -  .private_value = AD1848_MIXVAL_SINGLE(reg, shift, mask, invert), \
> -  .tlv = xtlv }
> +{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
> +  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
> +  .name = xname, .index = xindex, \
> +  .info = snd_ad1848_info_single, \
> +  .get = snd_ad1848_get_single, .put = snd_ad1848_put_single, \
> +  .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24), \
> +  .tlv = { .p = (xtlv) } }

Please just one per line (aligned is nice...)

>  #define AD1848_DOUBLE_TLV(xname, xindex, left_reg, right_reg, shift_left, shift_right, mask, invert, xtlv) \
> -{ .name = xname, \
> -  .index = xindex, \
> -  .type = AD1848_MIX_DOUBLE, \
> -  .private_value = AD1848_MIXVAL_DOUBLE(left_reg, right_reg, shift_left, shift_right, mask, invert), \
> -  .tlv = xtlv }
> -
> -static struct ad1848_mix_elem snd_ad1848_controls[] = {
> -AD1848_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
> -AD1848_DOUBLE_TLV("PCM Playback Volume", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1,
> +{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
> +  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
> +  .name = xname, .index = xindex, \
> +  .info = snd_ad1848_info_double, \
> +  .get = snd_ad1848_get_double, .put = snd_ad1848_put_double, \
> +  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | \
> +                  (shift_right << 19) | (mask << 24) | (invert << 22), \
> +  .tlv = { .p = (xtlv) } }

Same.

Throughout this patch there's also still the comment about ignoring the 
80-column thing with these macros. The cmi8330.c ones are a wonderful 
example of how much worse it gets. It's horrible.


*** 0007-wss_lib-use-CS4231P-instead-of-AD1848P-kill-the-AD.patch

> static void snd_ad1848_debug(struct snd_wss *chip)

Same. Otherwise

Reviewed-by: Rene Herman <rene.herman@gmail.com>

One other comment:

> diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
> index 08997d0..f695c85 100644
> --- a/sound/isa/wss/wss_lib.c
> +++ b/sound/isa/wss/wss_lib.c
> @@ -164,7 +164,6 @@ static inline void wss_outb(struct snd_wss *chip, u8 offset, u8 val)
>  {
>         outb(val, chip->port + offset);
>  }
> -EXPORT_SYMBOL(snd_wss_out);
>  
>  static inline u8 wss_inb(struct snd_wss *chip, u8 offset)
>  {
> @@ -228,6 +227,7 @@ void snd_wss_out(struct snd_wss *chip, unsigned char reg, unsigned char value)
>         snd_printdd("codec out - reg 0x%x = 0x%x\n",
>                         chip->mce_bit | reg, value);
>  }
> +EXPORT_SYMBOL(snd_wss_out);

Ah. This fixes up one of my comments from yesterday already. If this 
finds its way into 3, it should ofcourse be gone here.


*** 0008-wss_lib-use-wss-mixer-code-instead-of-ad1848-one.patch

> +#define WSS_SINGLE_TLV(xname, xindex, reg, shift, mask, invert, xtlv) \
> +{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
> +  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
> +  .name = xname, .index = xindex, \
> +  .info = snd_wss_info_single, \
> +  .get = snd_wss_get_single, .put = snd_wss_put_single, \
> +  .private_value = reg | (shift << 8) | (mask << 16) | (invert << 24), \
> +  .tlv = { .p = (xtlv) } }
> +
> +#define WSS_DOUBLE_TLV(xname, xindex, left_reg, right_reg, \
> +                       shift_left, shift_right, mask, invert, xtlv) \
> +{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
> +  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
> +  .name = xname, .index = xindex, \
> +  .info = snd_wss_info_double, \
> +  .get = snd_wss_get_double, .put = snd_wss_put_double, \
> +  .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | \
> +                  (shift_right << 19) | (mask << 24) | (invert << 22), \
> +  .tlv = { .p = (xtlv) } }

Ofcourse same with the please one member per line.


*** 0009-wss_lib-use-wss-pcm-code-instead-of-ad1848-one.patch

> --- a/sound/isa/wss/wss_lib.c
> +++ b/sound/isa/wss/wss_lib.c
> @@ -363,7 +363,7 @@ static void snd_wss_busy_wait(struct snd_wss *chip)
>         for (timeout = 5; timeout > 0; timeout--)
>                 wss_inb(chip, CS4231P(REGSEL));
>         /* end of cleanup sequence */
> -       for (timeout = 250;
> +       for (timeout = 2500;
>              timeout > 0 && (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
>              timeout--)
>                 udelay(10);

Was this intentional? You comment on this in 10/10...

> @@ -1360,6 +1381,11 @@ static int snd_wss_capture_open(struct s
>  
>         runtime->hw = snd_wss_capture;
>  
> +       /* hardware limitation of older chipsets */
> +       if (chip->hardware == WSS_HW_INTERWAVE && chip->dma1 > 3)
> +               runtime->hw.formats &= ~(SNDRV_PCM_FMTBIT_IMA_ADPCM |
> +                                        SNDRV_PCM_FMTBIT_S16_BE);
> +

If you'll be posting a V2 series, might as well fold 11/10 in here.

> const char *snd_wss_chip_id(struct snd_wss *chip)

Comment about the switch getting uglier again.


*** 0010-wss_lib-use-wss-detection-code-instead-of-ad1848-on.patch

> +++ b/sound/isa/wss/wss_lib.c
> @@ -363,7 +363,7 @@ static void snd_wss_busy_wait(struct snd_wss *chip)
>         for (timeout = 5; timeout > 0; timeout--)
>                 wss_inb(chip, CS4231P(REGSEL));
>         /* end of cleanup sequence */
> -       for (timeout = 2500;
> +       for (timeout = 25000;
>              timeout > 0 && (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
>              timeout--)
>                 udelay(10);

So now it's 100x total. Is this as planned?

> -static int snd_wss_probe(struct snd_wss *chip)
> +static int snd_ad1848_probe(struct snd_wss *chip)
>  {
>         unsigned long flags;
> -       int i, id, rev;
> -       unsigned char *ptr;
> -       unsigned int hw;
> +       int i, id, rev, ad1847;
>  
> -#if 0
> -       snd_wss_debug(chip);
> -#endif
>         id = 0;
> -       for (i = 0; i < 50; i++) {
> +       ad1847 = 0;
> +       for (i = 0; i < 1000; i++) {
>                 mb();
> -               if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
> -                       udelay(2000);
> +               if (inb(chip->port + CS4231P(REGSEL)) & CS4231_INIT)
> +                       msleep(1);

Mmm. This was changed from a udelay(500) in the ad1848 case. It would be 
better to keep these kinds of really functional changes seperated out.

[ ... ]

> +       id = 0;
> +       if (chip->hardware == WSS_HW_DETECT)
> +               id = ad1847 ? WSS_HW_AD1847 : WSS_HW_AD1848;
> +
> +       spin_lock_irqsave(&chip->reg_lock, flags);
> +       inb(chip->port + CS4231P(STATUS));      /* clear any pendings IRQ */
> +       outb(0, chip->port + CS4231P(STATUS));

The original snd_ad1848_probe() had this below the below tests (which 
were also outside the spinlock)

> +       mb();
> +       if (id == WSS_HW_AD1848) {
> +               /* check if there are more than 16 registers */
> +               rev = snd_wss_in(chip, CS4231_MISC_INFO);
> +               snd_wss_out(chip, CS4231_MISC_INFO, 0x40);
> +               for (i = 0; i < 16; ++i) {
> +                       if (snd_wss_in(chip, i) != snd_wss_in(chip, i + 16)) {
> +                               id = WSS_HW_CMI8330;
> +                               break;
> +                       }
> +               }
> +               snd_wss_out(chip, CS4231_MISC_INFO, 0x00);
> +               if (id != WSS_HW_CMI8330 && (rev & 0x80))
> +                       id = WSS_HW_CS4248;

This one could also wind up different. Originally, snd_ad1848_probe() 
would conclude CS4248 immediately upon (rev & 0x80) without doing that 
register test. It's probably all fine, but snd_ad1848 function changed 
very significantly in the move and I'd rather it not do that. A patch
12 alone is much easier reviewable and any possible difficulty much 
easier bisectable. Could you do that?


*** 0011-wss-fix-capture-formats-limitations.patch

Can be folded, but otherwise no comments...

Will also put a next series through some tests here locally. I'l test at 
least a few OPTi 92x cards since I don't see these in your report. Any 
specific hardware you'd want tested more than others? I might have it.

Rene.
