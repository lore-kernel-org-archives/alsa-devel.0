From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: cx2072x: remove set but not used variable 'is_right_j '
Date: Sat, 25 May 2019 20:32:04 +0800
Message-ID: <20190525123204.16148-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/codecs/cx2072x.c: In function cx2072x_config_i2spcm:
sound/soc/codecs/cx2072x.c:679:6: warning: variable is_right_j set but not used [-Wunused-but-set-variable]

It's never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/cx2072x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 23d2b25fe04c..a066ef83de1a 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -676,7 +676,6 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 	unsigned int bclk_rate = 0;
 	int is_i2s = 0;
 	int has_one_bit_delay = 0;
-	int is_right_j = 0;
 	int is_frame_inv = 0;
 	int is_bclk_inv = 0;
 	int pulse_len = 1;
@@ -740,7 +739,6 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 
 	case SND_SOC_DAIFMT_RIGHT_J:
 		is_i2s = 1;
-		is_right_j = 1;
 		pulse_len = frame_len / 2;
 		break;
 
-- 
2.17.1
