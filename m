From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] sound: dmasound_atari: Mark expected switch fall-through
Date: Tue, 30 Jul 2019 09:05:10 +0200
Message-ID: <CAMuHMdVuf7O3yRJ7EgjqQ=HdZSg8Qv4yVKmWM9b0McSYhX9MyA@mail.gmail.com>
References: <20190729205454.GA5084@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729205454.GA5084@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 29, 2019 at 10:55 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warning (Building: m68k):
>
> sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 1449:24
>
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Update code so switch and case statements are at the same indent.

Thanks, this time it works as expected.
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
