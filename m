From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 6/6] ASoC: codec2codec: fill some of the runtime stream parameters
Date: Wed, 24 Jul 2019 18:24:05 +0200
Message-ID: <20190724162405.6574-7-jbrunet@baylibre.com>
References: <20190724162405.6574-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724162405.6574-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Set the information provided struct snd_soc_pcm_stream in the
struct snd_pcm_runtime of the codec to codec link.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-dapm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e0eedff5fe94..a6bc3eda275d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3892,6 +3892,11 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			dapm_update_dai_unlocked(substream, &params, sink);
 		}
 
+		runtime->format = params_format(&params);
+		runtime->subformat = params_subformat(&params);
+		runtime->channels = params_channels(&params);
+		runtime->rate = params_rate(&params);
+
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
-- 
2.21.0
