From: Mike Dyer <mike.dyer@md-soft.co.uk>
Subject: [PATCH 1/1] ASoC: wm8960: Fix PLL register writes
Date: Fri, 16 Aug 2013 18:36:28 +0100
Message-ID: <1376674588-14454-1-git-send-email-mike.dyer@md-soft.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D52D826087C
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 19:37:11 +0200 (CEST)
Received: by mail-wg0-f48.google.com with SMTP id f12so1781684wgh.27
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 10:37:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mike.dyer@md-soft.co.uk, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Bit 9 of PLL2,3 and 4 is reserved as '0'. The 24bit fractional part should be split across each register in 8bit chunks.

Signed-off-by: Mike Dyer <mike.dyer@md-soft.co.uk>
---
 sound/soc/codecs/wm8960.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 0a4ffdd..5e5af89 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -857,9 +857,9 @@ static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	if (pll_div.k) {
 		reg |= 0x20;
 
-		snd_soc_write(codec, WM8960_PLL2, (pll_div.k >> 18) & 0x3f);
-		snd_soc_write(codec, WM8960_PLL3, (pll_div.k >> 9) & 0x1ff);
-		snd_soc_write(codec, WM8960_PLL4, pll_div.k & 0x1ff);
+		snd_soc_write(codec, WM8960_PLL2, (pll_div.k >> 16) & 0xff);
+		snd_soc_write(codec, WM8960_PLL3, (pll_div.k >> 8) & 0xff);
+		snd_soc_write(codec, WM8960_PLL4, pll_div.k & 0xff);
 	}
 	snd_soc_write(codec, WM8960_PLL1, reg);
 
-- 
1.8.3.1
