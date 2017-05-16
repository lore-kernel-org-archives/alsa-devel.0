From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: ASoC: rsnd: fix sound route path when using
	SRC6/SRC9
Date: Tue, 16 May 2017 17:06:08 +0200
Message-ID: <CAMuHMdXyc0Kt2Ec-k5xeJYTCpzoFfhEO_bbF1w2tUbyiRikR0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
 [209.85.214.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C5887266C59
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 17:06:10 +0200 (CEST)
Received: by mail-it0-f65.google.com with SMTP id l145so14371937ita.0
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 08:06:10 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

On Fri, Mar 31, 2017 at 9:32 PM, Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> Web:        https://git.kernel.org/torvalds/c/a1c2ff53726907aff5feb37e4cfd45c1ff626431
> Commit:     a1c2ff53726907aff5feb37e4cfd45c1ff626431
> Parent:     4b30eebfc35c67771b5f58d9274d3e321b72d7a8
> Refname:    refs/heads/master
> Author:     Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> AuthorDate: Wed Mar 1 03:51:00 2017 +0000
> Committer:  Mark Brown <broonie@kernel.org>
> CommitDate: Mon Mar 13 12:58:07 2017 +0000
>
>     ASoC: rsnd: fix sound route path when using SRC6/SRC9
>
>     This patch fixes the problem that the missing value of the route path
>     setting table and incorrect values are set in the CMD_ROUTE_SELECT
>     register.
>
>     Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
>     [Kuninori: shared data on MIX and non-MIX case]
>     Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>     Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/sh/rcar/cmd.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
> index abb5eaac854a..7d92a24b7cfa 100644
> --- a/sound/soc/sh/rcar/cmd.c
> +++ b/sound/soc/sh/rcar/cmd.c
> @@ -31,23 +31,24 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
>         struct rsnd_mod *mix = rsnd_io_to_mod_mix(io);
>         struct device *dev = rsnd_priv_to_dev(priv);
>         u32 data;
> +       u32 path[] = {
> +               [1] = 1 << 0,
> +               [5] = 1 << 8,
> +               [6] = 1 << 12,
> +               [9] = 1 << 15,
> +       };
>
>         if (!mix && !dvc)
>                 return 0;
>
> +       if (ARRAY_SIZE(path) < rsnd_mod_id(mod) + 1)
> +               return -ENXIO;
> +
>         if (mix) {
>                 struct rsnd_dai *rdai;
>                 struct rsnd_mod *src;
>                 struct rsnd_dai_stream *tio;
>                 int i;
> -               u32 path[] = {
> -                       [0] = 0,
> -                       [1] = 1 << 0,
> -                       [2] = 0,
> -                       [3] = 0,
> -                       [4] = 0,
> -                       [5] = 1 << 8
> -               };
>
>                 /*
>                  * it is assuming that integrater is well understanding about
> @@ -70,16 +71,19 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
>         } else {
>                 struct rsnd_mod *src = rsnd_io_to_mod_src(io);
>
> -               u32 path[] = {
> -                       [0] = 0x30000,
> -                       [1] = 0x30001,
> -                       [2] = 0x40000,
> -                       [3] = 0x10000,
> -                       [4] = 0x20000,
> -                       [5] = 0x40100
> +               u8 cmd_case[] = {
> +                       [0] = 0x3,
> +                       [1] = 0x3,
> +                       [2] = 0x4,
> +                       [3] = 0x1,
> +                       [4] = 0x2,
> +                       [5] = 0x4,
> +                       [6] = 0x1,
> +                       [9] = 0x2,
>                 };
>
> -               data = path[rsnd_mod_id(src)];
> +               data = path[rsnd_mod_id(src)] |

With gcc 4.9.0:

    sound/soc/sh/rcar/cmd.c: In function 'rsnd_cmd_init':
    sound/soc/sh/rcar/cmd.c:85:14: warning: array subscript is below
array bounds [-Warray-bounds]
       data = path[rsnd_mod_id(src)] |

> +                       cmd_case[rsnd_mod_id(src)] << 16;
>         }
>
>         dev_dbg(dev, "ctu/mix path = 0x%08x", data);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
