From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: BUG since "ASoC: simple-card: Add pm callbacks to platform driver"
Date: Tue, 17 May 2016 13:02:38 +0200
Message-ID: <CAMuHMdWfHiaJzvSE5XARcgUPWiJR4ZJ82TdCA53vZ=rQ5wD7EQ@mail.gmail.com>
References: <CAMuHMdX6veYCvRdJjui3J0oPUKLhZB1Y8_AROnqhtZS9=HyNTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX6veYCvRdJjui3J0oPUKLhZB1Y8_AROnqhtZS9=HyNTg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2016 at 12:55 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> With today's sound-asoc/for-next, I'm seeing on r8a7791/koelsch and
> sh73a0/kzm9g:
>
>     kernel BUG at drivers/base/regmap/regcache.c:347!
>     Internal error: Oops - BUG: 0 [#1] SMP ARM
>     Modules linked in:
>     CPU: 0 PID: 20 Comm: kworker/0:1 Not tainted
> 4.6.0-koelsch-07135-g1481dd77fa7d01cb #2621
>     Hardware name: Generic R8A7791 (Flattened Device Tree)
>     Workqueue: events soc_resume_deferred
>     task: ef512100 ti: ef5a6000 task.ti: ef5a6000
>     PC is at regcache_sync+0xc/0x118
>     LR is at ak4642_resume+0x20/0x28

This is during resume from s2ram.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
