From: Zidan Wang <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 4/4] ASoC: wm8958: correct BCLK DIV 348 to 384
Date: Tue, 12 May 2015 14:58:50 +0800
Message-ID: <db8ef4eba13e06c27b1da3762fdbd79be3afac2a.1431413323.git.zidan.wang@freescale.com>
References: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

According to the RM of wm8958, BCLK DIV 348 doesn't exist, correct it
to 384.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2d32b54..33bf663 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2752,7 +2752,7 @@ static struct {
 };
 
 static int fs_ratios[] = {
-	64, 128, 192, 256, 348, 512, 768, 1024, 1408, 1536
+	64, 128, 192, 256, 384, 512, 768, 1024, 1408, 1536
 };
 
 static int bclk_divs[] = {
-- 
1.9.1
