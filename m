From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: ak4642: Enable cache usage to fix crashes on resume
Date: Wed, 18 May 2016 20:05:42 +0200
Message-ID: <CAMuHMdXcsrwDrA_XvS2X23gHH-8i_amQBLcHyWCF0YvN9op-og@mail.gmail.com>
References: <1463593762-31871-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1463593762-31871-1-git-send-email-broonie@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, May 18, 2016 at 7:49 PM, Mark Brown <broonie@kernel.org> wrote:
> The ak4642 driver is using a regmap cache sync to restore the
> configuration of the chip on resume but (as Peter observed) does not
> actually define a register cache which means that the resume is never
> going to work and we trigger asserts in regmap.  Fix this by enabling
> caching.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org

Thanks, this gets rid of the

        kernel BUG at drivers/base/regmap/regcache.c:347!

I was seeing.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
