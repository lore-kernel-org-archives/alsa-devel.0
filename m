From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] sound: dmasound_atari: Mark expected
	switch fall-through
Date: Mon, 29 Jul 2019 17:35:16 +0200
Message-ID: <CAMuHMdWAboq1YxVVJUop0woJTcantfpftVoR8T5qm3KsAMyCPg@mail.gmail.com>
References: <20190729143320.GA8212@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B719F800E4
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 17:35:29 +0200 (CEST)
Received: by mail-wm1-f67.google.com with SMTP id v19so53906199wmj.5
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 08:35:29 -0700 (PDT)
In-Reply-To: <20190729143320.GA8212@embeddedor>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

Hi Gustavo,

Thanks for your patch!

On Mon, Jul 29, 2019 at 4:33 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 1449:24
>
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.

Have you compile-tested this?

This doesn't work with gcc version 8.2.0 (Ubuntu 8.2.0-1ubuntu2~18.04).
Turns out the warning only goes away when converting the indentation
of the switch() statement to match kernel style... Silly gcc...

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  sound/oss/dmasound/dmasound_atari.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
> index 83653683fd68..b5845e904ba1 100644
> --- a/sound/oss/dmasound/dmasound_atari.c
> +++ b/sound/oss/dmasound/dmasound_atari.c
> @@ -1449,7 +1449,7 @@ static int FalconMixerIoctl(u_int cmd, u_long arg)
>                 tt_dmasnd.input_gain =
>                         RECLEVEL_VOXWARE_TO_GAIN(data & 0xff) << 4 |
>                         RECLEVEL_VOXWARE_TO_GAIN(data >> 8 & 0xff);
> -               /* fall thru, return set value */
> +               /* fall through - return set value */
>             case SOUND_MIXER_READ_MIC:
>                 return IOCTL_OUT(arg,
>                         RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain >> 4 & 0xf) |

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
