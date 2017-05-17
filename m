From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: ASoC: rsnd: fix sound route path when using SRC6/SRC9
Date: Wed, 17 May 2017 09:32:21 +0200
Message-ID: <CAMuHMdW7JpNao7jik5nFg3NxyWvs180YRWucA4co7_hLGomSUQ@mail.gmail.com>
References: <CAMuHMdXyc0Kt2Ec-k5xeJYTCpzoFfhEO_bbF1w2tUbyiRikR0w@mail.gmail.com>
 <87pof846ie.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87pof846ie.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

On Wed, May 17, 2017 at 3:32 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > @@ -70,16 +71,19 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
>> >         } else {
>> >                 struct rsnd_mod *src = rsnd_io_to_mod_src(io);
>> >
>> > -               u32 path[] = {
>> > -                       [0] = 0x30000,
>> > -                       [1] = 0x30001,
>> > -                       [2] = 0x40000,
>> > -                       [3] = 0x10000,
>> > -                       [4] = 0x20000,
>> > -                       [5] = 0x40100
>> > +               u8 cmd_case[] = {
>> > +                       [0] = 0x3,
>> > +                       [1] = 0x3,
>> > +                       [2] = 0x4,
>> > +                       [3] = 0x1,
>> > +                       [4] = 0x2,
>> > +                       [5] = 0x4,
>> > +                       [6] = 0x1,
>> > +                       [9] = 0x2,
>> >                 };
>> >
>> > -               data = path[rsnd_mod_id(src)];
>> > +               data = path[rsnd_mod_id(src)] |
>>
>> With gcc 4.9.0:
>>
>>     sound/soc/sh/rcar/cmd.c: In function 'rsnd_cmd_init':
>>     sound/soc/sh/rcar/cmd.c:85:14: warning: array subscript is below
>> array bounds [-Warray-bounds]
>>        data = path[rsnd_mod_id(src)] |
>
> Hmm....
> I tried random code/compile, but gcc behavior seems strange.
> Fore example if I removed next line, this warning disappeard
>
> -               data = path[rsnd_mod_id(src)] |
> -                       cmd_case[rsnd_mod_id(src)] << 16;
> +               data = path[rsnd_mod_id(src)];
>
> Is this related to this ?
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=59124

Perhaps.

I guess the main question is: can src be NULL here?
If yes, rsnd_mod_id(src) will be -1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
