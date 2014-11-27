From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] ASoC: mxs-sgtl5000: Remove MCLK restriction
Date: Thu, 27 Nov 2014 13:01:59 -0200
Message-ID: <1417100521-8483-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 25C18266199
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 16:02:24 +0100 (CET)
Received: by mail-qc0-f181.google.com with SMTP id m20so3623661qcx.40
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 07:02:23 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, craig.mcqueen@beamcommunications.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

According to the sgtl5000 datasheet the MCLK frequency range restriction of
8 to 27 MHz only applies when the PLL is used - synchronous SYS_MCLK input mode.

mxs-sgtl5000 machine sets the codec as slave, and mx28 generates MCLK in the 
range of 256*fs, 384*fs or 512*fs, which is called asynchronous SYS_MCLK 
input.

In asynchronous SYS_MCLK we cannot have the 8 to 27 MHz check because if we
want to play a 8KHz sample rate track, with a MCLK of 8k * 512 = 4.096MHz the
current check would return -EINVAL, which is not correct.

Remove the 8 to 27MHz frequency check, since this only applies to the 
synchronous SYS_MCLK input case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-sgtl5000.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 7515cd4..6f1916b 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -49,13 +49,6 @@ static int mxs_sgtl5000_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	/* Sgtl5000 sysclk should be >= 8MHz and <= 27M */
-	if (mclk < 8000000 || mclk > 27000000) {
-		dev_err(codec_dai->dev, "Invalid mclk frequency: %u.%03uMHz\n",
-			mclk / 1000000, mclk / 1000 % 1000);
-		return -EINVAL;
-	}
-
 	/* Set SGTL5000's SYSCLK (provided by SAIF MCLK) */
 	ret = snd_soc_dai_set_sysclk(codec_dai, SGTL5000_SYSCLK, mclk, 0);
 	if (ret) {
-- 
1.9.1
