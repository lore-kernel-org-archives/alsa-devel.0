From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] ASoC: sn95031: Use table based control
	setup
Date: Wed,  5 Nov 2014 10:46:31 +0100
Message-ID: <1415180796-31129-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-084.synserver.de (smtp-out-084.synserver.de
 [212.40.185.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C3050261A95
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 10:46:37 +0100 (CET)
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

Makes the code a bit cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sn95031.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index cf8fa40..6167c59 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -867,9 +867,6 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, SN95031_SSR2, 0x10);
 	snd_soc_write(codec, SN95031_SSR3, 0x40);
 
-	snd_soc_add_codec_controls(codec, sn95031_snd_controls,
-			     ARRAY_SIZE(sn95031_snd_controls));
-
 	return 0;
 }
 
@@ -886,6 +883,9 @@ static struct snd_soc_codec_driver sn95031_codec = {
 	.remove		= sn95031_codec_remove,
 	.set_bias_level	= sn95031_set_vaud_bias,
 	.idle_bias_off	= true,
+
+	.controls	= sn95031_snd_controls,
+	.num_controls	= ARRAY_SIZE(sn95031_snd_controls),
 	.dapm_widgets	= sn95031_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(sn95031_dapm_widgets),
 	.dapm_routes	= sn95031_audio_map,
-- 
1.8.0
