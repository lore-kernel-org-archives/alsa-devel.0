From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] ASoC: meson: axg-fifo: report interrupt request failure
Date: Mon, 27 Aug 2018 16:15:29 +0200
Message-ID: <20180827141529.6497-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Return value of request_irq() was irgnored. Fix this and report
the failure if any

Fixes: 6dc4fa179fb8 ("ASoC: meson: add axg fifo base driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 30262550e37b..0e4f65e654c4 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -203,6 +203,8 @@ static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
 
 	ret = request_irq(fifo->irq, axg_fifo_pcm_irq_block, 0,
 			  dev_name(dev), ss);
+	if (ret)
+		return ret;
 
 	/* Enable pclk to access registers and clock the fifo ip */
 	ret = clk_prepare_enable(fifo->pclk);
-- 
2.17.1
