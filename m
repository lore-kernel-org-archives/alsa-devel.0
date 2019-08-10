From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 14/15] ASoC: soc-core: add for_each_xxx
	macro for aux_dev
Date: Sat, 10 Aug 2019 12:21:31 +0300
Message-ID: <bc67bd0e-cbb2-a129-672c-b4abb43c2747@bitmer.com>
References: <87zhkk6wdy.wl-kuninori.morimoto.gx@renesas.com>
 <87ftmc6w8s.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (50-87-157-213.static.tentacle.fi [213.157.87.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6FA5F8053A
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 11:21:46 +0200 (CEST)
In-Reply-To: <87ftmc6w8s.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Jie Yang <yang.jie@linux.intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Fontana <rfontana@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Kevin Hilman <khilman@baylibre.com>, YueHaibing <yuehaibing@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>, Chen-Yu Tsai <wens@csie.org>, Georgii Staroselski i <georgii.staroselskii@emlid.com>, Danny Milosavljevic <dannym@scratchpost.org>, Hans de Goede <hdegoede@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>Alexios Zavras <al>
List-Id: alsa-devel@alsa-project.org

On 8/8/19 8:54 AM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> To be more readable code, this patch adds
> new for_each_xxx() macro for aux_dev.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc.h        | 10 ++++++++++
>  sound/soc/meson/axg-card.c |  7 ++++---
>  sound/soc/soc-core.c       | 15 ++++++++-------
>  3 files changed, 22 insertions(+), 10 deletions(-)
> 
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
