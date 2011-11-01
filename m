From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: Ensure WM8962 PLL registers are reset
Date: Tue,  1 Nov 2011 18:40:36 +0000
Message-ID: <1320172842-15790-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 394E810383B
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 19:40:46 +0100 (CET)
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

The WM8962 has a separate software reset for the PLL registers. Ensure that
these are reset also on startup.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8d8b06c..9e2d5b0 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1963,7 +1963,13 @@ static int wm8962_readable_register(struct snd_soc_codec *codec, unsigned int re
 
 static int wm8962_reset(struct snd_soc_codec *codec)
 {
-	return snd_soc_write(codec, WM8962_SOFTWARE_RESET, 0x6243);
+	int ret;
+
+	ret = snd_soc_write(codec, WM8962_SOFTWARE_RESET, 0x6243);
+	if (ret != 0)
+		return ret;
+
+	return snd_soc_write(codec, WM8962_PLL_SOFTWARE_RESET, 0);
 }
 
 static const DECLARE_TLV_DB_SCALE(inpga_tlv, -2325, 75, 0);
-- 
1.7.7.1
