From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8580: Use snd_soc_update_bits for
	read-modify-write
Date: Mon, 17 Oct 2011 11:19:49 +0800
Message-ID: <1318821589.5325.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f171.google.com (mail-yx0-f171.google.com
	[209.85.213.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B12924554
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 05:20:02 +0200 (CEST)
Received: by yxl11 with SMTP id 11so2793689yxl.30
	for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2011 20:20:00 -0700 (PDT)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8580.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index b256727..5e348d6 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -430,8 +430,7 @@ static int wm8580_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	/* Always disable the PLL - it is not safe to leave it running
 	 * while reprogramming it.
 	 */
-	reg = snd_soc_read(codec, WM8580_PWRDN2);
-	snd_soc_write(codec, WM8580_PWRDN2, reg | pwr_mask);
+	snd_soc_update_bits(codec, WM8580_PWRDN2, pwr_mask, pwr_mask);
 
 	if (!freq_in || !freq_out)
 		return 0;
@@ -449,8 +448,7 @@ static int wm8580_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	snd_soc_write(codec, WM8580_PLLA4 + offset, reg);
 
 	/* All done, turn it on */
-	reg = snd_soc_read(codec, WM8580_PWRDN2);
-	snd_soc_write(codec, WM8580_PWRDN2, reg & ~pwr_mask);
+	snd_soc_update_bits(codec, WM8580_PWRDN2, pwr_mask, 0);
 
 	return 0;
 }
@@ -757,20 +755,19 @@ static int wm8580_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Power up and get individual control of the DACs */
-			reg = snd_soc_read(codec, WM8580_PWRDN1);
-			reg &= ~(WM8580_PWRDN1_PWDN | WM8580_PWRDN1_ALLDACPD);
-			snd_soc_write(codec, WM8580_PWRDN1, reg);
+			snd_soc_update_bits(codec, WM8580_PWRDN1,
+					    WM8580_PWRDN1_PWDN |
+					    WM8580_PWRDN1_ALLDACPD, 0);
 
 			/* Make VMID high impedance */
-			reg = snd_soc_read(codec,  WM8580_ADC_CONTROL1);
-			reg &= ~0x100;
-			snd_soc_write(codec, WM8580_ADC_CONTROL1, reg);
+			snd_soc_update_bits(codec, WM8580_ADC_CONTROL1,
+					    0x100, 0);
 		}
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		reg = snd_soc_read(codec, WM8580_PWRDN1);
-		snd_soc_write(codec, WM8580_PWRDN1, reg | WM8580_PWRDN1_PWDN);
+		snd_soc_update_bits(codec, WM8580_PWRDN1,
+				    WM8580_PWRDN1_PWDN, WM8580_PWRDN1_PWDN);
 		break;
 	}
 	codec->dapm.bias_level = level;
-- 
1.7.4.1
