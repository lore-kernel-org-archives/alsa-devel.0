From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] ASoC: rsnd: Add device tree support for r8a774[35]
Date: Wed, 13 Dec 2017 14:45:28 +0100
Message-ID: <CAMuHMdX+DZd5KwmCib+DBifbuc=tp=0cs7ctGtJEJz85sEKr4w@mail.gmail.com>
References: <1513102155-47925-1-git-send-email-biju.das@bp.renesas.com> <1513172158-60367-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513172158-60367-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 2:35 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Document r8a774[35] specific compatible strings. The Renesas RZ/G1[ME]
> (r8a774[35]) sound modules are identical to the R-Car Gen2 family.
> No driver change is needed as the fallback compatible string
> "renesas,rcar_sound-gen2" activates the right code in the driver.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
