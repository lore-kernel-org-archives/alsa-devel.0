From: Fabio Estevam <festevam@gmail.com>
Subject: [RFC] ASoC: sgtl5000: Remove cache support
Date: Fri,  3 May 2013 16:55:20 -0300
Message-ID: <1367610920-25604-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f173.google.com (mail-ve0-f173.google.com
 [209.85.128.173])
 by alsa0.perex.cz (Postfix) with ESMTP id BBBD7261783
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 21:55:32 +0200 (CEST)
Received: by mail-ve0-f173.google.com with SMTP id ox1so1852734veb.18
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2013 12:55:31 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, matt@genesi-usa.com, alsa-devel@alsa-project.org, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently sgtl5000 driver is probed correctly after a power-on reset, but after
audio is played and the board is reset, we are no longer able to probe again:

sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
sgtl5000 0-000a: ASoC: failed to probe CODEC -19
imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)

Removing the cache support mechanism allows us to probe sgtl5000 driver 
successfully in subsequent board resets.

Tested on a mx6qsabrelite board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
I would like to fix it properly and looking for some ideas/feedbacks as to what
a proper fix would be.

Should I complete the sgtl5000_regs array with all the sgtl5000 registers?

Thanks!

 sound/soc/codecs/sgtl5000.c |   31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 92bbfec..3884162 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -33,33 +33,6 @@
 #define SGTL5000_DAP_REG_OFFSET	0x0100
 #define SGTL5000_MAX_REG_OFFSET	0x013A
 
-/* default value of sgtl5000 registers */
-static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET] =  {
-	[SGTL5000_CHIP_CLK_CTRL] = 0x0008,
-	[SGTL5000_CHIP_I2S_CTRL] = 0x0010,
-	[SGTL5000_CHIP_SSS_CTRL] = 0x0008,
-	[SGTL5000_CHIP_DAC_VOL] = 0x3c3c,
-	[SGTL5000_CHIP_PAD_STRENGTH] = 0x015f,
-	[SGTL5000_CHIP_ANA_HP_CTRL] = 0x1818,
-	[SGTL5000_CHIP_ANA_CTRL] = 0x0111,
-	[SGTL5000_CHIP_LINE_OUT_VOL] = 0x0404,
-	[SGTL5000_CHIP_ANA_POWER] = 0x7060,
-	[SGTL5000_CHIP_PLL_CTRL] = 0x5000,
-	[SGTL5000_DAP_BASS_ENHANCE] = 0x0040,
-	[SGTL5000_DAP_BASS_ENHANCE_CTRL] = 0x051f,
-	[SGTL5000_DAP_SURROUND] = 0x0040,
-	[SGTL5000_DAP_EQ_BASS_BAND0] = 0x002f,
-	[SGTL5000_DAP_EQ_BASS_BAND1] = 0x002f,
-	[SGTL5000_DAP_EQ_BASS_BAND2] = 0x002f,
-	[SGTL5000_DAP_EQ_BASS_BAND3] = 0x002f,
-	[SGTL5000_DAP_EQ_BASS_BAND4] = 0x002f,
-	[SGTL5000_DAP_MAIN_CHAN] = 0x8000,
-	[SGTL5000_DAP_AVC_CTRL] = 0x0510,
-	[SGTL5000_DAP_AVC_THRESHOLD] = 0x1473,
-	[SGTL5000_DAP_AVC_ATTACK] = 0x0028,
-	[SGTL5000_DAP_AVC_DECAY] = 0x0050,
-};
-
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
 enum sgtl5000_regulator_supplies {
 	VDDA,
@@ -1391,10 +1364,6 @@ static struct snd_soc_codec_driver sgtl5000_driver = {
 	.suspend = sgtl5000_suspend,
 	.resume = sgtl5000_resume,
 	.set_bias_level = sgtl5000_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(sgtl5000_regs),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_step = 2,
-	.reg_cache_default = sgtl5000_regs,
 	.volatile_register = sgtl5000_volatile_register,
 	.controls = sgtl5000_snd_controls,
 	.num_controls = ARRAY_SIZE(sgtl5000_snd_controls),
-- 
1.7.9.5
