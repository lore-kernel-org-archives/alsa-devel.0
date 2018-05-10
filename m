From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: zx-i2s: fix spelling mistake: "timeing"
	-> "timing"
Date: Thu, 10 May 2018 15:58:38 +0100
Message-ID: <20180510145838.3907-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 51499267778
 for <alsa-devel@alsa-project.org>; Thu, 10 May 2018 16:59:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/zte/zx-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index 9a0565937d1f..b6b056c607fa 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -197,7 +197,7 @@ static int zx_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		val |= (ZX_I2S_TIMING_I2S | ZX_I2S_TIMING_LSB_JUSTIF);
 		break;
 	default:
-		dev_err(cpu_dai->dev, "Unknown i2s timeing\n");
+		dev_err(cpu_dai->dev, "Unknown i2s timing\n");
 		return -EINVAL;
 	}
 
-- 
2.17.0
