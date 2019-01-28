From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm512x: Fix clocking calculations when
	not using the PLL" to the asoc tree
Date: Mon, 28 Jan 2019 12:35:20 +0000 (GMT)
Message-ID: <20190128123520.80F501127D29@debutante.sirena.org.uk>
References: <f1d57eba-909d-7bc5-40ce-6e128a36a356@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A9C0267454
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 13:35:23 +0100 (CET)
In-Reply-To: <f1d57eba-909d-7bc5-40ce-6e128a36a356@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm512x: Fix clocking calculations when not using the PLL

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 51b033c2608147efe3a5368bfa64837e772d8c55 Mon Sep 17 00:00:00 2001
From: Dimitris Papavasiliou <dpapavas@gmail.com>
Date: Sat, 26 Jan 2019 15:23:45 +0200
Subject: [PATCH] ASoC: pcm512x: Fix clocking calculations when not using the
 PLL

The rationale behind the current calculation is somewhat obscure [1]
and can yield slightly wrong dividers in certain cases, which the
machine drivers for some boards (like the HiFiBerry DAC+ Pro)
seemingly try to circumvent, by updating the rate fraction so as to
suit this calculation.

The updated calculation should correctly yield the smallest bit clock
rate that would fit the frame.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144219.html

Signed-off-by: Dimitris Papavasiliou <dpapavas@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm512x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index ce8c5dbd2164..ae3bd533eadb 100644
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
2.20.1
