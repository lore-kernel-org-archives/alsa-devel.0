From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix inconsistent meaning of default case while
	checking alc5623->id
Date: Fri, 03 Dec 2010 17:25:57 +0800
Message-ID: <1291368357.20452.6.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In alc5623_i2c_probe(),
the default case for checking alc5623->id behaves the same as case 0x23.
However, In alc5623_probe() the default case for checking alc5623->id
becomes to be the same as case 0x21.
This makes the meaning of default case inconsistent.

Since we have checked codec id in alc5623_i2c_probe() by comparing
vid2 with id->driver_data, it is not possible to run into the default case now.

In case we may add more supported devices to alc5623_i2c_table in the future,
this patch changes the default case return -EINVAL to let people know that
they should not run into this case. They should also add a new case accordingly
for the new id.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---

Or alternatively, we can simply remove the default cases.

Axel

 sound/soc/codecs/alc5623.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 9783e7e..4f377c9 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -925,7 +925,6 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 	}
 
 	switch (alc5623->id) {
-	default:
 	case 0x21:
 		snd_soc_add_controls(codec, rt5621_vol_snd_controls,
 			ARRAY_SIZE(rt5621_vol_snd_controls));
@@ -938,6 +937,8 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 		snd_soc_add_controls(codec, alc5623_vol_snd_controls,
 			ARRAY_SIZE(alc5623_vol_snd_controls));
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	snd_soc_add_controls(codec, alc5623_snd_controls,
@@ -950,7 +951,6 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	switch (alc5623->id) {
-	default:
 	case 0x21:
 	case 0x22:
 		snd_soc_dapm_new_controls(dapm, alc5623_dapm_amp_widgets,
@@ -962,6 +962,8 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 		snd_soc_dapm_add_routes(dapm, intercon_spk,
 					ARRAY_SIZE(intercon_spk));
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	return ret;
@@ -1039,10 +1041,12 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 	case 0x22:
 		alc5623_dai.name = "alc5622-hifi";
 		break;
-	default:
 	case 0x23:
 		alc5623_dai.name = "alc5623-hifi";
 		break;
+	default:
+		kfree(alc5623);
+		return -EINVAL;
 	}
 
 	i2c_set_clientdata(client, alc5623);
-- 
1.7.2
