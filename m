From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT 1/2] ASoC: samsung: Fix possible double iounmap on s3c24xx driver probe failure
Date: Wed, 26 Jul 2017 20:57:28 +0200
Message-ID: <20170726185729.28897-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit 87b132bc0315 ("ASoC: samsung: s3c24{xx,12}-i2s: port to use
generic dmaengine API") moved ioremap() call from
s3c-i2s-v2.c:s3c_i2sv2_probe() to s3c2412-i2s.c:s3c2412_iis_dev_probe()
and converted it to devm- resource managed interface.

However the error path in first of them - s3c_i2sv2_probe() - was not
updated.  If getting a iis clock in s3c_i2sv2_probe() failed, the
address space would be unmapped there.  This could lead to:
1. double iounmap() later from devm-interface of s3c2412_iis_dev_probe()),
2. accessing the memory by other functions in s3c2412-i2s.c unit.

Anyway, the owner of this mapped region should be s3c2412-i2s.c because
it starts the mapping.

Affected are drivers for S3C24xx family although issue was not reproduced.

Fixes: 87b132bc0315 ("ASoC: samsung: s3c24{xx,12}-i2s: port to use generic dmaengine API")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not marking as Cc-stable because this is theoretical problem, not
reproduced and also not tested.

Please, kindly test on S3C24xx hardware.
---
 sound/soc/samsung/s3c-i2s-v2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index ca522a95160b..9b28046eea8e 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -634,7 +634,6 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
 	i2s->iis_pclk = clk_get(dev, "iis");
 	if (IS_ERR(i2s->iis_pclk)) {
 		dev_err(dev, "failed to get iis_clock\n");
-		iounmap(i2s->regs);
 		return -ENOENT;
 	}
 
-- 
2.11.0
