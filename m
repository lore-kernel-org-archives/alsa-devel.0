From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: wm8955: Fix setting wrong register for
 WM8955_K_8_0_MASK bits
Date: Fri, 15 May 2015 09:15:16 +0800
Message-ID: <1431652516.5652.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 596232614D9
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 03:15:23 +0200 (CEST)
Received: by pabts4 with SMTP id ts4so108102pab.3
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 18:15:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

WM8955_K_8_0_MASK bits is controlled by WM8955_PLL_CONTROL_3 rather than
WM8955_PLL_CONTROL_2.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8955.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index f400d5c..08063a6 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -298,7 +298,7 @@ static int wm8955_configure_clocking(struct snd_soc_codec *codec)
 		snd_soc_update_bits(codec, WM8955_PLL_CONTROL_2,
 				    WM8955_K_17_9_MASK,
 				    (pll.k >> 9) & WM8955_K_17_9_MASK);
-		snd_soc_update_bits(codec, WM8955_PLL_CONTROL_2,
+		snd_soc_update_bits(codec, WM8955_PLL_CONTROL_3,
 				    WM8955_K_8_0_MASK,
 				    pll.k & WM8955_K_8_0_MASK);
 		if (pll.k)
-- 
2.1.0
