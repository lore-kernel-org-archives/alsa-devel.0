From: jbrunet@baylibre.com
Subject: Re: [PATCH] ASoC: meson: axg-spdifout: select SND_PCM_IEC958
Date: Tue, 24 Jul 2018 12:03:10 +0200
Message-ID: <59fdcf671ffd0ef60e4d982ba269f853089ee7da.camel@baylibre.com>
References: <20180724093705.1691747-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724093705.1691747-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-07-24 at 11:36 +0200, Arnd Bergmann wrote:
> When CONFIG_SND_PCM_IEC958 is disabled, we get a link error for the
> new driver:
> 
> sound/soc/meson/axg-spdifout.o: In function `axg_spdifout_hw_params':
> axg-spdifout.c:(.text+0x650): undefined reference to
> `snd_pcm_create_iec958_consumer_hw_params'

I used arm64 defconfig to do all my test and this symbol was selected
by the HDMI codec driver, which is probably why missed it. 

Thanks a lot for fixing the problem Arnd.

> 
> The other users use 'select', so we should do the same here.
> 
> Fixes: 53eb4b7aaa04 ("ASoC: meson: add axg spdif output")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
