From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 6/6] ASoC: sgtl5000: Remove misleading comment
Date: Tue,  7 Jun 2016 01:14:53 +0200
Message-ID: <20160606231453.19377-7-clemens.gruber@pqgruber.com>
References: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Eric Nelson <eric@nelint.com>, linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>
List-Id: alsa-devel@alsa-project.org

All new designs should use external VDDD according to official
documentation. See ER1 in errata sheet:
http://cache.nxp.com/files/analog/doc/errata/SGTL5000ER.pdf

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 sound/soc/codecs/sgtl5000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index b8a2de85..39a178a 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -909,7 +909,6 @@ static const u8 vol_quot_table[] = {
  * and should be set according to:
  * 1. vddd provided by external or not
  * 2. vdda and vddio voltage value. > 3.1v or not
- * 3. chip revision >=0x11 or not. If >=0x11, not use external vddd.
  */
 static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 {
-- 
2.8.3
