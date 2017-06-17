From: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] ASoC: zx-i2s: flip I2S master/slave mode
Date: Sat, 17 Jun 2017 22:25:28 +0800
Message-ID: <1497709528-23036-1-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id CE942266D6A
 for <alsa-devel@alsa-project.org>; Sat, 17 Jun 2017 16:26:28 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Shawn Guo <shawn.guo@linaro.org>

The SND_SOC_DAIFMT_MASTER bits are defined to specify the master/slave
mode for Codec, not I2S.  So the I2S master/slave mode should be flipped
according to SND_SOC_DAIFMT_MASTER bits.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/zte/zx-i2s.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index dd124d5acf01..16195ee776e5 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -203,13 +203,15 @@ static int zx_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		i2s->master = 1;
-		val |= ZX_I2S_TIMING_MAST;
-		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
+		/* Codec is master, and I2S is slave. */
 		i2s->master = 0;
 		val |= ZX_I2S_TIMING_SLAVE;
 		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* Codec is slave, and I2S is master. */
+		i2s->master = 1;
+		val |= ZX_I2S_TIMING_MAST;
+		break;
 	default:
 		dev_err(cpu_dai->dev, "Unknown master/slave format\n");
 		return -EINVAL;
-- 
1.9.1
