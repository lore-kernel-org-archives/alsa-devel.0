From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] ASoC: da7218: fix fix child-node lookup
Date: Mon, 13 Nov 2017 12:12:55 +0100
Message-ID: <20171113111256.24140-1-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent codec node was also prematurely freed.

Fixes: 4d50934abd22 ("ASoC: da7218: Add da7218 codec driver")
Cc: stable <stable@vger.kernel.org>     # 4.5
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/da7218.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index b2d42ec1dcd9..56564ce90cb6 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2520,7 +2520,7 @@ static struct da7218_pdata *da7218_of_to_pdata(struct snd_soc_codec *codec)
 	}
 
 	if (da7218->dev_id == DA7218_DEV_ID) {
-		hpldet_np = of_find_node_by_name(np, "da7218_hpldet");
+		hpldet_np = of_get_child_by_name(np, "da7218_hpldet");
 		if (!hpldet_np)
 			return pdata;
 
-- 
2.15.0
