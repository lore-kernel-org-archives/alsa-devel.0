From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support !CONFIG_REGMAP builds
Date: Sat, 13 Aug 2011 11:52:42 +0900
Message-ID: <1313203962-7149-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01B9A1037E3
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Aug 2011 04:53:07 +0200 (CEST)
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
Cc: Axel Lin <axel.lin@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since we changed regmap to be selected and register per bus rather than
via the core only we can't rely on it being enabled by the ASoC core.
Support compiling it out.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reported-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/soc-io.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index be5aac3..3f56d52 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -18,6 +18,7 @@
 
 #include <trace/events/asoc.h>
 
+#ifdef CONFIG_REGMAP
 static int hw_write(struct snd_soc_codec *codec, unsigned int reg,
 		    unsigned int value)
 {
@@ -150,4 +151,12 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
-
+#else
+int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
+			       int addr_bits, int data_bits,
+			       enum snd_soc_control_type control)
+{
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
+#endif
-- 
1.7.5.4
