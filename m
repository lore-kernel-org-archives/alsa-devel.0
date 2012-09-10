From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: cs4270: Conver to data based control
	init
Date: Mon, 10 Sep 2012 12:58:43 +0800
Message-ID: <1347253125-8250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8478C264F15
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 07:01:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 44a176f..c6e5a73 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -521,14 +521,6 @@ static int cs4270_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/* Add the non-DAPM controls */
-	ret = snd_soc_add_codec_controls(codec, cs4270_snd_controls,
-				ARRAY_SIZE(cs4270_snd_controls));
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to add controls\n");
-		return ret;
-	}
-
 	/* get the power supply regulators */
 	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
 		cs4270->supplies[i].supply = supply_names[i];
@@ -634,6 +626,9 @@ static const struct snd_soc_codec_driver soc_codec_device_cs4270 = {
 	.remove =		cs4270_remove,
 	.suspend =		cs4270_soc_suspend,
 	.resume =		cs4270_soc_resume,
+
+	.controls =		cs4270_snd_controls,
+	.num_controls =		ARRAY_SIZE(cs4270_snd_controls),
 	.volatile_register =	cs4270_reg_is_volatile,
 	.readable_register =	cs4270_reg_is_readable,
 	.reg_cache_size =	CS4270_LASTREG + 1,
-- 
1.7.10.4
