From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add regmap as a control type
Date: Sun, 24 Jul 2011 22:52:51 +0100
Message-ID: <1311544371-10003-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7F3CD2453F
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jul 2011 23:52:57 +0200 (CEST)
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

Allow drivers to set up their own regmap API structures. This is mainly
useful with MFDs where the core driver will have set up regmap at the
minute, though it may make sense to push the existing regmap setup out
of the core into the drivers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    1 +
 sound/soc/soc-io.c  |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4d04b4b..d022694 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -261,6 +261,7 @@ extern struct snd_ac97_bus_ops soc_ac97_ops;
 enum snd_soc_control_type {
 	SND_SOC_I2C = 1,
 	SND_SOC_SPI,
+	SND_SOC_REGMAP,
 };
 
 enum snd_soc_compress_type {
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index b56e1c4..e471ed6 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -132,6 +132,10 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 						      &config);
 		break;
 
+	case SND_SOC_REGMAP:
+		/* Device has made its own regmap arrangements */
+		break;
+
 	default:
 		return -EINVAL;
 	}
-- 
1.7.5.4
