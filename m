From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] ASoC: simple-card: fix module load "unknown symbol" issue
Date: Mon, 1 Aug 2016 19:40:10 -0700
Message-ID: <CAOi56cUjygjOiZ6OwRHXu0XsNMkJHeTB9KCOzTM9mzsuP78GOw@mail.gmail.com>
References: <20160801233610.10479-1-khilman@baylibre.com> <877fc0hte3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <877fc0hte3.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 1, 2016 at 6:13 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Kevin
>
> Thank you for your patch
>
>> An ASoC driver using simple-card, when built as a module gets the
>> following error at module load time:
>>
>> [   23.571873] simple_card_utils: Unknown symbol snd_soc_of_parse_daifmt (err 0)
>> [   23.712726] simple_card_utils: Unknown symbol snd_soc_of_parse_card_name (err 0)
>>
>> fix this by including simple-card-utils.o symbols in the module build
>> its symols are resolved correctly.
>>
>> Tested on Davinci DA850-EVM using snd_soc_edma, snc_soc_davinci_mcasp,
>> with all of ASoC built as modules.
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>
> Hmm... strange...
>
> simple-card-utils will be used not only simple-card in the future,
> thus it should be build separately.
>
> And, snd_soc_of_parse_daifmt() and snd_soc_of_parse_card_name() are
> already exported on soc-core.c ?
>
> I tried it as module, but no error for me

The error I'm getting is not at build time, but at module load time.

The various snd related modules are autoloaded by udev events, but
during that time I see this:

[   23.571873] simple_card_utils: Unknown symbol snd_soc_of_parse_daifmt (err 0)
[   23.712726] simple_card_utils: Unknown symbol
snd_soc_of_parse_card_name (err 0)

and my patch fixes that problem so that the module symbols resolve at load time.

Kevin
