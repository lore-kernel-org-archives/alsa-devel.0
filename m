From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] sound: Disable the build of OSS drivers
Date: Fri, 12 May 2017 09:04:18 +0200
Message-ID: <CAMuHMdU9v4GX5ujgsrZCzarvG2j-=pF7_4pywUxaBY6mZwnOgA@mail.gmail.com>
References: <20170511205827.16446-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20170511205827.16446-1-tiwai@suse.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jaroslav Kysela <perex@perex.cz>, Linus Torvalds <torvalds@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

Hi Iwai-san,

On Thu, May 11, 2017 at 10:58 PM, Takashi Iwai <tiwai@suse.de> wrote:
> OSS drivers are left as badly unmaintained, and now we're facing a
> problem to clean up the hackish set_fs() usage in their codes.  Since
> most of drivers have been covered by ALSA, and the others are dead old
> and inactive, let's leave them RIP.
>
> This patch is the first step: disable the build of OSS drivers.
> We'll eventually drop the whole codes and clean up later.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

> --- a/sound/Kconfig
> +++ b/sound/Kconfig
> @@ -54,7 +54,7 @@ config SOUND_OSS_CORE_PRECLAIM
>
>           If unsure, say Y.
>
> -source "sound/oss/dmasound/Kconfig"
> +# source "sound/oss/dmasound/Kconfig"

Please note the dmasound drivers do not have ALSA equivalents.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
