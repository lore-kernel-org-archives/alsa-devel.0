From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Fix wrong mask in some
 snd_soc_update_bits calls
Date: Fri, 21 Oct 2011 09:54:43 +0800
Message-ID: <1319162083.4352.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3139B103A41
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 03:54:55 +0200 (CEST)
Received: by yxi13 with SMTP id 13so3456415yxi.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2011 18:54:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <B29396@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Ensure all mask bits are clear before setting new value.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I don't have this hardware, I'd appreciate if someone can test this patch.

Thanks,
Axel
 sound/soc/codecs/sgtl5000.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 32b5bbd..d15695d 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -723,7 +723,9 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, SGTL5000_CHIP_I2S_CTRL, i2s_ctl, i2s_ctl);
+	snd_soc_update_bits(codec, SGTL5000_CHIP_I2S_CTRL,
+			    SGTL5000_I2S_DLEN_MASK | SGTL5000_I2S_SCLKFREQ_MASK,
+			    i2s_ctl);
 
 	return 0;
 }
@@ -1146,8 +1148,7 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 		vag = (vag - SGTL5000_ANA_GND_BASE) / SGTL5000_ANA_GND_STP;
 
 	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
-			vag << SGTL5000_ANA_GND_SHIFT,
-			vag << SGTL5000_ANA_GND_SHIFT);
+			SGTL5000_ANA_GND_MASK, vag << SGTL5000_ANA_GND_SHIFT);
 
 	/* set line out VAG to vddio / 2, in range (0.8v, 1.675v) */
 	vag = vddio / 2;
@@ -1161,9 +1162,8 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 		    SGTL5000_LINE_OUT_GND_STP;
 
 	snd_soc_update_bits(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-			vag << SGTL5000_LINE_OUT_GND_SHIFT |
-			SGTL5000_LINE_OUT_CURRENT_360u <<
-				SGTL5000_LINE_OUT_CURRENT_SHIFT,
+			SGTL5000_LINE_OUT_CURRENT_MASK |
+			SGTL5000_LINE_OUT_GND_MASK,
 			vag << SGTL5000_LINE_OUT_GND_SHIFT |
 			SGTL5000_LINE_OUT_CURRENT_360u <<
 				SGTL5000_LINE_OUT_CURRENT_SHIFT);
-- 
1.7.5.4
