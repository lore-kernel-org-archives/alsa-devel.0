From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: wm8900: Fix wrong mask for setting
 DAC_CLKDIV/ADC_CLKDIV/LRCLK_MODE
Date: Sun, 16 Oct 2011 23:27:55 +0800
Message-ID: <1318778876.3106.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id E9B521037EE
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Oct 2011 17:28:09 +0200 (CEST)
Received: by pzk33 with SMTP id 33so6161181pzk.2
	for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2011 08:28:07 -0700 (PDT)
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

After checking the datasheet, I think what we want to do here is to
clear the WM8900_REG_CLOCKING2_DAC_CLKDIV/WM8900_REG_CLOCKING2_ADC_CLKDIV/
WM8900_REG_DACCTRL_AIF_LRCLKRATE bits and then OR with div value.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I'd appreciate if someone can test this serial of patches.
Thanks,
Axel
 sound/soc/codecs/wm8900.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 082040e..b16522f 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -844,17 +844,17 @@ static int wm8900_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	case WM8900_DAC_CLKDIV:
 		reg = snd_soc_read(codec, WM8900_REG_CLOCKING2);
 		snd_soc_write(codec, WM8900_REG_CLOCKING2,
-			     div | (reg & WM8900_REG_CLOCKING2_DAC_CLKDIV));
+			     div | (reg & ~WM8900_REG_CLOCKING2_DAC_CLKDIV));
 		break;
 	case WM8900_ADC_CLKDIV:
 		reg = snd_soc_read(codec, WM8900_REG_CLOCKING2);
 		snd_soc_write(codec, WM8900_REG_CLOCKING2,
-			     div | (reg & WM8900_REG_CLOCKING2_ADC_CLKDIV));
+			     div | (reg & ~WM8900_REG_CLOCKING2_ADC_CLKDIV));
 		break;
 	case WM8900_LRCLK_MODE:
 		reg = snd_soc_read(codec, WM8900_REG_DACCTRL);
 		snd_soc_write(codec, WM8900_REG_DACCTRL,
-			     div | (reg & WM8900_REG_DACCTRL_AIF_LRCLKRATE));
+			     div | (reg & ~WM8900_REG_DACCTRL_AIF_LRCLKRATE));
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.4.1
