From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rt5514: Fix up calculation for bclk_ms
Date: Mon, 08 Feb 2016 22:04:53 +0800
Message-ID: <1454940293.6265.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id BB16E260515
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 15:04:59 +0100 (CET)
Received: by mail-pa0-f53.google.com with SMTP id yy13so74131020pab.3
 for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2016 06:04:59 -0800 (PST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The equation to calculate bclk_ms is wrong, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 879bf60..5bfe720 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -574,7 +574,7 @@ static int rt5514_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	bclk_ms = frame_size > 32;
+	bclk_ms = frame_size >> 32;
 	rt5514->bclk = rt5514->lrck * (32 << bclk_ms);
 
 	dev_dbg(dai->dev, "bclk is %dHz and lrck is %dHz\n",
-- 
2.1.4
