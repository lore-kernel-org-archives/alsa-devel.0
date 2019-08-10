From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 01/15] ASoC: soc-core: support
 snd_soc_dai_link_component for aux_dev
Date: Sat, 10 Aug 2019 12:19:21 +0300
Message-ID: <00fb2b5b-ec46-4957-15c7-f2bfe40a8f9c@bitmer.com>
References: <87zhkk6wdy.wl-kuninori.morimoto.gx@renesas.com>
 <87y3046wcf.wl-kuninori.morimoto.gx@renesas.com>
 <7ee1cbe3-4d6e-d843-dc2e-75bc9b3b421c@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (50-87-157-213.static.tentacle.fi [213.157.87.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11D19F8015B
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 11:20:16 +0200 (CEST)
In-Reply-To: <7ee1cbe3-4d6e-d843-dc2e-75bc9b3b421c@bitmer.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Jie Yang <yang.jie@linux.intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Fontana <"r fontana"@redhat.com>, Shunli Wang <shunli.wang@mediatek.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Kevin Hilman <khilman@baylibre.com>, YueHaibing <yuehaibing@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>, Chen-Yu Tsai <wens@csie.org>, Georgii Staroselskii <georgii.staroselskii@emlid.com>, Danny Milosavljevic <dannym@scratchpost.org>, Hans de Goede <hdegoede@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas
List-Id: alsa-devel@alsa-project.org

Hi

On 8/10/19 12:16 PM, Jarkko Nikula wrote:
> Hi
> 
> On 8/8/19 8:52 AM, Kuninori Morimoto wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> To find aux_dev, ASoC is using .name, codec_name, codec_of_node.
>> Here, .name is used to fallback in case of no codec.
>>
>> But, we already have this kind of component finding method by
>> snd_soc_dai_link_component and soc_find_component().
>> We shouldn't have duplicated implementation to do same things.
>> This patch adds snd_soc_dai_link_component support to finding aux_dev.
>>
>> Now, no driver is using only .name.
>> All drivers are using codec_name and/or codec_of_node.
>> This means no driver is finding component from .name so far.
>> (Actually almost all drivers are using .name as just "device name",
>>  not for finding component...)
>>
>> This patch
>> 1) add snd_soc_dai_link_component support for aux_dev. legacy style will
>>    be removed if all drivers are switched to new style.
>> 2) try to find component via snd_soc_dai_link_component.
>>    Then, it doesn't try to find via .name, because no driver is using
>>    it so far.
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>  include/sound/soc.h  |  7 +++++++
>>  sound/soc/soc-core.c | 36 ++++++++++--------------------------
>>  2 files changed, 17 insertions(+), 26 deletions(-)
...

> Bike-shedding: maybe comment here should say legacy style binding etc? I
> know these lines are removed by patch 13/15 but here yet comment is not
> valid :-)
> 
I forgot to add

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
