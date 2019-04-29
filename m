From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 3/6] ASoC: hdmi-codec: stream is already locked in hw_params
Date: Mon, 29 Apr 2019 15:29:40 +0200
Message-ID: <20190429132943.16269-4-jbrunet@baylibre.com>
References: <20190429132943.16269-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429132943.16269-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

startup() should have run before hw_params() is called, so the
current_substream pointer should already be properly set. There
is no reason to call hdmi_codec_new_stream() again in the
hw_params() callback

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 4bd598253c62..780f2008b271 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -495,10 +495,6 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = hdmi_codec_new_stream(substream, dai);
-	if (ret)
-		return ret;
-
 	hdmi_audio_infoframe_init(&hp.cea);
 	hp.cea.channels = params_channels(params);
 	hp.cea.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
-- 
2.20.1
