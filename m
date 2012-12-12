From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: wm8804: Remove redundant check
Date: Wed, 12 Dec 2012 00:53:13 -0200
Message-ID: <1355280793-23143-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f177.google.com (mail-qc0-f177.google.com
 [209.85.216.177])
 by alsa0.perex.cz (Postfix) with ESMTP id E41E2261697
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 03:53:23 +0100 (CET)
Received: by mail-qc0-f177.google.com with SMTP id u28so77327qcs.36
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2012 18:53:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The condition "if (!freq_in || !freq_out)" has already been tested previously,
so no need to do it again.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8804.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index d321a87..1704b1e 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -395,9 +395,6 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 		/* power down the PLL before reprogramming it */
 		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0x1);
 
-		if (!freq_in || !freq_out)
-			return 0;
-
 		/* set PLLN and PRESCALE */
 		snd_soc_update_bits(codec, WM8804_PLL4, 0xf | 0x10,
 				    pll_div.n | (pll_div.prescale << 4));
-- 
1.7.9.5
