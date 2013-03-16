From: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Subject: [PATCH] sound: soc: fix invalid free of devm_ allocated data
Date: Sat, 16 Mar 2013 13:45:34 +0200
Message-ID: <1363434334-5461-1-git-send-email-silviupopescu1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, linux-kernel@vger.kernel.org, Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
List-Id: alsa-devel@alsa-project.org

The objects allocated by devm_* APIs are managed by devres and are freed when
the device is detached. Hence there is no need to use kfree() explicitly.

Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
---
 sound/soc/soc-core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b7e84a7..407b0a3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4197,7 +4197,6 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			dev_err(card->dev,
 				"ASoC: Property '%s' index %d could not be read: %d\n",
 				propname, 2 * i, ret);
-			kfree(routes);
 			return -EINVAL;
 		}
 		ret = of_property_read_string_index(np, propname,
@@ -4206,7 +4205,6 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 			dev_err(card->dev,
 				"ASoC: Property '%s' index %d could not be read: %d\n",
 				propname, (2 * i) + 1, ret);
-			kfree(routes);
 			return -EINVAL;
 		}
 	}
-- 
1.7.9.5
