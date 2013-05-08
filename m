From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: sgtl5000: Fix driver probe after reset
Date: Wed,  8 May 2013 17:45:55 -0300
Message-ID: <1368045961-31213-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 21304265369
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 22:46:27 +0200 (CEST)
Received: by mail-qc0-f171.google.com with SMTP id k15so1279272qcv.2
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 13:46:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

sgtl5000 codec does not have a reset line, nor a reset command in software.

After a 'reboot' command in Linux or after pressing the system's reset button
the sgtl5000 driver fails to probe:

sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
sgtl5000 0-000a: ASoC: failed to probe CODEC -19
imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)

As the sgtl5000 codec did not go through a real reset, we cannot rely on the 
sgtl5000_reg_defaults array, since these are only valid after a clean power-on 
reset.

To fix this issue, use 'num_reg_defaults_raw' which tells the regcache driver
to actually read the codec registers and then fill the cache with these values.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Remove sgtl5000_reg_defaults array
- Do not use num_reg_defaults_raw

 sound/soc/codecs/sgtl5000.c |   30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 327b443..fa342f7 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -34,33 +34,6 @@
 #define SGTL5000_DAP_REG_OFFSET	0x0100
 #define SGTL5000_MAX_REG_OFFSET	0x013A
 
-/* default value of sgtl5000 registers */
-static const struct reg_default sgtl5000_reg_defaults[] = {
-	{ SGTL5000_CHIP_CLK_CTRL,		0x0008 },
-	{ SGTL5000_CHIP_I2S_CTRL,		0x0010 },
-	{ SGTL5000_CHIP_SSS_CTRL,		0x0008 },
-	{ SGTL5000_CHIP_DAC_VOL,		0x3c3c },
-	{ SGTL5000_CHIP_PAD_STRENGTH,		0x015f },
-	{ SGTL5000_CHIP_ANA_HP_CTRL,		0x1818 },
-	{ SGTL5000_CHIP_ANA_CTRL,		0x0111 },
-	{ SGTL5000_CHIP_LINE_OUT_VOL,		0x0404 },
-	{ SGTL5000_CHIP_ANA_POWER,		0x7060 },
-	{ SGTL5000_CHIP_PLL_CTRL,		0x5000 },
-	{ SGTL5000_DAP_BASS_ENHANCE,		0x0040 },
-	{ SGTL5000_DAP_BASS_ENHANCE_CTRL,	0x051f },
-	{ SGTL5000_DAP_SURROUND,		0x0040 },
-	{ SGTL5000_DAP_EQ_BASS_BAND0,		0x002f },
-	{ SGTL5000_DAP_EQ_BASS_BAND1,		0x002f },
-	{ SGTL5000_DAP_EQ_BASS_BAND2,		0x002f },
-	{ SGTL5000_DAP_EQ_BASS_BAND3,		0x002f },
-	{ SGTL5000_DAP_EQ_BASS_BAND4,		0x002f },
-	{ SGTL5000_DAP_MAIN_CHAN,		0x8000 },
-	{ SGTL5000_DAP_AVC_CTRL,		0x0510 },
-	{ SGTL5000_DAP_AVC_THRESHOLD,		0x1473 },
-	{ SGTL5000_DAP_AVC_ATTACK,		0x0028 },
-	{ SGTL5000_DAP_AVC_DECAY,		0x0050 },
-};
-
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
 enum sgtl5000_regulator_supplies {
 	VDDA,
@@ -1470,8 +1443,7 @@ static const struct regmap_config sgtl5000_regmap = {
 	.readable_reg = sgtl5000_readable,
 
 	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults = sgtl5000_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(sgtl5000_reg_defaults),
+	.num_reg_defaults_raw = SGTL5000_MAX_REG_OFFSET,
 };
 
 static int sgtl5000_i2c_probe(struct i2c_client *client,
-- 
1.7.9.5
