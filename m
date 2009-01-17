From: "Theodore J. Allen" <tjallen@hws.edu>
Subject: Re: [PATCH] wss-lib: remove "pops" before each played
	sound
Date: Fri, 16 Jan 2009 22:55:43 -0500
Message-ID: <97774FA4-0C95-47C1-9C9F-6E7F816FCB25@hws.edu>
References: <20090116224730.fe9d786a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.hws.edu (smtp.hws.edu [64.89.144.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 224CA1037F8
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 04:55:46 +0100 (CET)
Received: from smtp.hws.edu (127.0.0.1) by smtp.hws.edu (MlfMTA v3.2r9) id
	he5bc60171s0 for <alsa-devel@alsa-project.org>;
	Fri, 16 Jan 2009 22:55:45 -0500 (envelope-from <tjallen@hws.edu>)
In-Reply-To: <20090116224730.fe9d786a.krzysztof.h1@poczta.fm>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Krzysztof,

I figured out the problem with the patches -- no need
to send me the patched wss_lib.c file.

It turns out that the patches are getting corrupted
by our institution's Microsoft Exchange mail system.
In addition to using our Exchange Server, I also have
my email forwarded to my home ISP (just in case) and
THAT copy of your message gave a patch file that works.
The funny thing is that, as far as I can tell, the two
different copies look identical in my mail client,
but they aren't.

The patched wss_lib.c does indeed get rid of the
"pops" for programs that use the ALSA interface.
Xmms, which uses the OSS compatibility interface,
still has a series of three clicks as it begins
playing, for some reason.  That's unfortunate.

I thank you for the fix for the "pops"!

Best,

	Ted

P.S. I still cannot get any MIDI out of the card, but
because it seems to load the microcode correctly (and
I made sure to use the same microcode that works correctly
on the other OSes), I must not be doing something that
I need to do to get the MIDI to work.  I've loaded the
microcode, loaded the snd-seq-midi module, and run
alsamixer, but still no success.  I must be missing
something.


On Jan 16, 2009, at 4:47 PM, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> A WSS codec is autocalibrated each time before
> playing sound. Do only one calibration during
> codec initialization.
>
> Complete snd_wss_calibrate_mute to mute loopback
> volume as well.
>
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
>  sound/isa/wss/wss_lib.c |   41 ++++++++++++ 
> +----------------------------
>  1 files changed, 13 insertions(+), 28 deletions(-)
>
> diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
> index 13299ae..f0c0be5 100644
> --- a/sound/isa/wss/wss_lib.c
> +++ b/sound/isa/wss/wss_lib.c
> @@ -181,25 +181,6 @@ static void snd_wss_wait(struct snd_wss *chip)
>                 udelay(100);
>  }
>
> -static void snd_wss_outm(struct snd_wss *chip, unsigned char reg,
> -                           unsigned char mask, unsigned char value)
> -{
> -       unsigned char tmp = (chip->image[reg] & mask) | value;
> -
> -       snd_wss_wait(chip);
> -#ifdef CONFIG_SND_DEBUG
> -       if (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
> -               snd_printk("outm: auto calibration time out - reg =  
> 0x%x, value = 0x%x\n", reg, value);
> -#endif
> -       chip->image[reg] = tmp;
> -       if (!chip->calibrate_mute) {
> -               wss_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
> -               wmb();
> -               wss_outb(chip, CS4231P(REG), tmp);
> -               mb();
> -       }
> -}
> -
>  static void snd_wss_dout(struct snd_wss *chip, unsigned char reg,
>                          unsigned char value)
>  {
> @@ -587,7 +568,15 @@ static void snd_wss_calibrate_mute(struct  
> snd_wss *chip, int mute)
>                              chip->image[CS4231_RIGHT_INPUT]);
>                 snd_wss_dout(chip, CS4231_LOOPBACK,
>                              chip->image[CS4231_LOOPBACK]);
> +       } else {
> +               snd_wss_dout(chip, CS4231_LEFT_INPUT,
> +                            0);
> +               snd_wss_dout(chip, CS4231_RIGHT_INPUT,
> +                            0);
> +               snd_wss_dout(chip, CS4231_LOOPBACK,
> +                            0xfd);
>         }
> +
>         snd_wss_dout(chip, CS4231_AUX1_LEFT_INPUT,
>                      mute | chip->image[CS4231_AUX1_LEFT_INPUT]);
>         snd_wss_dout(chip, CS4231_AUX1_RIGHT_INPUT,
> @@ -630,7 +619,6 @@ static void snd_wss_playback_format(struct  
> snd_wss *chip,
>         int full_calib = 1;
>
>         mutex_lock(&chip->mce_mutex);
> -       snd_wss_calibrate_mute(chip, 1);
>         if (chip->hardware == WSS_HW_CS4231A ||
>             (chip->hardware & WSS_HW_CS4232_MASK)) {
>                 spin_lock_irqsave(&chip->reg_lock, flags);
> @@ -681,7 +669,6 @@ static void snd_wss_playback_format(struct  
> snd_wss *chip,
>                         udelay(100);    /* this seems to help */
>                 snd_wss_mce_down(chip);
>         }
> -       snd_wss_calibrate_mute(chip, 0);
>         mutex_unlock(&chip->mce_mutex);
>  }
>
> @@ -693,7 +680,6 @@ static void snd_wss_capture_format(struct  
> snd_wss *chip,
>         int full_calib = 1;
>
>         mutex_lock(&chip->mce_mutex);
> -       snd_wss_calibrate_mute(chip, 1);
>         if (chip->hardware == WSS_HW_CS4231A ||
>             (chip->hardware & WSS_HW_CS4232_MASK)) {
>                 spin_lock_irqsave(&chip->reg_lock, flags);
> @@ -750,7 +736,6 @@ static void snd_wss_capture_format(struct  
> snd_wss *chip,
>                 spin_unlock_irqrestore(&chip->reg_lock, flags);
>                 snd_wss_mce_down(chip);
>         }
> -       snd_wss_calibrate_mute(chip, 0);
>         mutex_unlock(&chip->mce_mutex);
>  }
>
> @@ -807,6 +792,7 @@ static void snd_wss_init(struct snd_wss *chip)
>  {
>         unsigned long flags;
>
> +       snd_wss_calibrate_mute(chip, 1);
>         snd_wss_mce_down(chip);
>
>  #ifdef SNDRV_DEBUG_MCE
> @@ -830,6 +816,8 @@ static void snd_wss_init(struct snd_wss *chip)
>
>         snd_wss_mce_up(chip);
>         spin_lock_irqsave(&chip->reg_lock, flags);
> +       chip->image[CS4231_IFACE_CTRL] &= ~CS4231_AUTOCALIB;
> +       snd_wss_out(chip, CS4231_IFACE_CTRL, chip->image 
> [CS4231_IFACE_CTRL]);
>         snd_wss_out(chip,
>                     CS4231_ALT_FEATURE_1, chip->image 
> [CS4231_ALT_FEATURE_1]);
>         spin_unlock_irqrestore(&chip->reg_lock, flags);
> @@ -863,6 +851,7 @@ static void snd_wss_init(struct snd_wss *chip)
>                             chip->image[CS4231_REC_FORMAT]);
>         spin_unlock_irqrestore(&chip->reg_lock, flags);
>         snd_wss_mce_down(chip);
> +       snd_wss_calibrate_mute(chip, 0);
>
>  #ifdef SNDRV_DEBUG_MCE
>         snd_printk("init: (5)\n");
> @@ -921,8 +910,6 @@ static void snd_wss_close(struct snd_wss *chip,  
> unsigned int mode)
>                 mutex_unlock(&chip->open_mutex);
>                 return;
>         }
> -       snd_wss_calibrate_mute(chip, 1);
> -
>         /* disable IRQ */
>         spin_lock_irqsave(&chip->reg_lock, flags);
>         if (!(chip->hardware & WSS_HW_AD1848_MASK))
> @@ -955,8 +942,6 @@ static void snd_wss_close(struct snd_wss *chip,  
> unsigned int mode)
>         wss_outb(chip, CS4231P(STATUS), 0);     /* clear IRQ */
>         spin_unlock_irqrestore(&chip->reg_lock, flags);
>
> -       snd_wss_calibrate_mute(chip, 0);
> -
>         chip->mode = 0;
>         mutex_unlock(&chip->open_mutex);
>  }
> @@ -1149,7 +1134,7 @@ irqreturn_t snd_wss_interrupt(int irq, void  
> *dev_id)
>         if (chip->hardware & WSS_HW_AD1848_MASK)
>                 wss_outb(chip, CS4231P(STATUS), 0);
>         else
> -               snd_wss_outm(chip, CS4231_IRQ_STATUS, status, 0);
> +               snd_wss_out(chip, CS4231_IRQ_STATUS, status);
>         spin_unlock(&chip->reg_lock);
>         return IRQ_HANDLED;
>  }
> --
> 1.5.2.2
>
>
> ----------------------------------------------------------------------
> Speak Up. Angielski szybko i skutecznie. 3 miesiace nauki gratis.
> Sprawdz. >> http://link.interia.pl/f2019
>
