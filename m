From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] ASoC: ak4613/wm8940: Regmap cache fixes
Date: Thu, 16 Jun 2016 14:34:29 +0200
Message-ID: <1466080472-9817-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.wolfsonmicro.com, linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

	Hi Liam, Mark,

This series contains 3 fixes for regmap cache handling in the ak4613 and
wm8940 drivers. All fixes are based on recent similar fixes for the
ak4642 driver.

The first patch fixes a crash I've seen on r8a7795/Salvator-X.
The last patch is completely untested. The issue was discovered using
'git grep -Lw cache_type -- $(git grep -lw regcache_sync -- $(git grep
-lw regmap_config))''

Thanks!

Geert Uytterhoeven (3):
  ASoC: ak4613: Enable cache usage to fix crashes on resume
  ASoC: ak4613: Implement suspend callback
  ASoC: wm8940: Enable cache usage to fix crashes on resume

 sound/soc/codecs/ak4613.c | 13 ++++++++++++-
 sound/soc/codecs/wm8940.c |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
