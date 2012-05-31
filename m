From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2000: Add register readability
	information
Date: Thu, 31 May 2012 14:49:34 +0100
Message-ID: <1338472174-21175-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9528B24443
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 15:56:12 +0200 (CEST)
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
 sound/soc/codecs/wm2000.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index a75c376..4531c55 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -691,9 +691,39 @@ static int wm2000_resume(struct snd_soc_codec *codec)
 #define wm2000_resume NULL
 #endif
 
+static bool wm2000_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM2000_REG_SYS_START:
+	case WM2000_REG_SPEECH_CLARITY:
+	case WM2000_REG_SYS_WATCHDOG:
+	case WM2000_REG_ANA_VMID_PD_TIME:
+	case WM2000_REG_ANA_VMID_PU_TIME:
+	case WM2000_REG_CAT_FLTR_INDX:
+	case WM2000_REG_CAT_GAIN_0:
+	case WM2000_REG_SYS_STATUS:
+	case WM2000_REG_SYS_MODE_CNTRL:
+	case WM2000_REG_SYS_START0:
+	case WM2000_REG_SYS_START1:
+	case WM2000_REG_ID1:
+	case WM2000_REG_ID2:
+	case WM2000_REG_REVISON:
+	case WM2000_REG_SYS_CTL1:
+	case WM2000_REG_SYS_CTL2:
+	case WM2000_REG_ANC_STAT:
+	case WM2000_REG_IF_CTL:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config wm2000_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
+
+	.max_register = WM2000_REG_IF_CTL,
+	.readable_reg = wm2000_readable_reg,
 };
 
 static int wm2000_probe(struct snd_soc_codec *codec)
-- 
1.7.10
