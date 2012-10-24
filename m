From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Lower AIFnCLK divisor when
	dropping to 32kHz
Date: Wed, 24 Oct 2012 10:57:06 +0100
Message-ID: <1351072626-29087-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E0E12652E4
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2012 12:07:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When lowering SYSCLK to 50kHz for accessory detection also lower the
AIFnCLK divisor to normalise the clocking configuration within the
device. This will not disrupt audio as we cannot support active audio
with such a low SYSCLK.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 0932d7a..c16a9a3 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2443,6 +2443,18 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 
 	configure_clock(codec);
 
+	/*
+	 * If SYSCLK will be less than 50kHz adjust AIFnCLK dividers
+	 * for detection.
+	 */
+	if (max(wm8994->aifclk[0], wm8994->aifclk[1]) < 50000) {
+		dev_dbg(codec->dev, "Configuring AIFs for 128fs\n");
+		snd_soc_update_bits(codec, WM8994_AIF1_RATE,
+				    WM8994_AIF1CLK_RATE_MASK, 0x1);
+		snd_soc_update_bits(codec, WM8994_AIF2_RATE,
+				    WM8994_AIF2CLK_RATE_MASK, 0x1);
+	}
+
 	return 0;
 }
 
-- 
1.7.10.4
