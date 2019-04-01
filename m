From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] ASoC: dpcm: skip missing substream while applying symmetry
Date: Mon,  1 Apr 2019 15:03:54 +0200
Message-ID: <20190401130354.24202-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
List-Id: alsa-devel@alsa-project.org

If for any reason, the backend does not have the requested substream
(like capture on a playback only backend), the BE will be skipped in
dpcm_be_dai_startup().

However, dpcm_apply_symmetry() does not skip those BE and will
dereference the be_substream (NULL) pointer anyway.

Like in dpcm_be_dai_startup(), just skip those BE.

Fixes: 906c7d690c3b ("ASoC: dpcm: Apply symmetry for DPCM")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0d5ec68a1e50..99bbd724d2a6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1899,10 +1899,15 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
 			snd_soc_dpcm_get_substream(be, stream);
-		struct snd_soc_pcm_runtime *rtd = be_substream->private_data;
+		struct snd_soc_pcm_runtime *rtd;
 		struct snd_soc_dai *codec_dai;
 		int i;
 
+		/* A backend may not have the requested substream */
+		if (!be_substream)
+			continue;
+
+		rtd = be_substream->private_data;
 		if (rtd->dai_link->be_hw_params_fixup)
 			continue;
 
-- 
2.20.1
