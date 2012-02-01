From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm9712: Add TLV information for
	microphone input
Date: Wed,  1 Feb 2012 12:43:36 +0000
Message-ID: <1328100216-23825-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1328100216-23825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B73BD103BBD
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 13:43:46 +0100 (CET)
In-Reply-To: <1328100216-23825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm9712.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 247f19a..7291eab 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -20,6 +20,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
+#include <sound/tlv.h>
 #include "wm9712.h"
 
 static unsigned int ac97_read(struct snd_soc_codec *codec,
@@ -69,6 +70,9 @@ static const char *wm9712_rec_sel[] = {"Mic", "NC", "NC", "Speaker Mixer",
 static const char *wm9712_ng_type[] = {"Constant Gain", "Mute"};
 static const char *wm9712_diff_sel[] = {"Mic", "Line"};
 
+static const DECLARE_TLV_DB_SCALE(main_tlv, -3450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(boost_tlv, 0, 2000, 0);
+
 static const struct soc_enum wm9712_enum[] = {
 SOC_ENUM_SINGLE(AC97_PCI_SVID, 14, 4, wm9712_alc_select),
 SOC_ENUM_SINGLE(AC97_VIDEO, 12, 4, wm9712_alc_mux),
@@ -147,9 +151,9 @@ SOC_ENUM("Capture Volume Steps", wm9712_enum[6]),
 SOC_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 63, 1),
 SOC_SINGLE("Capture ZC Switch", AC97_REC_GAIN, 7, 1, 0),
 
-SOC_SINGLE("Mic 1 Volume", AC97_MIC, 8, 31, 1),
-SOC_SINGLE("Mic 2 Volume", AC97_MIC, 0, 31, 1),
-SOC_SINGLE("Mic 20dB Boost Switch", AC97_MIC, 7, 1, 0),
+SOC_SINGLE_TLV("Mic 1 Volume", AC97_MIC, 8, 31, 1, main_tlv),
+SOC_SINGLE_TLV("Mic 2 Volume", AC97_MIC, 0, 31, 1, main_tlv),
+SOC_SINGLE_TLV("Mic Boost Volume", AC97_MIC, 7, 1, 0, boost_tlv),
 };
 
 /* We have to create a fake left and right HP mixers because
-- 
1.7.9.rc1
