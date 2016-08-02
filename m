From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] ASoC: simple-card-utils: add missing MODULE_xxx()
Date: Tue, 02 Aug 2016 11:50:48 -0700
Message-ID: <m2r3a7qa2f.fsf@baylibre.com>
References: <20160801233610.10479-1-khilman@baylibre.com>
	<877fc0hte3.wl%kuninori.morimoto.gx@renesas.com>
	<CAOi56cUjygjOiZ6OwRHXu0XsNMkJHeTB9KCOzTM9mzsuP78GOw@mail.gmail.com>
	<8760rjj20g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8760rjj20g.wl%kuninori.morimoto.gx@renesas.com> (Kuninori
	Morimoto's message of "Tue, 2 Aug 2016 03:22:08 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> writes:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> simple-card-utils might be used as module, but MODULE_xxx()
> information was missed. This patch adds it.
> Otherwise, we will have below error, and can't use it.
> Specil thanks to Kevin.
>
>> insmod simple-card-utils.ko
> simple_card_utils: module license 'unspecified' taints kernel.
> Disabling lock debugging due to kernel taint
> simple_card_utils: Unknown symbol snd_soc_of_parse_daifmt (err 0)
> simple_card_utils: Unknown symbol snd_soc_of_parse_card_name (err 0)
> insmod: can't insert 'simple-card-utils.ko': \
>         unknown symbol in module, or unknown parameter
>
> Reported-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>
>>> Kevin
>
> Thank you for your report. I think this patch can solve your issue.
> Can you check this ?

Your patch works, but as Mark pointed out, I didn't think that this was
the right fix as this isn't a module, but just library.

Kevin
