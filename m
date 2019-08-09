From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 09/15] ASoC: samsung: speyside: use
 snd_soc_dai_link_component for aux_dev
Date: Fri, 9 Aug 2019 11:14:58 +0200
Message-ID: <CAJKOXPd05-kqE5Ug7p04M_KDvV-hXaNmpaNq3g4ZSxUgeGJJFw@mail.gmail.com>
References: <87zhkk6wdy.wl-kuninori.morimoto.gx@renesas.com>
 <87mugk6w9l.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F24CDF80529
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 11:15:13 +0200 (CEST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B2C692189F
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 09:15:11 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id t3so2897182ljj.12
 for <alsa-devel@alsa-project.org>; Fri, 09 Aug 2019 02:15:11 -0700 (PDT)
In-Reply-To: <87mugk6w9l.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Jie Yang <yang.jie@linux.intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Fontana <rfontana@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Kevin Hilman <khilman@baylibre.com>, YueHaibing <yuehaibing@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Tzung-Bi Shih <tzungbi@google.com>, Chen-Yu Tsai <wens@csie.org>, Georgii Staroselski i <georgii.staroselskii@emlid.com>, Danny Milosavljevic <dannym@scratchpost.org>, Alexios Zavras <alexios.zavras@intel.com>, Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Hans de Goede <hdeg>
List-Id: alsa-devel@alsa-project.org

On Thu, 8 Aug 2019 at 07:54, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> We can use snd_soc_dai_link_component to specify aux_dev.
> Let's use it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/samsung/speyside.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
