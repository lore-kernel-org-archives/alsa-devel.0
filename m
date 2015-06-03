From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH 5/7] ASoC: wm5100: remove bitwise
 operations involving GPIO level value
Date: Wed, 3 Jun 2015 03:50:04 -0700
Message-ID: <CA+7tXijtaM4tn3Mb+tbsd7JFbGjeh1yT=zTXPuCiFjqnvRjdvg@mail.gmail.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
 <1433200158-6890-5-git-send-email-vz@mleia.com>
 <20150602194558.GI14071@sirena.org.uk> <556E10CD.3090301@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 by alsa0.perex.cz (Postfix) with ESMTP id E63E1260535
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 12:50:05 +0200 (CEST)
Received: by igbpi8 with SMTP id pi8so107831886igb.0
 for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2015 03:50:04 -0700 (PDT)
In-Reply-To: <556E10CD.3090301@mleia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, Linus Walleij <linus.walleij@linaro.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 2, 2015 at 1:23 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:

> Hello Mark,
>
> On 02.06.2015 22:45, Mark Brown wrote:
> > On Tue, Jun 02, 2015 at 02:09:16AM +0300, Vladimir Zapolskiy wrote:
> >
> >> @@ -2244,26 +2244,27 @@ static inline struct wm5100_priv
> *gpio_to_wm5100(struct gpio_chip *chip)
> >>  static void wm5100_gpio_set(struct gpio_chip *chip, unsigned offset,
> int value)
> >>  {
> >>      struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
> >> +    unsigned int val = 0;
> >> +
> >> +    if (value)
> >> +            val = 0x1 << WM5100_GP1_LVL_SHIFT;
> >
> > Write this as an if/else so the reader doesn't have to wonder why you've
> > missed the handling of the false case.
> >
>
> the only objection I have is that the resulting code will be two lines
> longer. If you think this code is not clear enough (is "val" vs. "value"
> misleading?), I'll change the rest of my patches, which contain the same
> logic structure, please let me know.
>

const unsigned int val = value ?  (0x1 << WM5100_GP1_LVL_SHIFT) : 0;

Two lines shorter....

Have you measured the effect of going from int to bool on code size and
speed?  Clearly, the C code is getting longer as '!!' is transformed into
an if-then-else to set a new scratch variable.  But the compiler likely
converts both to a conditional branch or cmov type instruction.  What I
wonder is if converting gpiolib to use bools instead of ints is better just
because someone likes it more that way or if there are objective metrics
that show improvement.

BTW, with a little C algebra:
const unsigned int val = value ?  0x1 << WM5100_GP1_LVL_SHIFT : 0;
const unsigned int val = (value ?  0x1 : 0) << WM5100_GP1_LVL_SHIFT;
const unsigned int val = (!!value) << WM5100_GP1_LVL_SHIFT;  // definition
of ! operator

And now we're back to where we started, so I don't really see why this is
even necessary.  The semantics of the ! operator will be changed in a
future C version?
