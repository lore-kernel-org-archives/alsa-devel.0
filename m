From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/21] ASoC: dmic: declare trigger function as static
Date: Fri,  4 Jan 2019 20:02:29 -0600
Message-ID: <20190105020249.8639-2-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Kaehlcke <mka@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jenny TC <jenny.tc@intel.com>, Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

No reason why this is global, fix warnings with W=1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/dmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index da921da50ef0..de041369e5a7 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -44,8 +44,8 @@ struct dmic {
 	int modeswitch_delay;
 };
 
-int dmic_daiops_trigger(struct snd_pcm_substream *substream,
-		int cmd, struct snd_soc_dai *dai)
+static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
+			       int cmd, struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
 	struct dmic *dmic = snd_soc_component_get_drvdata(component);
-- 
2.17.1
