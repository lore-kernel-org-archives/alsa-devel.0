From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] ASoC: wl1273: Use table based control setup
Date: Wed,  5 Nov 2014 10:46:33 +0100
Message-ID: <1415180796-31129-3-git-send-email-lars@metafoo.de>
References: <1415180796-31129-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-084.synserver.de (smtp-out-084.synserver.de
 [212.40.185.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 65C62261AE0
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 10:46:40 +0100 (CET)
In-Reply-To: <1415180796-31129-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, patches@opensource.wolfsonmicro.com, Dan Murphy <dmurphy@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Makes the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wl1273.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index f3d4e88..00aea41 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -452,7 +452,6 @@ static int wl1273_probe(struct snd_soc_codec *codec)
 {
 	struct wl1273_core **core = codec->dev->platform_data;
 	struct wl1273_priv *wl1273;
-	int r;
 
 	dev_dbg(codec->dev, "%s.\n", __func__);
 
@@ -470,12 +469,7 @@ static int wl1273_probe(struct snd_soc_codec *codec)
 
 	snd_soc_codec_set_drvdata(codec, wl1273);
 
-	r = snd_soc_add_codec_controls(codec, wl1273_controls,
-				 ARRAY_SIZE(wl1273_controls));
-	if (r)
-		kfree(wl1273);
-
-	return r;
+	return 0;
 }
 
 static int wl1273_remove(struct snd_soc_codec *codec)
@@ -492,6 +486,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wl1273 = {
 	.probe = wl1273_probe,
 	.remove = wl1273_remove,
 
+	.controls = wl1273_controls,
+	.num_controls = ARRAY_SIZE(wl1273_controls),
 	.dapm_widgets = wl1273_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wl1273_dapm_widgets),
 	.dapm_routes = wl1273_dapm_routes,
-- 
1.8.0
