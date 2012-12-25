From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH 2/2] ASoC: core: fix the memory leak in case of
 remove_aux_dev()
Date: Wed, 26 Dec 2012 00:57:32 +0800
Message-ID: <1356454652.21958.4.camel@cliu38-desktop-build>
References: <1356454565.21958.2.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1356454565.21958.2.camel@cliu38-desktop-build>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com
List-Id: alsa-devel@alsa-project.org


When probing aux_dev, initializing is as below:
device_initialize()
device_add()

So when remove aux_dev, we need do as below:
device_del()
device_put()
Otherwise, the rtd_release() will not be called.

So here using device_unregister() to replace device_del(),
like the action in soc_remove_link_dais().
Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9689411..2270f8f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1556,7 +1556,7 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
 		device_remove_file(rtd->dev, &dev_attr_codec_reg);
-		device_del(rtd->dev);
+		device_unregister(rtd->dev);
 		rtd->dev_registered = 0;
 	}
 
-- 
1.7.0.4
