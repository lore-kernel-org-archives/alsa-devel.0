From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: [PATCH 2/2] ASoC: pcm512x: Fix clocking calculations
 when not using the PLL
Date: Sat, 26 Jan 2019 15:23:45 +0200
Message-ID: <f1d57eba-909d-7bc5-40ce-6e128a36a356@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F955267420
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 14:23:47 +0100 (CET)
Received: by mail-ed1-f67.google.com with SMTP id y20so9477592edw.9
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 05:23:47 -0800 (PST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

The rationale behind the current calculation is somewhat obscure [1]
and can yield slightly wrong dividers in certain cases, which the
machine drivers for some boards (like the HiFiBerry DAC+ Pro)
seemingly try to circumvent, by updating the rate fraction so as to
suit this calculation.

The updated calculation should correctly yield the smallest bit clock
rate that would fit the frame.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144219.html

Signed-off-by: Dimitris Papavasiliou <dpapavas@gmail.com>
---
 sound/soc/codecs/pcm512x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index b63d9392bae3..87a2bff366f3 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -929,8 +929,8 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
 
 	if (!pcm512x->pll_out) {
 		sck_rate = clk_get_rate(pcm512x->sclk);
-		bclk_div = params->rate_den * 64 / lrclk_div;
-		bclk_rate = DIV_ROUND_CLOSEST(sck_rate, bclk_div);
+		bclk_rate = params_rate(params) * lrclk_div;
+		bclk_div = DIV_ROUND_CLOSEST(sck_rate, bclk_rate);
 
 		mck_rate = sck_rate;
 	} else {
-- 
2.11.0
