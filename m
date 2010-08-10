From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 05/17] ASoC: multi-component - open firmware
Date: Wed, 11 Aug 2010 00:02:56 +0100
Message-ID: <1281481388-3000-6-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FFFA10385F
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:35 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so11453003wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:35 -0700 (PDT)
In-Reply-To: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Moving to multi-component model.

There are currently no users of soc-of-simple now.

Since all codecs are regular kernel devices now (with platform data) is
of-simple still required ? If not, this file will be removed.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 include/sound/soc-of-simple.h |    4 ++--
 sound/soc/fsl/soc-of-simple.c |    6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-of-simple.h b/include/sound/soc-of-simple.h
index a064e19..daa161f 100644
--- a/include/sound/soc-of-simple.h
+++ b/include/sound/soc-of-simple.h
@@ -12,8 +12,8 @@
 #include <linux/of.h>
 #include <sound/soc.h>
 
-int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
-			      void *codec_data, struct snd_soc_dai *dai,
+int of_snd_soc_register_codec(struct snd_soc_codec *codec,
+			      struct snd_soc_dai *dai,
 			      struct device_node *node);
 
 int of_snd_soc_register_platform(struct snd_soc_platform *platform,
diff --git a/sound/soc/fsl/soc-of-simple.c b/sound/soc/fsl/soc-of-simple.c
index 3bc13fd..3335296 100644
--- a/sound/soc/fsl/soc-of-simple.c
+++ b/sound/soc/fsl/soc-of-simple.c
@@ -99,8 +99,8 @@ static void of_snd_soc_register_device(struct of_snd_soc_device *of_soc)
 
 }
 
-int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
-			      void *codec_data, struct snd_soc_dai *dai,
+int of_snd_soc_register_codec(struct snd_soc_codec *codec,
+				  struct snd_soc_dai *dai,
 			      struct device_node *node)
 {
 	struct of_snd_soc_device *of_soc;
@@ -116,8 +116,6 @@ int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
 	}
 
 	/* Store the codec data */
-	of_soc->device.codec_data = codec_data;
-	of_soc->device.codec_dev = codec_dev;
 	of_soc->dai_link.name = (char *)node->name;
 	of_soc->dai_link.stream_name = (char *)node->name;
 	of_soc->dai_link.codec_dai = dai;
-- 
1.7.0.4
