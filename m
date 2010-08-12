From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Remove version display from WM8510
	driver
Date: Thu, 12 Aug 2010 10:57:04 +0100
Message-ID: <1281607025-12762-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EDCA8103815
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 11:57:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index dbfa05d..1c623de 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -29,8 +29,6 @@
 
 #include "wm8510.h"
 
-#define WM8510_VERSION "0.6"
-
 /*
  * wm8510 register cache
  * We can't read the WM8510 register space when we are
@@ -563,8 +561,6 @@ static int wm8510_probe(struct snd_soc_codec *codec)
 	struct wm8510_priv *wm8510 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	pr_info("WM8510 Audio Codec %s", WM8510_VERSION);
-
 	codec->control_data = wm8510->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9,  wm8510->control_type);
 	if (ret < 0) {
-- 
1.7.1
