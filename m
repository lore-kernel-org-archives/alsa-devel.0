From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/4] ASoC: wm8904: automatically choose clock source
Date: Sun, 25 Aug 2019 14:17:37 +0200
Message-ID: <0b92f741a4c382cb8d50c1aebfa9da15d7e470ae.1566734631.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, Allison Randal <allison@lohutok.net>, Enrico Weigelt <info@metux.net>, zhong jiang <zhongjiang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Anders Roxell <anders.roxell@linaro.org>, Annaliese McDermond <nh6z@nh6z.net>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jerome Brunet <jbrunet@baylibre.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ludovic
List-Id: alsa-devel@alsa-project.org

Choose clock source automatically if not provided. This will be the case
with eg. audio-graph-card.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 sound/soc/codecs/wm8904.c | 42 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index c9318fe34f91..946315d4cecf 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -367,15 +367,34 @@ static int wm8904_enable_sysclk(struct wm8904_priv *priv)
 	return err;
 }
 
+static int wm8904_bump_fll_sysclk(unsigned int *rate);
+
 static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 			     unsigned int rate, int dir)
 {
 	struct snd_soc_component *component = dai->component;
 	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	unsigned int clock0, clock2;
-	int err;
+	int err, do_div = false;
 
 	switch (clk_id) {
+	case 0:
+		if (rate == clk_round_rate(wm8904->mclk, rate)) {
+			clk_id = WM8904_CLK_MCLK;
+		} else if (rate * 2 == clk_round_rate(wm8904->mclk, rate * 2)) {
+			rate *= 2;
+			clk_id = WM8904_CLK_MCLK;
+			do_div = true;
+		} else {
+			clk_id = WM8904_CLK_FLL;
+			err = wm8904_bump_fll_sysclk(&rate);
+			if (err) {
+				dev_dbg(component->dev, "Can't match %u over FLL 1406250 Hz minimum\n", rate);
+				return err;
+			}
+		}
+		break;
+
 	case WM8904_CLK_MCLK:
 	case WM8904_CLK_FLL:
 		break;
@@ -421,7 +440,9 @@ static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	}
 
 	/* SYSCLK shouldn't be over 13.5MHz */
-	if (rate > 13500000) {
+	if (rate > 13500000)
+		do_div = true;
+	if (do_div) {
 		clock0 = WM8904_MCLK_DIV;
 		wm8904->sysclk_rate = rate / 2;
 	} else {
@@ -1350,6 +1371,23 @@ static struct {
 	{ 480, 20 },
 };
 
+static int wm8904_bump_fll_sysclk(unsigned int *rate)
+{
+	int i;
+
+	/* bump SYSCLK rate if below minimal FLL output */
+
+	for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
+		if (*rate * bclk_divs[i].div >= 1406250 * 10)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(bclk_divs))
+		return -ERANGE;
+
+	*rate = (*rate * bclk_divs[i].div) / 10;
+	return 0;
+}
 
 static int wm8904_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
-- 
2.20.1
