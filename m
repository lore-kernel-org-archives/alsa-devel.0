From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove driver versioning from ak4642
Date: Sun, 27 Nov 2011 12:13:03 +0000
Message-ID: <1322395984-4926-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 120012436E
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 13:13:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's never been updated so it can't be that useful and it makes the
driver needlessly chatty.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4642.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index c887ddf..30ce3d6 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -32,8 +32,6 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#define AK4642_VERSION "0.0.1"
-
 #define PW_MGMT1	0x00
 #define PW_MGMT2	0x01
 #define SG_SL1		0x02
@@ -473,8 +471,6 @@ static int ak4642_probe(struct snd_soc_codec *codec)
 	struct ak4642_priv *ak4642 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	dev_info(codec->dev, "AK4642 Audio Codec %s", AK4642_VERSION);
-
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, ak4642->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-- 
1.7.7.3
