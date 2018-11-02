From: sh liu <liush.damon@gmail.com>
Subject: [PATCH] ASoC: wm8996: fix small typo
Date: Fri, 2 Nov 2018 09:30:06 +0800
Message-ID: <CADnCVLz__D9n+UpFLChVcZkjmFZxKZacCCgufRx8y0_03OGgSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

>From e9b923690675ca8fa883fd25dcead5b457856735 Mon Sep 17 00:00:00 2001
From: liush <liush@allwinnertech.com>
Date: Fri, 2 Nov 2018 08:57:00 +0800
Subject: [PATCH] ASoC: wm8996: fix small typo

atleast -> at least

Change-Id: Icc970b438166daef13518b7d1a62b13eb8752f5f
Signed-off-by: liush <liush@allwinnertech.com>
---
 sound/soc/codecs/wm8996.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 8affa49..d039835 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2109,7 +2109,7 @@ static int wm8996_set_fll(struct snd_soc_codec
*codec, int fll_id, int source,
  if (i2c->irq)
  timeout *= 10;
  else
- /* ensure timeout of atleast 1 jiffies */
+ /* ensure timeout of at least 1 jiffies */
  timeout = timeout/2 ? : 1;

  for (retry = 0; retry < 10; retry++) {
-- 
1.9.1
