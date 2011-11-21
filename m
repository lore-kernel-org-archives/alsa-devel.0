From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use table based init for
	wm8731_snd_controls
Date: Mon, 21 Nov 2011 13:01:32 +0000
Message-ID: <1321880492-24520-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 112D624697
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 14:01:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4030a9c..b7abe33 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -559,9 +559,6 @@ static int wm8731_probe(struct snd_soc_codec *codec)
 	/* Disable bypass path by default */
 	snd_soc_update_bits(codec, WM8731_APANA, 0x8, 0);
 
-	snd_soc_add_controls(codec, wm8731_snd_controls,
-			     ARRAY_SIZE(wm8731_snd_controls));
-
 	/* Regulators will have been enabled by bias management */
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
 
@@ -598,6 +595,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
 	.num_dapm_widgets = ARRAY_SIZE(wm8731_dapm_widgets),
 	.dapm_routes = wm8731_intercon,
 	.num_dapm_routes = ARRAY_SIZE(wm8731_intercon),
+	.controls =	wm8731_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8731_snd_controls),
 };
 
 static const struct of_device_id wm8731_of_match[] = {
-- 
1.7.7.3
