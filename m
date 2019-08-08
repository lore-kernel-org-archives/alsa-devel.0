From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Subject: Re: [PATCH 15/15] ASoC: soc-core: add
	soc_unbind_aux_dev()
Date: Thu, 8 Aug 2019 09:45:30 -0700
Message-ID: <CAFQqKeW=ibEs3jN==8DGJ-OvbHcTqKbb1VMTHjWupnsDjm5m5w@mail.gmail.com>
References: <87zhkk6wdy.wl-kuninori.morimoto.gx@renesas.com>
 <87ef1w6w8o.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 757A8F800E3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 18:45:42 +0200 (CEST)
Received: by mail-yb1-xb44.google.com with SMTP id s41so12184311ybe.12
 for <alsa-devel@alsa-project.org>; Thu, 08 Aug 2019 09:45:42 -0700 (PDT)
In-Reply-To: <87ef1w6w8o.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Jie Yang <yang.jie@linux.intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Fontana <rfontana@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Kevin Hilman <khilman@baylibre.com>, YueHaibing <yuehaibing@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>, Chen-Yu Tsai <wens@csie.org>, Danny Milosavljevic <dannym@scratchpost.org>, Georgii Staroselski i <georgii.staroselskii@emlid.com>, Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Hans de Goede <hdegoede@>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 7, 2019 at 11:03 PM Kuninori Morimoto <
kuninori.morimoto.gx@renesas.com> wrote:

>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> It is easy to read code if it is cleanly using paired function/naming,
> like start <-> stop, register <-> unregister, etc, etc.
> But, current ALSA SoC code is very random, unbalance, not paired, etc.
> It is easy to create bug at the such code, and it will be difficult to
> debug.
>
> soc-core.c has soc_bind_aux_dev(), but, there is no its paired
> soc_unbind_aux_dev(). This patch adds it.
>
Morimoto-san,
I'm not sure it quite improves readability to just have list_del in
unbind_aux_dev(). bin_aux_dev() does more than just adding to the
card_aux_list(). So in fact, I think  this change makes it look unbalanced.
The existing code for aux_dev looks quite similar to what bind_dai_link()
and remove_dai_link() do and they are quite intuitive.

Thanks,
Ranjani

>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index f8a5464..5e3b907 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1527,6 +1527,11 @@ static int soc_probe_link_dais(struct snd_soc_card
> *card,
>         return ret;
>  }
>
> +static void soc_unbind_aux_dev(struct snd_soc_component *component)
> +{
> +       list_del(&component->card_aux_list);
> +}
> +
>  static int soc_bind_aux_dev(struct snd_soc_card *card,
>                             struct snd_soc_aux_dev *aux_dev)
>  {
> @@ -1578,7 +1583,7 @@ static void soc_remove_aux_devices(struct
> snd_soc_card *card)
>                         if (comp->driver->remove_order == order) {
>                                 soc_remove_component(comp);
>                                 /* remove it from the card's aux_comp_list
> */
> -                               list_del(&comp->card_aux_list);
> +                               soc_unbind_aux_dev(comp);
>                         }
>                 }
>         }
> --
> 2.7.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
