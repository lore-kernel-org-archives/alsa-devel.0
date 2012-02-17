From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: io: Retrieve val_bytes from the regmap
	API
Date: Fri, 17 Feb 2012 14:34:22 -0800
Message-ID: <1329518062-6693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32FE5104030
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 23:34:28 +0100 (CET)
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

Allow us to build infrastructure which needs to know the size of a value
without requiring regmap based drivers to supply this information to both
ASoC and regmap by asking regmap for the value.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-io.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 39ba507..4d8dc6a 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -114,6 +114,7 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 			       enum snd_soc_control_type control)
 {
 	struct regmap_config config;
+	int ret;
 
 	memset(&config, 0, sizeof(config));
 	codec->write = hw_write;
@@ -141,6 +142,11 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	case SND_SOC_REGMAP:
 		/* Device has made its own regmap arrangements */
 		codec->using_regmap = true;
+
+		ret = regmap_get_val_bytes(codec->control_data);
+		/* Errors are legitimate for non-integer byte multiples */
+		if (ret > 0)
+			codec->val_bytes = ret;
 		break;
 
 	default:
-- 
1.7.9
