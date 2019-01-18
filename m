From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ASoC: soc-core: remove error due to probe deferral
Date: Fri, 18 Jan 2019 10:55:04 +0100
Message-ID: <20190118095504.22397-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, lgirdwood@gmail.com, broonie@kernel.org
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: alsa-devel@alsa-project.org

Deferred probes shouldn't cause error messages in the boot log, so
change the dev_err() to the more harmless dev_info().

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b29d0f65611e..ba9b09517c5f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -903,8 +903,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
 		if (!codec_dais[i]) {
-			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
-				codecs[i].dai_name);
+			dev_info(card->dev, "ASoC: CODEC DAI %s not registered\n",
+				 codecs[i].dai_name);
 			goto _err_defer;
 		}
 		snd_soc_rtdcom_add(rtd, codec_dais[i]->component);
-- 
2.20.1
