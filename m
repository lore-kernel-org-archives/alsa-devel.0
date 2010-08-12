From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Remove version display from WM8971
	driver
Date: Thu, 12 Aug 2010 10:57:05 +0100
Message-ID: <1281607025-12762-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281607025-12762-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EBA921037F8
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 11:57:10 +0200 (CEST)
In-Reply-To: <1281607025-12762-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8971.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index ad2692a..9ec9a2e 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -30,8 +30,6 @@
 
 #include "wm8971.h"
 
-#define WM8971_VERSION "0.9"
-
 #define	WM8971_REG_COUNT		43
 
 static struct workqueue_struct *wm8971_workq = NULL;
@@ -640,8 +638,6 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	int ret = 0;
 	u16 reg;
 
-	pr_info("WM8971 Audio Codec %s", WM8971_VERSION);
-
 	codec->control_data = wm8971->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8971->control_type);
 	if (ret < 0) {
-- 
1.7.1
