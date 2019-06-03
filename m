From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] treewide: fix typos of SPDX-License-Identifier
Date: Mon, 3 Jun 2019 09:07:54 +0200
Message-ID: <CAMuHMdXXbEr=oU0amKLbEkTm3cZ=jyQuk1-aZa5L4JL_dUmYMw@mail.gmail.com>
References: <20190601032242.10405-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190601032242.10405-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kees Cook <keescook@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joe Perches <joe@perches.com>, linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Kishon Vijay Abraham I <kishon@ti.com>, linux-stm32@
List-Id: alsa-devel@alsa-project.org

Hi Yamada-san,

On Sat, Jun 1, 2019 at 5:24 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Prior to the adoption of SPDX, it was difficult for tools to determine
> the correct license due to incomplete or badly formatted license text.
> The SPDX solves this issue, assuming people can correctly spell
> "SPDX-License-Identifier" although this assumption is broken in some
> places.
>
> Since scripts/spdxcheck.py parses only lines that exactly matches to
> the correct tag, it cannot (should not) detect this kind of error.
>
> If the correct tag is missing, scripts/checkpatch.pl warns like this:
>
>  WARNING: Missing or malformed SPDX-License-Identifier tag in line *
>
> So, people should notice it before the patch submission, but in reality
> broken tags sometimes slip in. The checkpatch warning is not useful for
> checking the committed files globally since large number of files still
> have no SPDX tag.
>
> Also, I am not sure about the legal effect when the SPDX tag is broken.
>
> Anyway, these typos are absolutely worth fixing. It is pretty easy to
> find suspicious lines by grep.
>
>   $ git grep --not -e SPDX-License-Identifier --and -e SPDX- -- \
>     :^LICENSES :^scripts/spdxcheck.py :^*/license-rules.rst
>   arch/arm/kernel/bugs.c:// SPDX-Identifier: GPL-2.0
>   drivers/phy/st/phy-stm32-usbphyc.c:// SPDX-Licence-Identifier: GPL-2.0
>   drivers/pinctrl/sh-pfc/pfc-r8a77980.c:// SPDX-Lincense-Identifier: GPL 2.0
>   lib/test_stackinit.c:// SPDX-Licenses: GPLv2
>   sound/soc/codecs/max9759.c:// SPDX-Licence-Identifier: GPL-2.0
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks for your patch!

>  drivers/pinctrl/sh-pfc/pfc-r8a77980.c | 2 +-

For the sh-pfc change:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
