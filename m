From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/8] ASoC: Remove unused AK4535 hardware read
	functionality
Date: Mon,  3 Aug 2009 17:09:44 +0100
Message-ID: <1249315790-22814-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1249315790-22814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D70C24792
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 18:09:54 +0200 (CEST)
In-Reply-To: <1249315790-22814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Nothing uses it and the existing hw_read operation needs to be
refectored so it's easier to remove it rather than work with it.
Support can be re-added if the code requires volatile registers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4535.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index dd33802..0abec0d 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -59,21 +59,6 @@ static inline unsigned int ak4535_read_reg_cache(struct snd_soc_codec *codec,
 	return cache[reg];
 }
 
-static inline unsigned int ak4535_read(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u8 data;
-	data = reg;
-
-	if (codec->hw_write(codec->control_data, &data, 1) != 1)
-		return -EIO;
-
-	if (codec->hw_read(codec->control_data, &data, 1) != 1)
-		return -EIO;
-
-	return data;
-};
-
 /*
  * write ak4535 register cache
  */
@@ -635,7 +620,6 @@ static int ak4535_probe(struct platform_device *pdev)
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		codec->hw_write = (hw_write_t)i2c_master_send;
-		codec->hw_read = (hw_read_t)i2c_master_recv;
 		ret = ak4535_add_i2c_device(pdev, setup);
 	}
 #endif
-- 
1.6.3.3
