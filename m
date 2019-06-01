From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] treewide: fix typos of SPDX-License-Identifier
Date: Sat, 1 Jun 2019 18:29:45 +0200
Message-ID: <20190601162945.GA6395@kroah.com>
References: <20190601032242.10405-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190601032242.10405-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 01, 2019 at 12:22:42PM +0900, Masahiro Yamada wrote:
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

Very nice catch, thanks!  I'll go queue this up now.

greg k-h
