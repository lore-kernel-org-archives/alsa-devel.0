From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH 1/2] ASoC: core: fix the memory leak in case of
 device_add() failure
Date: Wed, 26 Dec 2012 00:56:05 +0800
Message-ID: <1356454565.21958.2.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com
List-Id: alsa-devel@alsa-project.org


After called device_initialize(), even device_add() returns
error, we still need use the put_device() to release the reference
to call rtd_release(), which will do the free() action.

Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
---
 sound/soc/soc-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 91d592f..9689411 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1255,6 +1255,8 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_CAPTURE].fe_clients);
 	ret = device_add(rtd->dev);
 	if (ret < 0) {
+		/* calling put_device() here to free the rtd->dev */
+		put_device(rtd->dev);
 		dev_err(card->dev,
 			"ASoC: failed to register runtime device: %d\n", ret);
 		return ret;
-- 
1.7.0.4
