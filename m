From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: fsi: Remove obsolete sh_fsi2 platform_device_id entry
Date: Thu, 16 Jul 2015 09:55:26 +0200
Message-ID: <CAMuHMdXPyvy8Koa37NCXtzmQX9td5k12ft=5T-0ET35jp1JtEQ@mail.gmail.com>
References: <1436875174-13960-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1436875174-13960-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, Jul 14, 2015 at 1:59 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Since the removal of the r8a7740 legacy board code in commit
> 1fa59bda21c7fa36 ("ARM: shmobile: Remove legacy board code for
> Armadillo-800 EVA"), all former users of the "sh_fsi2" platform device
> name are only supported in generic DT-only ARM multi-platform builds.
> The driver doesn't need to match platform devices by name anymore, hence
> remove the corresponding platform_device_id entry.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks like you applied this to spi/for-next instead of sound-asoc/for-next?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
